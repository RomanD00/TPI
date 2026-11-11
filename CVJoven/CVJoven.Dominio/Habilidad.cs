using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CVJoven.Dominio
{
    public class Habilidad
    {
        public long IdHabilidad { get; set; }
        public long IdCV { get; set; }
        public string Descripcion { get; set; }
        public bool TipoHabilidad { get; set; }
    }
}
