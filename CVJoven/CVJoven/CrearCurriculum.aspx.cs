using CVJoven.Dominio;
using CVJoven.Negocio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CVJoven
{
    public partial class CrearCurriculum : System.Web.UI.Page
    {
        private const int MaxHabilidades = 12;
        private const int MinHabilidadesRecomendadas = 3;
        private const int MaxIdiomas = 5;

        private List<Educacion> ListaEducacionTemp
        {
            get
            {
                if (Session["ListaEducacionTemp"] == null)
                    Session["ListaEducacionTemp"] = new List<Educacion>();
                return (List<Educacion>)Session["ListaEducacionTemp"];
            }
            set { Session["ListaEducacionTemp"] = value; }
        }

        private List<Experiencia> ListaExperienciaTemp
        {
            get
            {
                if (Session["ListaExperienciaTemp"] == null)
                    Session["ListaExperienciaTemp"] = new List<Experiencia>();
                return (List<Experiencia>)Session["ListaExperienciaTemp"];
            }
            set { Session["ListaExperienciaTemp"] = value; }
        }

        private List<string> ListaIdiomasTemp
        {
            get
            {
                if (Session["ListaIdiomasTemp"] == null)
                    Session["ListaIdiomasTemp"] = new List<string>();
                return (List<string>)Session["ListaIdiomasTemp"];
            }
            set { Session["ListaIdiomasTemp"] = value; }
        }

        private List<Habilidad> ListaHabilidadesTemp
        {
            get
            {
                if (Session["ListaHabilidadesTemp"] == null)
                    Session["ListaHabilidadesTemp"] = new List<Habilidad>();
                return (List<Habilidad>)Session["ListaHabilidadesTemp"];
            }
            set { Session["ListaHabilidadesTemp"] = value; }
        }

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
                ListaEducacionTemp = new List<Educacion>();
                ListaExperienciaTemp = new List<Experiencia>();
                ListaIdiomasTemp = new List<string>();
                ListaHabilidadesTemp = new List<Habilidad>();

                txtNombre.Text = usuario.Nombre;
                txtApellido.Text = usuario.Apellido;
                txtEmail.Text = usuario.Mail;
                txtCelular.Text = usuario.Celular;
                txtLocalidad.Text = usuario.ZonaLocalidad;

                if (long.TryParse(Request.QueryString["id"], out long idCV))
                {
                    CargarDatosParaEdicion(idCV, usuario.IdUsuario);
                }
                else
                {
                    BindListasTemporales();
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

            lblTituloPagina.Text = "Editar currículum";
            txtNombreCV.Text = cv.nombreDelCV;
            ddlDisponibilidad.SelectedValue = cv.DisponibilidadHoraria;
            btnGuardarCV.Text = "Guardar cambios";

            List<Educacion> estudios = negocio.ListarEducacionPorCV(idCV);
            if (estudios.Count == 1)
            {
                txtInstitucion.Text = estudios[0].Institucion;
                txtTitulo.Text = estudios[0].Titulo;
                ddlNivelEducacion.SelectedValue = estudios[0].NivelAlcanzado;
                txtAnioEducacion.Text = estudios[0].Anio.ToString();
            }
            else if (estudios.Count > 1)
            {
                ListaEducacionTemp = estudios;
            }

            List<Experiencia> experiencias = negocio.ListarExperienciaPorCV(idCV);
            if (experiencias.Count == 1)
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
            else if (experiencias.Count > 1)
            {
                ListaExperienciaTemp = experiencias;
            }

            List<Habilidad> habilidades = negocio.ListarHabilidadesPorCV(idCV);
            if (habilidades != null && habilidades.Count > 0)
            {
                foreach (var h in habilidades)
                {
                    if (h.Descripcion != null && h.Descripcion.StartsWith("Idioma:", StringComparison.OrdinalIgnoreCase))
                    {
                        ListaIdiomasTemp.Add(h.Descripcion.Substring(7).Trim());
                    }
                    else
                    {
                        ListaHabilidadesTemp.Add(h);
                    }
                }
            }

            BindListasTemporales();
        }

        private void BindListasTemporales()
        {
            rptEducacionCargada.DataSource = ListaEducacionTemp;
            rptEducacionCargada.DataBind();

            rptExperienciaCargada.DataSource = ListaExperienciaTemp;
            rptExperienciaCargada.DataBind();

            rptIdiomasCargados.DataSource = ListaIdiomasTemp;
            rptIdiomasCargados.DataBind();

            rptHabilidadesCargadas.DataSource = ListaHabilidadesTemp;
            rptHabilidadesCargadas.DataBind();

            ActualizarIndicadoresLimites();
        }

        private void ActualizarIndicadoresLimites()
        {
            // Habilidades
            int cantHab = ListaHabilidadesTemp.Count;
            lblContadorHabilidades.Text = $"{cantHab} / {MaxHabilidades}";
            btnAgregarHabilidad.Enabled = cantHab < MaxHabilidades;
            txtHabilidad.Enabled = cantHab < MaxHabilidades;

            if (cantHab >= MaxHabilidades)
            {
                lblRecomendacionHabilidades.CssClass = "alert alert-info py-2 px-3 small d-block mb-3";
                lblRecomendacionHabilidades.Text = $"Alcanzaste el límite de {MaxHabilidades} habilidades para mantener tu CV limpio y legible en una sola hoja.";
            }
            else if (cantHab < MinHabilidadesRecomendadas)
            {
                lblRecomendacionHabilidades.CssClass = "alert alert-warning py-2 px-3 small d-block mb-3";
                lblRecomendacionHabilidades.Text = $"Recomendación: cargá al menos {MinHabilidadesRecomendadas} habilidades (blandas o técnicas) para destacar tu perfil y recibir mejores ofertas recomendadas.";
            }
            else
            {
                lblRecomendacionHabilidades.CssClass = "alert alert-success py-2 px-3 small d-block mb-3";
                lblRecomendacionHabilidades.Text = $"¡Muy bien! Ya cargaste {cantHab} habilidades. Esto mejora la coincidencia con ofertas laborales.";
            }

            // Idiomas
            int cantIdiomas = ListaIdiomasTemp.Count;
            lblContadorIdiomas.Text = $"{cantIdiomas} / {MaxIdiomas}";
            btnAgregarIdioma.Enabled = cantIdiomas < MaxIdiomas;
            txtIdioma.Enabled = cantIdiomas < MaxIdiomas;

            if (cantIdiomas >= MaxIdiomas)
            {
                lblAvisoIdiomas.Visible = true;
                lblAvisoIdiomas.Text = $"Alcanzaste el máximo de {MaxIdiomas} idiomas permitidos.";
            }
            else
            {
                lblAvisoIdiomas.Visible = false;
            }
        }

        private Educacion LeerEducacionDeCampos()
        {
            if (string.IsNullOrWhiteSpace(txtInstitucion.Text) && string.IsNullOrWhiteSpace(txtTitulo.Text))
                return null;

            Educacion edu = new Educacion();
            edu.Institucion = !string.IsNullOrWhiteSpace(txtInstitucion.Text) ? txtInstitucion.Text.Trim() : "Institución educativa";
            edu.Titulo = !string.IsNullOrWhiteSpace(txtTitulo.Text) ? txtTitulo.Text.Trim() : "Estudios cursados";
            edu.NivelAlcanzado = !string.IsNullOrWhiteSpace(ddlNivelEducacion.SelectedValue) ? ddlNivelEducacion.SelectedValue : "Secundaria";
            edu.Anio = int.TryParse(txtAnioEducacion.Text.Trim(), out int anio) ? anio : DateTime.Now.Year;
            return edu;
        }

        private Experiencia LeerExperienciaDeCampos()
        {
            if (string.IsNullOrWhiteSpace(txtPuesto.Text) && string.IsNullOrWhiteSpace(txtEmpresa.Text))
                return null;

            Experiencia exp = new Experiencia();
            exp.TipoExperiencia = !string.IsNullOrWhiteSpace(ddlTipoExperiencia.SelectedValue) ? ddlTipoExperiencia.SelectedValue : "Laboral";
            exp.Puesto = !string.IsNullOrWhiteSpace(txtPuesto.Text) ? txtPuesto.Text.Trim() : "Colaborador";
            exp.Empresa = !string.IsNullOrWhiteSpace(txtEmpresa.Text) ? txtEmpresa.Text.Trim() : "Organización";
            exp.FechaDesde = DateTime.TryParse(txtFechaDesde.Text, out DateTime fechaDesde) ? fechaDesde : DateTime.Today;
            exp.FechaHasta = DateTime.TryParse(txtFechaHasta.Text, out DateTime fechaHasta) ? fechaHasta : DateTime.MinValue;
            exp.Descripcion = txtDescripcion.Text.Trim();
            return exp;
        }

        private Habilidad LeerHabilidadDeCampos()
        {
            if (string.IsNullOrWhiteSpace(txtHabilidad.Text))
                return null;

            string limpio = txtHabilidad.Text.Trim();
            Habilidad hab = new Habilidad();
            hab.Descripcion = char.ToUpper(limpio[0]) + limpio.Substring(1);
            hab.TipoHabilidad = ddlTipoHabilidad.SelectedValue == "true";
            return hab;
        }

        protected void btnAgregarEducacion_Click(object sender, EventArgs e)
        {
            Educacion edu = LeerEducacionDeCampos();
            if (edu != null)
            {
                ListaEducacionTemp.Add(edu);
                txtInstitucion.Text = "";
                txtTitulo.Text = "";
                ddlNivelEducacion.SelectedIndex = 0;
                txtAnioEducacion.Text = "";
                BindListasTemporales();
            }
        }

        protected void rptEducacionCargada_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Quitar" && int.TryParse(e.CommandArgument.ToString(), out int index))
            {
                if (index >= 0 && index < ListaEducacionTemp.Count)
                {
                    ListaEducacionTemp.RemoveAt(index);
                    BindListasTemporales();
                }
            }
        }

        protected void btnAgregarExperiencia_Click(object sender, EventArgs e)
        {
            Experiencia exp = LeerExperienciaDeCampos();
            if (exp != null)
            {
                ListaExperienciaTemp.Add(exp);
                ddlTipoExperiencia.SelectedIndex = 0;
                txtPuesto.Text = "";
                txtEmpresa.Text = "";
                txtFechaDesde.Text = "";
                txtFechaHasta.Text = "";
                txtDescripcion.Text = "";
                BindListasTemporales();
            }
        }

        protected void rptExperienciaCargada_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Quitar" && int.TryParse(e.CommandArgument.ToString(), out int index))
            {
                if (index >= 0 && index < ListaExperienciaTemp.Count)
                {
                    ListaExperienciaTemp.RemoveAt(index);
                    BindListasTemporales();
                }
            }
        }

        protected void btnAgregarIdioma_Click(object sender, EventArgs e)
        {
            if (ListaIdiomasTemp.Count >= MaxIdiomas)
            {
                ActualizarIndicadoresLimites();
                return;
            }

            if (!string.IsNullOrWhiteSpace(txtIdioma.Text))
            {
                string limpio = txtIdioma.Text.Trim();
                string nombreIdioma = char.ToUpper(limpio[0]) + limpio.Substring(1);
                string idiomaFormateado = nombreIdioma + " (" + ddlNivelIdioma.SelectedValue + ")";

                bool yaExiste = ListaIdiomasTemp.Any(i =>
                    i.StartsWith(nombreIdioma + " (", StringComparison.OrdinalIgnoreCase));

                if (yaExiste)
                {
                    lblAvisoIdiomas.Visible = true;
                    lblAvisoIdiomas.Text = $"Ya agregaste el idioma \"{nombreIdioma}\".";
                    return;
                }

                ListaIdiomasTemp.Add(idiomaFormateado);
                txtIdioma.Text = "";
                ddlNivelIdioma.SelectedIndex = 0;
                BindListasTemporales();
            }
        }

        protected void rptIdiomasCargados_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Quitar" && int.TryParse(e.CommandArgument.ToString(), out int index))
            {
                if (index >= 0 && index < ListaIdiomasTemp.Count)
                {
                    ListaIdiomasTemp.RemoveAt(index);
                    BindListasTemporales();
                }
            }
        }

        protected void btnAgregarHabilidad_Click(object sender, EventArgs e)
        {
            if (ListaHabilidadesTemp.Count >= MaxHabilidades)
            {
                ActualizarIndicadoresLimites();
                return;
            }

            Habilidad hab = LeerHabilidadDeCampos();
            if (hab != null)
            {
                bool yaExiste = ListaHabilidadesTemp.Any(h =>
                    h.Descripcion.Equals(hab.Descripcion, StringComparison.OrdinalIgnoreCase));

                if (yaExiste)
                {
                    lblRecomendacionHabilidades.CssClass = "alert alert-warning py-2 px-3 small d-block mb-3";
                    lblRecomendacionHabilidades.Text = $"La habilidad \"{hab.Descripcion}\" ya está en tu lista.";
                    return;
                }

                ListaHabilidadesTemp.Add(hab);
                txtHabilidad.Text = "";
                ddlTipoHabilidad.SelectedIndex = 0;
                BindListasTemporales();
            }
        }

        protected void rptHabilidadesCargadas_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Quitar" && int.TryParse(e.CommandArgument.ToString(), out int index))
            {
                if (index >= 0 && index < ListaHabilidadesTemp.Count)
                {
                    ListaHabilidadesTemp.RemoveAt(index);
                    BindListasTemporales();
                }
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
                CV cv = new CV();
                cv.IdUsuario = usuario.IdUsuario;
                cv.nombreDelCV = txtNombreCV.Text.Trim();
                cv.DisponibilidadHoraria = ddlDisponibilidad.SelectedValue;

                // Estudios
                List<Educacion> estudios = new List<Educacion>(ListaEducacionTemp);
                Educacion eduActual = LeerEducacionDeCampos();
                if (eduActual != null)
                    estudios.Add(eduActual);

                // Experiencias
                List<Experiencia> experiencias = new List<Experiencia>(ListaExperienciaTemp);
                Experiencia expActual = LeerExperienciaDeCampos();
                if (expActual != null)
                    experiencias.Add(expActual);

                // Habilidades blandas y técnicas (respetando tope y sin duplicados)
                List<Habilidad> listaHabilidades = new List<Habilidad>(ListaHabilidadesTemp);
                Habilidad habActual = LeerHabilidadDeCampos();
                if (habActual != null &&
                    listaHabilidades.Count < MaxHabilidades &&
                    !listaHabilidades.Any(h => h.Descripcion.Equals(habActual.Descripcion, StringComparison.OrdinalIgnoreCase)))
                {
                    listaHabilidades.Add(habActual);
                }

                // Idiomas (respetando tope y sin duplicados)
                List<string> idiomasFinales = new List<string>(ListaIdiomasTemp);
                if (!string.IsNullOrWhiteSpace(txtIdioma.Text) && idiomasFinales.Count < MaxIdiomas)
                {
                    string limpio = txtIdioma.Text.Trim();
                    string nombreIdioma = char.ToUpper(limpio[0]) + limpio.Substring(1);
                    if (!idiomasFinales.Any(i => i.StartsWith(nombreIdioma + " (", StringComparison.OrdinalIgnoreCase)))
                    {
                        idiomasFinales.Add(nombreIdioma + " (" + ddlNivelIdioma.SelectedValue + ")");
                    }
                }

                foreach (string idioma in idiomasFinales)
                {
                    Habilidad habIdioma = new Habilidad();
                    habIdioma.Descripcion = "Idioma: " + idioma;
                    habIdioma.TipoHabilidad = false;
                    listaHabilidades.Add(habIdioma);
                }

                CVNegocio negocio = new CVNegocio();

                if (long.TryParse(Request.QueryString["id"], out long idCVExistente))
                {
                    cv.IdCV = idCVExistente;
                    negocio.ActualizarCVCompleto(cv, estudios, experiencias, listaHabilidades);
                    Response.Redirect($"VerCV.aspx?id={idCVExistente}", false);
                    Context.ApplicationInstance.CompleteRequest();
                }
                else
                {
                    long idCVGenerado = negocio.GuardarCVCompleto(cv, estudios, experiencias, listaHabilidades);
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