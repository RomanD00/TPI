<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RegistroUsuarios.aspx.cs" Inherits="CVJoven.RegistroUsuarios" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Registrar Postulante</title>
    <!-- CDN de Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body class="bg-light d-flex align-items-center min-vh-100 py-4">

    <form id="form1" runat="server" class="w-100">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-12 col-md-8 col-lg-6">

                    <!-- Tarjeta con fondo blanco y sombra leve (shadow-sm) -->
                    <div class="card border-0 shadow-sm rounded-3 bg-white p-4">

                        <h3 class="text-center mb-4 text-dark fw-bold">Registrar Postulante</h3>

                        <!-- Pestañas de selección Postulante / Empresa -->
                        <div class="btn-group w-100 mb-4" role="group" aria-label="Tipo de Registro">
                            <asp:Button ID="btnPostulante" runat="server" Text="Postulante"
                                CssClass="btn btn-outline-primary active" OnClick="btnPostulante_Click" CausesValidation="false" />
                            <asp:Button ID="btnEmpresa" runat="server" Text="Empresa"
                                CssClass="btn btn-outline-primary" OnClick="btnEmpresa_Click" CausesValidation="false" />
                        </div>

                        <!-- Formulario Postulante -->
                        <asp:Panel ID="pnlPostulante" runat="server">
                            <div class="row g-3">

                                <!-- Nombre -->
                                <div class="col-md-6">
                                    <label for="<%= txtNombre.ClientID %>" class="form-label text-secondary fw-semibold">Nombre</label>
                                    <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" placeholder="Ingrese su nombre"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvNombre" runat="server"
                                ControlToValidate="txtNombre"
                                ErrorMessage="El nombre es obligatorio."
                                CssClass="text-danger small"
                                Display="Dynamic"
                                ValidationGroup="Postulante" />

                            <asp:RegularExpressionValidator ID="revNombre" runat="server"
                                ControlToValidate="txtNombre"
                                ValidationExpression="^.{2,100}$"
                                ErrorMessage="El nombre debe tener entre 2 y 100 caracteres."
                                CssClass="text-danger small"
                                Display="Dynamic"
                                ValidationGroup="Postulante" />
                                </div>

                                <!-- Apellido -->
                                <div class="col-md-6">
                                    <label for="<%= txtApellido.ClientID %>" class="form-label text-secondary fw-semibold">Apellido</label>
                                    <asp:TextBox ID="txtApellido" runat="server" CssClass="form-control" placeholder="Ingrese su apellido"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvApellido" runat="server"
                                ControlToValidate="txtApellido"
                                ErrorMessage="El apellido es obligatorio."
                                CssClass="text-danger small"
                                Display="Dynamic"
                                ValidationGroup="Postulante" />

                            <asp:RegularExpressionValidator ID="revApellido" runat="server"
                                ControlToValidate="txtApellido"
                                ValidationExpression="^.{2,100}$"
                                ErrorMessage="El apellido debe tener entre 2 y 100 caracteres."
                                CssClass="text-danger small"
                                Display="Dynamic"
                                ValidationGroup="Postulante" />
                                </div>

                                   <!-- dni -->
                                <div class="col-md-6">
                                   <label for="<%= txtDni.ClientID %>" class="form-label text-secondary fw-semibold">DNI</label>
                                   <asp:TextBox ID="txtDni" runat="server" CssClass="form-control" placeholder="Ingrese su DNI"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvDni" runat="server"
                                ControlToValidate="txtDni"
                                ErrorMessage="El DNI es obligatorio."
                                CssClass="text-danger small"
                                Display="Dynamic"
                                ValidationGroup="Postulante" />

                            <asp:RegularExpressionValidator ID="revDni" runat="server"
                                ControlToValidate="txtDni"
                                ValidationExpression="^\d{7,8}$"
                                ErrorMessage="El DNI debe contener 7 u 8 números."
                                CssClass="text-danger small"
                                Display="Dynamic"
                                ValidationGroup="Postulante" />
                                </div>

                                   <!-- Localidad -->
                                <div class="col-md-6">
                                    <label for="<%= txtDireccion.ClientID %>" class="form-label text-secondary fw-semibold">Localidad</label>
                                    <asp:TextBox ID="txtDireccion" runat="server" CssClass="form-control" placeholder="Ej: Caseros, Buenos Aires"></asp:TextBox>
                                    <asp:RequiredFieldValidator
                                        ID="RequiredFieldValidator1"
                                        runat="server"
                                        ControlToValidate="txtDireccion"
                                        ErrorMessage="La localidad es obligatoria."
                                        CssClass="text-danger small"
                                        Display="Dynamic"
                                        ValidationGroup="Postulante" />
                                </div>
                               

                            <asp:RequiredFieldValidator
                                ID="rfvDireccion"
                                runat="server"
                                ControlToValidate="txtDireccion"
                                ErrorMessage="La dirección es obligatoria."
                                CssClass="text-danger small"
                                Display="Dynamic"
                                ValidationGroup="Postulante" />
                                </div>

                                <!-- Fecha de Nacimiento -->
                                <div class="col-md-6">
                                    <label for="<%= txtFechaNac.ClientID %>" class="form-label text-secondary fw-semibold">Fecha de Nacimiento</label>
                                    <asp:TextBox ID="txtFechaNac" runat="server" TextMode="Date" CssClass="form-control"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvFechaNac" runat="server"
                                ControlToValidate="txtFechaNac"
                                ErrorMessage="La fecha de nacimiento es obligatoria."
                                CssClass="text-danger small"
                                Display="Dynamic"
                                ValidationGroup="Postulante" />
                                </div>

                                <!-- Celular -->
                                <div class="col-md-6">
                                    <label for="<%= txtCelular.ClientID %>" class="form-label text-secondary fw-semibold">Celular</label>
                                    <asp:TextBox ID="txtCelular" runat="server" TextMode="Phone" CssClass="form-control" placeholder="Ej: 1123456789"></asp:TextBox>
                               <asp:RequiredFieldValidator ID="rfvCelular" runat="server"
                                ControlToValidate="txtCelular"
                                ErrorMessage="El celular es obligatorio."
                                CssClass="text-danger small"
                                Display="Dynamic"
                                ValidationGroup="Postulante" />

                            <asp:RegularExpressionValidator ID="revCelular" runat="server"
                                ControlToValidate="txtCelular"
                                ValidationExpression="^\d{10,15}$"
                                ErrorMessage="Ingrese entre 10 y 15 números, sin espacios ni guiones."
                                CssClass="text-danger small"
                                Display="Dynamic"
                                ValidationGroup="Postulante" />
                                    </div>

                                <!-- Áreas de Interés -->
                                <div class="col-12">
                                    <label for="<%= txtAreasInteres.ClientID %>" class="form-label text-secondary fw-semibold">Áreas de Interés</label>
                                    <asp:TextBox ID="txtAreasInteres" runat="server"
                                        CssClass="form-control"
                                        placeholder="Seleccione o escriba un área..."
                                        list="dlAreasInteres"
                                        autocomplete="off"></asp:TextBox>
                                </div>

                                <!-- Email -->
                                <div class="col-12">
                                    <label for="<%= txtEmail.ClientID %>" class="form-label text-secondary fw-semibold">Email</label>
                                    <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" CssClass="form-control" placeholder="correo@ejemplo.com"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvEmail" runat="server"
                                ControlToValidate="txtEmail"
                                ErrorMessage="El correo electrónico es obligatorio."
                                CssClass="text-danger small"
                                Display="Dynamic"
                                ValidationGroup="Postulante" />

                            <asp:RegularExpressionValidator ID="revEmail" runat="server"
                                ControlToValidate="txtEmail"
                                ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$"
                                ErrorMessage="Ingrese un correo electrónico válido."
                                CssClass="text-danger small"
                                Display="Dynamic"
                                ValidationGroup="Postulante" />
                                </div>


                                  <div class="col-md-6">
      <label for="<%= pssw1.ClientID %>" class="form-label text-secondary fw-semibold">Contraseña</label>
      <asp:TextBox ID="pssw1" runat="server" CssClass="form-control" TextMode="Password" placeholder="Ingrese su Contraseña"></asp:TextBox>
  <asp:RequiredFieldValidator ID="rfvPasswordPostulante" runat="server"
    ControlToValidate="pssw1"
    ErrorMessage="La contraseña es obligatoria."
    CssClass="text-danger small"
    Display="Dynamic"
    MaxLength="100"
    ValidationGroup="Postulante" />

