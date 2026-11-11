using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CVJoven.Dominio
{
    public class Idioma
    {

        public long IdIdioma { get; set; }
        public long IdCV { get; set; }
        public string Descripcion { get; set; }
        public string Nivel { get; set; }
    }
}
