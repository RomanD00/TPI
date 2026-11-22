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
                // 1. Primero intenta iniciar sesión como Empresa (lo que hizo Fran)
                EmpresaNegocio empresaNegocio = new EmpresaNegocio();
                Empresa empresa = empresaNegocio.IniciarSesion(mail, password);

                if (empresa != null)
                {
                    Session.Clear();

                    Session["Usuario"] = empresa;
                    Session["IdEmpresa"] = empresa.IdEmpresa;
                    Session["NombreEmpresa"] = empresa.NombreComercial;
                    Session["TipoUsuario"] = empresa.IdTipoUsuario;

                    Response.Redirect("MiEmpresa.aspx", false);
                    Context.ApplicationInstance.CompleteRequest();
                    return;
                }

                // 2. Si no es empresa, intenta iniciar sesión como Postulante
                UsuarioNegocio usuarioNegocio = new UsuarioNegocio();
                Usuario usuario = usuarioNegocio.IniciarSesion(mail, password);

                if (usuario != null )
                {
                    Session["Usuario"] = usuario;

                    Session["IdUsuario"] = usuario.IdUsuario;
                    Session["NombreUsuario"] = usuario.Nombre + " " + usuario.Apellido;
                    Session["TipoUsuario"] = usuario.IdTipoUsuario;

                    Response.Redirect("MisCurriculums.aspx", false);
                    Context.ApplicationInstance.CompleteRequest();
                    return;
                }

                // 3. Si no encontró ni empresa ni postulante con esas credenciales
                lblMensaje.Text = "Correo o contraseña incorrectos.";
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine(ex);

                lblMensaje.Text = "Ocurrió un error al iniciar sesión.";
            }
        }



    }
}