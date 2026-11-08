using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CVJoven.Dominio
{
    public class OfertaLaboral
    {

        public int IdOferta { get; set; }
        public int IdEmpresa { get; set; }
        public string TituloOferta { get; set; }
        public string Zona { get; set; }
        public string TipoDeJornada { get; set; }
        public string Descripcion { get; set; }
        public bool AceptaDiscapacidad { get; set; }
    }
}
