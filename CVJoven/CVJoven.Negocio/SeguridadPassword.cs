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


        public static bool VerificarPassword(string password, string hashGuardado)
        {
            try
            {
                if (string.IsNullOrEmpty(password) ||
                    string.IsNullOrEmpty(hashGuardado))
                {
                    return false;
                }

                string[] partes = hashGuardado.Split('$');

                if (partes.Length != 4 || partes[0] != "PBKDF2-SHA256")
                {
                    return false;
                }

                int iteraciones = int.Parse(partes[1]);

                if (iteraciones < 100000 || iteraciones > 2000000)
                {
                    return false;
                }

                byte[] salt = Convert.FromBase64String(partes[2]);
                byte[] hashOriginal = Convert.FromBase64String(partes[3]);

                if (salt.Length != 16 || hashOriginal.Length != 32)
                {
                    return false;
                }

                using (var pbkdf2 = new Rfc2898DeriveBytes(
                    password, salt, iteraciones, HashAlgorithmName.SHA256))
                {
                    byte[] hashIngresado = pbkdf2.GetBytes(hashOriginal.Length);

                    int diferencia = 0;

                    for (int i = 0; i < hashOriginal.Length; i++)
                    {
                        diferencia |= hashOriginal[i] ^ hashIngresado[i];
                    }

                    return diferencia == 0;
                }
            }
            catch (FormatException)
            {
                return false;
            }
            catch (OverflowException)
            {
                return false;
            }
            catch (ArgumentException)
            {
                return false;
            }
        }





    }
}
