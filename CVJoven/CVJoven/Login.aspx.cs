using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CVJoven.Datos;
using CVJoven.Dominio;
using CVJoven.Negocio;

namespace CVJoven
{
    public partial class Login : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Listo para la lógica del Login
            }
        }


        protected void btnIngresar_Click(object sender, EventArgs e)
        {
            string mail = txtEmail.Text.Trim();
            string password = txtPassword.Text;

            lblMensaje.Text = "";

            if (string.IsNullOrWhiteSpace(mail) ||
                string.IsNullOrWhiteSpace(password))
            {
                lblMensaje.Text = "Ingrese su correo y contraseña.";
                return;
            }

            try
            {
                EmpresaNegocio negocio = new EmpresaNegocio();

                Empresa empresa = negocio.IniciarSesion(mail, password);

                if (empresa != null)
                {
                    // Guardar solamente los datos necesarios
                    Session["IdEmpresa"] = empresa.IdEmpresa;
                    Session["NombreEmpresa"] = empresa.NombreComercial;
                    Session["TipoUsuario"] = empresa.IdTipoUsuario;

                    // Redirigir a una página existente y protegida
                    Response.Redirect("OfertaLaboral.aspx", false);
                    Context.ApplicationInstance.CompleteRequest();
                }
                else
                {
                    lblMensaje.Text = "Correo o contraseña incorrectos.";
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine(ex);

                lblMensaje.Text = "Ocurrió un error al iniciar sesión.";
            }
        }



    }
}