
using System;
using System.Web.UI;
using CVJoven.Dominio;

namespace CVJoven
{
    public partial class CrearCurriculum : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Usuario usuario = Session["Usuario"] as Usuario;

            // Verificar que haya iniciado sesión
            if (usuario == null)
            {
                Response.Redirect("~/Login.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            // Mostrar nombre y correo arriba
            lblNombreUsuario.Text =
                usuario.Nombre + " " + usuario.Apellido;

            lblEmailUsuario.Text = usuario.Mail;

            // Cargar datos personales al abrir la página
            if (!IsPostBack)
            {
                txtNombre.Text = usuario.Nombre;
                txtApellido.Text = usuario.Apellido;
                txtEmail.Text = usuario.Mail;
                txtCelular.Text = usuario.Celular;
                txtLocalidad.Text = usuario.ZonaLocalidad;
            }
        }

        // EVENTO DEL BOTÓN GUARDAR
        protected void btnGuardarCV_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
                return;

            Usuario usuario = Session["Usuario"] as Usuario;

            if (usuario == null)
            {
                Response.Redirect("~/Login.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            // Crear el objeto CV con los datos del formulario
            CV cv = new CV();

            cv.IdUsuario = usuario.IdUsuario;
            cv.nombreDelCV = txtNombreCV.Text.Trim();
            cv.DisponibilidadHoraria =
                ddlDisponibilidad.SelectedValue;

            // Todavía no ejecutamos el INSERT
            lblMensaje.CssClass =
                "alert alert-info d-block mb-3";

            lblMensaje.Text =
                "Los datos están preparados para guardar.";
        }
    }
}
