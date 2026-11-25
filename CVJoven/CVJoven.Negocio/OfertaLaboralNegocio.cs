using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CVJoven.Datos;
using CVJoven.Dominio;
using System.Data;
using System.Globalization;

namespace CVJoven.Negocio
{
    public class OfertaLaboralNegocio
    {

        public bool RegistrarOferta(OfertaLaboral oferta)
        {
            if (oferta == null)
                throw new ArgumentException("La oferta no puede ser nula.");

            if (oferta.IdEmpresa <= 0)
                throw new ArgumentException("Empresa no válida.");

            if (oferta.Requisitos != null)
            {
                foreach (string requisito in oferta.Requisitos)
                {
                    if (string.IsNullOrWhiteSpace(requisito) ||
                        requisito.Length > 255)
                    {
                        throw new ArgumentException(
                            "Los requisitos deben tener entre 1 y 255 caracteres.");
                    }
                }
            }

            OfertaLaboralDatos datos = new OfertaLaboralDatos();

            return datos.InsertarOfertaConRequisitos(oferta);
        }

        public System.Data.DataTable ObtenerOfertas()
        {
            OfertaLaboralDatos datos = new OfertaLaboralDatos();
            return datos.ListarOfertas();
        }


        public System.Data.DataTable ObtenerDetalleOferta(long idOferta)
        {
            if (idOferta <= 0)
                throw new ArgumentException("Oferta inválida.");

            OfertaLaboralDatos datos = new OfertaLaboralDatos();

            return datos.ObtenerDetalleOferta(idOferta);
        }

        public System.Data.DataTable ObtenerRequisitosOferta(long idOferta)
        {
            if (idOferta <= 0)
                throw new ArgumentException("Oferta inválida.");

            OfertaLaboralDatos datos = new OfertaLaboralDatos();

            return datos.ObtenerRequisitosOferta(idOferta);
        }

        public DataTable ObtenerOfertasPorEmpresa(long idEmpresa)
        {
            if (idEmpresa <= 0)
            {
                throw new ArgumentException("Empresa no válida.");
            }

            OfertaLaboralDatos datos = new OfertaLaboralDatos();

            return datos.ObtenerOfertasPorEmpresa(idEmpresa);
        }


        public DataTable ObtenerOfertaPorEmpresa(
    long idOferta, long idEmpresa)
        {
            if (idOferta <= 0 || idEmpresa <= 0)
            {
                throw new ArgumentException(
                    "Oferta o empresa no válida.");
            }

            OfertaLaboralDatos datos = new OfertaLaboralDatos();

            return datos.ObtenerOfertaPorEmpresa(
                idOferta, idEmpresa);
        }

        public DataTable ObtenerOfertaParaEditar(
    long idOferta, long idEmpresa)
        {
            if (idOferta <= 0 || idEmpresa <= 0)
            {
                throw new ArgumentException("Oferta o empresa no válida.");
            }

            OfertaLaboralDatos datos = new OfertaLaboralDatos();

            return datos.ObtenerOfertaParaEditar(idOferta, idEmpresa);
        }


        public bool ActualizarOferta(
            long idOferta,
            long idEmpresa,
            string titulo,
            string zona,
            string jornada,
            string descripcion,
            bool aceptaDiscapacidad,
            List<string> requisitos = null)
        {
            if (idOferta <= 0 || idEmpresa <= 0)
            {
                throw new ArgumentException("Oferta o empresa no válida.");
            }

            if (string.IsNullOrWhiteSpace(titulo) ||
                string.IsNullOrWhiteSpace(zona) ||
                string.IsNullOrWhiteSpace(descripcion))
            {
                throw new ArgumentException(
                    "Todos los campos son obligatorios.");
            }

            if (titulo.Length > 150 || zona.Length > 100)
            {
                throw new ArgumentException(
                    "El título o la zona superan la longitud permitida.");
            }

            if (jornada != "Full-time" && jornada != "Part-time")
            {
                throw new ArgumentException(
                    "El tipo de jornada no es válido.");
            }

            List<string> requisitosLimpios = null;

            if (requisitos != null)
            {
                requisitosLimpios = new List<string>();
                foreach (string req in requisitos)
                {
                    string texto = (req ?? "").Trim();
                    if (string.IsNullOrWhiteSpace(texto))
                        continue;

                    if (texto.Length > 255)
                    {
                        throw new ArgumentException(
                            "Los requisitos deben tener como máximo 255 caracteres.");
                    }

                    requisitosLimpios.Add(texto);
                }
            }

            OfertaLaboralDatos datos = new OfertaLaboralDatos();

            int filasAfectadas = datos.ActualizarOferta(
                idOferta,
                idEmpresa,
                titulo,
                zona,
                jornada,
                descripcion,
                aceptaDiscapacidad
            );

            if (filasAfectadas == 1)
            {
                if (requisitosLimpios != null)
                {
                    datos.ReemplazarRequisitosOferta(idOferta, idEmpresa, requisitosLimpios);
                }

                return true;
            }

            return false;
        }


