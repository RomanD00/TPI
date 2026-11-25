using System;
using System.Collections.Generic;
using CVJoven.Dominio;
using System.Data;

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
                    IF EXISTS (SELECT 1 FROM CV WHERE IdCV = @IdCV AND IdUsuario = @IdUsuario)
                       AND NOT EXISTS (
                           SELECT 1
                           FROM Postulacion
                           WHERE IdCV = @IdCV
                             AND EstadoPostulacion <> 'Rechazado'
                       )
                    BEGIN
                        DELETE FROM Postulacion WHERE IdCV = @IdCV AND EstadoPostulacion = 'Rechazado';
                        DELETE FROM Discapacidad WHERE IdCV = @IdCV;
                        DELETE FROM Habilidades WHERE idCV = @IdCV;
                        DELETE FROM Experiencia WHERE idCV = @IdCV;
                        DELETE FROM Educacion WHERE idCV = @IdCV;
                        DELETE FROM CV WHERE IdCV = @IdCV AND IdUsuario = @IdUsuario;
                    END");

                datos.setearParametro("@IdCV", idCV);
                datos.setearParametro("@IdUsuario", idUsuario);

                return datos.ejecutarAccion();
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        // MÉTODOS PARA GUARDAR Y VER CV COMPLETO


        public long InsertarCV(CV cv)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta(@"
                    INSERT INTO CV (IdUsuario, nombreDelCV, DisponibilidadHoraria)
                    OUTPUT INSERTED.IdCV
                    VALUES (@IdUsuario, @Nombre, @Disponibilidad)");

                datos.setearParametro("@IdUsuario", cv.IdUsuario);
                datos.setearParametro("@Nombre", cv.nombreDelCV);
                datos.setearParametro("@Disponibilidad", cv.DisponibilidadHoraria);

                datos.ejecutarLectura();

                if (datos.Lector.Read())
                {
                    return Convert.ToInt64(datos.Lector[0]);
                }

                return 0;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public void InsertarEducacion(Educacion edu)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta(@"
                    INSERT INTO Educacion (idCV, Titulo, Institucion, nivelAlcanzado, Anio)
                    VALUES (@idCV, @titulo, @institucion, @nivelAlcanzado, @anio)");

                datos.setearParametro("@idCV", edu.IdCV);
                datos.setearParametro("@titulo", edu.Titulo);
                datos.setearParametro("@institucion", edu.Institucion);
                datos.setearParametro("@nivelAlcanzado", edu.NivelAlcanzado);
                datos.setearParametro("@anio", edu.Anio);

                datos.ejecutarAccion();
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public void InsertarExperiencia(Experiencia exp)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta(@"
                    INSERT INTO Experiencia (idCV, tipoExperiencia, Puesto, Empresa, Descripcion, FechaDesde, FechaHasta)
                    VALUES (@idCV, @tipo, @puesto, @empresa, @descripcion, @desde, @hasta)");

                datos.setearParametro("@idCV", exp.IdCV);
                datos.setearParametro("@tipo", exp.TipoExperiencia);
                datos.setearParametro("@puesto", exp.Puesto);
                datos.setearParametro("@empresa", exp.Empresa);
                datos.setearParametro("@descripcion", exp.Descripcion);
                datos.setearParametro("@desde", exp.FechaDesde);
                datos.setearParametro("@hasta", exp.FechaHasta == DateTime.MinValue ? (object)null : exp.FechaHasta);

                datos.ejecutarAccion();
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public void InsertarHabilidad(Habilidad hab)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta(@"
                    INSERT INTO Habilidades (idCV, Descripcion, TipoHabilidad)
                    VALUES (@idCV, @descripcion, @tipoHabilidad)");

                datos.setearParametro("@idCV", hab.IdCV);
                datos.setearParametro("@descripcion", hab.Descripcion);
                datos.setearParametro("@tipoHabilidad", hab.TipoHabilidad);

                datos.ejecutarAccion();
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public CV ObtenerCVPorId(long idCV)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta(@"
                    SELECT IdCV, IdUsuario, nombreDelCV, DisponibilidadHoraria
                    FROM CV
                    WHERE IdCV = @IdCV");

                datos.setearParametro("@IdCV", idCV);
                datos.ejecutarLectura();

                if (datos.Lector.Read())
                {
                    CV cv = new CV();
                    cv.IdCV = Convert.ToInt64(datos.Lector["IdCV"]);
                    cv.IdUsuario = Convert.ToInt64(datos.Lector["IdUsuario"]);
                    cv.nombreDelCV = datos.Lector["nombreDelCV"].ToString();
                    cv.DisponibilidadHoraria = datos.Lector["DisponibilidadHoraria"].ToString();
                    return cv;
                }

                return null;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public List<Educacion> ListarEducacionPorCV(long idCV)
        {
            List<Educacion> lista = new List<Educacion>();
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta(@"
                    SELECT idEducacion, idCV, Titulo, Institucion, nivelAlcanzado, Anio
                    FROM Educacion
                    WHERE idCV = @idCV
                    ORDER BY Anio DESC");

                datos.setearParametro("@idCV", idCV);
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Educacion edu = new Educacion();
                    edu.IdEducacion = Convert.ToInt64(datos.Lector["idEducacion"]);
                    edu.IdCV = Convert.ToInt64(datos.Lector["idCV"]);
                    edu.Titulo = datos.Lector["Titulo"].ToString();
                    edu.Institucion = datos.Lector["Institucion"].ToString();
                    edu.NivelAlcanzado = datos.Lector["nivelAlcanzado"].ToString();
                    edu.Anio = Convert.ToInt32(datos.Lector["Anio"]);
                    lista.Add(edu);
                }

                return lista;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public List<Experiencia> ListarExperienciaPorCV(long idCV)
        {
            List<Experiencia> lista = new List<Experiencia>();
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta(@"
                    SELECT idExperiencia, idCV, tipoExperiencia, Puesto, Empresa, Descripcion, FechaDesde, FechaHasta
                    FROM Experiencia
                    WHERE idCV = @idCV
                    ORDER BY FechaDesde DESC");

                datos.setearParametro("@idCV", idCV);
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Experiencia exp = new Experiencia();
                    exp.IdExperiencia = Convert.ToInt64(datos.Lector["idExperiencia"]);
                    exp.IdCV = Convert.ToInt64(datos.Lector["idCV"]);
                    exp.TipoExperiencia = datos.Lector["tipoExperiencia"].ToString();
                    exp.Puesto = datos.Lector["Puesto"].ToString();
                    exp.Empresa = datos.Lector["Empresa"].ToString();
                    exp.Descripcion = datos.Lector["Descripcion"] != DBNull.Value ? datos.Lector["Descripcion"].ToString() : "";
                    exp.FechaDesde = Convert.ToDateTime(datos.Lector["FechaDesde"]);
                    exp.FechaHasta = datos.Lector["FechaHasta"] != DBNull.Value ? Convert.ToDateTime(datos.Lector["FechaHasta"]) : DateTime.MinValue;
                    lista.Add(exp);
                }

                return lista;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public List<Habilidad> ListarHabilidadesPorCV(long idCV)
        {
            List<Habilidad> lista = new List<Habilidad>();
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta(@"
                    SELECT idHabilidad, idCV, Descripcion, TipoHabilidad
                    FROM Habilidades
                    WHERE idCV = @idCV");

                datos.setearParametro("@idCV", idCV);
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Habilidad hab = new Habilidad();
                    hab.IdHabilidad = Convert.ToInt64(datos.Lector["idHabilidad"]);
                    hab.IdCV = Convert.ToInt64(datos.Lector["idCV"]);
                    hab.Descripcion = datos.Lector["Descripcion"].ToString();
                    hab.TipoHabilidad = Convert.ToBoolean(datos.Lector["TipoHabilidad"]);
                    lista.Add(hab);
                }

                return lista;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public void ActualizarCVCompleto(
            CV cv,
            List<Educacion> estudios,
            List<Experiencia> experiencias,
            List<Habilidad> habilidades,
            List<long> idsDiscapacidad = null)
        {
            ModificarCV(cv);

            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta(@"
                    DELETE FROM Discapacidad WHERE IdCV = @idCV;
                    DELETE FROM Habilidades WHERE idCV = @idCV;
                    DELETE FROM Experiencia WHERE idCV = @idCV;
                    DELETE FROM Educacion WHERE idCV = @idCV;");
                datos.setearParametro("@idCV", cv.IdCV);
                datos.ejecutarAccion();
            }
            finally
            {
                datos.cerrarConexion();
            }

            if (estudios != null)
            {
                foreach (Educacion edu in estudios)
                {
                    edu.IdCV = cv.IdCV;
                    InsertarEducacion(edu);
                }
            }

            if (experiencias != null)
            {
                foreach (Experiencia exp in experiencias)
                {
                    exp.IdCV = cv.IdCV;
                    InsertarExperiencia(exp);
                }
            }

            if (habilidades != null)
            {
                foreach (Habilidad hab in habilidades)
                {
                    hab.IdCV = cv.IdCV;
                    InsertarHabilidad(hab);
                }
            }

            if (idsDiscapacidad != null)
            {
                foreach (long idDisc in idsDiscapacidad)
                {
                    InsertarDiscapacidad(cv.IdCV, idDisc);
                }
            }
        }

        public List<Habilidad> ListarHabilidadesPorUsuario(long idUsuario)
        {
            List<Habilidad> lista = new List<Habilidad>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta(@"
                    SELECT h.idHabilidad, h.idCV, h.Descripcion, h.TipoHabilidad
                    FROM Habilidades h
                    INNER JOIN CV c ON h.idCV = c.IdCV
                    WHERE c.IdUsuario = @idUsuario");

                datos.setearParametro("@idUsuario", idUsuario);
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Habilidad hab = new Habilidad();
                    hab.IdHabilidad = Convert.ToInt64(datos.Lector["idHabilidad"]);
                    hab.IdCV = Convert.ToInt64(datos.Lector["idCV"]);
                    hab.Descripcion = datos.Lector["Descripcion"].ToString();
                    hab.TipoHabilidad = Convert.ToBoolean(datos.Lector["TipoHabilidad"]);
                    lista.Add(hab);
                }

                return lista;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public DataTable ListarTiposDiscapacidad()
        {
            AccesoDatos datos = new AccesoDatos();
            DataTable tabla = new DataTable();

            try
            {
                datos.setearConsulta(@"
                    SELECT IdDiscapacidad, Nombre, Descripcion
                    FROM TipoDiscapacidad
                    ORDER BY Nombre");

                datos.ejecutarLectura();
                tabla.Load(datos.Lector);
                return tabla;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public void InsertarDiscapacidad(long idCV, long idDiscapacidad)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta(@"
                    INSERT INTO Discapacidad (IdCV, IdDiscapacidad)
                    VALUES (@idCV, @idDiscapacidad)");

                datos.setearParametro("@idCV", idCV);
                datos.setearParametro("@idDiscapacidad", idDiscapacidad);
                datos.ejecutarAccion();
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public List<long> ListarIdsDiscapacidadPorCV(long idCV)
        {
            List<long> lista = new List<long>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta(@"
                    SELECT IdDiscapacidad
                    FROM Discapacidad
                    WHERE IdCV = @idCV");

                datos.setearParametro("@idCV", idCV);
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    lista.Add(Convert.ToInt64(datos.Lector["IdDiscapacidad"]));
                }

                return lista;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public List<string> ListarNombresDiscapacidadPorCV(long idCV)
        {
            List<string> lista = new List<string>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta(@"
                    SELECT td.Nombre
                    FROM Discapacidad d
                    INNER JOIN TipoDiscapacidad td ON d.IdDiscapacidad = td.IdDiscapacidad
                    WHERE d.IdCV = @idCV
                    ORDER BY td.Nombre");

                datos.setearParametro("@idCV", idCV);
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    lista.Add(datos.Lector["Nombre"].ToString());
                }

                return lista;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public bool UsuarioTieneDiscapacidad(long idUsuario)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta(@"
                    SELECT TOP 1 1
                    FROM Discapacidad d
                    INNER JOIN CV c ON d.IdCV = c.IdCV
                    WHERE c.IdUsuario = @idUsuario");

                datos.setearParametro("@idUsuario", idUsuario);
                datos.ejecutarLectura();

                return datos.Lector.Read();
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
    }
}