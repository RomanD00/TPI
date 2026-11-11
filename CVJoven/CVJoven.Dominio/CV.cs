using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CVJoven.Dominio
{
    public class CV
    {
        public long IdCV { get; set; }
        public long IdUsuario { get; set; }
        public string nombreDelCV { get; set; }
        public string DisponibilidadHoraria { get; set; }

    }
}