<asp:RegularExpressionValidator ID="revPasswordPostulante" runat="server"
    ControlToValidate="pssw1"
    ValidationExpression="^.{8,100}$"
    ErrorMessage="La contraseña debe tener entre 8 y 100 caracteres."
    CssClass="text-danger small"
    Display="Dynamic"
    MaxLength="100"
    ValidationGroup="Postulante" />
                                  </div>

                                  <div class="col-md-6">
      <label for="<%= pssw2.ClientID %>" class="form-label text-secondary fw-semibold">Repetir Contraseña</label>
      <asp:TextBox ID="pssw2" runat="server" CssClass="form-control" TextMode="Password" placeholder="Repita su Contraseña"></asp:TextBox>
  <asp:RequiredFieldValidator ID="rfvConfirmarPostulante" runat="server"
    ControlToValidate="pssw2"
    ErrorMessage="Debe repetir la contraseña."
    CssClass="text-danger small"
    Display="Dynamic"
    ValidationGroup="Postulante" />

<asp:CompareValidator ID="cvPasswordPostulante" runat="server"
    ControlToValidate="pssw2"
    ControlToCompare="pssw1"
    ErrorMessage="Las contraseñas no coinciden."
    CssClass="text-danger small"
    Display="Dynamic"
    ValidationGroup="Postulante" />
                                  </div>

                                <div class="col-12">
    <asp:ValidationSummary ID="vsPostulante" runat="server"
        HeaderText="Por favor, corrija los siguientes errores:"
        CssClass="alert alert-danger mt-3"
        ValidationGroup="Postulante"
        DisplayMode="BulletList" />
