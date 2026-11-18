using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CVJoven.Datos;

namespace CVJoven.Negocio
{
    public class PostulacionNegocio
    {

        public DataTable ObtenerCVPorUsuario(long idUsuario)
        {
            if (idUsuario <= 0)
                throw new ArgumentException("Usuario inválido.");

            PostulacionDatos datos = new PostulacionDatos();
            return datos.ObtenerCVPorUsuario(idUsuario);
        }

        public bool RegistrarPostulacion(
            long idUsuario, long idCV, long idOferta)
        {
            if (idUsuario <= 0 || idCV <= 0 || idOferta <= 0)
                throw new ArgumentException(
                    "Los identificadores deben ser válidos.");

            PostulacionDatos datos = new PostulacionDatos();

            int filas = datos.RegistrarPostulacion(
                idUsuario, idCV, idOferta);

            return filas > 0;
        }

        public DataTable ObtenerCandidatosPorOferta(
    long idOferta, long idEmpresa)
        {
            if (idOferta <= 0 || idEmpresa <= 0)
            {
                throw new ArgumentException(
                    "Oferta o empresa no válida.");
            }

            PostulacionDatos datos = new PostulacionDatos();

            return datos.ObtenerCandidatosPorOferta(
                idOferta, idEmpresa);
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

        public DataTable ObtenerCandidatoPorPostulacion(
    long idPostulacion, long idEmpresa)
        {
            if (idPostulacion <= 0 || idEmpresa <= 0)
            {
                throw new ArgumentException(
                    "Postulación o empresa no válida.");
            }

            PostulacionDatos datos = new PostulacionDatos();

            return datos.ObtenerCandidatoPorPostulacion(
                idPostulacion, idEmpresa);
        }

        public bool SeleccionarCandidato(long idPostulacion,
    long idOferta, long idEmpresa)
        {
            if (idPostulacion <= 0 || idOferta <= 0 || idEmpresa <= 0)
            {
                throw new ArgumentException(
                    "Los datos ingresados no son válidos.");
            }

            PostulacionDatos postulacionDatos = new PostulacionDatos();
            OfertaLaboralDatos ofertaDatos = new OfertaLaboralDatos();

            int ofertaCerrada = ofertaDatos.CerrarOferta(
                idOferta, idEmpresa, idPostulacion);

            if (ofertaCerrada != 1)
            {
                return false;
            }

            int candidatoAceptado = postulacionDatos.AceptarCandidato(
                idPostulacion, idOferta, idEmpresa);

            if (candidatoAceptado != 1)
            {
                throw new InvalidOperationException(
                    "No se pudo aceptar al candidato.");
            }

            postulacionDatos.RechazarOtrosCandidatos(
                idPostulacion, idOferta, idEmpresa);

            return true;
        }





    }
}
