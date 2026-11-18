CREATE DATABASE CV_Joven;
USE CV_Joven;


CREATE TABLE TipoUsuario (
    idTipoUsuario INT IDENTITY(1,1) PRIMARY KEY,
    nombreRol VARCHAR(50) NOT NULL UNIQUE,
    CONSTRAINT CK_TipoUsuario_Rol
    CHECK (nombreRol IN ('Administrador', 'Postulante', 'Empresa'))
);

CREATE TABLE Usuario (
    idUsuario BIGINT IDENTITY(1,1) PRIMARY KEY,
    idTipoUsuario INT NOT NULL,
    mail VARCHAR(150) NOT NULL UNIQUE,
    contraseña VARCHAR(255) NOT NULL,
    Nombre VARCHAR(100) NOT NULL,
    Apellido VARCHAR(100) NOT NULL,
    DNI VARCHAR(20) NOT NULL UNIQUE,
    ZonaLocalidad VARCHAR(100) NOT NULL,
    celular VARCHAR(30) NOT NULL,
    FechaNacimiento DATE NOT NULL,
					CONSTRAINT CK_Usuario_Edad
				CHECK (
					FechaNacimiento <= DATEADD(YEAR,-18,GETDATE())
				),
    CONSTRAINT fk_usuario_tipo FOREIGN KEY (idTipoUsuario) 
        REFERENCES TipoUsuario(idTipoUsuario)
);

CREATE TABLE Empresa (
    idEmpresa BIGINT IDENTITY(1,1) PRIMARY KEY,
    idTipoUsuario INT NOT NULL,
    mail VARCHAR(150) NOT NULL UNIQUE,
    contraseña VARCHAR(255) NOT NULL,
    nombreLegal VARCHAR(150) NOT NULL,
    nombreComercial VARCHAR(150) NOT NULL,
    CUIT VARCHAR(20) NOT NULL UNIQUE,
    sector VARCHAR(100) NOT NULL,
    tamanioDeEmpresa VARCHAR(50) NOT NULL,
    CONSTRAINT CK_Empresa_Tamanio
    CHECK (tamanioDeEmpresa IN ('Pyme', 'Mediana', 'Grande')),
    paginaWeb VARCHAR(255) NULL,
    correoRRHH VARCHAR(150) NOT NULL,
    CONSTRAINT fk_empresa_tipo FOREIGN KEY (idTipoUsuario) 
        REFERENCES TipoUsuario(idTipoUsuario)
);

CREATE TABLE codigos_cambios_password (
    IdCodigo BIGINT IDENTITY(1,1) PRIMARY KEY,
    IdUsuario BIGINT NULL,
    IdEmpresa BIGINT NULL,
    Codigo_hash VARCHAR(255) NOT NULL,
    fechaCreacion DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
    fechaExpiracion DATETIME2 NOT NULL,
    Intentos INT NOT NULL DEFAULT 0,
    Usado BIT NOT NULL DEFAULT 0,
		CONSTRAINT CK_Intentos
	CHECK (Intentos >= 0),
					CONSTRAINT CK_Codigo_Propietario
				CHECK (
					(IdUsuario IS NOT NULL AND IdEmpresa IS NULL)
					OR
					(IdUsuario IS NULL AND IdEmpresa IS NOT NULL)
				),
    CONSTRAINT fk_codigo_usuario FOREIGN KEY (IdUsuario) 
        REFERENCES usuario(idUsuario) ON DELETE CASCADE,
    CONSTRAINT fk_codigo_empresa FOREIGN KEY (IdEmpresa) 
        REFERENCES empresa(idEmpresa) ON DELETE CASCADE
);

CREATE TABLE CV (
    IdCV BIGINT IDENTITY(1,1) PRIMARY KEY,
    IdUsuario BIGINT NOT NULL,
    nombreDelCV VARCHAR(100) NOT NULL,
    DisponibilidadHoraria VARCHAR(50) NOT NULL,
    CONSTRAINT CK_CV_DisponibilidadHoraria
    CHECK (DisponibilidadHoraria IN ('Full-time','Part-time')),
    CONSTRAINT fk_cv_usuario FOREIGN KEY (IdUsuario) 
        REFERENCES usuario(idUsuario) ON DELETE CASCADE
);

CREATE TABLE Educacion (
    IdEducacion BIGINT IDENTITY(1,1) PRIMARY KEY,
    IdCV BIGINT NOT NULL,
    Titulo VARCHAR(150) NOT NULL,
    Institucion VARCHAR(150) NOT NULL,
    nivelAlcanzado VARCHAR(100) NOT NULL,
    CONSTRAINT CK_Educacion_NivelAlcanzado
    CHECK (nivelAlcanzado IN ('Primaria', 'Secundaria', 'Terciario','Universidad','Posgrado')),
    Anio INT NOT NULL,
    CONSTRAINT CK_Educacion_Anio
	CHECK (Anio BETWEEN 1900 AND YEAR(GETDATE())),
    CONSTRAINT fk_educacion_cv FOREIGN KEY (IdCV) 
        REFERENCES CV(IdCV) ON DELETE CASCADE
);

CREATE TABLE Idioma (
    IdIdioma BIGINT IDENTITY(1,1) PRIMARY KEY,
    IdCV BIGINT NOT NULL,
    Descripcion VARCHAR(100) NOT NULL,
    nivel VARCHAR(50) NOT NULL,
	CONSTRAINT CK_Idioma_Nivel
    CHECK (nivel IN ('A1','A2','B1','B2','C1','C2')),
    CONSTRAINT fk_idioma_cv FOREIGN KEY (IdCV) 
        REFERENCES CV(IdCV) ON DELETE CASCADE
);

