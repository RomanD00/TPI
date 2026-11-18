using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using CVJoven.Dominio;
using CVJoven.Negocio;

namespace CVJoven
{
    public partial class MisPostulaciones : System.Web.UI.Page
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

            lblNombreUsuario.Text = usuario.Nombre + " " + usuario.Apellido;
            lblEmailUsuario.Text = usuario.Mail;

            if (!IsPostBack)
            {
                CargarPostulaciones(usuario.IdUsuario);
            }
        }

        private void CargarPostulaciones(long idUsuario)
        {
            try
            {
                PostulacionNegocio negocio = new PostulacionNegocio();
                DataTable tabla = negocio.ObtenerPostulacionesPorUsuario(idUsuario);

                int total = tabla.Rows.Count;
                int pendientes = 0;
                int aceptadas = 0;

                foreach (DataRow fila in tabla.Rows)
                {
                    string estado = fila["EstadoPostulacion"].ToString();
                    if (estado == "Pendiente" || estado == "En Revision")
                        pendientes++;
                    else if (estado == "Aceptado")
                        aceptadas++;
                }

                litTotal.Text = total.ToString();
                litPendientes.Text = pendientes.ToString();
                litAceptadas.Text = aceptadas.ToString();

                if (total > 0)
                {
                    rptPostulaciones.Visible = true;
                    rptPostulaciones.DataSource = tabla;
                    rptPostulaciones.DataBind();
                    pnlSinPostulaciones.Visible = false;
                }
                else
                {
                    rptPostulaciones.Visible = false;
                    pnlSinPostulaciones.Visible = true;
                }
            }
            catch (Exception ex)
            {
                lblMensaje.CssClass = "alert alert-danger d-block mb-3";
                lblMensaje.Text = "Error al cargar tus postulaciones: " + ex.Message;
            }
        }

        protected string ObtenerClaseEstado(string estado)
        {
            switch (estado)
            {
                case "Aceptado":
                    return "bg-success-subtle text-success border border-success-subtle";
                case "Rechazado":
                    return "bg-danger-subtle text-danger border border-danger-subtle";
                case "En Revision":
                    return "bg-info-subtle text-info-emphasis border border-info-subtle";
                default:
                    return "bg-warning-subtle text-warning-emphasis border border-warning-subtle";
            }
        }

        protected void rptPostulaciones_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            Usuario usuario = Session["Usuario"] as Usuario;
            if (usuario == null) return;

            if (e.CommandName == "Cancelar" && long.TryParse(e.CommandArgument.ToString(), out long idPostulacion))
            {
                try
                {
                    PostulacionNegocio negocio = new PostulacionNegocio();
                    bool cancelada = negocio.CancelarPostulacion(idPostulacion, usuario.IdUsuario);

                    if (cancelada)
                    {
                        lblMensaje.CssClass = "alert alert-success d-block mb-3";
                        lblMensaje.Text = "La postulación fue cancelada correctamente.";
                    }
                    else
                    {
                        lblMensaje.CssClass = "alert alert-warning d-block mb-3";
                        lblMensaje.Text = "No se pudo cancelar la postulación porque ya fue procesada por la empresa.";
                    }

                    CargarPostulaciones(usuario.IdUsuario);
                }
                catch (Exception ex)
                {
                    lblMensaje.CssClass = "alert alert-danger d-block mb-3";
                    lblMensaje.Text = "Error al cancelar la postulación: " + ex.Message;
                }
            }
        }
    }
}