</div>

                                <!-- Botón Registrar (Azul) -->
                                <div class="col-12 mt-4">
                                    <asp:Button ID="btnRegistrar" runat="server" Text="Registrar"
                                        CssClass="btn btn-primary w-100 py-2 fw-semibold" OnClick="btnRegistrar_Click"
                                        ValidationGroup="Postulante"/>
                                </div>

                            </div>
                        </asp:Panel>


<!-- Formulario Empresa -->
<asp:Panel ID="pnlEmpresa" runat="server" Visible="false">

    <div class="row g-3">

        <!-- Tipo de Usuario -->
        <asp:HiddenField ID="hfTipoUsuario" runat="server" Value="2" />

        <!-- Mail -->
        <div class="col-12">
            <label for="<%= txtMailEmpresa.ClientID %>"
                class="form-label text-secondary fw-semibold">
                Mail
            </label>

            <asp:TextBox ID="txtMailEmpresa" runat="server"
                TextMode="Email"
                CssClass="form-control"
                placeholder="correo@empresa.com">
            </asp:TextBox>

            <asp:RequiredFieldValidator
                ID="rfvMailEmpresa"
                runat="server"
                ControlToValidate="txtMailEmpresa"
                ErrorMessage="El mail es obligatorio."
                Display="Dynamic"
                CssClass="text-danger small"
                ValidationGroup="Empresa">
            </asp:RequiredFieldValidator>

            <asp:RegularExpressionValidator
                ID="revMailEmpresa"
                runat="server"
                ControlToValidate="txtMailEmpresa"
                ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$"
                ErrorMessage="Ingrese un mail válido."
                Display="Dynamic"
                CssClass="text-danger small"
                ValidationGroup="Empresa">
            </asp:RegularExpressionValidator>
        </div>
        <!-- Contraseña -->
<div class="col-md-6">
    <label class="form-label">Contraseña</label>

    <asp:TextBox ID="txtPasswordEmpresa"
        runat="server"
        TextMode="Password"
        CssClass="form-control"
        MaxLength="100">
    </asp:TextBox>

    <asp:RequiredFieldValidator
        ID="rfvPasswordEmpresa"
        runat="server"
        ControlToValidate="txtPasswordEmpresa"
        ErrorMessage="La contraseña es obligatoria."
        CssClass="text-danger small"
        Display="Dynamic"
        ValidationGroup="Empresa" />

    <asp:RegularExpressionValidator
        ID="revPasswordEmpresa"
        runat="server"
        ControlToValidate="txtPasswordEmpresa"
        ValidationExpression="^.{8,100}$"
        ErrorMessage="La contraseña debe tener entre 8 y 100 caracteres."
        CssClass="text-danger small"
        Display="Dynamic"
        ValidationGroup="Empresa" />
</div>

