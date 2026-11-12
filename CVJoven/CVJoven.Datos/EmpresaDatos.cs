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
    }
}
