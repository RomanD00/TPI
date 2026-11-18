using CVJoven.Dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;

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
            WHERE o.EstadoOferta = 'Activa'
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


        public DataTable ObtenerDetalleOferta(long idOferta)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta(@"
            SELECT
                o.IdOferta,
                o.TituloOferta,
                o.Zona,
                o.TipoDeJornada,
                o.Descripcion,
                o.AceptaDiscapacidad,
                e.nombreComercial AS Empresa,
                e.sector AS SectorEmpresa,
                e.tamanioDeEmpresa AS TamanoEmpresa,
                e.paginaWeb AS PaginaWeb
            FROM OfertaLaboral o
            INNER JOIN Empresa e
                ON o.IdEmpresa = e.idEmpresa
            WHERE o.IdOferta = @idOferta
            AND o.EstadoOferta = 'Activa'");

                datos.setearParametro("@idOferta", idOferta);

                datos.ejecutarLectura();

                DataTable tabla = new DataTable();

                tabla.Load(datos.Lector);

                return tabla;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }


        public System.Data.DataTable ObtenerRequisitosOferta(long idOferta)
        {
            AccesoDatos datos = new AccesoDatos();
            System.Data.DataTable tabla = new System.Data.DataTable();

            try
            {
                datos.setearConsulta(@"
            SELECT IdRequisito, Descripcion
            FROM Requisito
            WHERE idOferta = @idOferta
            ORDER BY IdRequisito");

                datos.setearParametro("@idOferta", idOferta);
                datos.ejecutarLectura();

                tabla.Load(datos.Lector);
                return tabla;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }


        public DataTable ObtenerOfertasPorEmpresa(long idEmpresa)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta(@"
            SELECT
                o.IdOferta,
                o.TituloOferta,
                o.Zona,
                o.TipoDeJornada,
                o.Descripcion,
                o.AceptaDiscapacidad,
                o.EstadoOferta,
                o.FechaPublicacion,
                (
                    SELECT COUNT(*)
                    FROM Postulacion p
                    WHERE p.IdOferta = o.IdOferta
                ) AS CantidadPostulaciones
            FROM OfertaLaboral o
            WHERE o.IdEmpresa = @idEmpresa
            ORDER BY o.FechaPublicacion DESC");

                datos.setearParametro("@idEmpresa", idEmpresa);

                datos.ejecutarLectura();

                DataTable tabla = new DataTable();

                tabla.Load(datos.Lector);

                return tabla;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }


        public DataTable ObtenerOfertaParaEditar(long idOferta, long idEmpresa)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta(@"
            SELECT IdOferta, TituloOferta, Zona,
                   TipoDeJornada, Descripcion,
                   AceptaDiscapacidad
            FROM OfertaLaboral
            WHERE IdOferta = @idOferta
            AND IdEmpresa = @idEmpresa
            AND EstadoOferta = 'Activa'");

                datos.setearParametro("@idOferta", idOferta);
                datos.setearParametro("@idEmpresa", idEmpresa);

                datos.ejecutarLectura();

                DataTable tabla = new DataTable();

                tabla.Load(datos.Lector);

                return tabla;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public int ActualizarOferta(
    long idOferta,
    long idEmpresa,
    string titulo,
    string zona,
    string jornada,
    string descripcion,
    bool aceptaDiscapacidad)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta(@"
            UPDATE OfertaLaboral
            SET TituloOferta = @titulo,
                Zona = @zona,
                TipoDeJornada = @jornada,
                Descripcion = @descripcion,
                AceptaDiscapacidad = @aceptaDiscapacidad
            WHERE IdOferta = @idOferta
            AND IdEmpresa = @idEmpresa
            AND EstadoOferta = 'Activa'");

                datos.setearParametro("@idOferta", idOferta);
                datos.setearParametro("@idEmpresa", idEmpresa);
                datos.setearParametro("@titulo", titulo);
                datos.setearParametro("@zona", zona);
                datos.setearParametro("@jornada", jornada);
                datos.setearParametro("@descripcion", descripcion);
                datos.setearParametro("@aceptaDiscapacidad", aceptaDiscapacidad);

                return datos.ejecutarAccion();
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public int CancelarOferta(long idOferta, long idEmpresa)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta(@"
            UPDATE OfertaLaboral
            SET EstadoOferta = 'Cancelada'
            WHERE IdOferta = @idOferta
            AND IdEmpresa = @idEmpresa
            AND EstadoOferta = 'Activa'");

                datos.setearParametro("@idOferta", idOferta);
                datos.setearParametro("@idEmpresa", idEmpresa);

                return datos.ejecutarAccion();
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public void RechazarPostulaciones(long idOferta, long idEmpresa)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta(@"
            UPDATE Postulacion
            SET EstadoPostulacion = 'Rechazado'
            WHERE IdOferta = @idOferta
            AND EstadoPostulacion IN ('Pendiente', 'En Revision')
            AND IdOferta IN (
                SELECT IdOferta
                FROM OfertaLaboral
                WHERE IdEmpresa = @idEmpresa
                AND EstadoOferta = 'Cancelada'
            )");

                datos.setearParametro("@idOferta", idOferta);
                datos.setearParametro("@idEmpresa", idEmpresa);

                datos.ejecutarAccion();
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public DataTable ObtenerOfertaPorEmpresa(
    long idOferta, long idEmpresa)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta(@"
            SELECT IdOferta, TituloOferta, EstadoOferta
            FROM OfertaLaboral
            WHERE IdOferta = @idOferta
            AND IdEmpresa = @idEmpresa");

                datos.setearParametro("@idOferta", idOferta);
                datos.setearParametro("@idEmpresa", idEmpresa);

                datos.ejecutarLectura();

                DataTable tabla = new DataTable();

                tabla.Load(datos.Lector);

                return tabla;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }


        public int CerrarOferta(long idOferta, long idEmpresa,
    long idPostulacion)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta(@"
            UPDATE OfertaLaboral
            SET EstadoOferta = 'Cerrada'
            WHERE IdOferta = @idOferta
            AND IdEmpresa = @idEmpresa
            AND EstadoOferta = 'Activa'
            AND EXISTS (
                SELECT 1
                FROM Postulacion
                WHERE IdPostulacion = @idPostulacion
                AND IdOferta = @idOferta
                AND EstadoPostulacion IN ('Pendiente', 'En Revision')
            )
            AND NOT EXISTS (
                SELECT 1
                FROM Postulacion
                WHERE IdOferta = @idOferta
                AND EstadoPostulacion = 'Aceptado'
            )");

                datos.setearParametro("@idOferta", idOferta);
                datos.setearParametro("@idEmpresa", idEmpresa);
                datos.setearParametro("@idPostulacion", idPostulacion);

                return datos.ejecutarAccion();
            }
            finally
            {
                datos.cerrarConexion();
            }
        }





    }
}
