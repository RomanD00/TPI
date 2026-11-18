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
        List<string> idiomas = new List<string>();

        if (todasHabilidades != null)
        {
            foreach (var hab in todasHabilidades)
            {
                if (hab.Descripcion != null && hab.Descripcion.StartsWith("Idioma:", StringComparison.OrdinalIgnoreCase))
                {
                    idiomas.Add(hab.Descripcion.Substring(7).Trim());
                }
                else
                {
                    hab.Descripcion = FormatearOracion(hab.Descripcion);
                    habilidadesFiltradas.Add(hab);
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

        string inicialNombre = !string.IsNullOrWhiteSpace(usuario.Nombre) ? usuario.Nombre.Trim()[0].ToString().ToUpper() : "U";
        string inicialApellido = !string.IsNullOrWhiteSpace(usuario.Apellido) ? usuario.Apellido.Trim()[0].ToString().ToUpper() : "";
        lblIniciales.Text = inicialNombre + inicialApellido;

        lblTituloDocumento.Text = FormatearOracion(cv.nombreDelCV);
        lnkEditarCV.NavigateUrl = $"CrearCurriculum.aspx?id={idCV}";
        lblNombreCompleto.Text = FormatearTitulo(usuario.Nombre + " " + usuario.Apellido);
        lblDisponibilidad.Text = cv.DisponibilidadHoraria;
        lblLocalidad.Text = FormatearTitulo(usuario.ZonaLocalidad);
        lblCelular.Text = usuario.Celular;
        lblEmail.Text = usuario.Mail.ToLower();

        string perfil = negocio.GenerarPerfilProfesional(usuario, cv, estudios, experiencias, habilidadesFiltradas);
        if (idiomas.Count > 0)
        {
            perfil += $" Manejo de idiomas: {string.Join(", ", idiomas)}.";
        }
        lblPerfilProfesional.Text = perfil;

        if (estudios != null && estudios.Count > 0)
        {
            repEducacion.DataSource = estudios;
            repEducacion.DataBind();
        }
        else
        {
            lblSinEducacion.Visible = true;
        }

        if (experiencias != null && experiencias.Count > 0)
        {
            repExperiencia.DataSource = experiencias;
            repExperiencia.DataBind();
        }
        else
        {
            lblSinExperiencia.Visible = true;
        }

        if (habilidadesFiltradas.Count > 0)
        {
            repHabilidades.DataSource = habilidadesFiltradas;
            repHabilidades.DataBind();
        }
        else
        {
            lblSinHabilidades.Visible = true;
        }

        if (idiomas.Count > 0)
        {
            pnlIdiomas.Visible = true;
            repIdiomas.DataSource = idiomas;
            repIdiomas.DataBind();
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
            margin: 25px auto 50px auto;
            background: #ffffff;
            box-shadow: 0 12px 30px rgba(15, 23, 42, 0.12);
            min-height: 920px;
            border-radius: 10px;
            overflow: hidden;
        }
        .columna-lateral {
            background: linear-gradient(180deg, #0f172a 0%, #1e293b 100%);
            color: #f8fafc;
            padding: 40px 30px;
        }
        .avatar-iniciales {
            width: 78px;
            height: 78px;
            border-radius: 50%;
            background: rgba(59, 130, 246, 0.2);
            border: 2px solid #3b82f6;
            color: #93c5fd;
            font-size: 1.75rem;
            font-weight: 700;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 18px;
        }
        .columna-principal {
            padding: 42px 40px;
            background-color: #ffffff;
        }
        .titulo-seccion {
            border-bottom: 2px solid #e2e8f0;
            padding-bottom: 8px;
            margin-bottom: 18px;
            font-weight: 700;
            text-transform: uppercase;
            font-size: 0.9rem;
            letter-spacing: 0.8px;
            color: #0f172a;
            display: flex;
            align-items: center;
        }
        .titulo-lateral {
            border-bottom: 1px solid #334155;
            padding-bottom: 8px;
            margin-bottom: 16px;
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.8rem;
            letter-spacing: 1px;
            color: #93c5fd;
        }
        .item-contacto {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 12px;
            font-size: 0.88rem;
            color: #e2e8f0;
        }
        .item-contacto i {
            color: #60a5fa;
            font-size: 1rem;
        }
        .chip-habilidad {
            background-color: rgba(255, 255, 255, 0.08);
            border: 1px solid rgba(148, 163, 184, 0.25);
            border-radius: 8px;
            padding: 8px 12px;
            margin-bottom: 10px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 0.85rem;
        }
        .bloque-item {
            border-left: 3px solid #2563eb;
            padding-left: 16px;
            margin-bottom: 20px;
            position: relative;
        }
        .caja-perfil {
            background-color: #f8fafc;
            border-left: 4px solid #2563eb;
            padding: 16px 18px;
            border-radius: 0 8px 8px 0;
            color: #334155;
            font-size: 0.95rem;
            line-height: 1.65;
        }
        @media print {
            body { background: #ffffff; }
            .no-imprimir { display: none !important; }
            .hoja-cv {
                box-shadow: none;
                margin: 0;
                max-width: 100%;
                min-height: 100vh;
                border-radius: 0;
            }
            .columna-lateral, .caja-perfil, .chip-habilidad {
                -webkit-print-color-adjust: exact;
                print-color-adjust: exact;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container pt-4 no-imprimir" style="max-width: 860px;">
            <div class="d-flex justify-content-between align-items-center bg-white p-3 rounded-3 shadow-sm">
                <div class="d-flex align-items-center gap-2">
                    <span class="badge bg-primary-subtle text-primary px-3 py-2">CV Generado</span>
                    <asp:Label ID="lblTituloDocumento" runat="server" CssClass="fw-bold text-dark fs-6" />
                </div>
                <div class="d-flex gap-2">
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
        </div>

        <div class="hoja-cv row g-0">
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

                <div class="mb-4 pb-2">
                    <h6 class="titulo-lateral">Habilidades y Competencias</h6>
                    <asp:Repeater ID="repHabilidades" runat="server">
                        <ItemTemplate>
                            <div class="chip-habilidad">
                                <span><%# Eval("Descripcion") %></span>
                                <span class="badge <%# Convert.ToBoolean(Eval("TipoHabilidad")) ? "bg-info text-dark" : "bg-primary" %>" style="font-size: 0.7rem;">
                                    <%# Convert.ToBoolean(Eval("TipoHabilidad")) ? "Blanda" : "Técnica" %>
                                </span>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                    <asp:Label ID="lblSinHabilidades" runat="server" CssClass="small text-secondary" Visible="false" Text="Sin habilidades registradas." />
                </div>

                <asp:Panel ID="pnlIdiomas" runat="server" Visible="false">
                    <h6 class="titulo-lateral">Idiomas</h6>
                    <asp:Repeater ID="repIdiomas" runat="server">
                        <ItemTemplate>
                            <div class="chip-habilidad">
                                <span><i class="bi bi-translate text-info me-2"></i><%# Container.DataItem %></span>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
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

                <div class="mb-4 pb-2">
                    <h5 class="titulo-seccion"><i class="bi bi-briefcase-fill text-primary me-2 fs-5"></i>Experiencia Laboral y Voluntariado</h5>
                    <asp:Repeater ID="repExperiencia" runat="server">
                        <ItemTemplate>
                            <div class="bloque-item">
                                <div class="d-flex justify-content-between align-items-center mb-1">
                                    <h6 class="fw-bold mb-0 text-dark fs-6"><%# Eval("Puesto") %></h6>
                                    <span class="badge bg-light text-primary border border-primary-subtle"><%# Eval("TipoExperiencia") %></span>
                                </div>
                                <div class="text-primary fw-semibold small mb-1">
                                    <i class="bi bi-building me-1"></i><%# Eval("Empresa") %>
                                    <span class="text-muted fw-normal ms-2">
                                        | <i class="bi bi-calendar3 me-1"></i><%# Eval("FechaDesde", "{0:MM/yyyy}") %> -
                                        <%# Convert.ToDateTime(Eval("FechaHasta")) == DateTime.MinValue ? "Actualidad" : Eval("FechaHasta", "{0:MM/yyyy}") %>
                                    </span>
                                </div>
                                <p class="small text-secondary mb-0 mt-1"><%# Eval("Descripcion") %></p>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                    <asp:Label ID="lblSinExperiencia" runat="server" CssClass="small text-muted fst-italic" Visible="false"
                        Text="Sin experiencia previa registrada. En búsqueda de primera oportunidad laboral." />
                </div>

                <div>
                    <h5 class="titulo-seccion"><i class="bi bi-mortarboard-fill text-primary me-2 fs-5"></i>Educación y Formación</h5>
                    <asp:Repeater ID="repEducacion" runat="server">
                        <ItemTemplate>
                            <div class="bloque-item">
                                <div class="d-flex justify-content-between align-items-center mb-1">
                                    <h6 class="fw-bold mb-0 text-dark fs-6"><%# Eval("Titulo") %></h6>
                                    <span class="badge bg-secondary-subtle text-dark">Año <%# Eval("Anio") %></span>
                                </div>
                                <div class="small text-primary fw-semibold mb-1">
                                    <i class="bi bi-bank me-1"></i><%# Eval("Institucion") %>
                                </div>
                                <div class="small text-muted">Nivel alcanzado: <strong><%# Eval("NivelAlcanzado") %></strong></div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                    <asp:Label ID="lblSinEducacion" runat="server" CssClass="small text-muted fst-italic" Visible="false"
                        Text="Sin estudios registrados." />
                </div>
            </div>
        </div>
    </form>
</body>
</html>