<%@ Page Language="C#" AutoEventWireup="true" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="CVJoven.Dominio" %>
<%@ Import Namespace="CVJoven.Negocio" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        Usuario usuario = Session["Usuario"] as Usuario;

        if (usuario == null)
        {
            Response.Redirect("~/Login.aspx", false);
            Context.ApplicationInstance.CompleteRequest();
            return;
        }

        if (!IsPostBack)
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
        List<Habilidad> habilidades = negocio.ListarHabilidadesPorCV(idCV);

        // Cabecera y datos personales
        lblTituloDocumento.Text = cv.nombreDelCV;
        lblNombreCompleto.Text = usuario.Nombre + " " + usuario.Apellido;
        lblDisponibilidad.Text = cv.DisponibilidadHoraria;
        lblLocalidad.Text = usuario.ZonaLocalidad;
        lblCelular.Text = usuario.Celular;
        lblEmail.Text = usuario.Mail;
        lblDni.Text = usuario.DNI;

        // Perfil profesional generado automáticamente
        lblPerfilProfesional.Text = negocio.GenerarPerfilProfesional(usuario, cv, estudios, experiencias, habilidades);

        // Educación
        if (estudios != null && estudios.Count > 0)
        {
            repEducacion.DataSource = estudios;
            repEducacion.DataBind();
        }
        else
        {
            lblSinEducacion.Visible = true;
        }

        // Experiencia
        if (experiencias != null && experiencias.Count > 0)
        {
            repExperiencia.DataSource = experiencias;
            repExperiencia.DataBind();
        }
        else
        {
            lblSinExperiencia.Visible = true;
        }

        // Habilidades
        if (habilidades != null && habilidades.Count > 0)
        {
            repHabilidades.DataSource = habilidades;
            repHabilidades.DataBind();
        }
        else
        {
            lblSinHabilidades.Visible = true;
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
        body { background-color: #f1f5f9; }
        .hoja-cv {
            max-width: 850px;
            margin: 25px auto 50px auto;
            background: #ffffff;
            box-shadow: 0 10px 25px rgba(0,0,0,0.08);
            min-height: 1050px;
            border-radius: 6px;
            overflow: hidden;
        }
        .columna-lateral {
            background-color: #0f172a;
            color: #f8fafc;
            padding: 35px 28px;
        }
        .columna-principal {
            padding: 40px 35px;
        }
        .titulo-seccion {
            border-bottom: 2px solid #2563eb;
            padding-bottom: 6px;
            margin-bottom: 16px;
            font-weight: 700;
            text-transform: uppercase;
            font-size: 0.95rem;
            letter-spacing: 0.5px;
            color: #0f172a;
        }
        .titulo-lateral {
            border-bottom: 1px solid #334155;
            padding-bottom: 6px;
            margin-bottom: 14px;
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.85rem;
            letter-spacing: 0.5px;
            color: #93c5fd;
        }
        @media print {
            body { background: #ffffff; }
            .no-imprimir { display: none !important; }
            .hoja-cv {
                box-shadow: none;
                margin: 0;
                max-width: 100%;
                border-radius: 0;
            }
            .columna-lateral {
                background-color: #0f172a !important;
                color: #f8fafc !important;
                -webkit-print-color-adjust: exact;
                print-color-adjust: exact;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container pt-4 no-imprimir" style="max-width: 850px;">
            <div class="d-flex justify-content-between align-items-center bg-white p-3 rounded shadow-sm">
                <div>
                    <span class="badge bg-primary-subtle text-primary me-2">CV Generado</span>
                    <asp:Label ID="lblTituloDocumento" runat="server" CssClass="fw-bold text-dark" />
                </div>
                <div class="d-flex gap-2">
                    <a href="MisCurriculums.aspx" class="btn btn-outline-secondary btn-sm">
                        <i class="bi bi-arrow-left me-1"></i>Volver a Mis CVs
                    </a>
                    <button type="button" class="btn btn-primary btn-sm fw-semibold" onclick="window.print();">
                        <i class="bi bi-file-earmark-pdf me-1"></i>Descargar PDF / Imprimir
                    </button>
                </div>
            </div>
        </div>

        <div class="hoja-cv row g-0">
            <!-- Columna Izquierda -->
            <div class="col-md-4 columna-lateral">
                <div class="mb-4">
                    <h2 class="h4 fw-bold mb-1"><asp:Label ID="lblNombreCompleto" runat="server" /></h2>
                    <span class="badge bg-primary mt-1">Disponibilidad <asp:Label ID="lblDisponibilidad" runat="server" /></span>
                </div>

                <div class="mb-4">
                    <h6 class="titulo-lateral">Datos de Contacto</h6>
                    <p class="small mb-2"><i class="bi bi-geo-alt me-2 text-info"></i><asp:Label ID="lblLocalidad" runat="server" /></p>
                    <p class="small mb-2"><i class="bi bi-telephone me-2 text-info"></i><asp:Label ID="lblCelular" runat="server" /></p>
                    <p class="small mb-2 text-break"><i class="bi bi-envelope me-2 text-info"></i><asp:Label ID="lblEmail" runat="server" /></p>
                    <p class="small mb-0"><i class="bi bi-person-vcard me-2 text-info"></i>DNI: <asp:Label ID="lblDni" runat="server" /></p>
                </div>

                <div class="mb-4">
                    <h6 class="titulo-lateral">Habilidades</h6>
                    <ul class="small ps-3 mb-0">
                        <asp:Repeater ID="repHabilidades" runat="server">
                            <ItemTemplate>
                                <li class="mb-2">
                                    <%# Eval("Descripcion") %>
                                    <span class="badge bg-secondary ms-1" style="font-size: 0.7rem;">
                                        <%# Convert.ToBoolean(Eval("TipoHabilidad")) ? "Blanda" : "Técnica" %>
                                    </span>
                                </li>
                            </ItemTemplate>
                        </asp:Repeater>
                    </ul>
                    <asp:Label ID="lblSinHabilidades" runat="server" CssClass="small text-secondary" Visible="false" Text="Sin habilidades registradas." />
                </div>
            </div>

            <!-- Columna Derecha -->
            <div class="col-md-8 columna-principal">
                <div class="mb-4">
                    <h5 class="titulo-seccion"><i class="bi bi-person-lines-fill text-primary me-2"></i>Perfil Profesional</h5>
                    <p class="text-secondary mb-0" style="line-height: 1.6;">
                        <asp:Label ID="lblPerfilProfesional" runat="server" />
                    </p>
                </div>

                <div class="mb-4">
                    <h5 class="titulo-seccion"><i class="bi bi-briefcase-fill text-primary me-2"></i>Experiencia</h5>
                    <asp:Repeater ID="repExperiencia" runat="server">
                        <ItemTemplate>
                            <div class="mb-3">
                                <div class="d-flex justify-content-between align-items-center">
                                    <h6 class="fw-bold mb-0 text-dark"><%# Eval("Puesto") %></h6>
                                    <span class="badge bg-light text-dark border"><%# Eval("TipoExperiencia") %></span>
                                </div>
                                <div class="text-primary fw-semibold small"><%# Eval("Empresa") %></div>
                                <small class="text-muted d-block mb-1">
                                    <%# Eval("FechaDesde", "{0:MM/yyyy}") %> -
                                    <%# Convert.ToDateTime(Eval("FechaHasta")) == DateTime.MinValue ? "Actualidad" : Eval("FechaHasta", "{0:MM/yyyy}") %>
                                </small>
                                <p class="small text-secondary mb-0"><%# Eval("Descripcion") %></p>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                    <asp:Label ID="lblSinExperiencia" runat="server" CssClass="small text-muted" Visible="false"
                        Text="En búsqueda de primera experiencia laboral." />
                </div>

                <div class="mb-4">
                    <h5 class="titulo-seccion"><i class="bi bi-mortarboard-fill text-primary me-2"></i>Educación</h5>
                    <asp:Repeater ID="repEducacion" runat="server">
                        <ItemTemplate>
                            <div class="mb-3">
                                <h6 class="fw-bold mb-0 text-dark"><%# Eval("Titulo") %></h6>
                                <div class="small text-secondary"><%# Eval("Institucion") %></div>
                                <small class="text-muted">Nivel: <%# Eval("NivelAlcanzado") %> | Año: <%# Eval("Anio") %></small>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                    <asp:Label ID="lblSinEducacion" runat="server" CssClass="small text-muted" Visible="false"
                        Text="Sin estudios registrados." />
                </div>
            </div>
        </div>
    </form>
</body>
</html>