<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CrearCurriculum.aspx.cs" Inherits="CVJoven.CrearCurriculum" MaintainScrollPositionOnPostback="true" %>

<!DOCTYPE html>
<html lang="es">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Crear currículum | CVJoven</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet" />
</head>
<body class="bg-light">
    <form id="form1" runat="server">
        <nav class="navbar bg-white border-bottom shadow-sm">
            <div class="container-fluid px-4">
                <a class="navbar-brand fw-bold text-primary" href="MisCurriculums.aspx">
                    <i class="bi bi-file-earmark-person me-2"></i>CVJoven
                </a>
                <div class="d-flex align-items-center gap-2">
                    <i class="bi bi-person-circle text-primary fs-3"></i>
                    <div class="d-flex flex-column small">
                        <asp:Label ID="lblNombreUsuario" runat="server" CssClass="fw-semibold" />
                        <asp:Label ID="lblEmailUsuario" runat="server" CssClass="text-secondary" />
                    </div>
                </div>
            </div>
        </nav>

        <main class="container py-4 py-lg-5">
            <div class="d-flex flex-wrap justify-content-between align-items-center gap-3 mb-4">
                <div>
                    <h1 class="h3 fw-bold mb-1"><asp:Label ID="lblTituloPagina" runat="server" Text="Crear currículum" /></h1>
                    <p class="text-secondary mb-0">Completá tus datos para generar y personalizar tu CV profesional.</p>
                </div>
                <a href="MisCurriculums.aspx" class="btn btn-outline-secondary">
                    <i class="bi bi-arrow-left me-1"></i>Mis currículums
                </a>
            </div>

            <asp:ValidationSummary ID="resumenErrores" runat="server" ValidationGroup="guardarCV"
                CssClass="alert alert-danger" DisplayMode="BulletList" />
            <asp:Label ID="lblMensaje" runat="server" CssClass="d-block mb-3" EnableViewState="false" />

            <div class="row g-4">
                <div class="col-lg-8">
                    <!-- 1. DATOS DEL CV -->
                    <section class="card border-0 shadow-sm mb-4">
                        <div class="card-body p-4">
                            <h2 class="h5 fw-bold mb-3"><i class="bi bi-file-earmark-text text-primary me-2"></i>Datos del currículum</h2>
                            <div class="mb-3">
                                <label for="txtNombreCV" class="form-label fw-semibold">Nombre del CV *</label>
                                <asp:TextBox ID="txtNombreCV" runat="server" CssClass="form-control" MaxLength="100" placeholder="Ej.: CV Administrativo / Primer Empleo" />
                                <asp:RequiredFieldValidator ID="valNombreCV" runat="server" ControlToValidate="txtNombreCV"
                                    ErrorMessage="Ingresá el nombre del CV." Text="Ingresá el nombre del CV."
                                    CssClass="text-danger small" ValidationGroup="guardarCV" Display="Dynamic" />
                            </div>
                            <div class="mb-0">
                                <label for="ddlDisponibilidad" class="form-label fw-semibold">Disponibilidad horaria *</label>
                                <asp:DropDownList ID="ddlDisponibilidad" runat="server" CssClass="form-select">
                                    <asp:ListItem Text="Seleccioná una opción" Value="" />
                                    <asp:ListItem Text="Full-time" Value="Full-time" />
                                    <asp:ListItem Text="Part-time" Value="Part-time" />
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="valDisponibilidad" runat="server" ControlToValidate="ddlDisponibilidad"
                                    InitialValue="" ErrorMessage="Elegí una disponibilidad horaria." Text="Elegí una disponibilidad."
                                    CssClass="text-danger small" ValidationGroup="guardarCV" Display="Dynamic" />
                            </div>
                        </div>
                    </section>

                    <!-- 2. INFORMACIÓN PERSONAL -->
                    <section class="card border-0 shadow-sm mb-4">
                        <div class="card-body p-4">
                            <h2 class="h5 fw-bold mb-3"><i class="bi bi-person text-primary me-2"></i>Información personal</h2>
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label class="form-label">Nombre</label>
                                    <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control bg-light" ReadOnly="true" />
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Apellido</label>
                                    <asp:TextBox ID="txtApellido" runat="server" CssClass="form-control bg-light" ReadOnly="true" />
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Correo</label>
                                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control bg-light" ReadOnly="true" />
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Celular</label>
                                    <asp:TextBox ID="txtCelular" runat="server" CssClass="form-control bg-light" ReadOnly="true" />
                                </div>
                                <div class="col-12">
                                    <label class="form-label">Localidad / Dirección</label>
                                    <asp:TextBox ID="txtLocalidad" runat="server" CssClass="form-control bg-light" ReadOnly="true" />
                                </div>
                            </div>
                            <div class="form-text mt-2">Estos datos se toman automáticamente de tu cuenta. Podés modificarlos desde <a href="MiPerfil.aspx">Mi perfil</a>.</div>
                        </div>
                    </section>

                    <!-- 3. EDUCACIÓN (MÚLTIPLE) -->
                    <section class="card border-0 shadow-sm mb-4">
                        <div class="card-body p-4">
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <h2 class="h5 fw-bold mb-0"><i class="bi bi-mortarboard text-primary me-2"></i>Educación y formación</h2>
                                <asp:LinkButton ID="btnAgregarEducacion" runat="server" CssClass="btn btn-sm btn-outline-primary fw-semibold"
                                    CausesValidation="false" OnClick="btnAgregarEducacion_Click">
                                    <i class="bi bi-plus-circle me-1"></i>Agregar otro estudio
                                </asp:LinkButton>
                            </div>

                            <asp:Repeater ID="rptEducacionCargada" runat="server" OnItemCommand="rptEducacionCargada_ItemCommand">
                                <ItemTemplate>
                                    <div class="d-flex justify-content-between align-items-center bg-primary-subtle border border-primary-subtle rounded-3 p-2 px-3 mb-2">
                                        <div>
                                            <i class="bi bi-check2-circle text-primary me-1"></i>
                                            <strong class="text-dark"><%#: Eval("Titulo") %></strong>
                                            <span class="text-secondary small"> — <%#: Eval("Institucion") %> (<%#: Eval("NivelAlcanzado") %>, <%# Eval("Anio") %>)</span>
                                        </div>
                                        <asp:LinkButton ID="btnQuitarEdu" runat="server" CommandName="Quitar" CommandArgument='<%# Container.ItemIndex %>'
                                            CssClass="btn btn-sm text-danger" CausesValidation="false">
                                            <i class="bi bi-trash"></i>
                                        </asp:LinkButton>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>

                            <div class="row g-3 mt-1">
                                <div class="col-md-6">
                                    <label class="form-label">Institución</label>
                                    <asp:TextBox ID="txtInstitucion" runat="server" CssClass="form-control" MaxLength="150" placeholder="Ej.: UTN / Colegio Secundario" />
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Título o Carrera</label>
                                    <asp:TextBox ID="txtTitulo" runat="server" CssClass="form-control" MaxLength="150" placeholder="Ej.: Bachiller / Tecnicatura en Programación" />
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Nivel alcanzado</label>
                                    <asp:DropDownList ID="ddlNivelEducacion" runat="server" CssClass="form-select">
                                        <asp:ListItem Text="Seleccionar" Value="" />
                                        <asp:ListItem Text="Primaria" Value="Primaria" />
                                        <asp:ListItem Text="Secundaria" Value="Secundaria" />
                                        <asp:ListItem Text="Terciario" Value="Terciario" />
                                        <asp:ListItem Text="Universidad" Value="Universidad" />
                                        <asp:ListItem Text="Posgrado" Value="Posgrado" />
                                    </asp:DropDownList>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Año</label>
                                    <asp:TextBox ID="txtAnioEducacion" runat="server" CssClass="form-control" TextMode="Number" placeholder="Ej.: 2025" />
                                </div>
                            </div>
                        </div>
                    </section>

                    <!-- 4. EXPERIENCIA (MÚLTIPLE) -->
                    <section class="card border-0 shadow-sm mb-4">
                        <div class="card-body p-4">
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <h2 class="h5 fw-bold mb-0"><i class="bi bi-briefcase text-primary me-2"></i>Experiencia laboral y voluntariado</h2>
                                <asp:LinkButton ID="btnAgregarExperiencia" runat="server" CssClass="btn btn-sm btn-outline-primary fw-semibold"
                                    CausesValidation="false" OnClick="btnAgregarExperiencia_Click">
                                    <i class="bi bi-plus-circle me-1"></i>Agregar otra experiencia
                                </asp:LinkButton>
                            </div>

                            <asp:Repeater ID="rptExperienciaCargada" runat="server" OnItemCommand="rptExperienciaCargada_ItemCommand">
                                <ItemTemplate>
                                    <div class="d-flex justify-content-between align-items-center bg-primary-subtle border border-primary-subtle rounded-3 p-2 px-3 mb-2">
                                        <div>
                                            <i class="bi bi-check2-circle text-primary me-1"></i>
                                            <strong class="text-dark"><%#: Eval("Puesto") %></strong>
                                            <span class="text-secondary small"> en <%#: Eval("Empresa") %> (<%#: Eval("TipoExperiencia") %>)</span>
                                        </div>
                                        <asp:LinkButton ID="btnQuitarExp" runat="server" CommandName="Quitar" CommandArgument='<%# Container.ItemIndex %>'
                                            CssClass="btn btn-sm text-danger" CausesValidation="false">
                                            <i class="bi bi-trash"></i>
                                        </asp:LinkButton>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>

                            <div class="row g-3 mt-1">
                                <div class="col-md-6">
                                    <label class="form-label">Tipo</label>
                                    <asp:DropDownList ID="ddlTipoExperiencia" runat="server" CssClass="form-select">
                                        <asp:ListItem Text="Seleccionar" Value="" />
                                        <asp:ListItem Text="Laboral" Value="Laboral" />
                                        <asp:ListItem Text="Voluntariado" Value="Voluntariado" />
                                    </asp:DropDownList>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Puesto / Rol</label>
                                    <asp:TextBox ID="txtPuesto" runat="server" CssClass="form-control" MaxLength="100" placeholder="Ej.: Atención al cliente / Administrativo" />
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Empresa u Organización</label>
                                    <asp:TextBox ID="txtEmpresa" runat="server" CssClass="form-control" MaxLength="150" placeholder="Ej.: Estudio Contable / Comercio" />
                                </div>
                                <div class="col-md-3">
                                    <label class="form-label">Desde</label>
                                    <asp:TextBox ID="txtFechaDesde" runat="server" CssClass="form-control" TextMode="Date" />
                                </div>
                                <div class="col-md-3">
                                    <label class="form-label">Hasta <span class="text-muted small">(opcional)</span></label>
                                    <asp:TextBox ID="txtFechaHasta" runat="server" CssClass="form-control" TextMode="Date" />
                                </div>
                                <div class="col-12">
                                    <label class="form-label">Descripción de tareas</label>
                                    <asp:TextBox ID="txtDescripcion" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" MaxLength="255"
                                        placeholder="Describí brevemente tus tareas principales..." />
                                </div>
                            </div>
                        </div>
                    </section>

                    <!-- 5. IDIOMAS (MÁXIMO 5) -->
                    <section class="card border-0 shadow-sm mb-4">
                        <div class="card-body p-4">
                            <div class="d-flex flex-wrap justify-content-between align-items-center gap-2 mb-3">
                                <div class="d-flex align-items-center gap-2">
                                    <h2 class="h5 fw-bold mb-0"><i class="bi bi-translate text-primary me-2"></i>Idiomas</h2>
                                    <asp:Label ID="lblContadorIdiomas" runat="server" CssClass="badge bg-light text-secondary border" Text="0 / 5" />
                                </div>
                                <asp:LinkButton ID="btnAgregarIdioma" runat="server" CssClass="btn btn-sm btn-outline-primary fw-semibold"
                                    CausesValidation="false" OnClick="btnAgregarIdioma_Click">
                                    <i class="bi bi-plus-circle me-1"></i>Agregar idioma
                                </asp:LinkButton>
                            </div>

                            <asp:Label ID="lblAvisoIdiomas" runat="server" Visible="false" CssClass="alert alert-warning py-2 px-3 small d-block mb-3" />

                            <asp:Repeater ID="rptIdiomasCargados" runat="server" OnItemCommand="rptIdiomasCargados_ItemCommand">
                                <ItemTemplate>
                                    <div class="d-flex justify-content-between align-items-center bg-primary-subtle border border-primary-subtle rounded-3 p-2 px-3 mb-2">
                                        <div>
                                            <i class="bi bi-globe2 text-primary me-2"></i>
                                            <strong class="text-dark"><%#: Container.DataItem %></strong>
                                        </div>
                                        <asp:LinkButton ID="btnQuitarIdioma" runat="server" CommandName="Quitar" CommandArgument='<%# Container.ItemIndex %>'
                                            CssClass="btn btn-sm text-danger" CausesValidation="false">
                                            <i class="bi bi-trash"></i>
                                        </asp:LinkButton>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>

                            <div class="row g-3 mt-1">
                                <div class="col-md-7">
                                    <label class="form-label">Idioma</label>
                                    <asp:TextBox ID="txtIdioma" runat="server" CssClass="form-control" MaxLength="40" placeholder="Ej.: Inglés / Portugués / Francés" />
                                </div>
                                <div class="col-md-5">
                                    <label class="form-label">Nivel</label>
                                    <asp:DropDownList ID="ddlNivelIdioma" runat="server" CssClass="form-select">
                                        <asp:ListItem Text="Básico" Value="Básico" />
                                        <asp:ListItem Text="Intermedio" Value="Intermedio" />
                                        <asp:ListItem Text="Avanzado" Value="Avanzado" />
                                        <asp:ListItem Text="Nativo / Bilingüe" Value="Nativo" />
                                    </asp:DropDownList>
                                </div>
                            </div>
                        </div>
                    </section>

                    <!-- 6. HABILIDADES BLANDAS Y TÉCNICAS (RECOMENDADO 3+, MÁXIMO 12) -->
                    <section class="card border-0 shadow-sm mb-4">
                        <div class="card-body p-4">
                            <div class="d-flex flex-wrap justify-content-between align-items-center gap-2 mb-3">
                                <div class="d-flex align-items-center gap-2">
                                    <h2 class="h5 fw-bold mb-0"><i class="bi bi-stars text-primary me-2"></i>Habilidades y Competencias</h2>
                                    <asp:Label ID="lblContadorHabilidades" runat="server" CssClass="badge bg-light text-secondary border" Text="0 / 12" />
                                </div>
                                <asp:LinkButton ID="btnAgregarHabilidad" runat="server" CssClass="btn btn-sm btn-outline-primary fw-semibold"
                                    CausesValidation="false" OnClick="btnAgregarHabilidad_Click">
                                    <i class="bi bi-plus-circle me-1"></i>Agregar habilidad
                                </asp:LinkButton>
                            </div>

                            <!-- Recomendación dinámica de cantidad de habilidades -->
                            <asp:Label ID="lblRecomendacionHabilidades" runat="server" CssClass="alert alert-warning py-2 px-3 small d-block mb-3" />

                            <asp:Repeater ID="rptHabilidadesCargadas" runat="server" OnItemCommand="rptHabilidadesCargadas_ItemCommand">
                                <ItemTemplate>
                                    <div class="d-flex justify-content-between align-items-center bg-primary-subtle border border-primary-subtle rounded-3 p-2 px-3 mb-2">
                                        <div class="d-flex align-items-center gap-2">
                                            <i class="bi bi-check2-circle text-primary"></i>
                                            <strong class="text-dark"><%#: Eval("Descripcion") %></strong>
                                            <span class='badge <%# Convert.ToBoolean(Eval("TipoHabilidad")) ? "bg-info text-dark" : "bg-primary" %>'>
                                                <%# Convert.ToBoolean(Eval("TipoHabilidad")) ? "Blanda" : "Técnica" %>
                                            </span>
                                        </div>
                                        <asp:LinkButton ID="btnQuitarHabilidad" runat="server" CommandName="Quitar" CommandArgument='<%# Container.ItemIndex %>'
                                            CssClass="btn btn-sm text-danger" CausesValidation="false">
                                            <i class="bi bi-trash"></i>
                                        </asp:LinkButton>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>

                            <div class="row g-3 mt-1">
                                <div class="col-md-7">
                                    <label class="form-label">Habilidad</label>
                                    <asp:TextBox ID="txtHabilidad" runat="server" CssClass="form-control" MaxLength="60"
                                        placeholder="Ej.: Trabajo en equipo / Excel / Atención al público" />
                                </div>
                                <div class="col-md-5">
                                    <label class="form-label">Tipo</label>
                                    <asp:DropDownList ID="ddlTipoHabilidad" runat="server" CssClass="form-select">
                                        <asp:ListItem Text="Blanda" Value="true" />
                                        <asp:ListItem Text="Técnica" Value="false" />
                                    </asp:DropDownList>
                                </div>
                            </div>
                        </div>
                    </section>

                    <div class="d-flex justify-content-end gap-2 mb-4">
                        <a href="MisCurriculums.aspx" class="btn btn-outline-secondary">Cancelar</a>

                        <asp:Button ID="btnGuardarCV" runat="server" Text="Guardar currículum"
                            CssClass="btn btn-primary px-4" ValidationGroup="guardarCV" OnClick="btnGuardarCV_Click" />
                    </div>
                </div>

                <aside class="col-lg-4">
                    <div class="card border-0 shadow-sm sticky-top" style="top: 24px;">
                        <div class="card-body p-4">
                            <h2 class="h5 fw-bold mb-3"><i class="bi bi-lightbulb text-warning me-2"></i>Consejos para tu CV</h2>
                            <ul class="small text-secondary ps-3 mb-0 d-flex flex-column gap-2">
                                <li><strong>Cargá al menos 3 habilidades:</strong> Combinar habilidades técnicas y blandas mejora tus recomendaciones de ofertas laborales.</li>
                                <li><strong>Mantenelo conciso:</strong> Podés cargar hasta 12 habilidades y 5 idiomas para que tu CV entre prolijo en una página.</li>
                                <li><strong>Dos formatos disponibles:</strong> Al guardar, vas a poder descargarlo en <em>Diseño Moderno</em> o en <em>Formato ATS</em> para postulaciones en portales.</li>
                            </ul>
                        </div>
                    </div>
                </aside>
            </div>
        </main>
    </form>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>