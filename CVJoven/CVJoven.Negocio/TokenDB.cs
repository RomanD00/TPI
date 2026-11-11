using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CVJoven.Dominio;
using CVJoven.Datos;

namespace CVJoven.Negocio
{
    public class TokenDB
    {

        AccesoDatos datos = new AccesoDatos();



        public int insertToken(string token, string email, DateTime fechaExP, DateTime fechaCreacion)
        {
            int resultado = 0; // Variable para almacenar el resultado a retornar

            try
            {
                // 1. Configurar la consulta INSERT estándar (sin select de identity)
                datos.setearConsulta("INSERT INTO Token (Token, TokenCreacion, TokenExpiracion, EmailConfirmado) VALUES (@token, @fechaCreacion, @fechaExP, @emailConf)");

                // 2. Agregar los parámetros necesarios
                datos.setearParametro("@token", token);
                datos.setearParametro("@confirmacion", 0); // o el valor que corresponda
                datos.setearParametro("@fechaCreacion", fechaCreacion);
                datos.setearParametro("@fechaExP", fechaExP);
                datos.setearParametro("@emailConf", email);

                // 3. Ejecutar la acción y capturar el entero que devuelve ExecuteNonQuery()
                // (Nota: Si tu método 'ejecutarAccion()' actual es void, puedes adaptarlo para que ejecute comando.ExecuteNonQuery() y devuelva ese int)
               resultado = datos.ejecutarAccion();
            }
            catch (Exception ex)
            {
                resultado = -1; // Ocurrió un error
            }
            finally
            {
                // 4. Asegurarse de cerrar siempre la conexión al terminar
                datos.cerrarConexion();
            }

            // Retornar el entero obtenido (ID generado o código de estado)
            return resultado;
        }


    }
}
