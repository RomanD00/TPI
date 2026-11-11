using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CVJoven.Dominio
{
    public class OfertaLaboral
    {

        public long IdOferta { get; set; }
        public long IdEmpresa { get; set; }
        public string TituloOferta { get; set; }
        public string Zona { get; set; }
        public string TipoDeJornada { get; set; }
        public string Descripcion { get; set; }
        public bool AceptaDiscapacidad { get; set; }
    }
}
