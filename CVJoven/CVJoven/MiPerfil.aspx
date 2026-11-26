<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="miperfil.aspx.cs" Inherits="CVJoven.miperfil" %>
<%@ Register Src="~/Controles/Accesibilidad.ascx"
    TagPrefix="uc"
    TagName="Accesibilidad" %>
<!DOCTYPE html>
<html lang="es">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Mi Perfil | CVJoven</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet" />
</head>
<body class="bg-light">
    <form id="form1" runat="server">
                <uc:Accesibilidad ID="Accesibilidad1" runat="server" />

        <!-- BARRA SUPERIOR -->
        <nav class="navbar navbar-expand-lg bg-white border-bottom shadow-sm">
            <div class="container-fluid px-4">
                <a class="navbar-brand fw-bold text-primary fs-4" href="MisCurriculums.aspx">
                    <i class="bi bi-file-earmark-person-fill me-2"></i>CVJoven
                </a>
                <div class="d-flex align-items-center gap-3">
                    <div class="bg-primary-subtle text-primary rounded-circle d-flex align-items-center justify-content-center"
                        style="width: 45px; height: 45px;">
                        <i class="bi bi-person-fill fs-4"></i>
                    </div>
                    <div class="d-flex flex-column">
                        <asp:Label ID="lblNombreUsuario" runat="server" CssClass="fw-bold text-dark" />
                        <asp:Label ID="lblEmailUsuario" runat="server" CssClass="text-secondary small" />
                    </div>
                </div>
            </div>
        </nav>

        <div class="container-fluid">
            <div class="row">
                <!-- MENÚ LATERAL -->
                <aside class="col-12 col-lg-2 bg-white border-end p-4" style="min-height: calc(100vh - 70px);">
                    <p class="text-secondary small fw-bold mb-3">MENÚ PRINCIPAL</p>
                    <div class="nav flex-column nav-pills gap-2">
                        <a href="MisCurriculums.aspx" class="nav-link text-secondary">
                            <i class="bi bi-file-earmark-text me-2"></i>Mis currículums
                        </a>
                        <a href="OfertasLaborales.aspx" class="nav-link text-secondary">
                            <i class="bi bi-briefcase me-2"></i>Ofertas laborales
                        </a>
                        <a href="MisPostulaciones.aspx" class="nav-link text-secondary">
                            <i class="bi bi-send me-2"></i>Mis postulaciones
                        </a>
                    </div>

                    <hr class="my-4" />

                    <p class="text-secondary small fw-bold">MI CUENTA</p>
                    <div class="nav flex-column nav-pills gap-2">
                        <a href="MiPerfil.aspx" class="nav-link active" aria-current="page">
                            <i class="bi bi-person me-2"></i>Mi perfil
                        </a>
                        <a href="Logout.aspx" class="nav-link text-danger">
                            <i class="bi bi-box-arrow-right me-2"></i>Cerrar sesión
                        </a>
                    </div>

                    <div class="card bg-primary-subtle border-0 mt-5">
                        <div class="card-body">
                            <h6 class="fw-bold text-primary">Tu futuro empieza acá</h6>
                            <p class="small text-secondary mb-0">
                                Mantené tus datos actualizados para que las empresas puedan contactarte fácilmente.
                            </p>
                        </div>
                    </div>
                </aside>

                <!-- CONTENIDO PRINCIPAL -->
                <main class="col-12 col-lg-10 p-4 p-lg-5">
                    <div class="container-fluid">
                        <!-- Encabezado -->
                        <div class="mb-4">
                            <p class="text-secondary small mb-2">Mi cuenta / Mi perfil</p>
                            <h1 class="h2 fw-bold text-dark mb-1">Mi perfil</h1>
                            <p class="text-muted mb-0">Administrá tus datos personales y mantené tu información de contacto actualizada.</p>
                        </div>

                        <!-- Alerta de feedback -->
                        <asp:Panel ID="pnlMensaje" runat="server" Visible="false" CssClass="alert alert-success alert-dismissible fade show rounded-3 shadow-sm mb-4" role="alert">
                            <asp:Label ID="lblMensaje" runat="server" Text=""></asp:Label>
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </asp:Panel>

                        <div class="row g-4">
                            <!-- Columna Izquierda: Resumen del Perfil -->
                            <div class="col-12 col-lg-4">
                                <div class="card border-0 shadow-sm rounded-4 h-100">
                                    <div class="card-body p-4 text-center d-flex flex-column justify-content-between">
                                        <div>
                                            <div class="bg-primary bg-opacity-10 text-primary rounded-circle d-inline-flex align-items-center justify-content-center mb-3 p-4">
                                                <i class="bi bi-person-fill fs-1"></i>
                                            </div>
                                            <h5 class="fw-bold text-dark mb-1">
                                                <asp:Label ID="lblNombreCompleto" runat="server" Text="-"></asp:Label>
                                            </h5>
                                            <p class="text-muted small mb-3">
                                                <asp:Label ID="lblEmailResumen" runat="server" Text="-"></asp:Label>
                                            </p>
                                            <span class="badge bg-primary bg-opacity-10 text-primary rounded-pill px-3 py-2 fw-semibold">
                                                Postulante
                                            </span>
                                        </div>

                                        <div class="mt-4 pt-3 border-top text-start">
                                            <div class="d-flex justify-content-between small mb-2">
                                                <span class="text-muted">DNI:</span>
                                                <span class="fw-semibold text-dark">
                                                    <asp:Label ID="lblDniResumen" runat="server" Text="-"></asp:Label>
                                                </span>
                                            </div>
                                            <div class="d-flex justify-content-between small mb-2">
                                                <span class="text-muted">Localidad:</span>
                                                <span class="fw-semibold text-dark">
                                                    <asp:Label ID="lblDireccionResumen" runat="server" Text="-"></asp:Label>
                                                </span>
                                            </div>
                                            <div class="d-flex justify-content-between small">
                                                <span class="text-muted">Teléfono:</span>
                                                <span class="fw-semibold text-dark">
                                                    <asp:Label ID="lblCelularResumen" runat="server" Text="-"></asp:Label>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Columna Derecha: Formulario de Edición -->
                            <div class="col-12 col-lg-8">
                                <div class="card border-0 shadow-sm rounded-4 mb-4">
                                    <div class="card-body p-4">
                                        <h5 class="fw-bold text-dark mb-4">Información Personal</h5>

                                        <div class="row g-3">
                                            <div class="col-12 col-md-6">
                                                <label for="<%= txtNombre.ClientID %>" class="form-label fw-semibold text-secondary small">Nombre</label>
                                                <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control rounded-3" placeholder="Ingresá tu nombre"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="rfvNombre" runat="server" ControlToValidate="txtNombre"
                                                    ErrorMessage="El nombre es obligatorio." CssClass="text-danger small" Display="Dynamic" ValidationGroup="PerfilGroup" />
                                            </div>

                                            <div class="col-12 col-md-6">
                                                <label for="<%= txtApellido.ClientID %>" class="form-label fw-semibold text-secondary small">Apellido</label>
                                                <asp:TextBox ID="txtApellido" runat="server" CssClass="form-control rounded-3" placeholder="Ingresá tu apellido"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="rfvApellido" runat="server" ControlToValidate="txtApellido"
                                                    ErrorMessage="El apellido es obligatorio." CssClass="text-danger small" Display="Dynamic" ValidationGroup="PerfilGroup" />
                                            </div>

                                            <div class="col-12 col-md-6">
                                                <label for="<%= txtDni.ClientID %>" class="form-label fw-semibold text-secondary small">DNI</label>
                                                <asp:TextBox ID="txtDni" runat="server" CssClass="form-control rounded-3 bg-light" ReadOnly="true"></asp:TextBox>
                                                <div class="form-text small">El DNI no puede modificarse directamente.</div>
                                            </div>

                                            <div class="col-12 col-md-6">
                                                <label for="<%= txtDireccion.ClientID %>" class="form-label fw-semibold text-secondary small">Localidad</label>
                                                <asp:TextBox ID="txtDireccion" runat="server" CssClass="form-control rounded-3" placeholder="Ej: Caseros, Buenos Aires"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="rfvDireccion" runat="server" ControlToValidate="txtDireccion"
                                                    ErrorMessage="La localidad es obligatoria." CssClass="text-danger small" Display="Dynamic" ValidationGroup="PerfilGroup" />
                                            </div>

                                            <div class="col-12 col-md-6">
                                                <label for="<%= txtFechaNacimiento.ClientID %>" class="form-label fw-semibold text-secondary small">Fecha de Nacimiento</label>
                                                <asp:TextBox ID="txtFechaNacimiento" runat="server" TextMode="Date" CssClass="form-control rounded-3"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="rfvFechaNac" runat="server" ControlToValidate="txtFechaNacimiento"
                                                    ErrorMessage="La fecha de nacimiento es obligatoria." CssClass="text-danger small" Display="Dynamic" ValidationGroup="PerfilGroup" />
                                            </div>

                                            <div class="col-12 col-md-6">
                                                <label for="<%= txtCelular.ClientID %>" class="form-label fw-semibold text-secondary small">Celular</label>
                                                <asp:TextBox ID="txtCelular" runat="server" TextMode="Phone" CssClass="form-control rounded-3" placeholder="Ej: 1122334455"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="rfvCelular" runat="server" ControlToValidate="txtCelular"
                                                    ErrorMessage="El celular es obligatorio." CssClass="text-danger small" Display="Dynamic" ValidationGroup="PerfilGroup" />
                                                <asp:RegularExpressionValidator ID="revCelular" runat="server" ControlToValidate="txtCelular"
                                                    ValidationExpression="^\d{10,15}$" ErrorMessage="Ingresá entre 10 y 15 números, sin espacios ni guiones."
                                                    CssClass="text-danger small" Display="Dynamic" ValidationGroup="PerfilGroup" />
                                            </div>

                                            <div class="col-12">
                                                <label for="<%= txtEmail.ClientID %>" class="form-label fw-semibold text-secondary small">Email</label>
                                                <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" CssClass="form-control rounded-3" placeholder="correo@ejemplo.com"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail"
                                                    ErrorMessage="El email es obligatorio." CssClass="text-danger small" Display="Dynamic" ValidationGroup="PerfilGroup" />
                                                <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail"
                                                    ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$" ErrorMessage="Ingresá un email válido."
                                                    CssClass="text-danger small" Display="Dynamic" ValidationGroup="PerfilGroup" />
                                            </div>
                                        </div>

                                        <div class="d-flex justify-content-end gap-2 mt-4 pt-3 border-top">
                                            <asp:Button ID="btnCancelar" runat="server" Text="Cancelar" CssClass="btn btn-outline-secondary rounded-3 px-4" CausesValidation="false" OnClick="btnCancelar_Click" />
                                            <asp:Button ID="btnGuardarCambios" runat="server" Text="Guardar cambios" CssClass="btn btn-primary rounded-3 px-4 fw-semibold" ValidationGroup="PerfilGroup" OnClick="btnGuardarCambios_Click" />
                                        </div>
                                    </div>
                                </div>


                            </div>
                        </div>
                    </div>
                </main>
            </div>
        </div>
    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>