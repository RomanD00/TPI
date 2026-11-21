using CVJoven.Dominio;
using CVJoven.Negocio;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CVJoven
{
    public partial class OfertasLaborales : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Usuario usuario = Session["Usuario"] as Usuario;
            // Mostrar los datos del usuario que inició sesión
            lblNombreUsuario.Text = usuario.Nombre + " " + usuario.Apellido;
            lblEmailUsuario.Text = usuario.Mail;
            if (!IsPostBack)
            {
                CargarOfertas();
            }
        }

        private void CargarOfertas()
        {
            try
            {
                OfertaLaboralNegocio negocio = new OfertaLaboralNegocio();

                DataTable ofertas = negocio.ObtenerOfertas();

                rptOfertas.DataSource = ofertas;
                rptOfertas.DataBind();

                lblCantidadOfertas.Text = ofertas.Rows.Count.ToString();

                pnlSinResultados.Visible = ofertas.Rows.Count == 0;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine(ex);

                lblCantidadOfertas.Text = "0";
                pnlSinResultados.Visible = false;

                ClientScript.RegisterStartupScript(
                    this.GetType(),
                    "errorOfertas",
                    "alert('No se pudieron cargar las ofertas laborales.');",
                    true
                );
            }
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            // Aquí llamas a tu método de filtrado con txtBuscar.Text y los DropDownList
            CargarOfertas();
        }


        protected void Filtros_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Se dispara automáticamente al cambiar cualquier filtro
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

                    DataTable curriculums =
                        negocio.ObtenerCVPorUsuario(idUsuario);

                    lblMensajePostulacion.Visible = false;
                    lblErrorModalPostulacion.Visible = false;

                    if (curriculums.Rows.Count == 0)
                    {
                        MostrarMensaje(
                            "Primero debés crear un currículum para postularte.",
                            false);

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

                    MostrarMensaje(
                        "No se pudieron cargar tus currículums.",
                        false);
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
                        "window.scrollTo({ top: 0, behavior: 'instant' });",
                        true
                    );
                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine(ex);

                    MostrarMensaje(
                        "No se pudo cargar el detalle de la oferta.",
                        false);
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

            ClientScript.RegisterStartupScript(
                this.GetType(),
                "abrirModal",
                script,
                true
            );
        }

        protected void btnCerrarDetalle_Click(object sender, EventArgs e)
        {
            pnlDetalleOferta.Visible = false;
        }
        private long ObtenerIdUsuario()
        {
            if (Session["IdUsuario"] == null)
                throw new UnauthorizedAccessException(
                    "Debés iniciar sesión para postularte.");

            return Convert.ToInt64(Session["IdUsuario"]);
        }


        protected void btnConfirmarPostulacion_Click(
            object sender, EventArgs e)
        {
            try
            {
                long idUsuario = ObtenerIdUsuario();

                if (!long.TryParse(ddlCurriculums.SelectedValue,
                    out long idCV) ||
                    !long.TryParse(hfIdOferta.Value, out long idOferta))
                {
                    MostrarMensaje(
                        "Seleccioná un currículum válido.", false);
                    return;
                }

                PostulacionNegocio negocio = new PostulacionNegocio();

                bool registrado = negocio.RegistrarPostulacion(
                    idUsuario, idCV, idOferta);

                if (registrado)
                {
                    MostrarMensaje(
                        "¡Te postulaste correctamente a la oferta!",
                        true);

                    ClientScript.RegisterStartupScript(
                        this.GetType(),
                        "scrollArriba",
                        "window.scrollTo({ top: 0, behavior: 'instant' });",
                        true
                        );
                }
                else
                {
                    lblErrorModalPostulacion.Text =
                        "No se pudo registrar la postulación. " +
                        "Es posible que ya te hayas postulado.";

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

                lblErrorModalPostulacion.Text =
                    "Ocurrió un error al registrar la postulación.";

                lblErrorModalPostulacion.Visible = true;

                AbrirModal("modalPostulacion");
            }
        }

    

        private void MostrarMensaje(string mensaje, bool exito)
        {
            lblMensajePostulacion.Text =
                Server.HtmlEncode(mensaje);

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

            lblTituloDetalle.Text =
                Server.HtmlEncode(oferta["TituloOferta"].ToString());

            lblEmpresaDetalle.Text =
                Server.HtmlEncode(oferta["Empresa"].ToString());

            lblZonaDetalle.Text =
                Server.HtmlEncode(oferta["Zona"].ToString());

            lblJornadaDetalle.Text =
                Server.HtmlEncode(oferta["TipoDeJornada"].ToString());

            lblSectorDetalle.Text =
                Server.HtmlEncode(oferta["SectorEmpresa"].ToString());

            lblTamanoDetalle.Text =
                Server.HtmlEncode(oferta["TamanoEmpresa"].ToString());

            bool aceptaDiscapacidad =
                Convert.ToBoolean(oferta["AceptaDiscapacidad"]);

            lblDiscapacidadDetalle.Text =
                aceptaDiscapacidad ? "Sí" : "No";

            lblDescripcionDetalle.Text =
                Server.HtmlEncode(oferta["Descripcion"].ToString())
                      .Replace("\r\n", "<br />")
                      .Replace("\n", "<br />");

            DataTable requisitos =
                negocio.ObtenerRequisitosOferta(idOferta);

            rptRequisitos.DataSource = requisitos;
            rptRequisitos.DataBind();

            lblSinRequisitos.Visible = requisitos.Rows.Count == 0;

            pnlDetalleOferta.Visible = true;
        }



    }
}