using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CVJoven.Dominio
{
    public class TokenValidacion
    {

        public string Token { get; set; }
        public string Email { get; set; }
        public DateTime FechaCreacion { get; set; }
        public DateTime FechaExpiracion { get; set; }  


        public string GenerarToken(string email)
        {
            string tokenUnico = Guid.NewGuid().ToString();
            return tokenUnico;
        }

    }
}
