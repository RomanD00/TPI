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

        public Empresa ObtenerEmpresa(long idEmpresa)
        {
            if (idEmpresa <= 0)
            {
                throw new ArgumentException(
                    "El identificador de la empresa no es válido.");
            }

            EmpresaDatos datos = new EmpresaDatos();

            return datos.BuscarPorId(idEmpresa);
        }

        public bool ActualizarEmpresa(Empresa empresa)
        {
            if (empresa == null || empresa.IdEmpresa <= 0)
            {
                throw new ArgumentException("Empresa no válida.");
            }

            if (string.IsNullOrWhiteSpace(empresa.NombreLegal) ||
                string.IsNullOrWhiteSpace(empresa.NombreComercial) ||
                string.IsNullOrWhiteSpace(empresa.CUIT) ||
                string.IsNullOrWhiteSpace(empresa.sector) ||
                string.IsNullOrWhiteSpace(empresa.TamanioDeEmpresa) ||
                string.IsNullOrWhiteSpace(empresa.Mail) ||
                string.IsNullOrWhiteSpace(empresa.CorreoRRHH))
            {
                throw new ArgumentException(
                    "Todos los campos son obligatorios, excepto la página web.");
            }

            EmpresaDatos datos = new EmpresaDatos();

            int filasAfectadas = datos.ActualizarEmpresa(empresa);

            return filasAfectadas == 1;
        }




    }
}
