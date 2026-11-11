using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CVJoven.Dominio
{
    public class Postulacion
    {

        public long IdPostulacion { get; set; }
        public long IdUsuario { get; set; }
        public long IdCV { get; set; }
        public long IdOferta { get; set; }
        public DateTime FechaPostulacion { get; set; }
        public string EstadoPostulacion { get; set; }
    }
}
