using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CVJoven.Dominio
{
    public class CodigoCambioPassword
    {

        public int IdCodigo { get; set; }
        public int IdUsuario { get; set; }
        public int IdEmpresa { get; set; }
        public string CodigoHash { get; set; }
        public DateTime FechaCreacion  { get; set; }
        public DateTime FechaExpiracion  { get; set; }
        public int Intentos  { get; set; }
        public bool Usado  { get; set; }



    }
}
