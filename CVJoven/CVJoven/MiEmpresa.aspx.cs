using CVJoven.Dominio;
using CVJoven.Negocio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace CVJoven
{
    public partial class MiEmpresa : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Empresa usuario = Session["Usuario"] as Empresa;
            if (Session["IdEmpresa"] == null)
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            lblNombreComercialNavbar.Text = usuario.NombreComercial;
            lblEmailUsuario.Text = usuario.Mail;

            if (!IsPostBack)
            {
                CargarDatosEmpresa();
                CargarOfertasEmpresa();
            }
        }

        private void CargarDatosEmpresa()
        {
            try
            {
                long idEmpresa =
                    Convert.ToInt64(Session["IdEmpresa"]);

                EmpresaNegocio negocio = new EmpresaNegocio();

                Empresa empresa = negocio.ObtenerEmpresa(idEmpresa);

                if (empresa == null)
                {
                    MostrarError("No se encontró la empresa.");
                    return;
                }

                lblNombreEmpresa.Text =
                    Server.HtmlEncode(empresa.NombreComercial);

                lblNombreLegal.Text =
                    Server.HtmlEncode(empresa.NombreLegal);

                lblNombreComercial.Text =
                    Server.HtmlEncode(empresa.NombreComercial);

                lblCUIT.Text =
                    Server.HtmlEncode(empresa.CUIT);

                lblSector.Text =
                    Server.HtmlEncode(empresa.sector);

                lblTamanio.Text =
                    Server.HtmlEncode(empresa.TamanioDeEmpresa);

                lblMail.Text =
                    Server.HtmlEncode(empresa.Mail);

                lblCorreoRRHH.Text =
                    Server.HtmlEncode(empresa.CorreoRRHH);

                lblPaginaWeb.Text =
                    string.IsNullOrWhiteSpace(empresa.PaginaWeb)
                    ? "No especificada"
                    : Server.HtmlEncode(empresa.PaginaWeb);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine(ex);

                MostrarError(
                    "No se pudieron cargar los datos de la empresa.");
            }
        }

        private void MostrarError(string mensaje)
        {
            lblMensaje.Text = Server.HtmlEncode(mensaje);
            lblMensaje.CssClass = "alert alert-danger d-block";
            lblMensaje.Visible = true;
        }

        private void AbrirModalEdicion()
        {
            string script = @"
        window.addEventListener('load', function () {
            var elemento = document.getElementById('modalEditarPerfil');
            var modal = bootstrap.Modal.getOrCreateInstance(elemento);
            modal.show();
        });
    ";

            ClientScript.RegisterStartupScript(
                this.GetType(),
                "abrirModalEdicion",
                script,
                true
            );
        }


        protected void btnEditarPerfil_Click(object sender, EventArgs e)
        {
            try
            {
                long idEmpresa =
                    Convert.ToInt64(Session["IdEmpresa"]);

                EmpresaNegocio negocio = new EmpresaNegocio();

                Empresa empresa = negocio.ObtenerEmpresa(idEmpresa);

                if (empresa == null)
                {
                    MostrarError("No se encontró la empresa.");
                    return;
                }

                txtNombreLegal.Text = empresa.NombreLegal;
                txtNombreComercial.Text = empresa.NombreComercial;
                txtCUIT.Text = empresa.CUIT;
                txtSector.Text = empresa.sector;
                ddlTamanio.SelectedValue = empresa.TamanioDeEmpresa;
                txtMail.Text = empresa.Mail;
                txtCorreoRRHH.Text = empresa.CorreoRRHH;
                txtPaginaWeb.Text = empresa.PaginaWeb ?? "";

                lblErrorEdicion.Visible = false;
                lblMensaje.Visible = false;

                AbrirModalEdicion();
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine(ex);

                MostrarError("No se pudieron cargar los datos.");
            }
        }


        protected void btnGuardarCambios_Click(object sender, EventArgs e)
        {
            try
            {
                lblErrorEdicion.Visible = false;

                Empresa empresa = new Empresa();

                empresa.IdEmpresa =
                    Convert.ToInt64(Session["IdEmpresa"]);

                empresa.NombreLegal = txtNombreLegal.Text.Trim();
                empresa.NombreComercial = txtNombreComercial.Text.Trim();
                empresa.CUIT = txtCUIT.Text.Trim();
                empresa.sector = txtSector.Text.Trim();
                empresa.TamanioDeEmpresa = ddlTamanio.SelectedValue;
                empresa.Mail = txtMail.Text.Trim();
                empresa.CorreoRRHH = txtCorreoRRHH.Text.Trim();
                empresa.PaginaWeb = txtPaginaWeb.Text.Trim();

                EmpresaNegocio negocio = new EmpresaNegocio();

                bool actualizado = negocio.ActualizarEmpresa(empresa);

                if (actualizado)
                {
                    Session["NombreEmpresa"] = empresa.NombreComercial;

                    CargarDatosEmpresa();

                    lblMensaje.Text = "Los datos se actualizaron correctamente.";
                    lblMensaje.CssClass = "alert alert-success d-block";
                    lblMensaje.Visible = true;
                }
                else
                {
                    MostrarErrorEdicion("No se pudieron actualizar los datos.");
                }
            }
            catch (ArgumentException ex)
            {
                MostrarErrorEdicion(ex.Message);
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                if (ex.Number == 2627 || ex.Number == 2601)
                {
                    MostrarErrorEdicion(
                        "El correo electrónico o el CUIT ya están registrados.");
                }
                else
                {
                    System.Diagnostics.Debug.WriteLine(ex);

                    MostrarErrorEdicion(
                        "Ocurrió un error al actualizar los datos.");
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine(ex);

                MostrarErrorEdicion(
                    "Ocurrió un error inesperado.");
            }
        }

        private void MostrarErrorEdicion(string mensaje)
        {
            lblErrorEdicion.Text = Server.HtmlEncode(mensaje);
            lblErrorEdicion.Visible = true;

            AbrirModalEdicion();
        }

        private void CargarOfertasEmpresa()
        {
            try
            {
                long idEmpresa =
                    Convert.ToInt64(Session["IdEmpresa"]);

                OfertaLaboralNegocio negocio =
                    new OfertaLaboralNegocio();

                DataTable ofertas =
                    negocio.ObtenerOfertasPorEmpresa(idEmpresa);

                rptMisOfertas.DataSource = ofertas;
                rptMisOfertas.DataBind();

                pnlSinOfertas.Visible = ofertas.Rows.Count == 0;

                int ofertasActivas = 0;
                int totalPostulaciones = 0;

                foreach (DataRow fila in ofertas.Rows)
                {
                    if (fila["EstadoOferta"].ToString() == "Activa")
                    {
                        ofertasActivas++;
                    }

                    totalPostulaciones +=
                        Convert.ToInt32(fila["CantidadPostulaciones"]);
                }

                lblTotalOfertas.Text =
                    ofertas.Rows.Count.ToString();

                lblOfertasActivas.Text =
                    ofertasActivas.ToString();

                lblTotalPostulaciones.Text =
                    totalPostulaciones.ToString();
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine(ex);

                MostrarError("No se pudieron cargar las ofertas laborales.");
            }
        }

        protected string ObtenerClaseEstado(string estado)
        {
            switch (estado)
            {
                case "Activa":
                    return "badge text-bg-success";

                case "Cerrada":
                    return "badge text-bg-secondary";

                case "Cancelada":
                    return "badge text-bg-danger";

                default:
                    return "badge text-bg-light";
            }
        }


        private void AbrirModalEditarOferta()
        {
            string script = @"
        window.addEventListener('load', function () {
            var elemento = document.getElementById('modalEditarOferta');
            var modal = bootstrap.Modal.getOrCreateInstance(elemento);
            modal.show();
        });
    ";

            ClientScript.RegisterStartupScript(
                this.GetType(),
                "abrirModalEditarOferta",
                script,
                true
            );
        }

        protected void rptMisOfertas_ItemCommand(
     object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "EditarOferta")
            {
                try
                {
                    long idOferta = Convert.ToInt64(e.CommandArgument);

                    CargarOfertaParaEditar(idOferta);
                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine(ex);

                    MostrarError("No se pudo cargar la oferta laboral.");
                }
            }
            else if (e.CommandName == "CancelarOferta")
            {
                long idOferta = Convert.ToInt64(e.CommandArgument);

                ViewState["IdOfertaCancelar"] = idOferta;

                lblErrorCancelarOferta.Visible = false;
                lblMensaje.Visible = false;

                AbrirModalCancelarOferta();
            }
            else if (e.CommandName == "VerCandidatos")
            {
                long idOferta = Convert.ToInt64(e.CommandArgument);

                Response.Redirect(
                    "Candidatos.aspx?idOferta=" + idOferta);
            }
        }


        private void AbrirModalCancelarOferta()
        {
            string script = @"
        window.addEventListener('load', function () {
            var elemento = document.getElementById(
                'modalCancelarOferta');

            var modal = bootstrap.Modal.getOrCreateInstance(elemento);

            modal.show();
        });
    ";

            ClientScript.RegisterStartupScript(
                this.GetType(),
                "abrirModalCancelarOferta",
                script,
                true
            );
        }


        protected void btnConfirmarCancelacion_Click(
    object sender, EventArgs e)
        {
            try
            {
                if (ViewState["IdOfertaCancelar"] == null)
                {
                    MostrarError("No se ha seleccionado una oferta.");
                    return;
                }

                long idOferta =
                    Convert.ToInt64(ViewState["IdOfertaCancelar"]);

                long idEmpresa =
                    Convert.ToInt64(Session["IdEmpresa"]);

                OfertaLaboralNegocio negocio =
                    new OfertaLaboralNegocio();

                bool cancelada =
                    negocio.CancelarOferta(idOferta, idEmpresa);

                if (cancelada)
                {
                    ViewState.Remove("IdOfertaCancelar");

                    lblMensaje.Text =
                        "La oferta laboral se canceló correctamente.";

                    lblMensaje.CssClass =
                        "alert alert-success d-block";

                    lblMensaje.Visible = true;

                    CargarOfertasEmpresa();

                    ClientScript.RegisterStartupScript(
                        this.GetType(),
                        "scrollCancelacion",
                        "window.scrollTo(0, 0);",
                        true
                    );
                }
                else
                {
                    MostrarErrorCancelarOferta(
                        "No se pudo cancelar la oferta laboral.");
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine(ex);

                CargarOfertasEmpresa();

                MostrarErrorCancelarOferta(
                    "Ocurrió un error durante la cancelación. " +
                    "Verificá el estado de la oferta.");
            }
        }

        private void MostrarErrorCancelarOferta(string mensaje)
        {
            lblErrorCancelarOferta.Text =
                Server.HtmlEncode(mensaje);

            lblErrorCancelarOferta.Visible = true;

            AbrirModalCancelarOferta();
        }

        private void CargarOfertaParaEditar(long idOferta)
        {
            long idEmpresa =
                Convert.ToInt64(Session["IdEmpresa"]);

            OfertaLaboralNegocio negocio =
                new OfertaLaboralNegocio();

            DataTable tabla =
                negocio.ObtenerOfertaParaEditar(idOferta, idEmpresa);

            if (tabla.Rows.Count == 0)
            {
                MostrarError("La oferta no existe o no puede editarse.");
                return;
            }

            DataRow oferta = tabla.Rows[0];

            txtEditarTitulo.Text =
                oferta["TituloOferta"].ToString();

            txtEditarZona.Text =
                oferta["Zona"].ToString();

            ddlEditarJornada.SelectedValue =
                oferta["TipoDeJornada"].ToString();

            txtEditarDescripcion.Text =
                oferta["Descripcion"].ToString();

            chkEditarDiscapacidad.Checked =
                Convert.ToBoolean(oferta["AceptaDiscapacidad"]);

            ViewState["IdOfertaEditar"] = idOferta;

            lblErrorEditarOferta.Visible = false;
            lblMensaje.Visible = false;

            AbrirModalEditarOferta();
        }


        protected void btnGuardarOferta_Click(object sender, EventArgs e)
        {
            try
            {
                lblErrorEditarOferta.Visible = false;

                if (ViewState["IdOfertaEditar"] == null)
                {
                    MostrarError("No se ha seleccionado una oferta.");
                    return;
                }

                long idEmpresa =
                    Convert.ToInt64(Session["IdEmpresa"]);

                long idOferta =
                    Convert.ToInt64(ViewState["IdOfertaEditar"]);

                OfertaLaboralNegocio negocio =
                    new OfertaLaboralNegocio();

                bool actualizado = negocio.ActualizarOferta(
                    idOferta,
                    idEmpresa,
                    txtEditarTitulo.Text.Trim(),
                    txtEditarZona.Text.Trim(),
                    ddlEditarJornada.SelectedValue,
                    txtEditarDescripcion.Text.Trim(),
                    chkEditarDiscapacidad.Checked
                );

                if (actualizado)
                {
                    ViewState.Remove("IdOfertaEditar");

                    lblMensaje.Text =
                        "La oferta laboral se actualizó correctamente.";

                    lblMensaje.CssClass =
                        "alert alert-success d-block";

                    lblMensaje.Visible = true;

                    CargarOfertasEmpresa();

                    ClientScript.RegisterStartupScript(
                        this.GetType(),
                        "scrollArribaOferta",
                        "window.scrollTo(0, 0);",
                        true
                    );
                }
                else
                {
                    MostrarErrorEditarOferta(
                        "No se pudo actualizar la oferta laboral.");
                }
            }
            catch (ArgumentException ex)
            {
                MostrarErrorEditarOferta(ex.Message);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine(ex);

                MostrarErrorEditarOferta(
                    "Ocurrió un error al actualizar la oferta.");
            }
        }

        private void MostrarErrorEditarOferta(string mensaje)
        {
            lblErrorEditarOferta.Text =
                Server.HtmlEncode(mensaje);

            lblErrorEditarOferta.Visible = true;

            AbrirModalEditarOferta();
        }






    }
}