using CVJoven.Negocio;
using System;
using System.Collections.Generic;
using System.Data;
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
            try
            {
                OfertaLaboralNegocio negocio = new OfertaLaboralNegocio();

                DataTable ofertas = negocio.ObtenerOfertas();

                rptOfertas.DataSource = ofertas;
                rptOfertas.DataBind();

                lblCantidadOfertas.Text = ofertas.Rows.Count.ToString();

                pnlSinResultados.Visible = ofertas.Rows.Count == 0;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine(ex);

                lblCantidadOfertas.Text = "0";
                pnlSinResultados.Visible = false;

                ClientScript.RegisterStartupScript(
                    this.GetType(),
                    "errorOfertas",
                    "alert('No se pudieron cargar las ofertas laborales.');",
                    true
                );
            }
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