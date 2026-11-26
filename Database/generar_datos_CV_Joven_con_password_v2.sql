USE CV_Joven;
GO
SET NOCOUNT ON;
SET XACT_ABORT ON;
BEGIN TRY
BEGIN TRANSACTION;
-- 1. Eliminar datos en orden de dependencias.
DELETE FROM dbo.Token;
DELETE FROM dbo.codigos_cambios_password;
DELETE FROM dbo.Postulacion;
DELETE FROM dbo.Requisito;
DELETE FROM dbo.OfertaLaboral;
DELETE FROM dbo.Responsabilidades;
DELETE FROM dbo.Experiencia;
DELETE FROM dbo.Educacion;
DELETE FROM dbo.Idioma;
DELETE FROM dbo.Habilidades;
DELETE FROM dbo.Discapacidad;
DELETE FROM dbo.TipoDiscapacidad;
DELETE FROM dbo.CV;
DELETE FROM dbo.Empresa;
DELETE FROM dbo.Usuario;
DELETE FROM dbo.TipoUsuario;

-- 2. Roles con IDs exactos, sin depender del contador IDENTITY.
SET IDENTITY_INSERT dbo.TipoUsuario ON;
INSERT dbo.TipoUsuario (idTipoUsuario,nombreRol) VALUES (1,'Postulante'),(2,'Empresa'),(3,'Administrador');
SET IDENTITY_INSERT dbo.TipoUsuario OFF;

-- Contraseña de acceso: CvJoven2026! (salt independiente por cuenta).
DECLARE @Password1 varchar(255) = 'PBKDF2-SHA256$600000$sPfHADKLeh/n09sFfNAdeQ==$rwf++0I4mVrxApxKH/7tTfCKhgKQvr0hS2eeR+Oe6jc=';
DECLARE @Password2 varchar(255) = 'PBKDF2-SHA256$600000$ovx4oOLFYIKdGyp+x/5wdA==$x+MF3avocM6Oyc5ibI8mFqbz1U9uNK1oYnSdLVuC8YY=';
DECLARE @Password3 varchar(255) = 'PBKDF2-SHA256$600000$dXS2usHu/gDGYuChiPSv9A==$djNliZM7xW1BKkv8S+1Nv/v1wekbM++T/rNpsgQ/43U=';
DECLARE @Password4 varchar(255) = 'PBKDF2-SHA256$600000$+EKvNzvKYyEehB5oQGEZJA==$uY9pWbtW7TmcVSx31WgFCmuUujAOsUQmfwxdU/WSMOI=';
DECLARE @Password5 varchar(255) = 'PBKDF2-SHA256$600000$c3yUgTMn0bXSQOPhFA2lGw==$hdyDoY3fSql2PQKFs+6ea4Um38q/VfuhgBI6giGssv8=';
DECLARE @Password6 varchar(255) = 'PBKDF2-SHA256$600000$iY4U7j8OjaFGKocEqORhBQ==$lceqibdaZsSPo0DP6Kh2H2ptkkyguRJ+a+fFAqmJ8jQ=';
DECLARE @Password7 varchar(255) = 'PBKDF2-SHA256$600000$NRii19Xwe5TYNx8D5eO7xA==$agzj75FJFTkNVm9UNm2IhHetq+bVfIm/XrG4M0oHeKs=';
DECLARE @Password8 varchar(255) = 'PBKDF2-SHA256$600000$WZkausWgOdLawejM7hbqIw==$8joAHr4HdMSYteyMIJQnBytUHIxSUVB2VbE5XmXNaS0=';
DECLARE @Usuarios TABLE (Id bigint, Mail varchar(150));
INSERT dbo.Usuario (idTipoUsuario,mail,[contraseña],Nombre,Apellido,DNI,ZonaLocalidad,celular,FechaNacimiento)
OUTPUT inserted.idUsuario, inserted.mail INTO @Usuarios
VALUES
(1,'lucia@cvjoven.test',@Password1,'Lucía','Pérez','99000001','Bahía Blanca','2910000001','20010115'),
(1,'mateo@cvjoven.test',@Password2,'Mateo','Gómez','99000002','Bahía Blanca','2910000002','20000220'),
(1,'sofia@cvjoven.test',@Password3,'Sofía','Ruiz','99000003','Bahía Blanca','2910000003','19990312'),
(1,'tomas@cvjoven.test',@Password4,'Tomás','López','99000004','Bahía Blanca','2910000004','20020410'),
(1,'valentina@cvjoven.test',@Password5,'Valentina','Díaz','99000005','Bahía Blanca','2910000005','20010518'),
(3,'admin@cvjoven.test',@Password6,'Martín','Herrera','99000006','Bahía Blanca','2910000006','19900101');
DECLARE @Empresas TABLE (Id bigint, Mail varchar(150));
INSERT dbo.Empresa (idTipoUsuario,mail,[contraseña],nombreLegal,nombreComercial,CUIT,sector,tamanioDeEmpresa,paginaWeb,correoRRHH)
OUTPUT inserted.idEmpresa, inserted.mail INTO @Empresas
VALUES (2,'tech@cvjoven.test',@Password7,'Tecnología Austral SA','Tech Austral','30-99000001-0','Tecnología','Mediana','https://tech.cvjoven.test','rrhh.tech@cvjoven.test'),
(2,'servicios@cvjoven.test',@Password8,'Servicios del Sur SRL','Sur Servicios','30-99000002-0','Servicios','Pyme','https://servicios.cvjoven.test','rrhh.sur@cvjoven.test');

