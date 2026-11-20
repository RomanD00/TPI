using System;
using System.Web.UI;
using CVJoven.Dominio;
using CVJoven.Negocio;

namespace CVJoven
{
    public partial class miperfil : System.Web.UI.Page
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

            if (!IsPostBack)
            {
                CargarDatosPerfil(usuario);
            }
        }

        private void CargarDatosPerfil(Usuario usuario)
        {
            lblNombreCompleto.Text = usuario.Nombre + " " + usuario.Apellido;
            lblEmailResumen.Text = usuario.Mail;
            lblDniResumen.Text = usuario.DNI;
            lblDireccionResumen.Text = usuario.ZonaLocalidad;
            lblCelularResumen.Text = usuario.Celular;

            txtNombre.Text = usuario.Nombre;
            txtApellido.Text = usuario.Apellido;
            txtDni.Text = usuario.DNI;
            txtDireccion.Text = usuario.ZonaLocalidad;
            txtCelular.Text = usuario.Celular;
            txtEmail.Text = usuario.Mail;

            if (usuario.FechaNacimiento != DateTime.MinValue)
            {
                txtFechaNacimiento.Text = usuario.FechaNacimiento.ToString("yyyy-MM-dd");
            }
        }

        protected void btnGuardarCambios_Click(object sender, EventArgs e)
        {
            Usuario usuarioSesion = Session["Usuario"] as Usuario;
            if (usuarioSesion == null)
            {
                Response.Redirect("~/Login.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            if (!Page.IsValid)
            {
                return;
            }

            if (!DateTime.TryParse(txtFechaNacimiento.Text.Trim(), out DateTime fechaNacimiento))
            {
                MostrarMensaje("La fecha de nacimiento ingresada no es válida.", false);
                return;
            }

            try
            {
                string nuevoMail = txtEmail.Text.Trim();
                UsuarioNegocio negocio = new UsuarioNegocio();

                if (negocio.ExisteMailEnSistema(nuevoMail, usuarioSesion.IdUsuario))
                {
                    MostrarMensaje("Ese correo electrónico ya está registrado en otra cuenta.", false);
                    return;
                }

                Usuario usuarioActualizado = new Usuario
                {
                    IdUsuario = usuarioSesion.IdUsuario,
                    IdTipoUsuario = usuarioSesion.IdTipoUsuario,
                    DNI = usuarioSesion.DNI,
                    Password = usuarioSesion.Password,
                    Nombre = txtNombre.Text.Trim(),
                    Apellido = txtApellido.Text.Trim(),
                    ZonaLocalidad = txtDireccion.Text.Trim(),
                    Celular = txtCelular.Text.Trim(),
                    FechaNacimiento = fechaNacimiento,
                    Mail = nuevoMail
                };

                bool actualizado = negocio.ActualizarUsuario(usuarioActualizado);

                if (actualizado)
                {
                    Session["Usuario"] = usuarioActualizado;
                    CargarDatosPerfil(usuarioActualizado);
                    MostrarMensaje("Tus datos personales se actualizaron correctamente.", true);
                }
                else
                {
                    MostrarMensaje("No se pudieron guardar los cambios. Intentá nuevamente.", false);
                }
            }
            catch (Exception ex)
            {
                MostrarMensaje("Error al actualizar el perfil: " + ex.Message, false);
            }
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Usuario usuario = Session["Usuario"] as Usuario;
            if (usuario != null)
            {
                CargarDatosPerfil(usuario);
            }
            pnlMensaje.Visible = false;
        }

        protected void btnCambiarPassword_Click(object sender, EventArgs e)
        {
            // Pendiente para el próximo paso
        }

        private void MostrarMensaje(string texto, bool exito)
        {
            pnlMensaje.Visible = true;
            pnlMensaje.CssClass = exito
                ? "alert alert-success alert-dismissible fade show rounded-3 shadow-sm mb-4"
                : "alert alert-danger alert-dismissible fade show rounded-3 shadow-sm mb-4";
            lblMensaje.Text = texto;
        }
    }
}