using CVJoven.Dominio;
using CVJoven.Negocio;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CVJoven
{
    public partial class OfertasLaborales : System.Web.UI.Page
    {
        private bool SoloRecomendadas
        {
            get { return ViewState["SoloRecomendadas"] != null && (bool)ViewState["SoloRecomendadas"]; }
            set { ViewState["SoloRecomendadas"] = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            Usuario usuario = Session["Usuario"] as Usuario;

            if (usuario == null)
            {
                Response.Redirect("~/Login.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            lblNombreUsuario.Text = usuario.Nombre + " " + usuario.Apellido;
            lblEmailUsuario.Text = usuario.Mail;

            if (!IsPostBack)
            {
                CargarFiltrosDinamicos();
                CargarOfertas();
            }
        }

        private void CargarFiltrosDinamicos()
        {
            OfertaLaboralNegocio negocio = new OfertaLaboralNegocio();
            DataTable todas = negocio.ObtenerOfertas();

            // Ubicaciones reales presentes en las ofertas activas
            List<string> ubicaciones = todas.AsEnumerable()
                .Select(r => r["Zona"] != DBNull.Value ? r["Zona"].ToString().Trim() : "")
                .Where(z => !string.IsNullOrEmpty(z))
                .Distinct(StringComparer.OrdinalIgnoreCase)
                .OrderBy(z => z)
                .ToList();

            ddlUbicacion.Items.Clear();
            ddlUbicacion.Items.Add(new ListItem("Ubicación", ""));
            foreach (string zona in ubicaciones)
            {
                ddlUbicacion.Items.Add(new ListItem(zona, zona));
            }

            // Sectores reales presentes en las empresas con ofertas activas
            List<string> sectores = todas.AsEnumerable()
                .Select(r => r["SectorEmpresa"] != DBNull.Value ? r["SectorEmpresa"].ToString().Trim() : "")
                .Where(s => !string.IsNullOrEmpty(s))
                .Distinct(StringComparer.OrdinalIgnoreCase)
                .OrderBy(s => s)
                .ToList();

            ddlAreaInteres.Items.Clear();
            ddlAreaInteres.Items.Add(new ListItem("Sector / Área", ""));
            foreach (string sector in sectores)
            {
                ddlAreaInteres.Items.Add(new ListItem(sector, sector));
            }
        }

        private void ActualizarEstilosPestanas(int totalRecomendadas)
        {
            string claseBadge = SoloRecomendadas
                ? "badge bg-white text-success ms-1"
                : "badge bg-success text-white ms-1";

            btnSoloRecomendadas.Text =
                $"<i class=\"bi bi-stars me-1\"></i>Recomendadas para vos <span class=\"{claseBadge}\">{totalRecomendadas}</span>";

            if (SoloRecomendadas)
            {
                btnTodasOfertas.CssClass = "btn btn-sm btn-outline-primary text-nowrap";
                btnSoloRecomendadas.CssClass = "btn btn-sm btn-success text-nowrap";
            }
            else
            {
                btnTodasOfertas.CssClass = "btn btn-sm btn-primary text-nowrap";
                btnSoloRecomendadas.CssClass = "btn btn-sm btn-outline-success text-nowrap";
            }
        }

        private void CargarOfertas()
        {
            try
            {
                long idUsuario = ObtenerIdUsuario();
                OfertaLaboralNegocio negocio = new OfertaLaboralNegocio();

                int totalRecomendadas;
                bool usuarioTieneHabilidades;

                DataTable ofertas = negocio.ObtenerOfertasParaPostulante(
                    idUsuario,
                    txtBuscar.Text.Trim(),
                    ddlTiempoPublicacion.SelectedValue,
                    ddlUbicacion.SelectedValue,
                    ddlTamanoEmpresa.SelectedValue,
                    ddlAreaInteres.SelectedValue,
                    ddlAceptaDiscapacidad.SelectedValue,
                    SoloRecomendadas,
                    out totalRecomendadas,
                    out usuarioTieneHabilidades
                );

                rptOfertas.DataSource = ofertas;
                rptOfertas.DataBind();

                lblCantidadOfertas.Text = ofertas.Rows.Count.ToString();
                pnlAvisoSinHabilidades.Visible = !usuarioTieneHabilidades;
                pnlSinResultados.Visible = ofertas.Rows.Count == 0;

                ActualizarEstilosPestanas(totalRecomendadas);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine(ex);

                lblCantidadOfertas.Text = "0";
                pnlSinResultados.Visible = false;
                MostrarMensaje("Ocurrió un error al cargar las ofertas laborales.", false);
            }
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            CargarOfertas();
        }

        protected void Filtros_SelectedIndexChanged(object sender, EventArgs e)
        {
            CargarOfertas();
        }

        protected void btnLimpiarFiltros_Click(object sender, EventArgs e)
        {
            txtBuscar.Text = "";
            ddlTiempoPublicacion.SelectedIndex = 0;
            ddlUbicacion.SelectedIndex = 0;
            ddlTamanoEmpresa.SelectedIndex = 0;
            ddlAreaInteres.SelectedIndex = 0;
            ddlAceptaDiscapacidad.SelectedIndex = 0;

            SoloRecomendadas = false;

            CargarOfertas();
        }

        protected void btnTodasOfertas_Click(object sender, EventArgs e)
        {
            SoloRecomendadas = false;
            CargarOfertas();
        }

        protected void btnSoloRecomendadas_Click(object sender, EventArgs e)
        {
            SoloRecomendadas = true;
            CargarOfertas();
        }

        protected void rptOfertas_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Postular")
            {
                try
                {
                    long idUsuario = ObtenerIdUsuario();
                    long idOferta = Convert.ToInt64(e.CommandArgument);

                    PostulacionNegocio negocio = new PostulacionNegocio();
                    DataTable curriculums = negocio.ObtenerCVPorUsuario(idUsuario);

                    lblMensajePostulacion.Visible = false;
                    lblErrorModalPostulacion.Visible = false;

                    if (curriculums.Rows.Count == 0)
                    {
                        MostrarMensaje("Primero debés crear un currículum para postularte.", false);
                        return;
                    }

                    ddlCurriculums.DataSource = curriculums;
                    ddlCurriculums.DataTextField = "nombreDelCV";
                    ddlCurriculums.DataValueField = "IdCV";
                    ddlCurriculums.DataBind();

                    hfIdOferta.Value = idOferta.ToString();

                    AbrirModal("modalPostulacion");
                }
                catch (UnauthorizedAccessException)
                {
                    Response.Redirect("~/Login.aspx", false);
                    Context.ApplicationInstance.CompleteRequest();
                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine(ex);
                    MostrarMensaje("No se pudieron cargar tus currículums.", false);
                }
            }
            else if (e.CommandName == "VerDetalle")
            {
                try
                {
                    long idOferta = Convert.ToInt64(e.CommandArgument);
                    MostrarDetalleOferta(idOferta);

                    ClientScript.RegisterStartupScript(
                        this.GetType(),
                        "scrollDetalle",
                        "setTimeout(function() { window.scrollTo({ top: 0, behavior: 'smooth' }); }, 150);",
                        true
                    );
                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine(ex);
                    MostrarMensaje("No se pudo cargar el detalle de la oferta.", false);
                }
            }
        }

        private void AbrirModal(string idModal)
        {
            string script = $@"
                var elemento = document.getElementById('{idModal}');
                var modal = bootstrap.Modal.getOrCreateInstance(elemento);
                modal.show();
            ";

            ClientScript.RegisterStartupScript(this.GetType(), "abrirModal", script, true);
        }

        protected void btnCerrarDetalle_Click(object sender, EventArgs e)
        {
            pnlDetalleOferta.Visible = false;
        }

        private long ObtenerIdUsuario()
        {
            Usuario usuario = Session["Usuario"] as Usuario;
            if (usuario != null)
                return usuario.IdUsuario;

            if (Session["IdUsuario"] != null)
                return Convert.ToInt64(Session["IdUsuario"]);

            throw new UnauthorizedAccessException("Debés iniciar sesión para postularte.");
        }

        protected void btnConfirmarPostulacion_Click(object sender, EventArgs e)
        {
            try
            {
                long idUsuario = ObtenerIdUsuario();

                if (!long.TryParse(ddlCurriculums.SelectedValue, out long idCV) ||
                    !long.TryParse(hfIdOferta.Value, out long idOferta))
                {
                    MostrarMensaje("Seleccioná un currículum válido.", false);
                    return;
                }

                PostulacionNegocio negocio = new PostulacionNegocio();
                bool registrado = negocio.RegistrarPostulacion(idUsuario, idCV, idOferta);

                if (registrado)
                {
                    CargarOfertas();

                    MostrarMensaje("¡Te postulaste correctamente a la oferta!", true);

                    ClientScript.RegisterStartupScript(
                        this.GetType(),
                        "scrollArriba",
                        "setTimeout(function() { window.scrollTo({ top: 0, behavior: 'smooth' }); }, 150);",
                        true
                    );
                }
                else
                {
                    lblErrorModalPostulacion.Text =
                        "No se pudo registrar la postulación. Es posible que ya te hayas postulado.";
                    lblErrorModalPostulacion.Visible = true;
                    AbrirModal("modalPostulacion");
                }
            }
            catch (UnauthorizedAccessException)
            {
                Response.Redirect("~/Login.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine(ex);
                lblErrorModalPostulacion.Text = "Ocurrió un error al registrar la postulación.";
                lblErrorModalPostulacion.Visible = true;
                AbrirModal("modalPostulacion");
            }
        }

        private void MostrarMensaje(string mensaje, bool exito)
        {
            lblMensajePostulacion.Text = Server.HtmlEncode(mensaje);
            lblMensajePostulacion.CssClass = exito
                ? "alert alert-success d-block mt-3"
                : "alert alert-danger d-block mt-3";
            lblMensajePostulacion.Visible = true;
        }

        private void MostrarDetalleOferta(long idOferta)
        {
            OfertaLaboralNegocio negocio = new OfertaLaboralNegocio();
            DataTable tabla = negocio.ObtenerDetalleOferta(idOferta);

            if (tabla.Rows.Count == 0)
            {
                pnlDetalleOferta.Visible = false;
                MostrarMensaje("La oferta laboral no existe.", false);
                return;
            }

            DataRow oferta = tabla.Rows[0];

            lblTituloDetalle.Text = Server.HtmlEncode(oferta["TituloOferta"].ToString());
            lblEmpresaDetalle.Text = Server.HtmlEncode(oferta["Empresa"].ToString());
            lblZonaDetalle.Text = Server.HtmlEncode(oferta["Zona"].ToString());
            lblJornadaDetalle.Text = Server.HtmlEncode(oferta["TipoDeJornada"].ToString());
            lblSectorDetalle.Text = Server.HtmlEncode(oferta["SectorEmpresa"].ToString());
            lblTamanoDetalle.Text = Server.HtmlEncode(oferta["TamanoEmpresa"].ToString());

            bool aceptaDiscapacidad = Convert.ToBoolean(oferta["AceptaDiscapacidad"]);
            lblDiscapacidadDetalle.Text = aceptaDiscapacidad ? "Sí" : "No";

            lblDescripcionDetalle.Text = Server.HtmlEncode(oferta["Descripcion"].ToString())
                .Replace("\r\n", "<br />")
                .Replace("\n", "<br />");

            DataTable requisitos = negocio.ObtenerRequisitosOferta(idOferta);

            rptRequisitos.DataSource = requisitos;
            rptRequisitos.DataBind();

            lblSinRequisitos.Visible = requisitos.Rows.Count == 0;
            pnlDetalleOferta.Visible = true;
        }
    }
}