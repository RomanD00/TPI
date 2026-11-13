<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CrearCurriculum.aspx.cs" Inherits="CVJoven.CrearCurriculum" %>

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
                    <h1 class="h3 fw-bold mb-1">Crear currículum</h1>
                    <p class="text-secondary mb-0">Completá tus datos para preparar tu CV.</p>
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
                    <section class="card border-0 shadow-sm mb-4">
                        <div class="card-body p-4">
                            <h2 class="h5 fw-bold mb-3"><i class="bi bi-file-earmark-text text-primary me-2"></i>Datos del currículum</h2>
                            <div class="mb-3">
                                <label for="txtNombreCV" class="form-label fw-semibold">Nombre del CV *</label>
                                <asp:TextBox ID="txtNombreCV" runat="server" CssClass="form-control" MaxLength="100" placeholder="Ej.: CV para primer empleo" />
                                <asp:RequiredFieldValidator ID="valNombreCV" runat="server" ControlToValidate="txtNombreCV"
                                    ErrorMessage="Ingresá el nombre del CV." Text="Ingresá el nombre del CV."
                                    CssClass="text-danger small" ValidationGroup="guardarCV" Display="Dynamic" />
                            </div>
                            <div class="mb-3">
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

                    <section class="card border-0 shadow-sm mb-4">
                        <div class="card-body p-4">
                            <h2 class="h5 fw-bold mb-3"><i class="bi bi-person text-primary me-2"></i>Información personal</h2>
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label class="form-label">Nombre</label>
                                    <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" ReadOnly="true" />
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Apellido</label>
                                    <asp:TextBox ID="txtApellido" runat="server" CssClass="form-control" ReadOnly="true" />
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Correo</label>
                                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" ReadOnly="true" />
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Celular</label>
                                    <asp:TextBox ID="txtCelular" runat="server" CssClass="form-control" ReadOnly="true" />
                                </div>
                                <div class="col-12">
                                    <label class="form-label">Localidad</label>
                                    <asp:TextBox ID="txtLocalidad" runat="server" CssClass="form-control" ReadOnly="true" />
                                </div>
                            </div>
                            <div class="form-text mt-2">Estos datos provienen de tu cuenta.</div>
                        </div>
                    </section>

                    <section class="card border-0 shadow-sm mb-4">
                        <div class="card-body p-4">
                            <h2 class="h5 fw-bold mb-3"><i class="bi bi-mortarboard text-primary me-2"></i>Educación</h2>
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label class="form-label">Institución</label>
                                    <asp:TextBox ID="txtInstitucion" runat="server" CssClass="form-control" MaxLength="150" />
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Título</label>
                                    <asp:TextBox ID="txtTitulo" runat="server" CssClass="form-control" MaxLength="150" />
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
                                    <asp:TextBox ID="txtAnioEducacion" runat="server" CssClass="form-control" TextMode="Number" />
                                </div>
                            </div>
                        </div>
                    </section>

                    <section class="card border-0 shadow-sm mb-4">
                        <div class="card-body p-4">
                            <h2 class="h5 fw-bold mb-3"><i class="bi bi-briefcase text-primary me-2"></i>Experiencia</h2>
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label class="form-label">Tipo</label>
                                    <asp:DropDownList ID="ddlTipoExperiencia" runat="server" CssClass="form-select">
                                        <asp:ListItem Text="Seleccionar" Value="" />
                                        <asp:ListItem Text="Laboral" Value="Laboral" />
                                        <asp:ListItem Text="Voluntariado" Value="Voluntariado" />
                                    </asp:DropDownList>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Puesto</label>
                                    <asp:TextBox ID="txtPuesto" runat="server" CssClass="form-control" MaxLength="100" />
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Empresa</label>
                                    <asp:TextBox ID="txtEmpresa" runat="server" CssClass="form-control" MaxLength="150" />
                                </div>
                                <div class="col-md-3">
                                    <label class="form-label">Desde</label>
                                    <asp:TextBox ID="txtFechaDesde" runat="server" CssClass="form-control" TextMode="Date" />
                                </div>
                                <div class="col-md-3">
                                    <label class="form-label">Hasta</label>
                                    <asp:TextBox ID="txtFechaHasta" runat="server" CssClass="form-control" TextMode="Date" />
                                </div>
                                <div class="col-12">
                                    <label class="form-label">Descripción</label>
                                    <asp:TextBox ID="txtDescripcion" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" MaxLength="255" />
                                </div>
                            </div>
                        </div>
                    </section>

                    <section class="card border-0 shadow-sm mb-4">
                        <div class="card-body p-4">
                            <h2 class="h5 fw-bold mb-3"><i class="bi bi-stars text-primary me-2"></i>Habilidad</h2>
                            <div class="row g-3">
                                <div class="col-md-8">
                                    <label class="form-label">Descripción</label>
                                    <asp:TextBox ID="txtHabilidad" runat="server" CssClass="form-control" MaxLength="150" placeholder="Ej.: Trabajo en equipo" />
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label">Tipo de habilidad</label>
                                    <asp:DropDownList ID="ddlTipoHabilidad" runat="server" CssClass="form-select">
                                        <asp:ListItem Text="Blanda" Value="true" />
                                        <asp:ListItem Text="Dura" Value="false" />
                                    </asp:DropDownList>
                                </div>
                            </div>
                        </div>
                    </section>

                    <div class="d-flex justify-content-end gap-2 mb-4">
                        <a href="MisCurriculums.aspx" class="btn btn-outline-secondary">Cancelar</a>
                        <asp:Button ID="btnGuardarCV" runat="server" Text="Guardar currículum"
                            CssClass="btn btn-primary" ValidationGroup="guardarCV" OnClick="btnGuardarCV_Click" />
                    </div>
                </div>

                <aside class="col-lg-4">
                    <div class="card border-0 shadow-sm">
                        <div class="card-body p-4">
                            <h2 class="h5 fw-bold">Antes de guardar</h2>
                            <p class="text-secondary mb-0">Podés completar los datos del CV. El botón Guardar ya está conectado a un evento de WebForms para implementar el guardado desde C#.</p>
                        </div>
                    </div>
                </aside>
            </div>
        </main>
    </form>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
