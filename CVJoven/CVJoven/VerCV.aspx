<%@ Page Language="C#" AutoEventWireup="true" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Globalization" %>
<%@ Import Namespace="CVJoven.Dominio" %>
<%@ Import Namespace="CVJoven.Negocio" %>
<%@ Import Namespace="System.Data" %>

<script runat="server">
    private void CargarCVComoEmpresa()
    {
        long idPostulacion;

        if (!long.TryParse(
            Request.QueryString["idPostulacion"],
            out idPostulacion) || idPostulacion <= 0)
        {
            Response.Redirect("MiEmpresa.aspx");
            return;
        }

        long idEmpresa = Convert.ToInt64(Session["IdEmpresa"]);

        PostulacionNegocio negocio = new PostulacionNegocio();

        DataTable tabla = negocio.ObtenerCandidatoPorPostulacion(idPostulacion, idEmpresa);

        if (tabla.Rows.Count == 0)
        {
            Response.Redirect("MiEmpresa.aspx");
            return;
        }

        DataRow fila = tabla.Rows[0];

        Usuario candidato = new Usuario();
        candidato.IdUsuario = Convert.ToInt64(fila["IdUsuario"]);
        candidato.Nombre = fila["Nombre"].ToString();
        candidato.Apellido = fila["Apellido"].ToString();
        candidato.ZonaLocalidad = fila["ZonaLocalidad"].ToString();
        candidato.FechaNacimiento = Convert.ToDateTime(fila["FechaNacimiento"]);
        candidato.Mail = fila["Mail"].ToString();
        candidato.Celular = fila["Celular"].ToString();
        candidato.DNI = "";

        long idCV = Convert.ToInt64(fila["IdCV"]);
        long idOferta = Convert.ToInt64(fila["IdOferta"]);

        CargarVistaPreviaCV(idCV, candidato);

        lnkEditarCV.Visible = false;
        pnlLocalidad.Visible = true;
        pnlCelular.Visible = true;
        pnlEmail.Visible = true;

        lnkVolver.NavigateUrl = "Candidatos.aspx?idOferta=" + idOferta;
        lnkVolver.Text = "Volver a candidatos";
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        Usuario usuario = Session["Usuario"] as Usuario;

        if (usuario == null && Session["IdEmpresa"] == null)
        {
            Response.Redirect("~/Login.aspx", false);
            Context.ApplicationInstance.CompleteRequest();
            return;
        }

        if (!IsPostBack)
        {
            if (Session["IdEmpresa"] != null)
            {
                CargarCVComoEmpresa();
            }
            else
            {
                long idCV;

                if (long.TryParse(Request.QueryString["id"], out idCV))
                {
                    CargarVistaPreviaCV(idCV, usuario);
                }
                else
                {
                    Response.Redirect("MisCurriculums.aspx", false);
                    Context.ApplicationInstance.CompleteRequest();
                }
            }
        }
    }

    private string FormatearTitulo(string texto)
    {
        if (string.IsNullOrWhiteSpace(texto)) return "";
        TextInfo ti = new CultureInfo("es-AR", false).TextInfo;
        return ti.ToTitleCase(texto.Trim().ToLower());
    }

    private string FormatearOracion(string texto)
    {
        if (string.IsNullOrWhiteSpace(texto)) return "";
        string limpio = texto.Trim();
        return char.ToUpper(limpio[0]) + limpio.Substring(1);
    }

    private void CargarVistaPreviaCV(long idCV, Usuario usuario)
    {
        CVNegocio negocio = new CVNegocio();
        CV cv = negocio.ObtenerCVPorId(idCV);

        if (cv == null || cv.IdUsuario != usuario.IdUsuario)
        {
            Response.Redirect("MisCurriculums.aspx", false);
            Context.ApplicationInstance.CompleteRequest();
            return;
        }

        List<Educacion> estudios = negocio.ListarEducacionPorCV(idCV);
        List<Experiencia> experiencias = negocio.ListarExperienciaPorCV(idCV);
        List<Habilidad> todasHabilidades = negocio.ListarHabilidadesPorCV(idCV);

        List<Habilidad> habilidadesFiltradas = new List<Habilidad>();
        List<string> habilidadesTecnicas = new List<string>();
        List<string> habilidadesBlandas = new List<string>();
        List<string> idiomas = new List<string>();

        if (todasHabilidades != null)
        {
            foreach (var hab in todasHabilidades)
            {
                if (string.IsNullOrWhiteSpace(hab.Descripcion)) continue;

                if (hab.Descripcion.StartsWith("Idioma:", StringComparison.OrdinalIgnoreCase))
                {
                    idiomas.Add(FormatearOracion(hab.Descripcion.Substring(7).Trim()));
                }
                else
                {
                    hab.Descripcion = FormatearOracion(hab.Descripcion);
                    habilidadesFiltradas.Add(hab);

                    if (hab.TipoHabilidad)
                        habilidadesBlandas.Add(hab.Descripcion);
                    else
                        habilidadesTecnicas.Add(hab.Descripcion);
                }
            }
        }

        if (estudios != null)
        {
            foreach (var edu in estudios)
            {
                edu.Titulo = FormatearTitulo(edu.Titulo);
                edu.Institucion = FormatearTitulo(edu.Institucion);
            }
        }

        if (experiencias != null)
        {
            foreach (var exp in experiencias)
            {
                exp.Puesto = FormatearTitulo(exp.Puesto);
                exp.Empresa = FormatearTitulo(exp.Empresa);
                exp.Descripcion = FormatearOracion(exp.Descripcion);
            }
        }

        string nombreCompleto = FormatearTitulo(usuario.Nombre + " " + usuario.Apellido);
        string localidad = FormatearTitulo(usuario.ZonaLocalidad);
        string email = usuario.Mail.ToLower();
        string celular = usuario.Celular;

        string inicialNombre = !string.IsNullOrWhiteSpace(usuario.Nombre) ? usuario.Nombre.Trim()[0].ToString().ToUpper() : "U";
        string inicialApellido = !string.IsNullOrWhiteSpace(usuario.Apellido) ? usuario.Apellido.Trim()[0].ToString().ToUpper() : "";
        lblIniciales.Text = inicialNombre + inicialApellido;

        lblTituloDocumento.Text = Server.HtmlEncode(FormatearOracion(cv.nombreDelCV));
        lnkEditarCV.NavigateUrl = $"CrearCurriculum.aspx?id={idCV}";

        // Datos Vista Moderna
        lblNombreCompleto.Text = Server.HtmlEncode(nombreCompleto);
        lblDisponibilidad.Text = Server.HtmlEncode(cv.DisponibilidadHoraria);
        lblLocalidad.Text = Server.HtmlEncode(localidad);
        lblCelular.Text = Server.HtmlEncode(celular);
        lblEmail.Text = Server.HtmlEncode(email);

        // Datos Vista ATS
        lblNombreATS.Text = Server.HtmlEncode(nombreCompleto);
        List<string> contactoATS = new List<string>();
        if (!string.IsNullOrWhiteSpace(localidad)) contactoATS.Add(localidad);
        if (!string.IsNullOrWhiteSpace(celular)) contactoATS.Add(celular);
        if (!string.IsNullOrWhiteSpace(email)) contactoATS.Add(email);
        contactoATS.Add("Disponibilidad " + cv.DisponibilidadHoraria);
        lblContactoATS.Text = Server.HtmlEncode(string.Join("  •  ", contactoATS));

        // Perfil profesional en primera persona
        string perfil = negocio.GenerarPerfilProfesional(usuario, cv, estudios, experiencias, habilidadesFiltradas);
        if (idiomas.Count > 0)
        {
            perfil += $" Además, cuento con conocimientos en idiomas: {string.Join(", ", idiomas)}.";
        }
        lblPerfilProfesional.Text = Server.HtmlEncode(perfil);
        lblPerfilATS.Text = Server.HtmlEncode(perfil);

        // Educación (se oculta si está vacía)
        if (estudios != null && estudios.Count > 0)
        {
            pnlEducacionModerna.Visible = true;
            repEducacion.DataSource = estudios;
            repEducacion.DataBind();

            pnlEducacionATS.Visible = true;
            repEducacionATS.DataSource = estudios;
            repEducacionATS.DataBind();
        }

        // Experiencia (se oculta si está vacía)
        if (experiencias != null && experiencias.Count > 0)
        {
            pnlExperienciaModerna.Visible = true;
            repExperiencia.DataSource = experiencias;
            repExperiencia.DataBind();

            pnlExperienciaATS.Visible = true;
            repExperienciaATS.DataSource = experiencias;
            repExperienciaATS.DataBind();
        }

        // Habilidades (compactas en chips, ocultas si están vacías)
        if (habilidadesFiltradas.Count > 0)
        {
            pnlHabilidadesModerna.Visible = true;
            pnlHabilidadesATS.Visible = true;

            if (habilidadesTecnicas.Count > 0)
            {
                pnlTecnicasModerna.Visible = true;
                repTecnicasModerna.DataSource = habilidadesTecnicas;
                repTecnicasModerna.DataBind();

                pnlTecnicasATS.Visible = true;
                lblTecnicasATS.Text = Server.HtmlEncode(string.Join(", ", habilidadesTecnicas));
            }

            if (habilidadesBlandas.Count > 0)
            {
                pnlBlandasModerna.Visible = true;
                repBlandasModerna.DataSource = habilidadesBlandas;
                repBlandasModerna.DataBind();

                pnlBlandasATS.Visible = true;
                lblBlandasATS.Text = Server.HtmlEncode(string.Join(", ", habilidadesBlandas));
            }
        }

        // Idiomas (ocultos si están vacíos)
        if (idiomas.Count > 0)
        {
            pnlIdiomas.Visible = true;
            repIdiomas.DataSource = idiomas;
            repIdiomas.DataBind();

            pnlIdiomasATS.Visible = true;
            lblIdiomasATS.Text = Server.HtmlEncode(string.Join("  •  ", idiomas));
        }
    }
