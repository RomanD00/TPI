using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CVJoven.Dominio
{
    public class Experiencia
    {
        public long IdExperiencia { get; set; }
        public long IdCV { get; set; }
        public string TipoExperiencia { get; set; }
        public string Puesto { get; set; }
        public string Empresa { get; set; }
        public string Descripcion { get; set; }
        public DateTime FechaDesde { get; set; }
        public DateTime FechaHasta { get; set; }
    }
}
