using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CVJoven.Dominio
{
    public class CV
    {
        public int IdCV { get; set; }
        public int IdUsuario { get; set; }
        public string nombreDelCV { get; set; }
        public string DisponibilidadHoraria { get; set; }

    }
}
