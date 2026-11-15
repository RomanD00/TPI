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

    }
}
