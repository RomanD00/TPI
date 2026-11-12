using System;
using CVJoven.Datos;
using CVJoven.Dominio;

namespace CVJoven.Negocio
{
    public class UsuarioNegocio
    {
        private UsuarioDatos usuarioDatos = new UsuarioDatos();

        public bool RegistrarUsuario(Usuario usuario)
        {
            if (usuario == null)
            {
                return false;
            }

            // Verificar que no exista otro postulante con el mismo mail
            Usuario existente = usuarioDatos.BuscarPorMail(usuario.Mail);
            if (existente != null)
            {
                return false;
            }

            int filasAfectadas = usuarioDatos.InsertarUsuario(usuario);
            return filasAfectadas > 0;
        }

        public Usuario IniciarSesion(string mail, string password)
        {
            Usuario usuario = usuarioDatos.BuscarPorMail(mail);

            if (usuario == null)
            {
                return null;
            }

            bool passwordValida = SeguridadPassword.VerificarPassword(password, usuario.Password);

            if (!passwordValida)
            {
                return null;
            }

            return usuario;
        }
    }
}