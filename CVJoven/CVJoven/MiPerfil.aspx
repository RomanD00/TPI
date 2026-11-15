<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="miperfil.aspx.cs" Inherits="CVJoven.miperfil" %>

<!DOCTYPE html>
<html lang="es">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Mi Perfil - CVJoven</title>
    <!-- Bootstrap 5 CSS y Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet" />
</head>
<body class="bg-light">
    <form id="form1" runat="server">
        <div class="container py-5">
            
            <!-- Encabezado -->
            <div class="mb-4">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb mb-1 small text-muted">
                        <li class="breadcrumb-item">Mi cuenta</li>
                        <li class="breadcrumb-item active" aria-current="page">Mi perfil</li>
                    </ol>
                </nav>
                <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center gap-3">
                    <div>
                        <h1 class="h2 fw-bold text-dark mb-1">Mi perfil 👤</h1>
                        <p class="text-muted mb-0">Administrá tus datos personales y mantené tu información de contacto actualizada.</p>
                    </div>
                </div>
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
                                    <asp:Label ID="lblNombreCompleto" runat="server" Text="Ale Maza"></asp:Label>
                                </h5>
                                <p class="text-muted small mb-3">
                                    <asp:Label ID="lblEmailResumen" runat="server" Text="alejandrojmm26@gmail.com"></asp:Label>
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
                    <!-- Tarjeta 1: Datos Personales -->
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
                                    <label for="<%= txtDireccion.ClientID %>" class="form-label fw-semibold text-secondary small">Dirección</label>
                                    <asp:TextBox ID="txtDireccion" runat="server" CssClass="form-control rounded-3" placeholder="Ej: Buenos Aires, El Talar"></asp:TextBox>
                                </div>

                                <div class="col-12 col-md-6">
                                    <label for="<%= txtFechaNacimiento.ClientID %>" class="form-label fw-semibold text-secondary small">Fecha de Nacimiento</label>
                                    <asp:TextBox ID="txtFechaNacimiento" runat="server" TextMode="Date" CssClass="form-control rounded-3"></asp:TextBox>
                                </div>

                                <div class="col-12 col-md-6">
                                    <label for="<%= txtCelular.ClientID %>" class="form-label fw-semibold text-secondary small">Celular</label>
                                    <asp:TextBox ID="txtCelular" runat="server" TextMode="Phone" CssClass="form-control rounded-3" placeholder="Ej: 1122334455"></asp:TextBox>
                                </div>

                                <div class="col-12">
                                    <label for="<%= txtAreasInteres.ClientID %>" class="form-label fw-semibold text-secondary small">Áreas de Interés</label>
                                    <asp:TextBox ID="txtAreasInteres" runat="server" CssClass="form-control rounded-3" placeholder="Ej: Desarrollo Web, Sistemas, Soporte Técnico"></asp:TextBox>
                                </div>

                                <div class="col-12">
                                    <label for="<%= txtEmail.ClientID %>" class="form-label fw-semibold text-secondary small">Email</label>
                                    <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" CssClass="form-control rounded-3" placeholder="correo@ejemplo.com"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail" 
                                        ErrorMessage="El email es obligatorio." CssClass="text-danger small" Display="Dynamic" ValidationGroup="PerfilGroup" />
                                </div>
                            </div>

                            <div class="d-flex justify-content-end gap-2 mt-4 pt-3 border-top">
                                <asp:Button ID="btnCancelar" runat="server" Text="Cancelar" CssClass="btn btn-outline-secondary rounded-3 px-4" CausesValidation="false" OnClick="btnCancelar_Click" />
                                <asp:Button ID="btnGuardarCambios" runat="server" Text="Guardar cambios" CssClass="btn btn-primary rounded-3 px-4 fw-semibold" ValidationGroup="PerfilGroup" OnClick="btnGuardarCambios_Click" />
                            </div>
                        </div>
                    </div>

                    <!-- Tarjeta 2: Seguridad -->
                    <div class="card border-0 shadow-sm rounded-4">
                        <div class="card-body p-4">
                            <h5 class="fw-bold text-dark mb-1">Seguridad</h5>
                            <p class="text-muted small mb-4">Actualizá tu contraseña para mantener tu cuenta protegida.</p>

                            <div class="row g-3">
                                <div class="col-12 col-md-4">
                                    <label for="<%= txtPasswordActual.ClientID %>" class="form-label fw-semibold text-secondary small">Contraseña actual</label>
                                    <asp:TextBox ID="txtPasswordActual" runat="server" TextMode="Password" CssClass="form-control rounded-3" placeholder="••••••••"></asp:TextBox>
                                </div>
                                <div class="col-12 col-md-4">
                                    <label for="<%= txtPasswordNueva.ClientID %>" class="form-label fw-semibold text-secondary small">Nueva contraseña</label>
                                    <asp:TextBox ID="txtPasswordNueva" runat="server" TextMode="Password" CssClass="form-control rounded-3" placeholder="••••••••"></asp:TextBox>
                                </div>
                                <div class="col-12 col-md-4">
                                    <label for="<%= txtPasswordRepetir.ClientID %>" class="form-label fw-semibold text-secondary small">Repetir nueva contraseña</label>
                                    <asp:TextBox ID="txtPasswordRepetir" runat="server" TextMode="Password" CssClass="form-control rounded-3" placeholder="••••••••"></asp:TextBox>
                                </div>
                            </div>

                            <div class="d-flex justify-content-end mt-4 pt-3 border-top">
                                <asp:Button ID="btnCambiarPassword" runat="server" Text="Actualizar contraseña" CssClass="btn btn-outline-primary rounded-3 px-4 fw-semibold" ValidationGroup="PasswordGroup" OnClick="btnCambiarPassword_Click" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>

    <!-- Bootstrap 5 JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
