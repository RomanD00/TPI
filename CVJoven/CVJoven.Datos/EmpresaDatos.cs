using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CVJoven.Dominio;

namespace CVJoven.Datos
{
    public class EmpresaDatos
    {
        public int InsertarEmpresa(Empresa empresa)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta(@"
                    INSERT INTO Empresa
                    (idTipoUsuario, mail, contraseña,
                     nombreLegal, nombreComercial, CUIT,
                     sector, tamanioDeEmpresa, paginaWeb,
                     correoRRHH)
                    VALUES
                    (@idTipoUsuario, @mail, @password,
                     @nombreLegal, @nombreComercial, @cuit,
                     @sector, @tamanio, @paginaWeb,
                     @correoRRHH)");

                datos.setearParametro("@idTipoUsuario", empresa.IdTipoUsuario);
                datos.setearParametro("@mail", empresa.Mail);
                datos.setearParametro("@password", empresa.Password);
                datos.setearParametro("@nombreLegal", empresa.NombreLegal);
                datos.setearParametro("@nombreComercial", empresa.NombreComercial);
                datos.setearParametro("@cuit", empresa.CUIT);
                datos.setearParametro("@sector", empresa.sector);
                datos.setearParametro("@tamanio", empresa.TamanioDeEmpresa);
                datos.setearParametro("@paginaWeb", empresa.PaginaWeb);
                datos.setearParametro("@correoRRHH", empresa.CorreoRRHH);

                return datos.ejecutarAccion();
            }
            finally
            {
                datos.cerrarConexion();
            }
        }




        public Empresa BuscarPorMail(string mail)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta(@"
            SELECT idEmpresa, idTipoUsuario, mail,
                   contraseña, nombreLegal, nombreComercial,
                   CUIT, sector, tamanioDeEmpresa,
                   paginaWeb, correoRRHH
            FROM Empresa
            WHERE mail = @mail");

                datos.setearParametro("@mail", mail);

                datos.ejecutarLectura();

                if (datos.Lector.Read())
                {
                    Empresa empresa = new Empresa();

                    empresa.IdEmpresa = Convert.ToInt64(datos.Lector["idEmpresa"]);
                    empresa.IdTipoUsuario = Convert.ToInt32(datos.Lector["idTipoUsuario"]);
                    empresa.Mail = datos.Lector["mail"].ToString();
                    empresa.Password = datos.Lector["contraseña"].ToString();
                    empresa.NombreLegal = datos.Lector["nombreLegal"].ToString();
                    empresa.NombreComercial = datos.Lector["nombreComercial"].ToString();
                    empresa.CUIT = datos.Lector["CUIT"].ToString();
                    empresa.sector = datos.Lector["sector"].ToString();
                    empresa.TamanioDeEmpresa = datos.Lector["tamanioDeEmpresa"].ToString();

                    empresa.PaginaWeb = datos.Lector["paginaWeb"] == DBNull.Value
                        ? null
                        : datos.Lector["paginaWeb"].ToString();

                    empresa.CorreoRRHH = datos.Lector["correoRRHH"].ToString();

                    return empresa;
                }

                return null;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }




    }
}
