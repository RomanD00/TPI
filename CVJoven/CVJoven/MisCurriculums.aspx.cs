
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
                Response.Redirect("~/Login.aspx");
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
                // Instanciamos la capa de Negocio
                CVDatos negocio = new CVDatos();

                // Obtenemos los CV del usuario
                List<CV> lista = negocio.ListarCV(idUsuario);

                // Mostramos los CV en el Repeater
                rptCurriculums.DataSource = lista;
                rptCurriculums.DataBind();

                // Mostramos cuántos CV tiene
                litTotalCV.Text = lista.Count.ToString();

                // Mensaje si todavía no tiene currículums
                pnlSinCV.Visible = lista.Count == 0;
            }
            catch (Exception)
            {
                lblMensaje.CssClass =
                    "alert alert-danger d-block mb-3";

                lblMensaje.Text =
                    "Ocurrió un error al cargar los currículums.";

                litTotalCV.Text = "0";

                rptCurriculums.DataSource = null;
                rptCurriculums.DataBind();

                pnlSinCV.Visible = false;
            }
        }

        // Se conserva porque tu ASPX tiene OnItemCommand
        protected void rptCurriculums_ItemCommand(
            object source,
            System.Web.UI.WebControls.RepeaterCommandEventArgs e)
        {
            // Los botones Ver, Editar y Eliminar
            // los implementaremos después.
        }
    }
}
