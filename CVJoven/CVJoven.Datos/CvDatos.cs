
using System;
using System.Collections.Generic;
using CVJoven.Dominio;

namespace CVJoven.Datos
{
    public class CVDatos
    {
        // LISTAR CURRICULUMS DE UN USUARIO
        public List<CV> ListarCV(long idUsuario)
        {
            List<CV> lista = new List<CV>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta(@"
                    SELECT IdCV, IdUsuario, nombreDelCV,
                           DisponibilidadHoraria
                    FROM CV
                    WHERE IdUsuario = @IdUsuario
                    ORDER BY IdCV DESC");

                datos.setearParametro("@IdUsuario", idUsuario);
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    CV cv = new CV();

                    cv.IdCV = Convert.ToInt64(datos.Lector["IdCV"]);
                    cv.IdUsuario = Convert.ToInt64(datos.Lector["IdUsuario"]);
                    cv.nombreDelCV = datos.Lector["nombreDelCV"].ToString();
                    cv.DisponibilidadHoraria =
                        datos.Lector["DisponibilidadHoraria"].ToString();

                    lista.Add(cv);
                }

                return lista;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        // AGREGAR CURRICULUM
        public int AgregarCV(CV cv)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta(@"
                    INSERT INTO CV
                    (IdUsuario, nombreDelCV, DisponibilidadHoraria)
                    VALUES
                    (@IdUsuario, @Nombre, @Disponibilidad)");

                datos.setearParametro("@IdUsuario", cv.IdUsuario);
                datos.setearParametro("@Nombre", cv.nombreDelCV);
                datos.setearParametro("@Disponibilidad",
                    cv.DisponibilidadHoraria);

                return datos.ejecutarAccion();
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        // MODIFICAR CURRICULUM
        public int ModificarCV(CV cv)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta(@"
                    UPDATE CV
                    SET nombreDelCV = @Nombre,
                        DisponibilidadHoraria = @Disponibilidad
                    WHERE IdCV = @IdCV
                      AND IdUsuario = @IdUsuario");

                datos.setearParametro("@IdCV", cv.IdCV);
                datos.setearParametro("@IdUsuario", cv.IdUsuario);
                datos.setearParametro("@Nombre", cv.nombreDelCV);
                datos.setearParametro("@Disponibilidad",
                    cv.DisponibilidadHoraria);

                return datos.ejecutarAccion();
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        // ELIMINAR CURRICULUM
        public int EliminarCV(long idCV, long idUsuario)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta(@"
                    DELETE FROM CV
                    WHERE IdCV = @IdCV
                      AND IdUsuario = @IdUsuario
                      AND NOT EXISTS
                      (
                          SELECT 1
                          FROM Postulacion
                          WHERE Postulacion.IdCV = CV.IdCV
                      )");

                datos.setearParametro("@IdCV", idCV);
                datos.setearParametro("@IdUsuario", idUsuario);

                return datos.ejecutarAccion();
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
    }
}

