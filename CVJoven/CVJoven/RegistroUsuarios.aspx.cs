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
            if (pnlPostulante.Visible)
            {
                 EnviarCorreoConfirmacion(registrarPostulante(), txtEmail.Text, txtNombre.Text);
            }
            else {

              //  registrarEmpresa();

            }
        }


        private bool registrarPostulante()
        {
            try
            {
                string nombre = txtNombre.Text;
                string apellido = txtApellido.Text;
                string dni = txtDni.Text;
                string direccion = txtDireccion.Text;
                string celular = txtCelular.Text;
                string fechaNacimiento = txtFechaNac.Text;
                string mail = txtEmail.Text;
                string password = pssw1.Text;
                string passwordConfirm = pssw2.Text;

                Dictionary<string, int> contador = new Dictionary<string, int>()
        {
            { "success", 0 },
            { "error", 0 }
        };

                ValidacionDatos validar = new ValidacionDatos();

                // Reemplazamos el operador ternario por un if/else tradicional para cada validación
                if (validar.validarString(nombre)) contador["success"]++; else contador["error"]++;
                if (validar.validarString(apellido)) contador["success"]++; else contador["error"]++;
                if (validar.validarDni(dni)) contador["success"]++; else contador["error"]++;
                if (validar.validarPassword(password)) contador["success"]++; else contador["error"]++;
                if (validar.validarPassword(passwordConfirm)) contador["success"]++; else contador["error"]++;

                // Validación extra de coincidencia de contraseñas
                if (password != passwordConfirm)
                {
                    // Las contraseñas no coinciden
                    return false;
                }

                // Si se acumuló al menos un error en las validaciones anteriores
                if (contador["error"] > 0)
                {
                    // Hay errores de validación
                    return false;
                }

                return true;
            }
            catch (Exception ex)
            {
                ex.ToString();
                // Manejar la excepción según sea necesario (puedes hacer un Debug.WriteLine(ex.Message))
                return false;
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
                string enlaceVerificacion = $"{urlDominio}/Verificar.aspx?email={emailDestino}&token={tokenUnico}";

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

                        ClientScript.RegisterStartupScript(this.GetType(), "alerta", "alert('¡Correo enviado con éxito!');", true);

                    }

                }
            }
            catch (Exception ex)
            {
                // Manejar error de envío si el servidor SMTP no está abierto
                ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('Error al enviar el correo: {ex.Message.Replace("'", "")}');", true);
            }
        }

    }
}