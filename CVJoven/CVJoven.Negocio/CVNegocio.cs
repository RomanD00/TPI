using System;
using System.Collections.Generic;
using CVJoven.Datos;
using CVJoven.Dominio;

namespace CVJoven.Negocio
{
    public class CVNegocio
    {
        private readonly CVDatos cvDatos = new CVDatos();

        // Métodos base por si los usa MisCurriculums.aspx
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

        // Métodos nuevos para guardar el formulario completo y armar la vista previa
        public long GuardarCVCompleto(CV cv, Educacion edu, Experiencia exp, List<Habilidad> habilidades)
        {
            long idCV = cvDatos.InsertarCV(cv);

            if (idCV <= 0)
            {
                return 0;
            }

            if (edu != null)
            {
                edu.IdCV = idCV;
                cvDatos.InsertarEducacion(edu);
            }

            if (exp != null)
            {
                exp.IdCV = idCV;
                cvDatos.InsertarExperiencia(exp);
            }

            if (habilidades != null)
            {
                foreach (Habilidad hab in habilidades)
                {
                    hab.IdCV = idCV;
                    cvDatos.InsertarHabilidad(hab);
                }
            }

            return idCV;
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

        public void ActualizarCVCompleto(CV cv, Educacion edu, Experiencia exp, List<Habilidad> habilidades)
        {
            cvDatos.ActualizarCVCompleto(cv, edu, exp, habilidades);
        }

        public string GenerarPerfilProfesional(Usuario u, CV cv, List<Educacion> estudios, List<Experiencia> experiencias, List<Habilidad> habilidades)
        {
            int edad = DateTime.Today.Year - u.FechaNacimiento.Year;
            if (u.FechaNacimiento.Date > DateTime.Today.AddYears(-edad)) edad--;

            string resumen = $"Joven profesional de {edad} años residente en {u.ZonaLocalidad}";

            if (estudios != null && estudios.Count > 0)
            {
                Educacion edu = estudios[0];
                resumen += $", con formación de nivel {edu.NivelAlcanzado.ToLower()} en {edu.Titulo} ({edu.Institucion}). ";
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
                    resumen += $"Cuenta con experiencia laboral previa desempeñándose como {exp.Puesto} en {exp.Empresa}. ";
                }
                else
                {
                    resumen += $"Cuenta con trayectoria en proyectos de voluntariado desempeñándose como {exp.Puesto} en {exp.Empresa}. ";
                }
            }
            else
            {
                resumen += "En búsqueda activa de una oportunidad laboral para aportar compromiso, rápido aprendizaje y vocación de servicio. ";
            }

            if (habilidades != null && habilidades.Count > 0)
            {
                List<string> nombresHab = new List<string>();
                foreach (var h in habilidades)
                {
                    nombresHab.Add(h.Descripcion.ToLower());
                }

                string listaTexto = string.Join(", ", nombresHab);
                resumen += $"Destaca por sus competencias en {listaTexto}. ";
            }

            resumen += $"Disponibilidad horaria {cv.DisponibilidadHoraria.ToLower()} para incorporación inmediata.";

            return resumen;
        }
    }
}