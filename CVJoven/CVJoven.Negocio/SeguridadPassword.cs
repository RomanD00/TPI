using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Security.Cryptography;

namespace CVJoven.Negocio
{
    public static class SeguridadPassword
    {
        public static string GenerarHash(string password)
        {
            byte[] salt = new byte[16];

            using (RandomNumberGenerator rng = RandomNumberGenerator.Create())
            {
                rng.GetBytes(salt);
            }

            const int iteraciones = 600000;

            using (var pbkdf2 = new Rfc2898DeriveBytes(
                password, salt, iteraciones, HashAlgorithmName.SHA256))
            {
                byte[] hash = pbkdf2.GetBytes(32);

                return "PBKDF2-SHA256$" +
                       iteraciones + "$" +
                       Convert.ToBase64String(salt) + "$" +
                       Convert.ToBase64String(hash);
            }
        }
    }
}
