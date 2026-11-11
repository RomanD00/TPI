using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Runtime.Remoting.Messaging;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Xml.Schema;
using static System.Net.Mime.MediaTypeNames;

namespace CVJoven.Dominio
{
    public class ValidacionDatos
    {

        public bool validarString(string cadena) {

            if (!String.IsNullOrWhiteSpace(cadena) && Regex.IsMatch(cadena, "^[a-zA-Z]+$"))
            {
                return true;
            }
            return false;
        }


        public bool validarDni(string dni){

            if (Regex.IsMatch(dni, "^[0-9]{8}$")) { 
            return true;
            }
            return false;

        }

        public bool validarPassword(string password) {

          
            if (!string.IsNullOrEmpty(password) && password.Length > 6)
            {
                    return true;
            }
            return false;

        }


    }
}