<!-- Confirmar contraseña -->
<div class="col-md-6">
    <label class="form-label">Confirmar contraseña</label>

    <asp:TextBox ID="txtConfirmarPasswordEmpresa"
        runat="server"
        TextMode="Password"
        CssClass="form-control"
        MaxLength="100">
    </asp:TextBox>

    <asp:RequiredFieldValidator
        ID="rfvConfirmarPasswordEmpresa"
        runat="server"
        ControlToValidate="txtConfirmarPasswordEmpresa"
        ErrorMessage="Debe confirmar la contraseña."
        CssClass="text-danger small"
        Display="Dynamic"
        ValidationGroup="Empresa" />

    <asp:CompareValidator
        ID="cvPasswordEmpresa"
        runat="server"
        ControlToValidate="txtConfirmarPasswordEmpresa"
        ControlToCompare="txtPasswordEmpresa"
        ErrorMessage="Las contraseñas no coinciden."
        CssClass="text-danger small"
        Display="Dynamic"
        ValidationGroup="Empresa" />
</div>
        <!-- Nombre Legal -->
        <div class="col-md-6">
            <label for="<%= txtNombreLegal.ClientID %>"
                class="form-label text-secondary fw-semibold">
                Nombre Legal
            </label>

            <asp:TextBox ID="txtNombreLegal" runat="server"
                CssClass="form-control"
                placeholder="Ej: Empresa S.A.">
            </asp:TextBox>

            <asp:RequiredFieldValidator
                ID="rfvNombreLegal"
                runat="server"
                ControlToValidate="txtNombreLegal"
                ErrorMessage="El nombre legal es obligatorio."
                Display="Dynamic"
                CssClass="text-danger small"
                ValidationGroup="Empresa">
            </asp:RequiredFieldValidator>
        </div>

        <!-- Nombre Comercial -->
        <div class="col-md-6">
            <label for="<%= txtNombreComercial.ClientID %>"
                class="form-label text-secondary fw-semibold">
                Nombre Comercial
            </label>

            <asp:TextBox ID="txtNombreComercial" runat="server"
                CssClass="form-control"
                placeholder="Ej: Empresa">
            </asp:TextBox>

            <asp:RequiredFieldValidator
                ID="rfvNombreComercial"
                runat="server"
                ControlToValidate="txtNombreComercial"
                ErrorMessage="El nombre comercial es obligatorio."
                Display="Dynamic"
                CssClass="text-danger small"
                ValidationGroup="Empresa">
            </asp:RequiredFieldValidator>
        </div>

        <!-- CUIT -->
        <div class="col-md-6">
            <label for="<%= txtCUIT.ClientID %>"
                class="form-label text-secondary fw-semibold">
                CUIT
            </label>

            <asp:TextBox ID="txtCUIT" runat="server"
                CssClass="form-control"
                placeholder="Ej: 30-12345678-9"
                MaxLength="13">
            </asp:TextBox>

            <asp:RequiredFieldValidator
                ID="rfvCUIT"
                runat="server"
                ControlToValidate="txtCUIT"
                ErrorMessage="El CUIT es obligatorio."
                Display="Dynamic"
                CssClass="text-danger small"
                ValidationGroup="Empresa">
            </asp:RequiredFieldValidator>

            <asp:RegularExpressionValidator
                ID="revCUIT"
                runat="server"
                ControlToValidate="txtCUIT"
                ValidationExpression="^\d{2}-?\d{8}-?\d$"
                ErrorMessage="Ingrese un CUIT válido (11 dígitos)."
                Display="Dynamic"
                CssClass="text-danger small"
                ValidationGroup="Empresa">
            </asp:RegularExpressionValidator>
        </div>

        <!-- Sector -->
        <div class="col-md-6">
            <label for="<%= txtSector.ClientID %>"
                class="form-label text-secondary fw-semibold">
                Sector
            </label>

            <asp:TextBox ID="txtSector" runat="server"
                CssClass="form-control"
                placeholder="Ej: Tecnología, Comercio, Salud">
            </asp:TextBox>

            <asp:RequiredFieldValidator
                ID="rfvSector"
                runat="server"
                ControlToValidate="txtSector"
                ErrorMessage="El sector es obligatorio."
                Display="Dynamic"
                CssClass="text-danger small"
                ValidationGroup="Empresa">
            </asp:RequiredFieldValidator>
        </div>

