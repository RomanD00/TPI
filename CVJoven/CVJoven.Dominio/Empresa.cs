using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CVJoven.Dominio
{
    public class Empresa
    {
        public int IdEmpresa { get; set; }
        public int IdTipoUsuario { get; set; }
        public string Mail { get; set; }
        public string Password { get; set; }
        public string NombreLegal { get; set; }
        public string NombreComercial { get; set; }
        public string CUIT { get; set; }
        public string sector { get; set; }
        public string TamanioDeEmpresa { get; set; }
        public string PaginaWeb { get; set; }
        public string CorreoRRHH { get; set; }

    }
}
