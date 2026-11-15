
using CVJoven.Dominio;
using CVJoven.Negocio;
using System;
using System.Collections.Generic;
using System.Web.UI;

namespace CVJoven
{
    public partial class CrearCurriculum : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Usuario usuario = Session["Usuario"] as Usuario;

            // Verificar que haya iniciado sesión
            if (usuario == null)
            {
                Response.Redirect("~/Login.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            // Mostrar nombre y correo arriba
            lblNombreUsuario.Text =
                usuario.Nombre + " " + usuario.Apellido;

            lblEmailUsuario.Text = usuario.Mail;

            // Cargar datos personales al abrir la página
            if (!IsPostBack)
            {
                txtNombre.Text = usuario.Nombre;
                txtApellido.Text = usuario.Apellido;
                txtEmail.Text = usuario.Mail;
                txtCelular.Text = usuario.Celular;
                txtLocalidad.Text = usuario.ZonaLocalidad;
            }
        }

        // EVENTO DEL BOTÓN GUARDAR
        protected void btnGuardarCV_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
                return;

            Usuario usuario = Session["Usuario"] as Usuario;

            if (usuario == null)
            {
                Response.Redirect("~/Login.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            try
            {
                // 1. Cabecera del CV
               int errores = 0;
                CV cv = new CV();
                cv.IdUsuario = usuario.IdUsuario;
                cv.nombreDelCV = txtNombreCV.Text.Trim();
                cv.DisponibilidadHoraria = ddlDisponibilidad.SelectedValue;

                // 2. Educación (si completó los campos)
                Educacion edu = null;
                if (!string.IsNullOrWhiteSpace(txtInstitucion.Text) &&
                    !string.IsNullOrWhiteSpace(txtTitulo.Text) &&
                    !string.IsNullOrWhiteSpace(ddlNivelEducacion.SelectedValue))
                {
                    edu = new Educacion();
                    edu.Institucion = txtInstitucion.Text.Trim();
                    edu.Titulo = txtTitulo.Text.Trim();
                    edu.NivelAlcanzado = ddlNivelEducacion.SelectedValue;
                    edu.Anio = int.TryParse(txtAnioEducacion.Text.Trim(), out int anio) ? anio : DateTime.Now.Year;
                }
                else {
                    errores++;
                
                }

                // 3. Experiencia (si completó los campos)
                Experiencia exp = null;
                if (!string.IsNullOrWhiteSpace(ddlTipoExperiencia.SelectedValue) &&
                    !string.IsNullOrWhiteSpace(txtPuesto.Text) &&
                    !string.IsNullOrWhiteSpace(txtEmpresa.Text) &&
                    DateTime.TryParse(txtFechaDesde.Text, out DateTime fechaDesde))
                {
                    exp = new Experiencia();
                    exp.TipoExperiencia = ddlTipoExperiencia.SelectedValue;
                    exp.Puesto = txtPuesto.Text.Trim();
                    exp.Empresa = txtEmpresa.Text.Trim();
                    exp.FechaDesde = fechaDesde;
                    exp.FechaHasta = DateTime.TryParse(txtFechaHasta.Text, out DateTime fechaHasta) ? fechaHasta : DateTime.MinValue;
                    exp.Descripcion = txtDescripcion.Text.Trim();
                }
                else {
                    errores++;
                
                }

                // 4. Habilidad (si completó el campo)
                Habilidad hab = null;
                if (!string.IsNullOrWhiteSpace(txtHabilidad.Text))
                {
                    hab = new Habilidad();
                    hab.Descripcion = txtHabilidad.Text.Trim();
                    hab.TipoHabilidad = bool.Parse(ddlTipoHabilidad.SelectedValue);
                }

                long idCVGenerado = 0;
                if (errores == 0)
                {

                    CVNegocio negocio = new CVNegocio();
                    idCVGenerado = negocio.GuardarCVCompleto(cv, edu, exp, hab);
                }
                else { 
                
                errores = 0;
                }
                // 5. Guardar todo en SQL Server y redirigir al CV generado

                if (idCVGenerado > 0)
                {
                    Response.Redirect($"VerCV.aspx?id={idCVGenerado}", false);
                    Context.ApplicationInstance.CompleteRequest();
                }
                else
                {
                    lblMensaje.CssClass = "alert alert-danger d-block mb-3";
                    lblMensaje.Text = "No se pudo guardar el currículum.";
                }
            }
            catch (Exception ex)
            {
                lblMensaje.CssClass = "alert alert-danger d-block mb-3";
                lblMensaje.Text = "Error al guardar el CV: " + ex.Message;
            }
        }
    }
}
