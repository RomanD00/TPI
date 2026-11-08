using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CVJoven.Dominio
{
    public class Habilidad
    {
        public int IdHabilidad { get; set; }
        public int IdCV { get; set; }
        public string Descripcion { get; set; }
        public bool TipoHabilidad { get; set; }
    }
}
