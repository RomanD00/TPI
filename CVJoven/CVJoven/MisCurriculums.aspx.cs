using System;
using System.Collections.Generic;
using System.Web.UI;
using CVJoven.Datos;
using CVJoven.Dominio;
using CVJoven.Negocio;

namespace CVJoven
{
    public partial class MisCurriculums : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Usuario usuario = Session["Usuario"] as Usuario;

            if (usuario == null)
            {
                Response.Redirect("~/Login.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            // Mostrar los datos del usuario que inició sesión
            lblNombreUsuario.Text = usuario.Nombre + " " + usuario.Apellido;
            lblEmailUsuario.Text = usuario.Mail;

            // Cargar automáticamente sus currículums
            if (!IsPostBack)
            {
                CargarCurriculums(usuario.IdUsuario);
            }
        }

        private void CargarCurriculums(long idUsuario)
        {
            try
            {
                CVNegocio negocio = new CVNegocio();
                List<CV> lista = negocio.ListarCV(idUsuario);

                rptCurriculums.DataSource = lista;
                rptCurriculums.DataBind();

                litTotalCV.Text = lista.Count.ToString();
                pnlSinCV.Visible = lista.Count == 0;
            }
            catch (Exception)
            {
                lblMensaje.CssClass = "alert alert-danger d-block mb-3";
                lblMensaje.Text = "Ocurrió un error al cargar los currículums.";

                litTotalCV.Text = "0";
                rptCurriculums.DataSource = null;
                rptCurriculums.DataBind();
                pnlSinCV.Visible = false;
            }
        }

        protected void rptCurriculums_ItemCommand(
            object source,
            System.Web.UI.WebControls.RepeaterCommandEventArgs e)
        {
            Usuario usuario = Session["Usuario"] as Usuario;
            if (usuario == null)
            {
                Response.Redirect("~/Login.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            if (!long.TryParse(e.CommandArgument.ToString(), out long idCV))
                return;

            if (e.CommandName == "Ver")
            {
                Response.Redirect($"~/VerCV.aspx?id={idCV}", false);
                Context.ApplicationInstance.CompleteRequest();
            }
            else if (e.CommandName == "Editar")
            {
                Response.Redirect($"~/CrearCurriculum.aspx?id={idCV}", false);
                Context.ApplicationInstance.CompleteRequest();
            }
            else if (e.CommandName == "Eliminar")
            {
                try
                {
                    CVNegocio negocio = new CVNegocio();
                    int filasAfectadas = negocio.EliminarCV(idCV, usuario.IdUsuario);

                    if (filasAfectadas > 0)
                    {
                        lblMensaje.CssClass = "alert alert-success d-block mb-3";
                        lblMensaje.Text = "El currículum se eliminó correctamente.";
                    }
                    else
                    {
                        lblMensaje.CssClass = "alert alert-warning d-block mb-3";
                        lblMensaje.Text = "No se puede eliminar este currículum porque está asociado a una postulación activa.";
                    }

                    CargarCurriculums(usuario.IdUsuario);
                }
                catch (Exception ex)
                {
                    lblMensaje.CssClass = "alert alert-danger d-block mb-3";
                    lblMensaje.Text = "Error al eliminar el currículum: " + ex.Message;
                }
            }
        }
    }
}