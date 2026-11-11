using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CVJoven.Dominio
{
    public class Requisito
    {
        public long IdRequisito { get; set; }
        public long IdOferta { get; set; }
        public string Descripcion { get; set; }
    }
}
