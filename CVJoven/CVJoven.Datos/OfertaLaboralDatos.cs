using CVJoven.Dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CVJoven.Datos
{
    public class OfertaLaboralDatos
    {

        public int InsertarOferta(OfertaLaboral oferta)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta(@"
                    INSERT INTO OfertaLaboral
                    (IdEmpresa, TituloOferta, Zona, TipoDeJornada,
                     Descripcion, AceptaDiscapacidad)
                    VALUES
                    (@idEmpresa, @titulo, @zona, @tipoJornada,
                     @descripcion, @aceptaDiscapacidad)");

                datos.setearParametro("@idEmpresa", oferta.IdEmpresa);
                datos.setearParametro("@titulo", oferta.TituloOferta);
                datos.setearParametro("@zona", oferta.Zona);
                datos.setearParametro("@tipoJornada", oferta.TipoDeJornada);
                datos.setearParametro("@descripcion", oferta.Descripcion);
                datos.setearParametro("@aceptaDiscapacidad", oferta.AceptaDiscapacidad);

                return datos.ejecutarAccion();
            }
            finally
            {
                datos.cerrarConexion();
            }
        }



        public System.Data.DataTable ListarOfertas()
        {
            AccesoDatos datos = new AccesoDatos();
            System.Data.DataTable tabla = new System.Data.DataTable();

            try
            {
                datos.setearConsulta(@"
                        
                            SELECT
                                o.IdOferta,
                                o.TituloOferta,
                                o.Zona,
                                e.nombreComercial AS Empresa,
                                o.Zona AS Ubicacion,
                                e.tamanioDeEmpresa AS TamanoEmpresa,
                                CASE
                                    WHEN o.AceptaDiscapacidad = 1 THEN 'Sí'
                                    ELSE 'No'
                                END AS AceptaDiscapacidad
                            FROM OfertaLaboral o
                            INNER JOIN Empresa e
                                ON o.IdEmpresa = e.idEmpresa
                            ORDER BY o.IdOferta DESC;
                            ");

                datos.ejecutarLectura();

                tabla.Load(datos.Lector);

                return tabla;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }


    }
}