-- 3. Catálogo de discapacidad.
INSERT dbo.TipoDiscapacidad (Nombre,Descripcion) VALUES
('Motriz','Limitación de movilidad'),('Visual','Limitación de la visión'),('Auditiva','Limitación de la audición'),('Intelectual','Limitación del funcionamiento intelectual'),('Psicosocial','Discapacidad de origen psicosocial'),('Visceral','Limitación vinculada a funciones orgánicas');

-- 4. CV: un currículum por postulante.
DECLARE @CV TABLE (IdCV bigint, IdUsuario bigint, Perfil int);
INSERT dbo.CV (IdUsuario,nombreDelCV,DisponibilidadHoraria)
OUTPUT inserted.IdCV,inserted.IdUsuario INTO @CV(IdCV,IdUsuario)
SELECT u.Id, v.Nombre,v.Jornada FROM @Usuarios u JOIN (VALUES
('lucia@cvjoven.test','CV Desarrollo .NET','Full-time'),('mateo@cvjoven.test','CV Soporte IT','Full-time'),('sofia@cvjoven.test','CV Datos','Full-time'),('tomas@cvjoven.test','CV Administración','Part-time'),('valentina@cvjoven.test','CV Atención y QA','Full-time')) v(Mail,Nombre,Jornada) ON u.Mail=v.Mail;
UPDATE c SET Perfil=v.Perfil FROM @CV c JOIN @Usuarios u ON c.IdUsuario=u.Id JOIN (VALUES ('lucia@cvjoven.test',1),('mateo@cvjoven.test',2),('sofia@cvjoven.test',3),('tomas@cvjoven.test',4),('valentina@cvjoven.test',5)) v(Mail,Perfil) ON u.Mail=v.Mail;