<!-- Tamaño de Empresa -->
<div class="col-md-6">
    <label for="<%= ddlTamanioEmpresa.ClientID %>"
        class="form-label text-secondary fw-semibold">
        Tamaño de Empresa
    </label>

    <asp:DropDownList ID="ddlTamanioEmpresa" runat="server"
        CssClass="form-select">

        <asp:ListItem Text="Seleccione una opción" Value="" />
        <asp:ListItem Text="Pyme" Value="Pyme" />
        <asp:ListItem Text="Mediana" Value="Mediana" />
        <asp:ListItem Text="Grande" Value="Grande" />

    </asp:DropDownList>

    <asp:RequiredFieldValidator
        ID="rfvTamanioEmpresa"
        runat="server"
        ControlToValidate="ddlTamanioEmpresa"
        InitialValue=""
        ErrorMessage="Debe seleccionar el tamaño de la empresa."
        Display="Dynamic"
        CssClass="text-danger small"
        ValidationGroup="Empresa">
    </asp:RequiredFieldValidator>
</div>

        <!-- Página Web (Opcional) -->
        <div class="col-12">
            <label for="<%= txtPaginaWeb.ClientID %>"
                class="form-label text-secondary fw-semibold">
                Página Web (Opcional)
            </label>

            <asp:TextBox ID="txtPaginaWeb" runat="server"
                TextMode="Url"
                CssClass="form-control"
                placeholder="https://www.empresa.com">
            </asp:TextBox>

            <asp:RegularExpressionValidator
                ID="revPaginaWeb"
                runat="server"
                ControlToValidate="txtPaginaWeb"
                ValidationExpression="^https?://.+\..+$"
                ErrorMessage="Ingrese una URL válida (Ej: https://www.empresa.com)."
                Display="Dynamic"
                CssClass="text-danger small"
                ValidationGroup="Empresa">
            </asp:RegularExpressionValidator>
        </div>

        <!-- Correo RRHH -->
        <div class="col-12">
            <label for="<%= txtCorreoRRHH.ClientID %>"
                class="form-label text-secondary fw-semibold">
                Correo de Recursos Humanos
            </label>

            <asp:TextBox ID="txtCorreoRRHH" runat="server"
                TextMode="Email"
                CssClass="form-control"
                placeholder="rrhh@empresa.com">
            </asp:TextBox>

            <asp:RequiredFieldValidator
                ID="rfvCorreoRRHH"
                runat="server"
                ControlToValidate="txtCorreoRRHH"
                ErrorMessage="El correo de RRHH es obligatorio."
                Display="Dynamic"
                CssClass="text-danger small"
                ValidationGroup="Empresa">
            </asp:RequiredFieldValidator>

            <asp:RegularExpressionValidator
                ID="revCorreoRRHH"
                runat="server"
                ControlToValidate="txtCorreoRRHH"
                ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$"
                ErrorMessage="Ingrese un correo de RRHH válido."
                Display="Dynamic"
                CssClass="text-danger small"
                ValidationGroup="Empresa">
            </asp:RegularExpressionValidator>
        </div>

        <!-- Resumen de Validaciones -->
        <div class="col-12">
            <asp:ValidationSummary
                ID="vsEmpresa"
                runat="server"
                HeaderText="Por favor, corrija los siguientes errores:"
                CssClass="alert alert-danger mt-3"
                ValidationGroup="Empresa"
                DisplayMode="BulletList" />
        </div>

        <!-- Botón Registrar -->
        <div class="col-12 mt-4">
            <asp:Button ID="btnRegistrarEmpresa" runat="server"
                Text="Registrar Empresa"
                CssClass="btn btn-primary w-100 py-2 fw-semibold"
                OnClick="btnRegistrarEmpresa_Click"
                ValidationGroup="Empresa" />
        </div>

    </div>

</asp:Panel>


                    </div>

                </div>
            </div>
        </div>
          <div class="text-center">
      <span class="text-muted small">¿Ya tienes cuenta?</span>
      <asp:HyperLink ID="hlRegistro" runat="server" NavigateUrl="login.aspx" CssClass="small text-decoration-none fw-semibold ms-1">Iniciar Sesion</asp:HyperLink>
  </div>
    </form>

    <!-- Script de Bootstrap 5 -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/bootstrap.bundle.min.js"></script>
</body>
</html>