        public bool CancelarOferta(long idOferta, long idEmpresa)
        {
            if (idOferta <= 0 || idEmpresa <= 0)
            {
                throw new ArgumentException("Oferta o empresa no válida.");
            }

            OfertaLaboralDatos datos = new OfertaLaboralDatos();

            int filasAfectadas = datos.CancelarOferta(idOferta, idEmpresa);

            if (filasAfectadas == 1)
            {
                datos.RechazarPostulaciones(idOferta, idEmpresa);

                return true;
            }

            return false;
        }


        public DataTable ObtenerOfertasParaPostulante(
            long idUsuario,
            string busqueda,
            string diasPublicacion,
            string ubicacion,
            string tamanoEmpresa,
            string sector,
            bool soloRecomendadas,
            out int totalRecomendadas,
            out bool usuarioTieneHabilidades)
        {
            OfertaLaboralDatos ofertaDatos = new OfertaLaboralDatos();
            CVDatos cvDatos = new CVDatos();

            DataTable tablaBase = ofertaDatos.ListarOfertas();
            Dictionary<long, List<string>> requisitosPorOferta = ofertaDatos.ObtenerRequisitosDeOfertasActivas();
            HashSet<long> ofertasPostuladas = ofertaDatos.ObtenerIdsOfertasPostuladas(idUsuario);

            // Habilidades blandas y duras del postulante (excluye idiomas)
            List<Habilidad> habilidadesUsuario = cvDatos.ListarHabilidadesPorUsuario(idUsuario)
                .Where(h => !string.IsNullOrWhiteSpace(h.Descripcion) &&
                            !h.Descripcion.Trim().StartsWith("Idioma:", StringComparison.OrdinalIgnoreCase))
                .ToList();

            usuarioTieneHabilidades = habilidadesUsuario.Count > 0;

            bool usuarioTieneDiscapacidad = cvDatos.UsuarioTieneDiscapacidad(idUsuario);

            // Columnas calculadas para mostrar recomendaciones y fechas
            tablaBase.Columns.Add("EsRecomendada", typeof(bool));
            tablaBase.Columns.Add("CantidadCoincidencias", typeof(int));
            tablaBase.Columns.Add("HabilidadesCoincidentes", typeof(string));
            tablaBase.Columns.Add("CoincideDiscapacidad", typeof(bool));
            tablaBase.Columns.Add("FechaPublicacionTexto", typeof(string));
            tablaBase.Columns.Add("YaPostulado", typeof(bool));


            string busquedaNorm = NormalizarTexto(busqueda);
            string ubicacionNorm = NormalizarTexto(ubicacion);
            string tamanoNorm = NormalizarTexto(tamanoEmpresa);
            string sectorNorm = NormalizarTexto(sector);

            int diasFiltro = 0;
            bool filtrarPorFecha = int.TryParse(diasPublicacion, out diasFiltro) && diasFiltro > 0;
            DateTime fechaLimite = DateTime.Today.AddDays(-diasFiltro);

            DataTable tablaResultado = tablaBase.Clone();
            List<DataRow> filasValidas = new List<DataRow>();
            totalRecomendadas = 0;

            foreach (DataRow fila in tablaBase.Rows)
            {
                long idOferta = Convert.ToInt64(fila["IdOferta"]);
                string titulo = fila["TituloOferta"].ToString();
                string empresa = fila["Empresa"].ToString();
                string zona = fila["Zona"].ToString();
                string descripcion = fila["Descripcion"].ToString();
                string sectorOferta = fila["SectorEmpresa"] != DBNull.Value ? fila["SectorEmpresa"].ToString() : "";
                string tamanoOferta = fila["TamanoEmpresa"] != DBNull.Value ? fila["TamanoEmpresa"].ToString() : "";

                List<string> requisitos = requisitosPorOferta.ContainsKey(idOferta)
                    ? requisitosPorOferta[idOferta]
                    : new List<string>();

                // 1. Filtro por fecha de publicación
                DateTime fechaPub = DateTime.MinValue;
                if (fila["FechaPublicacion"] != DBNull.Value)
                {
                    fechaPub = Convert.ToDateTime(fila["FechaPublicacion"]);
                    fila["FechaPublicacionTexto"] = fechaPub.ToString("dd/MM/yyyy");
                }
                else
                {
                    fila["FechaPublicacionTexto"] = "";
                }

                if (filtrarPorFecha && (fechaPub == DateTime.MinValue || fechaPub.Date < fechaLimite))
                {
                    continue;
                }

                // 2. Filtro por ubicación
                if (!string.IsNullOrEmpty(ubicacionNorm) &&
                    !NormalizarTexto(zona).Contains(ubicacionNorm))
                {
                    continue;
                }

                // 3. Filtro por tamaño de empresa
                if (!string.IsNullOrEmpty(tamanoNorm) &&
                    NormalizarTexto(tamanoOferta) != tamanoNorm)
                {
                    continue;
                }

                // 4. Filtro por sector / área
                if (!string.IsNullOrEmpty(sectorNorm) &&
                    !NormalizarTexto(sectorOferta).Contains(sectorNorm))
                {
                    continue;
                }

                // 5. Filtro por buscador de texto (busca en título, empresa, zona, sector, descripción y requisitos)
                if (!string.IsNullOrEmpty(busquedaNorm))
                {
                    string textoCompleto = NormalizarTexto(
                        titulo + " " + empresa + " " + zona + " " + sectorOferta + " " + descripcion + " " + string.Join(" ", requisitos)
                    );

                    if (!textoCompleto.Contains(busquedaNorm))
                    {
                        continue;
                    }
                }

                // 6. Match de habilidades blandas y duras contra requisitos de la oferta
                List<string> coincidencias = new List<string>();
                HashSet<string> yaAgregadas = new HashSet<string>(StringComparer.OrdinalIgnoreCase);

                foreach (Habilidad hab in habilidadesUsuario)
                {
                    foreach (string req in requisitos)
                    {
                        if (CoincideHabilidadConRequisito(hab.Descripcion, req))
                        {
                            string clave = NormalizarTexto(hab.Descripcion);
                            if (yaAgregadas.Add(clave))
                            {
                                string etiquetaTipo = hab.TipoHabilidad ? "Blanda" : "Técnica";
                                coincidencias.Add($"{hab.Descripcion} ({etiquetaTipo})");
                            }
                            break;
                        }
                    }
                }

                bool aceptaDiscapacidad = string.Equals(
                    fila["AceptaDiscapacidad"].ToString().Trim(),
                    "Sí",
                    StringComparison.OrdinalIgnoreCase);

                bool coincideDiscapacidad = usuarioTieneDiscapacidad && aceptaDiscapacidad;
                bool esRecomendada = coincidencias.Count > 0 || coincideDiscapacidad;

                fila["EsRecomendada"] = esRecomendada;
                fila["CantidadCoincidencias"] = coincidencias.Count + (coincideDiscapacidad ? 1 : 0);
                fila["HabilidadesCoincidentes"] = string.Join(", ", coincidencias);
                fila["CoincideDiscapacidad"] = coincideDiscapacidad;
                fila["YaPostulado"] = ofertasPostuladas.Contains(idOferta);

                if (esRecomendada)
                {
                    totalRecomendadas++;
                }

                if (soloRecomendadas && !esRecomendada)
                {
                    continue;
                }

                filasValidas.Add(fila);
            }

            // Ordenar: primero las que más habilidades matchean, luego las más recientes
            foreach (DataRow fila in filasValidas
                .OrderByDescending(r => Convert.ToInt32(r["CantidadCoincidencias"]))
                .ThenByDescending(r => Convert.ToInt64(r["IdOferta"])))
            {
                tablaResultado.ImportRow(fila);
            }

            return tablaResultado;
        }

