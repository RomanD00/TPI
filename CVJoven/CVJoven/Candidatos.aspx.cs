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
    public partial class Candidatos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["IdEmpresa"] == null)
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                CargarCandidatos();
            }
        }

        private void CargarCandidatos()
        {
            try
            {
                long idOferta;

                if (!long.TryParse(
                    Request.QueryString["idOferta"],
                    out idOferta) || idOferta <= 0)
                {
                    MostrarError("La oferta laboral no es válida.");
                    return;
                }

                long idEmpresa =
                    Convert.ToInt64(Session["IdEmpresa"]);

                OfertaLaboralNegocio ofertaNegocio =
                    new OfertaLaboralNegocio();

                DataTable oferta =
                    ofertaNegocio.ObtenerOfertaPorEmpresa(
                        idOferta, idEmpresa);

                if (oferta.Rows.Count == 0)
                {
                    MostrarError(
                        "La oferta no existe o no pertenece a tu empresa.");

                    return;
                }

                lblTituloOferta.Text = Server.HtmlEncode(
                    oferta.Rows[0]["TituloOferta"].ToString());
                            ViewState["EstadoOferta"] =
                oferta.Rows[0]["EstadoOferta"].ToString();

                PostulacionNegocio postulacionNegocio =
                    new PostulacionNegocio();

                DataTable candidatos =
                    postulacionNegocio.ObtenerCandidatosPorOferta(
                        idOferta, idEmpresa);

                rptCandidatos.DataSource = candidatos;
                rptCandidatos.DataBind();

                lblTotalCandidatos.Text =
                    candidatos.Rows.Count.ToString();

                pnlSinCandidatos.Visible =
                    candidatos.Rows.Count == 0;

                pnlCandidatos.Visible = true;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine(ex);

                MostrarError(
                    "No se pudieron cargar los candidatos.");
            }
        }

        private void MostrarError(string mensaje)
        {
            lblMensaje.Text = Server.HtmlEncode(mensaje);
            lblMensaje.Visible = true;
            pnlCandidatos.Visible = false;
        }

        protected string ObtenerClaseEstado(string estado)
        {
            switch (estado)
            {
                case "Pendiente":
                    return "badge text-bg-warning";

                case "En Revision":
                    return "badge text-bg-info";

                case "Aceptado":
                    return "badge text-bg-success";

                case "Rechazado":
                    return "badge text-bg-danger";

                default:
                    return "badge text-bg-secondary";
            }
        }

        protected bool PuedeSeleccionar(string estadoPostulacion)
        {
            string estadoOferta =
                Convert.ToString(ViewState["EstadoOferta"]);

            return estadoOferta == "Activa" &&
                (estadoPostulacion == "Pendiente" ||
                 estadoPostulacion == "En Revision");
        }

        protected void rptCandidatos_ItemCommand(
    object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "SeleccionarCandidato")
            {
                try
                {
                    long idPostulacion =
                        Convert.ToInt64(e.CommandArgument);

                    long idEmpresa =
                        Convert.ToInt64(Session["IdEmpresa"]);

                    long idOferta;

                    if (!long.TryParse(Request.QueryString["idOferta"],
                        out idOferta) || idOferta <= 0)
                    {
                        MostrarError("La oferta no es válida.");
                        return;
                    }

                    PostulacionNegocio negocio =
                        new PostulacionNegocio();

                    DataTable tabla =
                        negocio.ObtenerCandidatoPorPostulacion(
                            idPostulacion, idEmpresa);

                    if (tabla.Rows.Count == 0)
                    {
                        MostrarError("No se encontró el candidato.");
                        return;
                    }

                    DataRow candidato = tabla.Rows[0];

                    if (Convert.ToInt64(candidato["IdOferta"]) != idOferta ||
                        !PuedeSeleccionar(
                            candidato["EstadoPostulacion"].ToString()))
                    {
                        MostrarError("No se puede seleccionar al candidato.");
                        return;
                    }

                    lblCandidatoSeleccionado.Text = Server.HtmlEncode(
                        candidato["Nombre"].ToString() + " " +
                        candidato["Apellido"].ToString());

                    ViewState["IdPostulacionSeleccionada"] =
                        idPostulacion;

                    lblErrorSeleccion.Visible = false;
                    lblMensaje.Visible = false;

                    AbrirModalSeleccion();
                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine(ex);

                    MostrarError(
                        "No se pudo cargar el candidato.");
                }
            }
        }

        private void AbrirModalSeleccion()
        {
            string script = @"
        window.addEventListener('load', function () {
            var elemento = document.getElementById(
                'modalSeleccionarCandidato');

            var modal = bootstrap.Modal.getOrCreateInstance(
                elemento);

            modal.show();
        });";

            ClientScript.RegisterStartupScript(
                this.GetType(),
                "abrirModalSeleccion",
                script,
                true);
        }

        protected void btnConfirmarSeleccion_Click(
    object sender, EventArgs e)
        {
            try
            {
                if (ViewState["IdPostulacionSeleccionada"] == null)
                {
                    MostrarError("No se ha seleccionado un candidato.");
                    return;
                }

                long idPostulacion = Convert.ToInt64(
                    ViewState["IdPostulacionSeleccionada"]);

                long idEmpresa =
                    Convert.ToInt64(Session["IdEmpresa"]);

                long idOferta;

                if (!long.TryParse(Request.QueryString["idOferta"],
                    out idOferta) || idOferta <= 0)
                {
                    MostrarError("La oferta no es válida.");
                    return;
                }

                PostulacionNegocio negocio =
                    new PostulacionNegocio();

                bool seleccionado = negocio.SeleccionarCandidato(
                    idPostulacion, idOferta, idEmpresa);

                ViewState.Remove("IdPostulacionSeleccionada");

                CargarCandidatos();

                if (seleccionado)
                {
                    lblMensaje.Text =
                        "El candidato fue seleccionado correctamente. " +
                        "La oferta laboral se ha cerrado.";

                    lblMensaje.CssClass =
                        "alert alert-success d-block";

                    lblMensaje.Visible = true;
                }
                else
                {
                    lblMensaje.Text =
                        "No se pudo seleccionar al candidato.";

                    lblMensaje.CssClass =
                        "alert alert-danger d-block";

                    lblMensaje.Visible = true;
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine(ex);

                ViewState.Remove("IdPostulacionSeleccionada");

                CargarCandidatos();

                lblMensaje.Text =
                    "Ocurrió un error durante la selección. " +
                    "Verificá el estado de la oferta y las postulaciones.";

                lblMensaje.CssClass =
                    "alert alert-danger d-block";

                lblMensaje.Visible = true;
            }
        }





    }
}