CREATE TABLE Experiencia (
    IdExperiencia BIGINT IDENTITY(1,1) PRIMARY KEY,
    IdCV BIGINT NOT NULL,
    tipoExperiencia VARCHAR(50) NOT NULL,
    CONSTRAINT CK_Experiencia_TipoExperiencia
    CHECK (tipoExperiencia IN ('Voluntariado','Laboral')),
    Puesto VARCHAR(100) NOT NULL,
    Empresa VARCHAR(150) NOT NULL,
    Descripcion VARCHAR(255) NULL,
    FechaDesde DATE NOT NULL,
    FechaHasta DATE NULL,
    CONSTRAINT CK_Experiencia_Fechas
				CHECK (
					FechaHasta IS NULL
					OR FechaHasta >= FechaDesde
				),
    CONSTRAINT fk_experiencia_cv FOREIGN KEY (IdCV) 
        REFERENCES CV(IdCV) ON DELETE CASCADE
);

CREATE TABLE Responsabilidades (
    IdResponsabilidad BIGINT IDENTITY(1,1) PRIMARY KEY,
    IdExperiencia BIGINT NOT NULL,
    Descripcion VARCHAR(255) NOT NULL,
    CONSTRAINT fk_responsabilidad_experiencia FOREIGN KEY (IdExperiencia) 
        REFERENCES Experiencia(IdExperiencia) ON DELETE CASCADE
);

CREATE TABLE Habilidades (
    IdHabilidad BIGINT IDENTITY(1,1) PRIMARY KEY,
    IdCV BIGINT NOT NULL,
    Descripcion VARCHAR(150) NOT NULL,
    TipoHabilidad BIT NOT NULL,
    -- En TipoHabilidad 'True' es Habilidad Blanda y 'False' es Habilidad Dura !!!
    CONSTRAINT fk_habilidades_cv FOREIGN KEY (IdCV) 
        REFERENCES CV(IdCV) ON DELETE CASCADE
);

CREATE TABLE TipoDiscapacidad (
    IdDiscapacidad BIGINT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL UNIQUE,
    Descripcion VARCHAR(255) NULL
);

CREATE TABLE Discapacidad (
    IdCV BIGINT NOT NULL,
    IdDiscapacidad BIGINT NOT NULL,
    PRIMARY KEY (IdCV, IdDiscapacidad),
    CONSTRAINT fk_discapacidad_cv FOREIGN KEY (IdCV) 
        REFERENCES CV(IdCV) ON DELETE CASCADE,
    CONSTRAINT fk_discapacidad_tipo FOREIGN KEY (IdDiscapacidad) 
        REFERENCES TipoDiscapacidad(IdDiscapacidad)
);

CREATE TABLE OfertaLaboral (
    IdOferta BIGINT IDENTITY(1,1) PRIMARY KEY,
    IdEmpresa BIGINT NOT NULL,
    TituloOferta VARCHAR(150) NOT NULL,
    Zona VARCHAR(100) NOT NULL,
    TipoDeJornada VARCHAR(50) NOT NULL,    
    CONSTRAINT CK_OfertaLaboral_TipoDeJornada
    CHECK (TipoDeJornada IN ('Part-time','Full-time')),
    Descripcion VARCHAR(MAX) NOT NULL,
    AceptaDiscapacidad BIT NOT NULL DEFAULT 0,
    CONSTRAINT fk_oferta_empresa FOREIGN KEY (IdEmpresa) 
        REFERENCES empresa(idEmpresa) ON DELETE CASCADE
);

CREATE TABLE Requisito (
    IdRequisito BIGINT IDENTITY(1,1) PRIMARY KEY,
    idOferta BIGINT NOT NULL,
    Descripcion VARCHAR(255) NOT NULL,
    CONSTRAINT fk_requisito_oferta FOREIGN KEY (idOferta) 
        REFERENCES OfertaLaboral(IdOferta) ON DELETE CASCADE
);

CREATE TABLE Postulacion (
    IdPostulacion BIGINT IDENTITY(1,1) PRIMARY KEY,
    IdUsuario BIGINT NOT NULL,
    IdCV BIGINT NOT NULL,
    IdOferta BIGINT NOT NULL,
    FechaPostulacion DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
    EstadoPostulacion VARCHAR(50) NOT NULL DEFAULT 'Pendiente',
				CONSTRAINT CK_Postulacion_Estado
			CHECK (
				EstadoPostulacion IN (
					'Pendiente',
					'En Revision',
					'Aceptado',
					'Rechazado'
				)
			),
					CONSTRAINT UQ_Postulacion
				UNIQUE (IdUsuario, IdOferta),
    CONSTRAINT fk_postulacion_usuario FOREIGN KEY (IdUsuario) 
        REFERENCES usuario(idUsuario),
    CONSTRAINT fk_postulacion_cv FOREIGN KEY (IdCV) 
        REFERENCES CV(IdCV),
    CONSTRAINT fk_postulacion_oferta FOREIGN KEY (IdOferta) 
        REFERENCES OfertaLaboral(IdOferta)
);


CREATE TABLE Token (
    Token VARCHAR(50) DEFAULT NULL,
    Confirmacion BIT DEFAULT 0,
    TokenExpiracion DATETIME DEFAULT NULL,
    EmailConfirmado VARCHAR(60) DEFAULT NULL
);


ALTER TABLE OfertaLaboral
ADD EstadoOferta VARCHAR(20) NOT NULL
DEFAULT 'Activa'
CONSTRAINT CK_OfertaLaboral_Estado
CHECK (EstadoOferta IN ('Activa', 'Cerrada', 'Cancelada'));


ALTER TABLE OfertaLaboral
ADD FechaPublicacion DATETIME NOT NULL
DEFAULT GETDATE();


