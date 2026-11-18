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
            (
                IdUsuario,
                IdCV,
                IdOferta,
                FechaPostulacion,
                EstadoPostulacion
            )
            SELECT
                @idUsuario,
                c.IdCV,
                o.IdOferta,
                GETDATE(),
                'Pendiente'
            FROM CV c
            CROSS JOIN OfertaLaboral o
            WHERE c.IdCV = @idCV
            AND c.IdUsuario = @idUsuario
            AND o.IdOferta = @idOferta
            AND o.EstadoOferta = 'Activa'
            AND NOT EXISTS
            (
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

        public DataTable ObtenerCandidatosPorOferta(
    long idOferta, long idEmpresa)
        {
            AccesoDatos datos = new AccesoDatos();
            DataTable tabla = new DataTable();

            try
            {
                datos.setearConsulta(@"
            SELECT
                p.IdPostulacion,
                p.IdUsuario,
                p.IdCV,
                u.Nombre,
                u.Apellido,
                c.nombreDelCV,
                p.FechaPostulacion,
                p.EstadoPostulacion
            FROM Postulacion p
            INNER JOIN Usuario u
                ON p.IdUsuario = u.IdUsuario
            INNER JOIN CV c
                ON p.IdCV = c.IdCV
                AND c.IdUsuario = p.IdUsuario
            INNER JOIN OfertaLaboral o
                ON p.IdOferta = o.IdOferta
            WHERE p.IdOferta = @idOferta
            AND o.IdEmpresa = @idEmpresa
            ORDER BY p.FechaPostulacion DESC");

                datos.setearParametro("@idOferta", idOferta);
                datos.setearParametro("@idEmpresa", idEmpresa);

                datos.ejecutarLectura();

                tabla.Load(datos.Lector);

                return tabla;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }


        public DataTable ObtenerCandidatoPorPostulacion(
    long idPostulacion, long idEmpresa)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta(@"
            SELECT
                p.IdPostulacion,
                p.IdCV,
                p.IdOferta,
                p.EstadoPostulacion,
                u.IdUsuario,
                u.Nombre,
                u.Apellido,
                u.ZonaLocalidad,
                u.FechaNacimiento,
                u.mail AS Mail,
                u.celular AS Celular
            FROM Postulacion p
            INNER JOIN Usuario u
                ON p.IdUsuario = u.IdUsuario
            INNER JOIN OfertaLaboral o
                ON p.IdOferta = o.IdOferta
            INNER JOIN CV c
                ON p.IdCV = c.IdCV
                AND c.IdUsuario = p.IdUsuario
            WHERE p.IdPostulacion = @idPostulacion
            AND o.IdEmpresa = @idEmpresa");

                datos.setearParametro("@idPostulacion", idPostulacion);
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


        public int AceptarCandidato(long idPostulacion,
    long idOferta, long idEmpresa)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta(@"
            UPDATE Postulacion
            SET EstadoPostulacion = 'Aceptado'
            WHERE IdPostulacion = @idPostulacion
            AND IdOferta = @idOferta
            AND EstadoPostulacion IN ('Pendiente', 'En Revision')
            AND EXISTS (
                SELECT 1
                FROM OfertaLaboral
                WHERE IdOferta = @idOferta
                AND IdEmpresa = @idEmpresa
                AND EstadoOferta = 'Cerrada'
            )
            AND NOT EXISTS (
                SELECT 1
                FROM Postulacion
                WHERE IdOferta = @idOferta
                AND EstadoPostulacion = 'Aceptado'
            )");

                datos.setearParametro("@idPostulacion", idPostulacion);
                datos.setearParametro("@idOferta", idOferta);
                datos.setearParametro("@idEmpresa", idEmpresa);

                return datos.ejecutarAccion();
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public void RechazarOtrosCandidatos(long idPostulacion,
    long idOferta, long idEmpresa)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta(@"
            UPDATE Postulacion
            SET EstadoPostulacion = 'Rechazado'
            WHERE IdOferta = @idOferta
            AND IdPostulacion <> @idPostulacion
            AND EstadoPostulacion IN ('Pendiente', 'En Revision')
            AND EXISTS (
                SELECT 1
                FROM OfertaLaboral
                WHERE IdOferta = @idOferta
                AND IdEmpresa = @idEmpresa
                AND EstadoOferta = 'Cerrada'
            )
            AND EXISTS (
                SELECT 1
                FROM Postulacion
                WHERE IdPostulacion = @idPostulacion
                AND IdOferta = @idOferta
                AND EstadoPostulacion = 'Aceptado'
            )");

                datos.setearParametro("@idPostulacion", idPostulacion);
                datos.setearParametro("@idOferta", idOferta);
                datos.setearParametro("@idEmpresa", idEmpresa);

                datos.ejecutarAccion();
            }
            finally
            {
                datos.cerrarConexion();
            }
        }




    }
}
