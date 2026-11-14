using CVJoven.Dominio;
using CVJoven.Negocio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CVJoven
{
    public partial class VerificarUsuario : Page
    {
        string email;
        string token;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
            
            }
        }

        protected void btnVerificar_Click(object sender, EventArgs e)
        {

            string emailUrl = Request.QueryString["email"] ?? string.Empty;
            string tokenUrl = Request.QueryString["token"] ?? string.Empty;

            // 1. Lógica de base de datos para verificar al usuario (ej: negocio.ActivarUsuario(id));
            TokenDB tokenDB = new TokenDB();
            int res = tokenDB.confirmTokenCount(tokenUrl, emailUrl);
            if (res > 0)
            {
                Usuario user = (Usuario)Session["usuarioPorRegistrar"];
                UsuarioNegocio usneg = new UsuarioNegocio();
                bool resgitrarUserRes = usneg.RegistrarUsuario(user);

                if (resgitrarUserRes) {

                    divIcono.Attributes["class"] = "rounded-circle d-flex align-items-center justify-content-center mx-auto mb-4 bg-success bg-opacity-10 text-success";
                    pDescripcion.InnerText = "Tu cuenta ya se encuentra activa y lista para usar.";

                    btnVerificar.Visible = false; // Ocultamos el botón
                    lblMensaje.Text = "¡Usuario verificado con éxito!";
                    lblMensaje.Visible = true;

                }


            }
            else {
                // 2. Actualización visual usando clases de Bootstrap (éxito en verde)
                pDescripcion.InnerText = "Ha expirado el tiempo para validar tu cuenta, vuelva a registrarse";
                lblMensaje.Text = "¡ERROR!";
                divIcono.Attributes["class"] = "rounded-circle d-flex align-items-center justify-content-center mx-auto mb-4 bg-danger bg-opacity-10 text-danger";
                divIcono.InnerHtml = "<i class=\"fas fa-times\"></i>"; // Si usas FontAwesome
                btnVerificar.Text = "Volver a registrar";
                

            }
        }
    }
}