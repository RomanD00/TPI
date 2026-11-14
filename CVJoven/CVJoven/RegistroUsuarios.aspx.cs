using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using CVJoven.Dominio;
using System.Net.Mail;
using CVJoven.Datos;
using CVJoven.Negocio;

namespace CVJoven
{
    public partial class RegistroUsuarios : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                MostrarPostulante();
            }
        }

        protected void btnPostulante_Click(object sender, EventArgs e)
        {
            MostrarPostulante();
        }

        protected void btnEmpresa_Click(object sender, EventArgs e)
        {
            MostrarEmpresa();
        }


        protected void btnRegistrarEmpresa_Click(object sender, EventArgs e)
        {
            // Comprobar validaciones
            if (!Page.IsValid)
            {
                return;
            }

            // Recuperar datos
            string mail = txtMailEmpresa.Text.Trim();
            string nombreLegal = txtNombreLegal.Text.Trim();
            string nombreComercial = txtNombreComercial.Text.Trim();
            string cuit = txtCUIT.Text.Trim();
            string sector = txtSector.Text.Trim();
            string tamanioEmpresa = ddlTamanioEmpresa.SelectedValue;
            string password = txtPasswordEmpresa.Text;
            string confirmarPassword = txtConfirmarPasswordEmpresa.Text;
            string paginaWeb = txtPaginaWeb.Text.Trim();
            string correoRRHH = txtCorreoRRHH.Text.Trim();

            // Validar contraseñas
            if (password.Length < 8 || password.Length > 100 ||
                password != confirmarPassword)
            {
                return;
            }

            // Página web opcional
            if (string.IsNullOrWhiteSpace(paginaWeb))
            {
                paginaWeb = null;
            }

            // Crear objeto Empresa
            Empresa empresa = new Empresa();

            empresa.IdTipoUsuario = 2;
            empresa.Mail = mail;
            empresa.NombreLegal = nombreLegal;
            empresa.NombreComercial = nombreComercial;
            empresa.CUIT = cuit;
            empresa.sector = sector;
            empresa.TamanioDeEmpresa = tamanioEmpresa;
            empresa.PaginaWeb = paginaWeb;
            empresa.CorreoRRHH = correoRRHH;

            // Generar hash seguro de la contraseña
            empresa.Password = SeguridadPassword.GenerarHash(password);

            // Registrar empresa en SQL Server
            try
            {
                EmpresaNegocio negocio = new EmpresaNegocio();

                bool registrado = negocio.RegistrarEmpresa(empresa);

                if (registrado)
                {
                    ClientScript.RegisterStartupScript(
                        this.GetType(),
                        "exito",
                        "alert('Empresa registrada correctamente');",
                        true
                    );
                }
                else
                {
                    ClientScript.RegisterStartupScript(
                        this.GetType(),
                        "error",
                        "alert('No se pudo registrar la empresa');",
                        true
                    );
                }
            }
            catch (Exception ex)
            {
                string detalleError = ex.Message.Replace("'", "").Replace("\r\n", " ");
                ClientScript.RegisterStartupScript(
                    this.GetType(),
                    "error",
                    $"alert('Error real: {detalleError}');",
                    true
                );
            }
        }


        private void MostrarPostulante()
        {
            pnlPostulante.Visible = true;
            pnlEmpresa.Visible = false;
            btnPostulante.CssClass = "btn btn-outline-primary active";
            btnEmpresa.CssClass = "btn btn-outline-primary";
        }

        private void MostrarEmpresa()
        {
            pnlPostulante.Visible = false;
            pnlEmpresa.Visible = true;
            btnPostulante.CssClass = "btn btn-outline-primary";
            btnEmpresa.CssClass = "btn btn-outline-primary active";
        }

        protected void btnRegistrar_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
            {
                return;
            }

            if (pnlPostulante.Visible)
            {
                registrarPostulante(2);
            }
        }

        private void registrarPostulante(int idTipoUsuario)
        {
            try
            {
                string nombre = txtNombre.Text.Trim();
                string apellido = txtApellido.Text.Trim();
                string dni = txtDni.Text.Trim();
                string direccion = txtDireccion.Text.Trim();
                string celular = txtCelular.Text.Trim();
                string fechaNacimientoTexto = txtFechaNac.Text.Trim();
                string mail = txtEmail.Text.Trim();
                string password = pssw1.Text;
                string passwordConfirm = pssw2.Text;

                if (password.Length < 8 || password.Length > 100 || password != passwordConfirm)
                {
                    return;
                }

                if (!DateTime.TryParse(fechaNacimientoTexto, out DateTime fechaNacimiento))
                {
                    return;
                }

                Usuario usuario = new Usuario();
                usuario.IdTipoUsuario = idTipoUsuario;
                usuario.Mail = mail;
                usuario.Nombre = nombre;
                usuario.Apellido = apellido;
                usuario.DNI = dni;
                usuario.ZonaLocalidad = direccion;
                usuario.Celular = celular;
                usuario.FechaNacimiento = fechaNacimiento;
                usuario.Password = SeguridadPassword.GenerarHash(password);

                Session["usuarioPorRegistrar"] = usuario;

                EnviarCorreoConfirmacion(true, mail, nombre);

                ///UsuarioNegocio negocio = new UsuarioNegocio();
                ///bool registrado = negocio.RegistrarUsuario(usuario);

                /*  if (registrado)
                  {
                      ClientScript.RegisterStartupScript(
                          this.GetType(),
                          "exitoPostulante",
                          "alert('Postulante registrado correctamente');",
                          true
                      );
                      return true;
                  }
                  else
                  {
                      ClientScript.RegisterStartupScript(
                          this.GetType(),
                          "errorPostulante",
                          "alert('No se pudo registrar el postulante (verifique que el correo o DNI no estén repetidos)');",
                          true
                      );
                      return false;
                  }*/
            }
            catch (Exception ex)
            {
                string detalleError = ex.Message.Replace("'", "").Replace("\r\n", " ");
                ClientScript.RegisterStartupScript(
                    this.GetType(),
                    "errorExcepcionPostulante",
                    $"alert('Error al registrar postulante: {detalleError}');",
                    true
                );
                return;
            }
        }

        private void registrarEmpresa()
        {
            // Implementar la lógica para registrar una empresa
        }

        ////mandar email de confirmacion de registro
 
        protected void EnviarCorreoConfirmacion(bool registro, string emailDestino, string nombre)
        {
            try
            {
                if (registro) { 
                string tokenUnico = Guid.NewGuid().ToString();
                DateTime creacionToken = DateTime.Now;
                DateTime expiracionToken = creacionToken.AddHours(1); // Token válido por 24 horas
                    string urlDominio = Request.Url.GetLeftPart(UriPartial.Authority);
                string enlaceVerificacion = $"{urlDominio}/VerificarLogin.aspx?email={emailDestino}&token={tokenUnico}";

                // Construir el mensaje del correo
                MailMessage mensaje = new MailMessage();
                mensaje.To.Add(emailDestino);
                mensaje.Subject = $"Confirma tu cuenta de correo {nombre}";
                mensaje.Body = $"<p>Haz clic para confirmar: <a href='{enlaceVerificacion}'>{enlaceVerificacion}</a></p>";
                mensaje.IsBodyHtml = true;

                using (SmtpClient clienteSmtp = new SmtpClient())
                {
                        clienteSmtp.Send(mensaje);


                    }

                    TokenDB tokenDB = new TokenDB();
                    int res = tokenDB.insertToken(tokenUnico, emailDestino, expiracionToken, creacionToken);
                    if (res > 0) {

                        ClientScript.RegisterStartupScript(this.GetType(), "alerta", "alert('¡Correo de verificacion de registro enviado con éxito!');", true);

                    }

                }
            }
            catch (Exception ex)
            {
                // Manejar error de envío si el servidor SMTP no está abierto
                ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('Error al enviar el correo: {ex.Message}');", true);
            }
        }

    }
}