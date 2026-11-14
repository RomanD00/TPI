using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CVJoven
{
    public partial class OfertasLaborales : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarOfertas();
            }
        }

        private void CargarOfertas()
        {
            // Datos de prueba simulando tu base de datos
            var ofertas = new List<dynamic>
            {
                new { IdOferta = 1, Titulo = "Desarrollador .NET Junior", Empresa = "TechSolutions AR", Area = "Tecnología y Sistemas", Ubicacion = "Remoto", TamanoEmpresa = "Mediana (101-500 emp.)", TiempoPublicacion = "Hace 2 horas" },
                new { IdOferta = 2, Titulo = "Diseñador/a UX/UI Trainée", Empresa = "Estudio Creativo Sur", Area = "Diseño UX/UI y Gráfico", Ubicacion = "Buenos Aires (CABA)", TamanoEmpresa = "Startup (1-20 emp.)", TiempoPublicacion = "Hace 2 días" },
                new { IdOferta = 3, Titulo = "Analista de E-commerce y Marketing Digital", Empresa = "TiendaNorte SRL", Area = "Marketing y E-commerce", Ubicacion = "GBA / Zona Norte", TamanoEmpresa = "PyME (21-100 emp.)", TiempoPublicacion = "Hace 5 días" }
            };

            rptOfertas.DataSource = ofertas;
            rptOfertas.DataBind();
            lblCantidadOfertas.Text = ofertas.Count.ToString();
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            // Aquí llamas a tu método de filtrado con txtBuscar.Text y los DropDownList
            CargarOfertas();
        }

        protected void Filtros_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Se dispara automáticamente al cambiar cualquier filtro
            CargarOfertas();
        }

        protected void rptOfertas_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            string idOferta = e.CommandArgument.ToString();
            if (e.CommandName == "Postular")
            {
                // Lógica para registrar la postulación
            }
            else if (e.CommandName == "VerDetalle")
            {
                // Redirigir o abrir modal con el detalle de la oferta
            }
        }
    }
}