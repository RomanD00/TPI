using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CVJoven.Dominio
{
    public class CodigoCambioPassword
    {

        public long IdCodigo { get; set; }
        public long IdUsuario { get; set; }
        public long IdEmpresa { get; set; }
        public string CodigoHash { get; set; }
        public DateTime FechaCreacion  { get; set; }
        public DateTime FechaExpiracion  { get; set; }
        public int Intentos  { get; set; }
        public bool Usado  { get; set; }



    }
}
