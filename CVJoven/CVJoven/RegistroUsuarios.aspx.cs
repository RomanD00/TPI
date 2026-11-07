using System;

namespace CVJoven
{
    public partial class RegistroUsuarios : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                MostrarPostulante();
            }
        }

        protected void btnPostulante_Click(object sender, EventArgs e)
        {
            MostrarPostulante();
        }

        protected void btnEmpresa_Click(object sender, EventArgs e)
        {
            MostrarEmpresa();
        }

        private void MostrarPostulante()
        {
            pnlPostulante.Visible = true;
            pnlEmpresa.Visible = false;
            btnPostulante.CssClass = "btn btn-outline-primary active";
            btnEmpresa.CssClass = "btn btn-outline-primary";
        }

        private void MostrarEmpresa()
        {
            pnlPostulante.Visible = false;
            pnlEmpresa.Visible = true;
            btnPostulante.CssClass = "btn btn-outline-primary";
            btnEmpresa.CssClass = "btn btn-outline-primary active";
        }

        protected void btnRegistrar_Click(object sender, EventArgs e)
        {
            // Lógica de registro
        }
    }
}