using CVJoven.Dominio;
using CVJoven.Negocio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CVJoven.Dominio;
using CVJoven.Negocio;

namespace CVJoven
{
    public partial class RegistrarOfertaLaboral : System.Web.UI.Page
    {


        protected void Page_Load(object sender, EventArgs e)
        {
            // Impedir el acceso sin una sesión de empresa.
            if (Session["IdEmpresa"] == null ||
                Session["TipoUsuario"] == null ||
                Convert.ToInt32(Session["TipoUsuario"]) != 2)
            {
                Response.Redirect("Login.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }
        }

        protected void btnRegistrarOferta_Click(object sender, EventArgs e)
        {
            Page.Validate("Oferta");

            if (!Page.IsValid)
            {
                return;
            }

            // Volver a comprobar la sesión.
            if (Session["IdEmpresa"] == null ||
                Session["TipoUsuario"] == null ||
                Convert.ToInt32(Session["TipoUsuario"]) != 2)
            {
                Response.Redirect("Login.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            try
            {
                string titulo = txtTituloOferta.Text.Trim();
                string zona = txtZona.Text.Trim();
                string tipoJornada = ddlTipoJornada.SelectedValue;
                string descripcion = txtDescripcion.Text.Trim();

                bool aceptaDiscapacidad =
                    chkAceptaDiscapacidad.Checked;

                // Validaciones adicionales del servidor.
                if (titulo.Length < 5 ||
                    string.IsNullOrWhiteSpace(zona) ||
                    string.IsNullOrWhiteSpace(tipoJornada) ||
                    descripcion.Length < 10)
                {
                    MostrarMensaje("Revise los datos ingresados.");
                    return;
                }

                OfertaLaboral oferta = new OfertaLaboral();

                oferta.IdEmpresa =
                    Convert.ToInt64(Session["IdEmpresa"]);

                oferta.TituloOferta = titulo;
                oferta.Zona = zona;
                oferta.TipoDeJornada = tipoJornada;
                oferta.Descripcion = descripcion;
                oferta.AceptaDiscapacidad = aceptaDiscapacidad;

                OfertaLaboralNegocio negocio =
                    new OfertaLaboralNegocio();

                bool registrada = negocio.RegistrarOferta(oferta);

                if (registrada)
                {
                    MostrarMensaje("Oferta laboral registrada correctamente.");
                }
                else
                {
                    MostrarMensaje("No se pudo registrar la oferta.");
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine(ex);

                MostrarMensaje("Ocurrió un error al registrar la oferta.");
            }
        }

        private void MostrarMensaje(string mensaje)
        {
            string texto = System.Web.HttpUtility.JavaScriptStringEncode(mensaje);

            ClientScript.RegisterStartupScript(
                this.GetType(),
                "mensaje",
                "alert('" + texto + "');",
                true
            );
        }


    }
}