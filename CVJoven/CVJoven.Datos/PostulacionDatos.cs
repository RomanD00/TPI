using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CVJoven.Datos
{
    public class PostulacionDatos
    {

        public DataTable ObtenerCVPorUsuario(long idUsuario)
        {
            AccesoDatos datos = new AccesoDatos();
            DataTable tabla = new DataTable();

            try
            {
                datos.setearConsulta(@"
                    SELECT IdCV, nombreDelCV
                    FROM CV
                    WHERE IdUsuario = @idUsuario
                    ORDER BY nombreDelCV");

                datos.setearParametro("@idUsuario", idUsuario);
                datos.ejecutarLectura();

                tabla.Load(datos.Lector);
                return tabla;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public int RegistrarPostulacion(
            long idUsuario, long idCV, long idOferta)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta(@"
                    INSERT INTO Postulacion
                        (IdUsuario, IdCV, IdOferta,
                         FechaPostulacion, EstadoPostulacion)
                    SELECT
                        @idUsuario, c.IdCV, o.IdOferta,
                        GETDATE(), 'Pendiente'
                    FROM CV c
                    CROSS JOIN OfertaLaboral o
                    WHERE c.IdCV = @idCV
                      AND c.IdUsuario = @idUsuario
                      AND o.IdOferta = @idOferta
                      AND NOT EXISTS (
                          SELECT 1
                          FROM Postulacion p
                          WHERE p.IdUsuario = @idUsuario
                            AND p.IdOferta = @idOferta
                      )");

                datos.setearParametro("@idUsuario", idUsuario);
                datos.setearParametro("@idCV", idCV);
                datos.setearParametro("@idOferta", idOferta);

                return datos.ejecutarAccion();
            }
            finally
            {
                datos.cerrarConexion();
            }
        }


    }
}
