
<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CrearCurriculum.aspx.cs" Inherits="CVJoven.CrearCurriculum" %>

<!DOCTYPE html>
<html lang="es">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Crear currículum | CVJoven</title>

    <style>
        * { box-sizing: border-box; }

        body {
            margin: 0;
            font-family: 'Segoe UI', Arial, sans-serif;
            background: #f5f7fc;
            color: #18243b;
        }

        .navbar {
            background: white;
            padding: 20px 6%;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid #e8ecf4;
        }

        .logo {
            color: #5145d9;
            font-size: 25px;
            font-weight: 800;
        }

        .volver {
            text-decoration: none;
            color: #59657a;
            font-weight: 600;
        }

        .contenedor {
            max-width: 1320px;
            margin: 35px auto;
            padding: 0 25px;
        }

        .encabezado h1 {
            font-size: 32px;
            margin-bottom: 8px;
        }

        .encabezado p {
            color: #748096;
            margin-top: 0;
        }

        .progreso {
            display: flex;
            align-items: center;
            gap: 12px;
            margin: 25px 0 32px;
            font-size: 13px;
            color: #646f84;
        }

        .progreso span {
            padding: 9px 14px;
            background: #fff;
            border-radius: 25px;
        }

        .progreso .activo {
            background: #5145d9;
            color: white;
        }

        .layout {
            display: grid;
            grid-template-columns: 1.2fr 0.8fr;
            gap: 25px;
            align-items: start;
        }

        .tarjeta {
            background: white;
            border-radius: 18px;
            padding: 28px;
            margin-bottom: 22px;
            border: 1px solid #e8ecf5;
            box-shadow: 0 5px 24px rgba(30, 45, 90, .035);
        }

        .titulo-seccion {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 23px;
        }

        .numero {
            background: #efedff;
            color: #5145d9;
            border-radius: 11px;
            width: 36px;
            height: 36px;
            display: grid;
            place-items: center;
            font-weight: 800;
        }

        h2 {
            font-size: 19px;
            margin: 0;
        }

        .subtexto {
            color: #8590a3;
            font-size: 13px;
            margin: 6px 0 20px;
        }

        .fila {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 17px;
        }

        .campo {
            margin-bottom: 19px;
        }

        label {
            display: block;
            font-size: 13px;
            font-weight: 650;
            margin-bottom: 8px;
        }

        .campo input,
        .campo textarea,
        .campo select {
            width: 100%;
            padding: 13px 14px;
            border: 1px solid #dce2ed;
            border-radius: 10px;
            font: inherit;
            font-size: 14px;
            background: #fcfdff;
            color: #26344d;
            outline: none;
            transition: .2s;
        }

        .campo input:focus,
        .campo textarea:focus {
            border-color: #6659e8;
            box-shadow: 0 0 0 3px #eeecff;
        }

        textarea {
            min-height: 115px;
            resize: vertical;
        }

        .ayuda {
            font-size: 12px;
            color: #8b95a6;
            margin-top: 7px;
        }

        .boton-secundario {
            background: #f0eeff;
            color: #5145d9;
            border: 1px dashed #b7afff;
            padding: 13px 16px;
            border-radius: 10px;
            font-weight: 700;
            cursor: pointer;
            width: 100%;
        }

        .boton-secundario:hover {
            background: #e6e2ff;
        }

        .entrada-extra {
            padding: 15px;
            background: #f8f9fd;
            border-radius: 12px;
            margin-bottom: 14px;
        }

        .acciones {
            display: flex;
            justify-content: flex-end;
            gap: 12px;
            padding: 15px 0 35px;
        }

        .btn {
            padding: 14px 24px;
            border-radius: 11px;
            border: none;
            font-weight: 700;
            font-size: 14px;
            cursor: pointer;
        }

        .btn-blanco {
            background: white;
            border: 1px solid #dce2ed;
            color: #58657b;
        }

        .btn-principal {
            background: #5145d9;
            color: white;
            box-shadow: 0 5px 15px #5145d933;
        }

        .btn-principal:hover {
            background: #4034c1;
        }

        .panel-vista {
            position: sticky;
            top: 22px;
        }

        .barra-vista {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 14px;
        }

        .barra-vista h2 {
            font-size: 17px;
        }

        .estado {
            font-size: 12px;
            color: #168466;
            background: #e5f8f0;
            padding: 7px 10px;
            border-radius: 25px;
        }

        .hoja {
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 15px 45px #27345916;
            min-height: 640px;
        }

        .hoja-cabecera {
            background: #222b53;
            color: white;
            padding: 36px 30px;
        }

        .hoja-cabecera h2 {
            font-size: 26px;
            margin-bottom: 7px;
            overflow-wrap: anywhere;
        }

        .hoja-cabecera p {
            margin: 6px 0;
            color: #cbd2f0;
            font-size: 12px;
            overflow-wrap: anywhere;
        }

        .hoja-cuerpo {
            padding: 30px;
        }

        .hoja-seccion {
            margin-bottom: 27px;
            overflow-wrap: anywhere;
        }

        .hoja-seccion h3 {
            color: #5145d9;
            text-transform: uppercase;
            letter-spacing: 1.3px;
            font-size: 12px;
            border-bottom: 1px solid #e8eaf3;
            padding-bottom: 10px;
        }

        .hoja-seccion p {
            color: #505d71;
            font-size: 13px;
            line-height: 1.7;
            white-space: pre-line;
        }

        .vacio {
            color: #9ca5b5 !important;
            font-style: italic;
        }

        .aviso {
            font-size: 12px;
            color: #8792a4;
            text-align: center;
            margin-top: 18px;
        }

        @media(max-width: 950px) {
            .layout { grid-template-columns: 1fr; }
            .panel-vista { position: static; }
            .progreso { flex-wrap: wrap; }
        }

        @media(max-width: 550px) {
            .fila { grid-template-columns: 1fr; gap: 0; }
            .tarjeta { padding: 20px; }
            .encabezado h1 { font-size: 26px; }
            .acciones { flex-direction: column; }
            .btn { width: 100%; }
        }
    </style>
