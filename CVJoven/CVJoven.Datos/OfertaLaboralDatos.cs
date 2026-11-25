using CVJoven.Dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;

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
                    o.TipoDeJornada,
                    o.Descripcion,
                    o.FechaPublicacion,
                    e.nombreComercial AS Empresa,
                    e.sector AS SectorEmpresa,
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
                ORDER BY o.IdOferta DESC;");

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

        public Dictionary<long, List<string>> ObtenerRequisitosDeOfertasActivas()
        {
            AccesoDatos datos = new AccesoDatos();
            Dictionary<long, List<string>> mapa = new Dictionary<long, List<string>>();

            try
            {
                datos.setearConsulta(@"
                    SELECT r.idOferta, r.Descripcion
                    FROM Requisito r
                    INNER JOIN OfertaLaboral o ON r.idOferta = o.IdOferta
                    WHERE o.EstadoOferta = 'Activa'
                    ORDER BY r.IdRequisito");

                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    long idOferta = Convert.ToInt64(datos.Lector["idOferta"]);
                    string descripcion = datos.Lector["Descripcion"].ToString();

                    if (!mapa.ContainsKey(idOferta))
                    {
                        mapa[idOferta] = new List<string>();
                    }

                    mapa[idOferta].Add(descripcion);
                }

                return mapa;
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

        public bool InsertarOfertaConRequisitos(OfertaLaboral oferta)
        {
            string cadenaConexion =
                ConfigurationManager.ConnectionStrings["CadenaConexion"] != null
                    ? ConfigurationManager.ConnectionStrings["CadenaConexion"].ConnectionString
                    : "server=.\\SQLEXPRESS; database=CV_Joven; integrated security=true;";

            using (SqlConnection conexion = new SqlConnection(cadenaConexion))
            {
                conexion.Open();

                using (SqlTransaction transaccion = conexion.BeginTransaction())
                {
                    try
                    {
                        // Registrar la oferta y obtener el ID generado.
                        string consultaOferta = @"
                    INSERT INTO OfertaLaboral
                    (IdEmpresa, TituloOferta, Zona, TipoDeJornada,
                     Descripcion, AceptaDiscapacidad)
                    OUTPUT INSERTED.IdOferta
                    VALUES
                    (@idEmpresa, @titulo, @zona, @jornada,
                     @descripcion, @discapacidad);";

                        long idOferta;

                        using (SqlCommand comando = new SqlCommand(
                            consultaOferta, conexion, transaccion))
                        {
                            comando.Parameters.Add("@idEmpresa", SqlDbType.BigInt)
                                .Value = oferta.IdEmpresa;

                            comando.Parameters.Add("@titulo", SqlDbType.VarChar, 150)
                                .Value = oferta.TituloOferta;

                            comando.Parameters.Add("@zona", SqlDbType.VarChar, 100)
                                .Value = oferta.Zona;

                            comando.Parameters.Add("@jornada", SqlDbType.VarChar, 50)
                                .Value = oferta.TipoDeJornada;

                            comando.Parameters.Add("@descripcion", SqlDbType.VarChar, -1)
                                .Value = oferta.Descripcion;

                            comando.Parameters.Add("@discapacidad", SqlDbType.Bit)
                                .Value = oferta.AceptaDiscapacidad;

                            idOferta = Convert.ToInt64(comando.ExecuteScalar());
                        }

                        // Registrar los requisitos de esa oferta.
                        if (oferta.Requisitos != null)
                        {
                            foreach (string requisito in oferta.Requisitos)
                            {
                                using (SqlCommand comando = new SqlCommand(
                                    @"INSERT INTO Requisito (idOferta, Descripcion)
                              VALUES (@idOferta, @descripcion)",
                                    conexion, transaccion))
                                {
                                    comando.Parameters.Add("@idOferta", SqlDbType.BigInt)
                                        .Value = idOferta;

                                    comando.Parameters.Add("@descripcion", SqlDbType.VarChar, 255)
                                        .Value = requisito;

                                    comando.ExecuteNonQuery();
                                }
                            }
                        }

                        transaccion.Commit();

                        oferta.IdOferta = idOferta;

                        return true;
                    }
                    catch
                    {
                        transaccion.Rollback();
                        throw;
                    }
                }
            }
        }

        public HashSet<long> ObtenerIdsOfertasPostuladas(long idUsuario)
        {
            AccesoDatos datos = new AccesoDatos();
            HashSet<long> ids = new HashSet<long>();

            try
            {
                datos.setearConsulta(@"
                    SELECT DISTINCT p.IdOferta
                    FROM Postulacion p
                    INNER JOIN CV c ON p.IdCV = c.IdCV
                    WHERE c.IdUsuario = @idUsuario");

                datos.setearParametro("@idUsuario", idUsuario);
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    ids.Add(Convert.ToInt64(datos.Lector["IdOferta"]));
                }

                return ids;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public void ReemplazarRequisitosOferta(long idOferta, long idEmpresa, List<string> requisitos)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta(@"
                    DELETE r
                    FROM Requisito r
                    INNER JOIN OfertaLaboral o ON r.idOferta = o.IdOferta
                    WHERE r.idOferta = @idOferta
                      AND o.IdEmpresa = @idEmpresa
                      AND o.EstadoOferta = 'Activa'");

                datos.setearParametro("@idOferta", idOferta);
                datos.setearParametro("@idEmpresa", idEmpresa);
                datos.ejecutarAccion();
            }
            finally
            {
                datos.cerrarConexion();
            }

            if (requisitos != null)
            {
                foreach (string requisito in requisitos)
                {
                    AccesoDatos datosInsert = new AccesoDatos();

                    try
                    {
                        datosInsert.setearConsulta(@"
                            INSERT INTO Requisito (idOferta, Descripcion)
                            SELECT IdOferta, @descripcion
                            FROM OfertaLaboral
                            WHERE IdOferta = @idOferta
                              AND IdEmpresa = @idEmpresa
                              AND EstadoOferta = 'Activa'");

                        datosInsert.setearParametro("@idOferta", idOferta);
                        datosInsert.setearParametro("@idEmpresa", idEmpresa);
                        datosInsert.setearParametro("@descripcion", requisito);
                        datosInsert.ejecutarAccion();
                    }
                    finally
                    {
                        datosInsert.cerrarConexion();
                    }
                }
            }
        }

    }
}