INSERT dbo.Educacion (IdCV,Titulo,Institucion,nivelAlcanzado,Anio)
SELECT IdCV,'Bachiller',CASE Perfil WHEN 1 THEN 'Escuela Normal Superior Vicente Fatone' WHEN 2 THEN 'Escuela de Educación Secundaria Técnica N° 1 de Bahía Blanca' WHEN 3 THEN 'Colegio Nacional de Bahía Blanca' WHEN 4 THEN 'Escuela de Comercio de Bahía Blanca' ELSE 'Escuela Normal Superior Vicente Fatone' END,'Secundaria',2018 FROM @CV
UNION ALL SELECT c.IdCV,v.Titulo,v.Institucion,v.Nivel,2023 FROM @CV c JOIN (VALUES
(1,'Tecnicatura en Programación','Universidad Tecnológica Nacional - Facultad Regional Bahía Blanca','Universidad'),(2,'Técnico en Informática','Instituto Superior Juan XXIII','Terciario'),(3,'Licenciatura en Ciencias de la Computación','Universidad Nacional del Sur','Universidad'),(4,'Técnico en Administración','Instituto Superior Juan XXIII','Terciario'),(5,'Técnico en Gestión Comercial','Instituto Superior Juan XXIII','Terciario')) v(Perfil,Titulo,Institucion,Nivel) ON c.Perfil=v.Perfil;
INSERT dbo.Idioma (IdCV,Descripcion,nivel)
SELECT IdCV,'Inglés',CASE WHEN Perfil IN (1,3) THEN 'B2' ELSE 'B1' END FROM @CV
UNION ALL SELECT IdCV,'Portugués','A2' FROM @CV;

DECLARE @Exp TABLE (IdExperiencia bigint, IdCV bigint, Tipo varchar(50));
INSERT dbo.Experiencia (IdCV,tipoExperiencia,Puesto,Empresa,Descripcion,FechaDesde,FechaHasta)
OUTPUT inserted.IdExperiencia,inserted.IdCV,inserted.tipoExperiencia INTO @Exp
SELECT c.IdCV,'Laboral',v.Puesto,CASE c.Perfil WHEN 1 THEN 'Pampa Digital' WHEN 2 THEN 'Redes del Atlántico' WHEN 3 THEN 'Horizonte Consultores' WHEN 4 THEN 'Distribuidora del Puerto' ELSE 'Comercial Patagonia' END,v.Descripcion,'20240101','20251231' FROM @CV c JOIN (VALUES
(1,'Desarrolladora junior','Desarrollo de aplicaciones web y consultas SQL'),(2,'Soporte técnico','Resolución de incidentes y mantenimiento'),(3,'Analista junior','Preparación de informes y análisis de datos'),(4,'Auxiliar administrativo','Gestión de documentación y planillas'),(5,'Asistente comercial','Atención al cliente y validación funcional')) v(Perfil,Puesto,Descripcion) ON c.Perfil=v.Perfil
UNION ALL SELECT IdCV,'Voluntariado','Asistente voluntario','Cruz Roja Argentina','Colaboración en actividades comunitarias','20230101','20231231' FROM @CV;
INSERT dbo.Responsabilidades (IdExperiencia,Descripcion)
SELECT e.IdExperiencia,v.Descripcion FROM @Exp e CROSS APPLY (VALUES ('Organizar tareas y cumplir plazos'),('Documentar actividades y resultados'),('Coordinar tareas con el equipo')) v(Descripcion);

-- 1 = blanda; 0 = dura. Ocho habilidades por CV.
INSERT dbo.Habilidades (IdCV,Descripcion,TipoHabilidad)
SELECT c.IdCV,v.Descripcion,v.Tipo FROM @CV c CROSS APPLY (VALUES ('Trabajo en equipo',1),('Comunicación efectiva',1),('Resolución de problemas',1),('Adaptabilidad',1)) v(Descripcion,Tipo)
UNION ALL SELECT c.IdCV,v.Descripcion,0 FROM @CV c JOIN (VALUES
(1,'C#'),(1,'SQL Server'),(1,'ASP.NET'),(1,'Git'),
(2,'Windows'),(2,'Redes informáticas'),(2,'Active Directory'),(2,'Soporte técnico'),
(3,'SQL Server'),(3,'Excel'),(3,'Python'),(3,'Power BI'),
(4,'Excel'),(4,'Gestión documental'),(4,'Facturación'),(4,'Microsoft Word'),
(5,'Atención al cliente'),(5,'Testing funcional'),(5,'Gestión de tickets'),(5,'Excel')) v(Perfil,Descripcion) ON c.Perfil=v.Perfil;
INSERT dbo.Discapacidad (IdCV,IdDiscapacidad)
SELECT c.IdCV,d.IdDiscapacidad FROM @CV c JOIN (VALUES (2,'Motriz'),(5,'Auditiva')) v(Perfil,Nombre) ON c.Perfil=v.Perfil JOIN dbo.TipoDiscapacidad d ON d.Nombre=v.Nombre;

