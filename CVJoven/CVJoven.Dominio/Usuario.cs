using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CVJoven.Dominio
{
    public class Usuario
    {

        public int IdUsuario { get; set; }
        public int IdTipoUsuario { get; set; }
        public string Mail { get; set; }
        public string Password { get; set; }
        public string Nombre { get; set; }
        public string Apellido { get; set; }
        public string DNI { get; set; }
        public string ZonaLocalidad { get; set; }
        public string Celular { get; set; }
        public DateTime FechaNacimiento { get; set; }
    }
}
