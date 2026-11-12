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
    }
}