-- 5. Ofertas y requisitos.
DECLARE @Ofertas TABLE (IdOferta bigint,Titulo varchar(150),Numero int);
INSERT dbo.OfertaLaboral (IdEmpresa,TituloOferta,Zona,TipoDeJornada,Descripcion,AceptaDiscapacidad,EstadoOferta,FechaPublicacion)
OUTPUT inserted.IdOferta,inserted.TituloOferta INTO @Ofertas(IdOferta,Titulo)
SELECT e.Id,v.Titulo,'Bahía Blanca',v.Jornada,v.Descripcion,v.Acepta,'Activa',DATEADD(day,-15,GETDATE()) FROM @Empresas e JOIN (VALUES
('tech@cvjoven.test','Desarrollador .NET Junior','Full-time','Desarrollo de aplicaciones web.',1),
('tech@cvjoven.test','Soporte técnico IT','Full-time','Atención de incidentes informáticos.',1),
('tech@cvjoven.test','Analista de datos Junior','Full-time','Análisis de datos e informes.',1),
('servicios@cvjoven.test','Administrativo','Part-time','Gestión de documentación y facturación.',0),
('servicios@cvjoven.test','Atención al cliente','Full-time','Atención y seguimiento de consultas.',1),
('tech@cvjoven.test','Tester QA Junior','Full-time','Ejecución de validación funcional.',1)) v(Mail,Titulo,Jornada,Descripcion,Acepta) ON e.Mail=v.Mail;
UPDATE o SET Numero=v.Numero FROM @Ofertas o JOIN (VALUES ('Desarrollador .NET Junior',1),('Soporte técnico IT',2),('Analista de datos Junior',3),('Administrativo',4),('Atención al cliente',5),('Tester QA Junior',6)) v(Titulo,Numero) ON o.Titulo=v.Titulo;
INSERT dbo.Requisito (idOferta,Descripcion)
SELECT o.IdOferta,v.Descripcion FROM @Ofertas o JOIN (VALUES
(1,'C#'),(1,'SQL Server'),(1,'ASP.NET'),(1,'Trabajo en equipo'),
(2,'Windows'),(2,'Redes informáticas'),(2,'Soporte técnico'),(2,'Resolución de problemas'),
(3,'SQL Server'),(3,'Python'),(3,'Power BI'),(3,'Trabajo en equipo'),
(4,'Excel'),(4,'Gestión documental'),(4,'Facturación'),(4,'Adaptabilidad'),
(5,'Atención al cliente'),(5,'Gestión de tickets'),(5,'Comunicación efectiva'),(5,'Adaptabilidad'),
(6,'Testing funcional'),(6,'Gestión de tickets'),(6,'Resolución de problemas'),(6,'Trabajo en equipo')) v(Numero,Descripcion) ON o.Numero=v.Numero;

-- 6. Todos los postulantes se postulan a todas las ofertas.
INSERT dbo.Postulacion (IdUsuario,IdCV,IdOferta,FechaPostulacion,EstadoPostulacion)
SELECT c.IdUsuario,c.IdCV,o.IdOferta,DATEADD(day,-10,SYSDATETIME()),'Pendiente' FROM @CV c CROSS JOIN @Ofertas o;
-- Un aceptado por cada oferta cerrada; la cancelada no tiene contratación.
UPDATE p SET EstadoPostulacion=CASE WHEN c.Perfil=o.Numero THEN 'Aceptado' ELSE 'Rechazado' END
FROM dbo.Postulacion p JOIN @CV c ON p.IdCV=c.IdCV JOIN @Ofertas o ON p.IdOferta=o.IdOferta WHERE o.Numero BETWEEN 1 AND 5;
UPDATE p SET EstadoPostulacion='Rechazado' FROM dbo.Postulacion p JOIN @Ofertas o ON p.IdOferta=o.IdOferta WHERE o.Numero=6;
UPDATE f SET EstadoOferta=CASE WHEN o.Numero=6 THEN 'Cancelada' ELSE 'Cerrada' END FROM dbo.OfertaLaboral f JOIN @Ofertas o ON f.IdOferta=o.IdOferta;


