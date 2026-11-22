using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CVJoven.Datos;
using CVJoven.Dominio;
using System.Data;

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
    bool aceptaDiscapacidad)
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

            return filasAfectadas == 1;
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






    }
}