</head>

<body>
<form id="form1" runat="server">

    <nav class="navbar">
        <div class="logo">CVJoven.</div>
        <a href="MisCurriculums.aspx" class="volver">
            ← Mis currículums
        </a>
    </nav>

    <main class="contenedor">

        <div class="encabezado">
            <h1>Creá tu currículum ✨</h1>
            <p>Mostrá tu potencial y preparate para tu próxima oportunidad laboral.</p>
        </div>

        <div class="progreso">
            <span class="activo">01 · Información personal</span>
            <span>02 · Formación</span>
            <span>03 · Experiencia</span>
            <span>04 · Habilidades</span>
        </div>

        <div class="layout">

            <!-- FORMULARIO -->
            <div>

                <section class="tarjeta">
                    <div class="titulo-seccion">
                        <div class="numero">1</div>
                        <h2>Información personal</h2>
                    </div>

                    <div class="fila">
                        <div class="campo">
                            <label>Nombre *</label>
                            <input id="nombre" type="text"
                                placeholder="Ej: Martina" required
                                oninput="actualizarVista()" />
                        </div>

                        <div class="campo">
                            <label>Apellido *</label>
                            <input id="apellido" type="text"
                                placeholder="Ej: González" required
                                oninput="actualizarVista()" />
                        </div>
                    </div>

                    <div class="fila">
                        <div class="campo">
                            <label>Correo electrónico *</label>
                            <input id="email" type="email"
                                placeholder="tuemail@ejemplo.com" required
                                oninput="actualizarVista()" />
                        </div>

                        <div class="campo">
                            <label>Teléfono</label>
                            <input id="telefono" type="tel"
                                placeholder="Ej: 11 5555-5555"
                                oninput="actualizarVista()" />
                        </div>
                    </div>

                    <div class="campo">
                        <label>Ciudad o localidad</label>
                        <input id="ubicacion" type="text"
                            placeholder="Ej: Tigre, Buenos Aires"
                            oninput="actualizarVista()" />
                    </div>

                    <div class="campo">
                        <label>¿A qué puesto aspirás?</label>
                        <input id="puesto" type="text"
                            placeholder="Ej: Atención al cliente"
                            oninput="actualizarVista()" />
                    </div>
                </section>

                <section class="tarjeta">
                    <div class="titulo-seccion">
                        <div class="numero">2</div>
                        <h2>Perfil profesional</h2>
                    </div>

                    <p class="subtexto">
                        Contá brevemente quién sos, qué sabés hacer y qué buscás.
                    </p>

                    <div class="campo">
                        <label>Sobre mí</label>
                        <textarea id="perfil"
                            placeholder="Soy una persona responsable, con ganas de aprender y desarrollar mis habilidades..."
                            oninput="actualizarVista()"></textarea>
                        <div class="ayuda">
                            Consejo: escribí entre 3 y 5 líneas.
                        </div>
                    </div>
                </section>

                <section class="tarjeta">
                    <div class="titulo-seccion">
                        <div class="numero">3</div>
                        <h2>Educación</h2>
                    </div>

                    <div id="listaEducacion">
                        <div class="entrada-extra educacion-item">
                            <div class="campo">
                                <label>Institución educativa</label>
                                <input class="institucion" type="text"
                                    placeholder="Ej: Universidad Tecnológica Nacional"
                                    oninput="actualizarVista()" />
                            </div>

                            <div class="campo">
                                <label>Título o estudios</label>
                                <input class="estudio" type="text"
                                    placeholder="Ej: Tecnicatura en Programación"
                                    oninput="actualizarVista()" />
                            </div>

                            <div class="campo">
                                <label>Período / Estado</label>
                                <input class="periodo" type="text"
                                    placeholder="Ej: 2024 - En curso"
                                    oninput="actualizarVista()" />
                            </div>
                        </div>
                    </div>

                    <button type="button" class="boton-secundario"
                        onclick="agregarEducacion()">
                        + Agregar otra formación
                    </button>
                </section>

                <section class="tarjeta">
                    <div class="titulo-seccion">
                        <div class="numero">4</div>
                        <h2>Experiencia laboral</h2>
                    </div>

                    <p class="subtexto">
                        ¿Es tu primer empleo? Podés dejar esta sección vacía.
                    </p>

                    <div id="listaExperiencia">
                        <div class="entrada-extra experiencia-item">

                            <div class="campo">
                                <label>Puesto desempeñado</label>
                                <input class="trabajo" type="text"
                                    placeholder="Ej: Vendedor"
                                    oninput="actualizarVista()" />
                            </div>

                            <div class="campo">
                                <label>Empresa</label>
                                <input class="empresa" type="text"
                                    placeholder="Ej: Comercio local"
                                    oninput="actualizarVista()" />
                            </div>

                            <div class="campo">
                                <label>Período</label>
                                <input class="fechaTrabajo" type="text"
                                    placeholder="Ej: 2023 - 2025"
                                    oninput="actualizarVista()" />
                            </div>

                            <div class="campo">
                                <label>Tareas realizadas</label>
                                <textarea class="tareas"
                                    placeholder="Describí tus principales responsabilidades..."
                                    oninput="actualizarVista()"></textarea>
                            </div>

                        </div>
                    </div>

                    <button type="button" class="boton-secundario"
                        onclick="agregarExperiencia()">
                        + Agregar otra experiencia
                    </button>
                </section>

                <section class="tarjeta">
                    <div class="titulo-seccion">
                        <div class="numero">5</div>
                        <h2>Habilidades</h2>
                    </div>

                    <p class="subtexto">
                        Incluí tus conocimientos técnicos y habilidades personales.
                    </p>

                    <div class="campo">
                        <label>Mis habilidades</label>
                        <textarea id="habilidades"
                            placeholder="Ej: Trabajo en equipo, Microsoft Office, comunicación, organización..."
                            oninput="actualizarVista()"></textarea>
                        <div class="ayuda">
                            Separá cada habilidad con una coma.
                        </div>
                    </div>
                </section>

                <div class="acciones">
                    <button type="button" class="btn btn-blanco"
                        onclick="window.location.href='MisCurriculums.aspx'">
                        Cancelar
                    </button>

                    <button type="button" class="btn btn-principal"
                        onclick="guardarBorrador()">
                        Guardar borrador
                    </button>
                </div>

            </div>

            <!-- VISTA PREVIA -->
            <aside class="panel-vista">

                <div class="barra-vista">
                    <h2>Vista previa</h2>
                    <span class="estado">● En tiempo real</span>
                </div>

                <div class="hoja">

                    <div class="hoja-cabecera">
                        <h2 id="previewNombre">Tu nombre completo</h2>
                        <p id="previewPuesto">Tu próximo puesto</p>
                        <p id="previewContacto">Email · Teléfono · Ubicación</p>
                    </div>

                    <div class="hoja-cuerpo">

                        <div class="hoja-seccion">
                            <h3>Perfil profesional</h3>
                            <p id="previewPerfil" class="vacio">
                                Tu presentación profesional aparecerá aquí.
                            </p>
                        </div>

                        <div class="hoja-seccion">
                            <h3>Educación</h3>
                            <p id="previewEducacion" class="vacio">
                                Tu formación académica aparecerá aquí.
                            </p>
                        </div>

                        <div class="hoja-seccion">
                            <h3>Experiencia laboral</h3>
                            <p id="previewExperiencia" class="vacio">
                                Tu experiencia aparecerá aquí.
                            </p>
                        </div>

                        <div class="hoja-seccion">
                            <h3>Habilidades</h3>
                            <p id="previewHabilidades" class="vacio">
                                Tus habilidades aparecerán aquí.
                            </p>
                        </div>

                    </div>
                </div>

                <p class="aviso">
                    Esta es una vista previa de tu currículum.
                </p>

            </aside>

        </div>

    </main>

