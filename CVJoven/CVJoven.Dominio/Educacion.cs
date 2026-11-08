using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CVJoven.Dominio
{
    public class Educacion
    {
        public int IdEducacion { get; set; }
        public int IdCV { get; set; }
        public string Titulo { get; set; }
        public string Institucion { get; set; }
        public string NivelAlcanzado { get; set; }
        public int Anio { get; set; }


    }
}