</script>

<!DOCTYPE html>
<html lang="es">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Vista previa de CV | CVJoven</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet" />
    <style>
        body {
            background-color: #e2e8f0;
            font-family: 'Segoe UI', system-ui, -apple-system, sans-serif;
        }
        .hoja-cv {
            max-width: 860px;
            margin: 22px auto 50px auto;
            background: #ffffff;
            box-shadow: 0 12px 30px rgba(15, 23, 42, 0.12);
            min-height: 920px;
            border-radius: 10px;
            overflow: hidden;
        }

        /* --- ESTILOS DISEÑO MODERNO --- */
        .columna-lateral {
            background: linear-gradient(180deg, #0f172a 0%, #1e293b 100%);
            color: #f8fafc;
            padding: 36px 26px;
        }
        .avatar-iniciales {
            width: 72px;
            height: 72px;
            border-radius: 50%;
            background: rgba(59, 130, 246, 0.2);
            border: 2px solid #3b82f6;
            color: #93c5fd;
            font-size: 1.6rem;
            font-weight: 700;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 16px;
        }
        .columna-principal {
            padding: 38px 38px;
            background-color: #ffffff;
        }
        .titulo-seccion {
            border-bottom: 2px solid #e2e8f0;
            padding-bottom: 8px;
            margin-bottom: 16px;
            font-weight: 700;
            text-transform: uppercase;
            font-size: 0.88rem;
            letter-spacing: 0.8px;
            color: #0f172a;
            display: flex;
            align-items: center;
        }
        .titulo-lateral {
            border-bottom: 1px solid #334155;
            padding-bottom: 7px;
            margin-bottom: 12px;
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.78rem;
            letter-spacing: 1px;
            color: #93c5fd;
        }
        .subtitulo-lateral {
            font-size: 0.72rem;
            text-transform: uppercase;
            letter-spacing: 0.6px;
            color: #94a3b8;
            margin-bottom: 6px;
            font-weight: 600;
        }
        .item-contacto {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 10px;
            font-size: 0.86rem;
            color: #e2e8f0;
        }
        .item-contacto i {
            color: #60a5fa;
            font-size: 0.95rem;
        }
        .chip-compacto {
            display: inline-block;
            background-color: rgba(255, 255, 255, 0.09);
            border: 1px solid rgba(148, 163, 184, 0.28);
            border-radius: 6px;
            padding: 4px 10px;
            font-size: 0.8rem;
            color: #f1f5f9;
            line-height: 1.3;
        }
        .chip-compacto.tecnica {
            border-color: rgba(59, 130, 246, 0.5);
            background-color: rgba(59, 130, 246, 0.16);
        }
        .chip-compacto.blanda {
            border-color: rgba(56, 189, 248, 0.45);
            background-color: rgba(56, 189, 248, 0.12);
        }
        .bloque-item {
            border-left: 3px solid #2563eb;
            padding-left: 16px;
            margin-bottom: 18px;
        }
        .caja-perfil {
            background-color: #f8fafc;
            border-left: 4px solid #2563eb;
            padding: 15px 18px;
            border-radius: 0 8px 8px 0;
            color: #334155;
            font-size: 0.93rem;
            line-height: 1.62;
        }

        /* --- ESTILOS FORMATO ATS (CLÁSICO / HARVARD) --- */
        .hoja-ats {
            padding: 46px 54px;
            color: #111111;
            font-family: Arial, Helvetica, sans-serif;
            line-height: 1.5;
        }
        .ats-header {
            text-align: center;
            border-bottom: 2px solid #111111;
            padding-bottom: 14px;
            margin-bottom: 20px;
        }
        .ats-nombre {
            font-size: 1.75rem;
            font-weight: 700;
            letter-spacing: 0.6px;
            text-transform: uppercase;
            margin: 0 0 6px 0;
            color: #000000;
        }
        .ats-contacto {
            font-size: 0.88rem;
            color: #222222;
        }
        .ats-seccion {
            margin-bottom: 20px;
        }
        .ats-titulo {
            font-size: 0.92rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.8px;
            border-bottom: 1px solid #333333;
            padding-bottom: 4px;
            margin-bottom: 10px;
            color: #000000;
        }
        .ats-item {
            margin-bottom: 12px;
        }
        .ats-texto {
            font-size: 0.9rem;
            color: #1f2937;
            margin: 0;
        }

        @media print {
            body { background: #ffffff; }
            .no-imprimir { display: none !important; }
            .hoja-cv {
                box-shadow: none;
                margin: 0;
                max-width: 100%;
                min-height: auto;
                border-radius: 0;
            }
            .hoja-ats {
                padding: 16px 24px;
            }
            .columna-lateral, .caja-perfil, .chip-compacto {
                -webkit-print-color-adjust: exact;
                print-color-adjust: exact;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <!-- BARRA DE ACCIONES SUPERIOR -->
        <div class="container pt-4 no-imprimir" style="max-width: 860px;">
            <div class="d-flex flex-wrap justify-content-between align-items-center gap-2 bg-white p-3 rounded-3 shadow-sm">
                <div class="d-flex align-items-center gap-2">
                    <span class="badge bg-primary-subtle text-primary px-3 py-2">CV Generado</span>
                    <asp:Label ID="lblTituloDocumento" runat="server" CssClass="fw-bold text-dark fs-6" />
                </div>

                <!-- Selector Moderno / ATS -->
                <div class="btn-group btn-group-sm" role="group" aria-label="Formato de CV">
                    <button type="button" id="btnModoModerno" class="btn btn-primary" onclick="cambiarFormato('moderno')">
                        <i class="bi bi-layout-sidebar me-1"></i>Moderno
                    </button>
                    <button type="button" id="btnModoATS" class="btn btn-outline-dark" onclick="cambiarFormato('ats')">
                        <i class="bi bi-file-earmark-check me-1"></i>Formato ATS
                    </button>
                </div>

                <div class="d-flex flex-wrap gap-2">
                    <asp:HyperLink ID="lnkVolver"
                        runat="server"
                        NavigateUrl="MisCurriculums.aspx"
                        Text="Volver a Mis CVs"
                        CssClass="btn btn-outline-secondary btn-sm px-3" />
                    <asp:HyperLink ID="lnkEditarCV" runat="server" CssClass="btn btn-outline-primary btn-sm px-3">
                        <i class="bi bi-pencil me-1"></i>Editar CV
                    </asp:HyperLink>
                    <button type="button" class="btn btn-primary btn-sm fw-semibold px-3" onclick="window.print();">
                        <i class="bi bi-file-earmark-pdf me-1"></i>Descargar PDF / Imprimir
                    </button>
                </div>
            </div>
            <div id="notaATS" class="small text-secondary mt-2 d-none">
                <i class="bi bi-info-circle me-1"></i>
                <strong>Formato ATS:</strong> diseño limpio de una columna pensado para pasar filtros automáticos de selección y ahorrar tinta al imprimir.
            </div>
        </div>

        <!-- 1. VISTA DISEÑO MODERNO -->
        <div id="vistaModerna" class="hoja-cv row g-0">
            <!-- Columna Izquierda -->
            <div class="col-md-4 columna-lateral">
                <div class="mb-4 pb-2">
                    <div class="avatar-iniciales">
                        <asp:Label ID="lblIniciales" runat="server" />
                    </div>
                    <h1 class="h4 fw-bold mb-2 text-white"><asp:Label ID="lblNombreCompleto" runat="server" /></h1>
                    <span class="badge bg-primary px-3 py-2 fw-normal">
                        <i class="bi bi-clock me-1"></i>Disponibilidad <asp:Label ID="lblDisponibilidad" runat="server" />
                    </span>
                </div>

                <div class="mb-4 pb-2">
                    <h6 class="titulo-lateral">Datos de Contacto</h6>
                    <div id="pnlLocalidad" runat="server" class="item-contacto">
                        <i class="bi bi-geo-alt-fill"></i>
                        <span><asp:Label ID="lblLocalidad" runat="server" /></span>
                    </div>
                    <div id="pnlCelular" runat="server" class="item-contacto">
                        <i class="bi bi-telephone-fill"></i>
                        <span><asp:Label ID="lblCelular" runat="server" /></span>
                    </div>
                    <div id="pnlEmail" runat="server" class="item-contacto text-break mb-0">
                        <i class="bi bi-envelope-fill"></i>
                        <span><asp:Label ID="lblEmail" runat="server" /></span>
                    </div>
                </div>

                <!-- Habilidades en chips compactos (se oculta si no tiene ninguna) -->
                <asp:Panel ID="pnlHabilidadesModerna" runat="server" Visible="false" CssClass="mb-4 pb-2">
                    <h6 class="titulo-lateral">Habilidades</h6>

                    <asp:Panel ID="pnlTecnicasModerna" runat="server" Visible="false" CssClass="mb-3">
                        <div class="subtitulo-lateral">Técnicas</div>
                        <div class="d-flex flex-wrap gap-2">
                            <asp:Repeater ID="repTecnicasModerna" runat="server">
                                <ItemTemplate>
                                    <span class="chip-compacto tecnica"><%#: Container.DataItem %></span>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>
                    </asp:Panel>

                    <asp:Panel ID="pnlBlandasModerna" runat="server" Visible="false">
                        <div class="subtitulo-lateral">Blandas</div>
                        <div class="d-flex flex-wrap gap-2">
                            <asp:Repeater ID="repBlandasModerna" runat="server">
                                <ItemTemplate>
                                    <span class="chip-compacto blanda"><%#: Container.DataItem %></span>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>
                    </asp:Panel>
                </asp:Panel>

                <!-- Idiomas en chips compactos (se oculta si no tiene) -->
                <asp:Panel ID="pnlIdiomas" runat="server" Visible="false">
                    <h6 class="titulo-lateral">Idiomas</h6>
                    <div class="d-flex flex-wrap gap-2">
                        <asp:Repeater ID="repIdiomas" runat="server">
                            <ItemTemplate>
                                <span class="chip-compacto"><i class="bi bi-translate text-info me-1"></i><%#: Container.DataItem %></span>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </asp:Panel>
            </div>

            <!-- Columna Derecha -->
            <div class="col-md-8 columna-principal">
                <div class="mb-4 pb-2">
                    <h5 class="titulo-seccion"><i class="bi bi-person-lines-fill text-primary me-2 fs-5"></i>Perfil Profesional</h5>
                    <div class="caja-perfil">
                        <asp:Label ID="lblPerfilProfesional" runat="server" />
                    </div>
                </div>

                <asp:Panel ID="pnlExperienciaModerna" runat="server" Visible="false" CssClass="mb-4 pb-2">
                    <h5 class="titulo-seccion"><i class="bi bi-briefcase-fill text-primary me-2 fs-5"></i>Experiencia Laboral y Voluntariado</h5>
                    <asp:Repeater ID="repExperiencia" runat="server">
                        <ItemTemplate>
                            <div class="bloque-item">
                                <div class="d-flex justify-content-between align-items-center mb-1">
                                    <h6 class="fw-bold mb-0 text-dark fs-6"><%#: Eval("Puesto") %></h6>
                                    <span class="badge bg-light text-primary border border-primary-subtle"><%#: Eval("TipoExperiencia") %></span>
                                </div>
                                <div class="text-primary fw-semibold small mb-1">
                                    <i class="bi bi-building me-1"></i><%#: Eval("Empresa") %>
                                    <span class="text-muted fw-normal ms-2">
                                        | <i class="bi bi-calendar3 me-1"></i><%# Eval("FechaDesde", "{0:MM/yyyy}") %> -
                                        <%# Convert.ToDateTime(Eval("FechaHasta")) == DateTime.MinValue ? "Actualidad" : Eval("FechaHasta", "{0:MM/yyyy}") %>
                                    </span>
                                </div>
                                <p class="small text-secondary mb-0 mt-1"><%#: Eval("Descripcion") %></p>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </asp:Panel>

                <asp:Panel ID="pnlEducacionModerna" runat="server" Visible="false">
                    <h5 class="titulo-seccion"><i class="bi bi-mortarboard-fill text-primary me-2 fs-5"></i>Educación y Formación</h5>
                    <asp:Repeater ID="repEducacion" runat="server">
                        <ItemTemplate>
                            <div class="bloque-item">
                                <div class="d-flex justify-content-between align-items-center mb-1">
                                    <h6 class="fw-bold mb-0 text-dark fs-6"><%#: Eval("Titulo") %></h6>
                                    <span class="badge bg-secondary-subtle text-dark">Año <%# Eval("Anio") %></span>
                                </div>
                                <div class="small text-primary fw-semibold mb-1">
                                    <i class="bi bi-bank me-1"></i><%#: Eval("Institucion") %>
                                </div>
                                <div class="small text-muted">Nivel alcanzado: <strong><%#: Eval("NivelAlcanzado") %></strong></div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </asp:Panel>
            </div>
        </div>

        <!-- 2. VISTA FORMATO ATS (UNA COLUMNA, COMPATIBLE CON FILTROS AUTOMÁTICOS) -->
        <div id="vistaATS" class="hoja-cv hoja-ats d-none">
            <header class="ats-header">
                <h1 class="ats-nombre"><asp:Label ID="lblNombreATS" runat="server" /></h1>
                <div class="ats-contacto"><asp:Label ID="lblContactoATS" runat="server" /></div>
            </header>

            <section class="ats-seccion">
                <h2 class="ats-titulo">Perfil Profesional</h2>
                <p class="ats-texto"><asp:Label ID="lblPerfilATS" runat="server" /></p>
            </section>

            <asp:Panel ID="pnlExperienciaATS" runat="server" Visible="false" CssClass="ats-seccion">
                <h2 class="ats-titulo">Experiencia Laboral y Voluntariado</h2>
                <asp:Repeater ID="repExperienciaATS" runat="server">
                    <ItemTemplate>
                        <div class="ats-item">
                            <div class="d-flex justify-content-between align-items-baseline">
                                <strong><%#: Eval("Puesto") %> — <%#: Eval("Empresa") %> (<%#: Eval("TipoExperiencia") %>)</strong>
                                <span class="small text-muted">
                                    <%# Eval("FechaDesde", "{0:MM/yyyy}") %> -
                                    <%# Convert.ToDateTime(Eval("FechaHasta")) == DateTime.MinValue ? "Actualidad" : Eval("FechaHasta", "{0:MM/yyyy}") %>
                                </span>
                            </div>
                            <p class="ats-texto mt-1"><%#: Eval("Descripcion") %></p>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </asp:Panel>

            <asp:Panel ID="pnlEducacionATS" runat="server" Visible="false" CssClass="ats-seccion">
                <h2 class="ats-titulo">Educación y Formación</h2>
                <asp:Repeater ID="repEducacionATS" runat="server">
                    <ItemTemplate>
                        <div class="ats-item">
                            <div class="d-flex justify-content-between align-items-baseline">
                                <strong><%#: Eval("Titulo") %> — <%#: Eval("Institucion") %></strong>
                                <span class="small text-muted">Año <%# Eval("Anio") %></span>
                            </div>
                            <div class="ats-texto">Nivel alcanzado: <%#: Eval("NivelAlcanzado") %></div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </asp:Panel>

            <asp:Panel ID="pnlHabilidadesATS" runat="server" Visible="false" CssClass="ats-seccion">
                <h2 class="ats-titulo">Habilidades y Competencias</h2>
                <asp:Panel ID="pnlTecnicasATS" runat="server" Visible="false" CssClass="mb-1">
                    <p class="ats-texto"><strong>Habilidades técnicas:</strong> <asp:Label ID="lblTecnicasATS" runat="server" /></p>
                </asp:Panel>
                <asp:Panel ID="pnlBlandasATS" runat="server" Visible="false">
                    <p class="ats-texto"><strong>Habilidades blandas:</strong> <asp:Label ID="lblBlandasATS" runat="server" /></p>
                </asp:Panel>
            </asp:Panel>

            <asp:Panel ID="pnlIdiomasATS" runat="server" Visible="false" CssClass="ats-seccion mb-0">
                <h2 class="ats-titulo">Idiomas</h2>
                <p class="ats-texto"><asp:Label ID="lblIdiomasATS" runat="server" /></p>
            </asp:Panel>
        </div>
    </form>

    <script>
        function cambiarFormato(formato) {
            var moderna = document.getElementById('vistaModerna');
            var ats = document.getElementById('vistaATS');
            var btnMod = document.getElementById('btnModoModerno');
            var btnAts = document.getElementById('btnModoATS');
            var nota = document.getElementById('notaATS');

            if (formato === 'ats') {
                moderna.classList.add('d-none');
                ats.classList.remove('d-none');
                nota.classList.remove('d-none');
                btnMod.className = 'btn btn-outline-primary';
                btnAts.className = 'btn btn-dark';
            } else {
                ats.classList.add('d-none');
                moderna.classList.remove('d-none');
                nota.classList.add('d-none');
                btnMod.className = 'btn btn-primary';
                btnAts.className = 'btn btn-outline-dark';
            }
        }
    </script>
</body>
</html>