</form>

<script>
    function valor(id) {
        return document.getElementById(id).value.trim();
    }

    function mostrar(id, texto, alternativo) {
        const elemento = document.getElementById(id);
        elemento.textContent = texto || alternativo;
        elemento.classList.toggle("vacio", !texto);
    }

    function actualizarVista() {
        const nombre = [valor("nombre"), valor("apellido")]
            .filter(Boolean).join(" ");

        mostrar("previewNombre", nombre, "Tu nombre completo");
        mostrar("previewPuesto", valor("puesto"), "Tu próximo puesto");

        const contacto = [
            valor("email"), valor("telefono"), valor("ubicacion")
        ].filter(Boolean).join(" · ");

        mostrar("previewContacto", contacto,
            "Email · Teléfono · Ubicación");

        mostrar("previewPerfil", valor("perfil"),
            "Tu presentación profesional aparecerá aquí.");

        mostrar("previewHabilidades", valor("habilidades"),
            "Tus habilidades aparecerán aquí.");

        const formaciones = [];

        document.querySelectorAll(".educacion-item").forEach(item => {
            const institucion = item.querySelector(".institucion").value.trim();
            const estudio = item.querySelector(".estudio").value.trim();
            const periodo = item.querySelector(".periodo").value.trim();

            if (institucion || estudio || periodo) {
                formaciones.push(
                    [estudio, institucion, periodo].filter(Boolean).join(" · ")
                );
            }
        });

        mostrar("previewEducacion", formaciones.join("\n\n"),
            "Tu formación académica aparecerá aquí.");

        const experiencias = [];

        document.querySelectorAll(".experiencia-item").forEach(item => {
            const trabajo = item.querySelector(".trabajo").value.trim();
            const empresa = item.querySelector(".empresa").value.trim();
            const fecha = item.querySelector(".fechaTrabajo").value.trim();
            const tareas = item.querySelector(".tareas").value.trim();

            if (trabajo || empresa || fecha || tareas) {
                experiencias.push(
                    [trabajo, empresa, fecha, tareas].filter(Boolean).join(" · ")
                );
            }
        });

        mostrar("previewExperiencia", experiencias.join("\n\n"),
            "Tu experiencia aparecerá aquí.");
    }

    function agregarEducacion() {
        const lista = document.getElementById("listaEducacion");
        const nuevo = lista.firstElementChild.cloneNode(true);

        nuevo.querySelectorAll("input, textarea").forEach(campo => {
            campo.value = "";
        });

        lista.appendChild(nuevo);
        actualizarVista();
    }

    function agregarExperiencia() {
        const lista = document.getElementById("listaExperiencia");
        const nuevo = lista.firstElementChild.cloneNode(true);

        nuevo.querySelectorAll("input, textarea").forEach(campo => {
            campo.value = "";
        });

        lista.appendChild(nuevo);
        actualizarVista();
    }

    function guardarBorrador() {
        const educacion = Array.from(
            document.querySelectorAll(".educacion-item")
        ).map(item => ({
            institucion: item.querySelector(".institucion").value.trim(),
            estudio: item.querySelector(".estudio").value.trim(),
            periodo: item.querySelector(".periodo").value.trim()
        }));

        const experiencia = Array.from(
            document.querySelectorAll(".experiencia-item")
        ).map(item => ({
            trabajo: item.querySelector(".trabajo").value.trim(),
            empresa: item.querySelector(".empresa").value.trim(),
            periodo: item.querySelector(".fechaTrabajo").value.trim(),
            tareas: item.querySelector(".tareas").value.trim()
        }));

        const curriculum = {
            nombre: valor("nombre"),
            apellido: valor("apellido"),
            email: valor("email"),
            telefono: valor("telefono"),
            ubicacion: valor("ubicacion"),
            puesto: valor("puesto"),
            perfil: valor("perfil"),
            educacion: educacion,
            experiencia: experiencia,
            habilidades: valor("habilidades")
        };

        if (!curriculum.nombre || !curriculum.apellido ||
            !curriculum.email) {
            alert("Completá nombre, apellido y correo electrónico.");
            return;
        }

        const emailInput = document.getElementById("email");
        if (!emailInput.checkValidity()) {
            alert("Ingresá un correo electrónico válido.");
            return;
        }

        try {
            localStorage.setItem(
                "cvjoven_borrador",
                JSON.stringify(curriculum)
            );
            alert("Borrador guardado en este navegador.");
        } catch (error) {
            alert("No se pudo guardar el borrador en este navegador.");
        }
    }
</script>

</body>
</html>
