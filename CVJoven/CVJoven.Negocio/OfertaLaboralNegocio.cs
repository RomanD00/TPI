using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CVJoven.Datos;
using CVJoven.Dominio;

namespace CVJoven.Negocio
{
    public class OfertaLaboralNegocio
    {

        public bool RegistrarOferta(OfertaLaboral oferta)
        {
            OfertaLaboralDatos datos = new OfertaLaboralDatos();

            int filasAfectadas = datos.InsertarOferta(oferta);

            return filasAfectadas == 1;
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



    }
}
