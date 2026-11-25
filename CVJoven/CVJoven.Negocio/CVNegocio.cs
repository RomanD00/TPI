using System;
using System.Collections.Generic;
using CVJoven.Datos;
using CVJoven.Dominio;
using System.Data;

namespace CVJoven.Negocio
{
    public class CVNegocio
    {
        private readonly CVDatos cvDatos = new CVDatos();

        public List<CV> ListarCV(long idUsuario)
        {
            return cvDatos.ListarCV(idUsuario);
        }

        public int AgregarCV(CV cv)
        {
            return cvDatos.AgregarCV(cv);
        }

        public int ModificarCV(CV cv)
        {
            return cvDatos.ModificarCV(cv);
        }

        public int EliminarCV(long idCV, long idUsuario)
        {
            return cvDatos.EliminarCV(idCV, idUsuario);
        }

        public long GuardarCVCompleto(
            CV cv,
            List<Educacion> estudios,
            List<Experiencia> experiencias,
            List<Habilidad> habilidades,
            List<long> idsDiscapacidad = null)
        {
            long idCV = cvDatos.InsertarCV(cv);

            if (idCV <= 0)
                return 0;

            try
            {
                if (estudios != null)
                {
                    foreach (Educacion edu in estudios)
                    {
                        edu.IdCV = idCV;
                        cvDatos.InsertarEducacion(edu);
                    }
                }

                if (experiencias != null)
                {
                    foreach (Experiencia exp in experiencias)
                    {
                        exp.IdCV = idCV;
                        cvDatos.InsertarExperiencia(exp);
                    }
                }

                if (habilidades != null)
                {
                    foreach (Habilidad hab in habilidades)
                    {
                        hab.IdCV = idCV;
                        cvDatos.InsertarHabilidad(hab);
                    }
                }

                if (idsDiscapacidad != null)
                {
                    foreach (long idDisc in idsDiscapacidad)
                    {
                        cvDatos.InsertarDiscapacidad(idCV, idDisc);
                    }
                }

                return idCV;
            }
            catch
            {
                try { cvDatos.EliminarCV(idCV, cv.IdUsuario); } catch { }
                throw;
            }
        }

        public void ActualizarCVCompleto(
            CV cv,
            List<Educacion> estudios,
            List<Experiencia> experiencias,
            List<Habilidad> habilidades,
            List<long> idsDiscapacidad = null)
        {
            cvDatos.ActualizarCVCompleto(cv, estudios, experiencias, habilidades, idsDiscapacidad);
        }

        public CV ObtenerCVPorId(long idCV)
        {
            return cvDatos.ObtenerCVPorId(idCV);
        }

        public List<Educacion> ListarEducacionPorCV(long idCV)
        {
            return cvDatos.ListarEducacionPorCV(idCV);
        }

        public List<Experiencia> ListarExperienciaPorCV(long idCV)
        {
            return cvDatos.ListarExperienciaPorCV(idCV);
        }

        public List<Habilidad> ListarHabilidadesPorCV(long idCV)
        {
            return cvDatos.ListarHabilidadesPorCV(idCV);
        }

        public List<Habilidad> ListarHabilidadesPorUsuario(long idUsuario)
        {
            return cvDatos.ListarHabilidadesPorUsuario(idUsuario);
        }

        public string GenerarPerfilProfesional(Usuario u, CV cv, List<Educacion> estudios, List<Experiencia> experiencias, List<Habilidad> habilidades)
        {
            int edad = DateTime.Today.Year - u.FechaNacimiento.Year;
            if (u.FechaNacimiento.Date > DateTime.Today.AddYears(-edad)) edad--;

            string resumen = !string.IsNullOrWhiteSpace(u.ZonaLocalidad)
                ? $"Tengo {edad} años y resido en {u.ZonaLocalidad.Trim()}"
                : $"Tengo {edad} años";

            if (estudios != null && estudios.Count > 0)
            {
                Educacion edu = estudios[0];
                resumen += $". Cuento con formación de nivel {edu.NivelAlcanzado.ToLower()} en {edu.Titulo} ({edu.Institucion}). ";
            }
            else
            {
                resumen += ". ";
            }

            if (experiencias != null && experiencias.Count > 0)
            {
                Experiencia exp = experiencias[0];
                if (exp.TipoExperiencia == "Laboral")
                {
                    resumen += $"Cuento con experiencia laboral previa como {exp.Puesto} en {exp.Empresa}. ";
                }
                else
                {
                    resumen += $"Cuento con experiencia en voluntariado como {exp.Puesto} en {exp.Empresa}. ";
                }
            }
            else
            {
                resumen += "Me encuentro en búsqueda activa de una oportunidad laboral para aportar compromiso, rápido aprendizaje y vocación de servicio. ";
            }

            if (habilidades != null && habilidades.Count > 0)
            {
                List<string> blandas = new List<string>();
                List<string> tecnicas = new List<string>();

                foreach (var h in habilidades)
                {
                    if (string.IsNullOrWhiteSpace(h.Descripcion) ||
                        h.Descripcion.Trim().StartsWith("Idioma:", StringComparison.OrdinalIgnoreCase))
                        continue;

                    if (h.TipoHabilidad)
                    {
                        if (blandas.Count < 4)
                            blandas.Add(h.Descripcion.Trim());
                    }
                    else
                    {
                        if (tecnicas.Count < 5)
                            tecnicas.Add(h.Descripcion.Trim());
                    }
                }

                if (tecnicas.Count > 0)
                {
                    resumen += $"Mis habilidades técnicas son: {string.Join(", ", tecnicas)}. ";
                }

                if (blandas.Count > 0)
                {
                    resumen += $"Mis habilidades blandas son: {string.Join(", ", blandas)}. ";
                }
            }

            resumen += $"Cuento con disponibilidad horaria {cv.DisponibilidadHoraria.ToLower()} para incorporación inmediata.";

            return resumen;
        }

        public DataTable ListarTiposDiscapacidad()
        {
            return cvDatos.ListarTiposDiscapacidad();
        }

        public List<long> ListarIdsDiscapacidadPorCV(long idCV)
        {
            return cvDatos.ListarIdsDiscapacidadPorCV(idCV);
        }

        public List<string> ListarNombresDiscapacidadPorCV(long idCV)
        {
            return cvDatos.ListarNombresDiscapacidadPorCV(idCV);
        }

        public bool UsuarioTieneDiscapacidad(long idUsuario)
        {
            return cvDatos.UsuarioTieneDiscapacidad(idUsuario);
        }
    }
}