using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CVJoven.Dominio
{
    public class Postulacion
    {

        public int IdPostulacion { get; set; }
        public int IdUsuario { get; set; }
        public int IdCV { get; set; }
        public int IdOferta { get; set; }
        public DateTime FechaPostulacion { get; set; }
        public string EstadoPostulacion { get; set; }
    }
}