        private bool CoincideHabilidadConRequisito(string habilidad, string requisito)
        {
            string habNorm = NormalizarTexto(habilidad);
            string reqNorm = NormalizarTexto(requisito);

            if (string.IsNullOrEmpty(habNorm) || string.IsNullOrEmpty(reqNorm))
                return false;

            if (habNorm == reqNorm)
                return true;

            if (habNorm.Length >= 2 && ContienePalabraExacta(reqNorm, habNorm))
                return true;

            if (reqNorm.Length >= 2 && ContienePalabraExacta(habNorm, reqNorm))
                return true;

            if (habNorm.Length >= 5 && reqNorm.Contains(habNorm))
                return true;

            if (reqNorm.Length >= 5 && habNorm.Contains(reqNorm))
                return true;

            return false;
        }

        private bool ContienePalabraExacta(string texto, string palabra)
        {
            string[] tokens = texto.Split(
                new char[] { ' ', ',', ';', '.', '/', '-', '(', ')', ':', '¡', '!', '¿', '?' },
                StringSplitOptions.RemoveEmptyEntries);

            return tokens.Any(t => t == palabra);
        }

        private string NormalizarTexto(string texto)
        {
            if (string.IsNullOrWhiteSpace(texto))
                return string.Empty;

            string descompuesto = texto.Trim().ToLowerInvariant().Normalize(NormalizationForm.FormD);
            StringBuilder sb = new StringBuilder();

            foreach (char c in descompuesto)
            {
                if (CharUnicodeInfo.GetUnicodeCategory(c) != UnicodeCategory.NonSpacingMark)
                {
                    sb.Append(c);
                }
            }

            return sb.ToString().Normalize(NormalizationForm.FormC);
        }



    }
}