-- 7. Ofertas activas sin postulaciones.
DECLARE @NuevasOfertas TABLE (IdOferta bigint, Titulo varchar(150));
INSERT dbo.OfertaLaboral (IdEmpresa,TituloOferta,Zona,TipoDeJornada,Descripcion,AceptaDiscapacidad,EstadoOferta,FechaPublicacion)
OUTPUT inserted.IdOferta,inserted.TituloOferta INTO @NuevasOfertas
SELECT e.Id,v.Titulo,'Bahía Blanca',v.Jornada,v.Descripcion,v.Acepta,'Activa',DATEADD(day,-3,GETDATE())
FROM @Empresas e CROSS JOIN (VALUES
('Auxiliar de depósito','Full-time','Recepción, clasificación y preparación de mercadería.',0),
('Recepcionista','Part-time','Recepción de visitantes y coordinación de turnos.',1),
('Operario de limpieza','Full-time','Higiene y mantenimiento de espacios comerciales.',0),
('Vendedor de salón','Full-time','Asesoramiento comercial y reposición de productos.',1),
('Cajero comercial','Part-time','Cobro de compras y cierre diario de caja.',1),
('Ayudante de cocina','Full-time','Preparación de ingredientes y mantenimiento de la cocina.',0),
('Auxiliar de logística','Full-time','Coordinación de despachos y seguimiento de entregas.',1),
('Operario de mantenimiento','Full-time','Mantenimiento preventivo de instalaciones y equipos.',0),
('Asistente de recursos humanos','Part-time','Gestión de legajos y coordinación de entrevistas.',1),
('Asistente de compras','Full-time','Solicitud de cotizaciones y seguimiento de proveedores.',1)
) v(Titulo,Jornada,Descripcion,Acepta) WHERE e.Mail='servicios@cvjoven.test';
INSERT dbo.Requisito (idOferta,Descripcion)
SELECT o.IdOferta,v.Descripcion FROM @NuevasOfertas o JOIN (VALUES
('Auxiliar de depósito','Control de stock'),
('Auxiliar de depósito','Preparación de pedidos'),
('Auxiliar de depósito','Organización'),
('Auxiliar de depósito','Trabajo en equipo'),
('Recepcionista','Atención al cliente'),
('Recepcionista','Microsoft Word'),
('Recepcionista','Comunicación efectiva'),
('Recepcionista','Organización'),
('Operario de limpieza','Limpieza profesional'),
('Operario de limpieza','Manejo de insumos'),
('Operario de limpieza','Responsabilidad'),
('Operario de limpieza','Puntualidad'),
('Vendedor de salón','Ventas'),
('Vendedor de salón','Atención al cliente'),
('Vendedor de salón','Comunicación efectiva'),
('Vendedor de salón','Adaptabilidad'),
('Cajero comercial','Manejo de caja'),
('Cajero comercial','Medios de pago'),
('Cajero comercial','Atención al detalle'),
('Cajero comercial','Atención al cliente'),
('Ayudante de cocina','Manipulación de alimentos'),
('Ayudante de cocina','Higiene alimentaria'),
('Ayudante de cocina','Trabajo en equipo'),
('Ayudante de cocina','Organización'),
('Auxiliar de logística','Excel'),
('Auxiliar de logística','Control de stock'),
('Auxiliar de logística','Gestión documental'),
('Auxiliar de logística','Resolución de problemas'),
('Operario de mantenimiento','Mantenimiento general'),
('Operario de mantenimiento','Uso de herramientas'),
('Operario de mantenimiento','Responsabilidad'),
('Operario de mantenimiento','Resolución de problemas'),
('Asistente de recursos humanos','Excel'),
('Asistente de recursos humanos','Gestión documental'),
('Asistente de recursos humanos','Comunicación efectiva'),
('Asistente de recursos humanos','Confidencialidad'),
('Asistente de compras','Excel'),
('Asistente de compras','Negociación'),
('Asistente de compras','Gestión de proveedores'),
('Asistente de compras','Organización')
) v(Titulo,Descripcion) ON o.Titulo=v.Titulo;
IF (SELECT COUNT(*) FROM dbo.OfertaLaboral)<>16 THROW 50003,'Cantidad de ofertas incorrecta',1;
IF (SELECT COUNT(*) FROM dbo.Requisito)<>64 THROW 50004,'Cantidad de requisitos incorrecta',1;
IF EXISTS (SELECT 1 FROM dbo.Postulacion p JOIN @NuevasOfertas n ON p.IdOferta=n.IdOferta) THROW 50005,'Las ofertas nuevas deben estar sin postulaciones',1;

