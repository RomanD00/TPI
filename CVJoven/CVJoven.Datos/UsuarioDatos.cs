using System;
using CVJoven.Dominio;

namespace CVJoven.Datos
{
    public class UsuarioDatos
    {
        public int InsertarUsuario(Usuario usuario)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta(@"
                    INSERT INTO Usuario
                    (idTipoUsuario, mail, contraseña,
                     Nombre, Apellido, DNI,
                     ZonaLocalidad, celular, FechaNacimiento)
                    VALUES
                    (@idTipoUsuario, @mail, @password,
                     @nombre, @apellido, @dni,
                     @zonaLocalidad, @celular, @fechaNacimiento)");

                datos.setearParametro("@idTipoUsuario", usuario.IdTipoUsuario);
                datos.setearParametro("@mail", usuario.Mail);
                datos.setearParametro("@password", usuario.Password);
                datos.setearParametro("@nombre", usuario.Nombre);
                datos.setearParametro("@apellido", usuario.Apellido);
                datos.setearParametro("@dni", usuario.DNI);
                datos.setearParametro("@zonaLocalidad", usuario.ZonaLocalidad);
                datos.setearParametro("@celular", usuario.Celular);
                datos.setearParametro("@fechaNacimiento", usuario.FechaNacimiento);

                return datos.ejecutarAccion();
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public Usuario BuscarPorMail(string mail)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta(@"
                    SELECT idUsuario, idTipoUsuario, mail,
                           contraseña, Nombre, Apellido,
                           DNI, ZonaLocalidad, celular, FechaNacimiento
                    FROM Usuario
                    WHERE mail = @mail");

                datos.setearParametro("@mail", mail);
                datos.ejecutarLectura();

                if (datos.Lector.Read())
                {
                    Usuario usuario = new Usuario();

                    usuario.IdUsuario = Convert.ToInt64(datos.Lector["idUsuario"]);
                    usuario.IdTipoUsuario = Convert.ToInt32(datos.Lector["idTipoUsuario"]);
                    usuario.Mail = datos.Lector["mail"].ToString();
                    usuario.Password = datos.Lector["contraseña"].ToString();
                    usuario.Nombre = datos.Lector["Nombre"].ToString();
                    usuario.Apellido = datos.Lector["Apellido"].ToString();
                    usuario.DNI = datos.Lector["DNI"].ToString();
                    usuario.ZonaLocalidad = datos.Lector["ZonaLocalidad"].ToString();
                    usuario.Celular = datos.Lector["celular"].ToString();
                    usuario.FechaNacimiento = Convert.ToDateTime(datos.Lector["FechaNacimiento"]);

                    return usuario;
                }

                return null;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public bool ExisteMailEnSistema(string mail, long idUsuarioExcluir = 0)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta(@"
                    SELECT COUNT(1) AS Cantidad
                    FROM (
                        SELECT mail FROM Usuario
                        WHERE LOWER(LTRIM(RTRIM(mail))) = LOWER(LTRIM(RTRIM(@mail)))
                          AND idUsuario <> @idUsuarioExcluir
                        UNION ALL
                        SELECT mail FROM Empresa
                        WHERE LOWER(LTRIM(RTRIM(mail))) = LOWER(LTRIM(RTRIM(@mail)))
                    ) AS Correos");

                datos.setearParametro("@mail", mail);
                datos.setearParametro("@idUsuarioExcluir", idUsuarioExcluir);
                datos.ejecutarLectura();

                if (datos.Lector.Read())
                {
                    return Convert.ToInt32(datos.Lector["Cantidad"]) > 0;
                }

                return false;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public int ActualizarUsuario(Usuario usuario)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta(@"
                    UPDATE Usuario
                    SET mail = @mail,
                        Nombre = @nombre,
                        Apellido = @apellido,
                        ZonaLocalidad = @zonaLocalidad,
                        celular = @celular,
                        FechaNacimiento = @fechaNacimiento
                    WHERE idUsuario = @idUsuario");

                datos.setearParametro("@mail", usuario.Mail);
                datos.setearParametro("@nombre", usuario.Nombre);
                datos.setearParametro("@apellido", usuario.Apellido);
                datos.setearParametro("@zonaLocalidad", usuario.ZonaLocalidad);
                datos.setearParametro("@celular", usuario.Celular);
                datos.setearParametro("@fechaNacimiento", usuario.FechaNacimiento);
                datos.setearParametro("@idUsuario", usuario.IdUsuario);

                return datos.ejecutarAccion();
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
    }
}