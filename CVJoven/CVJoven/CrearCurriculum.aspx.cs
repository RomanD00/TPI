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

            if (usuario == null)
            {
                Response.Redirect("~/Login.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            lblNombreUsuario.Text = usuario.Nombre + " " + usuario.Apellido;
            lblEmailUsuario.Text = usuario.Mail;

            if (!IsPostBack)
            {
                txtNombre.Text = usuario.Nombre;
                txtApellido.Text = usuario.Apellido;
                txtEmail.Text = usuario.Mail;
                txtCelular.Text = usuario.Celular;
                txtLocalidad.Text = usuario.ZonaLocalidad;

                // Si viene con ?id= en la URL, cargamos los datos para Editar
                if (long.TryParse(Request.QueryString["id"], out long idCV))
                {
                    CargarDatosParaEdicion(idCV, usuario.IdUsuario);
                }
            }
        }

        private void CargarDatosParaEdicion(long idCV, long idUsuario)
        {
            CVNegocio negocio = new CVNegocio();
            CV cv = negocio.ObtenerCVPorId(idCV);

            if (cv == null || cv.IdUsuario != idUsuario)
            {
                Response.Redirect("MisCurriculums.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            txtNombreCV.Text = cv.nombreDelCV;
            ddlDisponibilidad.SelectedValue = cv.DisponibilidadHoraria;
            btnGuardarCV.Text = "Guardar cambios";

            List<Educacion> estudios = negocio.ListarEducacionPorCV(idCV);
            if (estudios.Count > 0)
            {
                txtInstitucion.Text = estudios[0].Institucion;
                txtTitulo.Text = estudios[0].Titulo;
                ddlNivelEducacion.SelectedValue = estudios[0].NivelAlcanzado;
                txtAnioEducacion.Text = estudios[0].Anio.ToString();
            }

            List<Experiencia> experiencias = negocio.ListarExperienciaPorCV(idCV);
            if (experiencias.Count > 0)
            {
                ddlTipoExperiencia.SelectedValue = experiencias[0].TipoExperiencia;
                txtPuesto.Text = experiencias[0].Puesto;
                txtEmpresa.Text = experiencias[0].Empresa;
                txtFechaDesde.Text = experiencias[0].FechaDesde.ToString("yyyy-MM-dd");
                if (experiencias[0].FechaHasta != DateTime.MinValue)
                {
                    txtFechaHasta.Text = experiencias[0].FechaHasta.ToString("yyyy-MM-dd");
                }
                txtDescripcion.Text = experiencias[0].Descripcion;
            }

            List<Habilidad> habilidades = negocio.ListarHabilidadesPorCV(idCV);
            if (habilidades.Count > 0)
            {
                List<string> descripciones = new List<string>();
                foreach (var h in habilidades)
                {
                    descripciones.Add(h.Descripcion);
                }
                txtHabilidad.Text = string.Join(", ", descripciones);
                ddlTipoHabilidad.SelectedValue = habilidades[0].TipoHabilidad ? "true" : "false";
            }
        }

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
                CV cv = new CV();
                cv.IdUsuario = usuario.IdUsuario;
                cv.nombreDelCV = txtNombreCV.Text.Trim();
                cv.DisponibilidadHoraria = ddlDisponibilidad.SelectedValue;

                // 2. Educación
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

                // 3. Experiencia
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

                // 4. Habilidades (permite varias separadas por coma)
                List<Habilidad> listaHabilidades = new List<Habilidad>();
                if (!string.IsNullOrWhiteSpace(txtHabilidad.Text))
                {
                    bool esBlanda = bool.Parse(ddlTipoHabilidad.SelectedValue);
                    string[] items = txtHabilidad.Text.Split(new char[] { ',', ';' }, StringSplitOptions.RemoveEmptyEntries);

                    foreach (string item in items)
                    {
                        string limpio = item.Trim();
                        if (!string.IsNullOrEmpty(limpio))
                        {
                            Habilidad hab = new Habilidad();
                            hab.Descripcion = char.ToUpper(limpio[0]) + limpio.Substring(1);
                            hab.TipoHabilidad = esBlanda;
                            listaHabilidades.Add(hab);
                        }
                    }
                }

                CVNegocio negocio = new CVNegocio();

                // 5. Si estamos editando un CV existente, actualizamos; si no, creamos uno nuevo
                if (long.TryParse(Request.QueryString["id"], out long idCVExistente))
                {
                    cv.IdCV = idCVExistente;
                    negocio.ActualizarCVCompleto(cv, edu, exp, listaHabilidades);
                    Response.Redirect($"VerCV.aspx?id={idCVExistente}", false);
                    Context.ApplicationInstance.CompleteRequest();
                }
                else
                {
                    long idCVGenerado = negocio.GuardarCVCompleto(cv, edu, exp, listaHabilidades);
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
            }
            catch (Exception ex)
            {
                lblMensaje.CssClass = "alert alert-danger d-block mb-3";
                lblMensaje.Text = "Error al guardar el CV: " + ex.Message;
            }
        }
    }
}