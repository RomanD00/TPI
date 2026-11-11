using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace CVJoven.Datos
{
    public class AccesoDatos
    {
        private SqlConnection conexion;
        private SqlCommand comando;
        private SqlDataReader lector;

        public SqlDataReader Lector
        {
            get { return lector; }
        }

        public AccesoDatos()
        {
          
            string cadena = ConfigurationManager.ConnectionStrings["CadenaConexion"] != null
                ? ConfigurationManager.ConnectionStrings["CadenaConexion"].ConnectionString
                : "server=.\\SQLEXPRESS; database=CV_Joven; integrated security=true;";

            conexion = new SqlConnection(cadena);
            comando = new SqlCommand();
        }

        public void setearConsulta(string consulta)
        {
            comando.CommandType = CommandType.Text;
            comando.CommandText = consulta;
        }

        public void setearParametro(string nombre, object valor)
        {
            comando.Parameters.AddWithValue(nombre, valor ?? DBNull.Value);
        }

        public void ejecutarLectura()
        {
            comando.Connection = conexion;
            conexion.Open();
            lector = comando.ExecuteReader();
        }

        public int ejecutarAccion()
        {
            comando.Connection = conexion;
            conexion.Open();
            return comando.ExecuteNonQuery();
        }

        public void cerrarConexion()
        {
            if (lector != null)
                lector.Close();

            if (conexion.State == ConnectionState.Open)
                conexion.Close();
        }

    }
}