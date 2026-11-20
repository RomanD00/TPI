using System;
using CVJoven.Datos;
using CVJoven.Dominio;

namespace CVJoven.Negocio
{
    public class UsuarioNegocio
    {
        private UsuarioDatos usuarioDatos = new UsuarioDatos();

        public bool ExisteMailEnSistema(string mail, long idUsuarioExcluir = 0)
        {
            if (string.IsNullOrWhiteSpace(mail))
            {
                return false;
            }

            return usuarioDatos.ExisteMailEnSistema(mail.Trim(), idUsuarioExcluir);
        }

        public bool RegistrarUsuario(Usuario usuario)
        {
            if (usuario == null)
            {
                return false;
            }

            if (usuarioDatos.ExisteMailEnSistema(usuario.Mail.Trim()))
            {
                return false;
            }

            int filasAfectadas = usuarioDatos.InsertarUsuario(usuario);
            return filasAfectadas > 0;
        }

        public bool ActualizarUsuario(Usuario usuario)
        {
            if (usuario == null || usuario.IdUsuario <= 0)
            {
                return false;
            }

            if (usuarioDatos.ExisteMailEnSistema(usuario.Mail.Trim(), usuario.IdUsuario))
            {
                return false;
            }

            return usuarioDatos.ActualizarUsuario(usuario) > 0;
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