IF (SELECT COUNT(*) FROM dbo.Postulacion)<>30 THROW 50001,'Cantidad de postulaciones incorrecta',1;
IF EXISTS (SELECT 1 FROM dbo.OfertaLaboral f LEFT JOIN dbo.Postulacion p ON f.IdOferta=p.IdOferta AND p.EstadoPostulacion='Aceptado' WHERE f.EstadoOferta='Cerrada' GROUP BY f.IdOferta HAVING COUNT(p.IdPostulacion)<>1) THROW 50002,'Cantidad de aceptados incorrecta',1;
COMMIT TRANSACTION;
END TRY
BEGIN CATCH
IF @@TRANCOUNT>0 ROLLBACK TRANSACTION;
THROW;
END CATCH;
GO
-- Verificación de resultados.
SELECT f.TituloOferta,f.EstadoOferta,COUNT(p.IdPostulacion) AS TotalPostulaciones,SUM(CASE WHEN p.EstadoPostulacion='Aceptado' THEN 1 ELSE 0 END) AS Aceptados FROM dbo.OfertaLaboral f LEFT JOIN dbo.Postulacion p ON f.IdOferta=p.IdOferta GROUP BY f.IdOferta,f.TituloOferta,f.EstadoOferta;
SELECT u.Nombre,u.Apellido,f.TituloOferta,h.Descripcion AS Coincidencia,h.TipoHabilidad FROM dbo.Postulacion p JOIN dbo.Usuario u ON p.IdUsuario=u.idUsuario JOIN dbo.OfertaLaboral f ON p.IdOferta=f.IdOferta JOIN dbo.Habilidades h ON h.IdCV=p.IdCV JOIN dbo.Requisito r ON r.idOferta=f.IdOferta AND r.Descripcion=h.Descripcion ORDER BY f.TituloOferta,u.Nombre;
SELECT COUNT(*) AS TotalTokens FROM dbo.Token;
SELECT COUNT(*) AS TotalCodigos FROM dbo.codigos_cambios_password;
GO
-- 8. Operación opcional de borrado físico. Descomentar para ejecutar.
-- ROLLBACK conserva el escenario original de 30 postulaciones.
/*
BEGIN TRANSACTION;
DECLARE @OfertaBorrar bigint=(SELECT IdOferta FROM dbo.OfertaLaboral WHERE TituloOferta='Tester QA Junior');
DELETE FROM dbo.Postulacion WHERE IdOferta=@OfertaBorrar;
DELETE FROM dbo.OfertaLaboral WHERE IdOferta=@OfertaBorrar; -- Requisito se elimina por CASCADE.
SELECT * FROM dbo.OfertaLaboral WHERE IdOferta=@OfertaBorrar;
ROLLBACK TRANSACTION; -- Cambiar a COMMIT únicamente si desea eliminarla definitivamente.
*/
