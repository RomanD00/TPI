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


        public int confirmTokenCount(string token, string email)
        {
            int count = 0;
            try
            {
                if (isTokenValid(token, email))
                {
                    // Creamos una nueva instancia de AccesoDatos para que comience con los parámetros limpios
                    AccesoDatos datosUpdate = new AccesoDatos();
                    try
                    {
                        datosUpdate.setearConsulta("UPDATE Token SET Confirmacion = 1 WHERE Token = @token AND EmailConfirmado = @emailConf");
                        datosUpdate.setearParametro("@token", token);
                        datosUpdate.setearParametro("@emailConf", email);

                        count = datosUpdate.ejecutarAccion();
                    }
                    finally
                    {
                        datosUpdate.cerrarConexion();
                    }
                }
                else
                {
                    count = 0; // Token inválido o expirado
                }
            }
            catch (Exception ex)
            {
                // ¡Útil para depurar si algo vuelve a fallar!
                System.Diagnostics.Debug.WriteLine("Error en confirmTokenCount: " + ex.Message);
                count = -1;
            }
            return count;
        }

        public bool isTokenValid(string token, string email)
{
    bool isValid = false;
    try
    {
        datos.setearConsulta("SELECT TokenExpiracion FROM Token WHERE Token = @token AND EmailConfirmado = @emailConf");
        
        // ¡Importante! Faltaba setear estos parámetros aquí también:
        datos.setearParametro("@token", token);
        datos.setearParametro("@emailConf", email);
        
        datos.ejecutarLectura();
        if (datos.Lector.Read())
        {
            DateTime tokenExpiracion = Convert.ToDateTime(datos.Lector["TokenExpiracion"]);
            isValid = DateTime.Now <= tokenExpiracion;
        }
    }
    catch (Exception ex)
    {
        isValid = false;
    }
    finally
    {
        datos.cerrarConexion();
    }
    return isValid;
}

    }
}
