using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CVJoven.Datos;
using CVJoven.Dominio;

namespace CVJoven.Negocio
{
    public class EmpresaNegocio
    {

        public bool RegistrarEmpresa(Empresa empresa)
        {
            EmpresaDatos datos = new EmpresaDatos();

            int filasAfectadas = datos.InsertarEmpresa(empresa);

            return filasAfectadas == 1;
        }


        public Empresa IniciarSesion(string mail, string password)
        {
            EmpresaDatos datos = new EmpresaDatos();

            Empresa empresa = datos.BuscarPorMail(mail);

            if (empresa == null)
            {
                return null;
            }

            bool passwordCorrecta = SeguridadPassword.VerificarPassword(
                password,
                empresa.Password
            );

            if (!passwordCorrecta)
            {
                return null;
            }

            // No devolver el hash a la capa de presentación
            empresa.Password = null;

            return empresa;
        }




    }
}
