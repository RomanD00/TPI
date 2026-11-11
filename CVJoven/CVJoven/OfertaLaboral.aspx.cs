using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CVJoven
{
    public partial class OfertaLaboral : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnRegistrarOferta_Click(object sender, EventArgs e)
        {
            // Comprobar las validaciones del formulario
            if (!Page.IsValid)
            {
                return;
            }
            // Recuperar los datos del formulario
            string titulo = txtTituloOferta.Text;
            string zona = txtZona.Text;
            string tipoJornada = ddlTipoJornada.SelectedValue;
            string descripcion = txtDescripcion.Text;

            // Recuperar el valor booleano
            bool aceptaDiscapacidad = chkAceptaDiscapacidad.Checked;


            // A partir de acá se puede realizar el INSERT en SQL Server
        }

    }
}