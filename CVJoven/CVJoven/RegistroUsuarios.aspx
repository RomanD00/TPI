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
                                </div>

                                <!-- Apellido -->
                                <div class="col-md-6">
                                    <label for="<%= txtApellido.ClientID %>" class="form-label text-secondary fw-semibold">Apellido</label>
                                    <asp:TextBox ID="txtApellido" runat="server" CssClass="form-control" placeholder="Ingrese su apellido"></asp:TextBox>
                                </div>

                                <!-- Fecha de Nacimiento -->
                                <div class="col-md-6">
                                    <label for="<%= txtFechaNac.ClientID %>" class="form-label text-secondary fw-semibold">Fecha de Nacimiento</label>
                                    <asp:TextBox ID="txtFechaNac" runat="server" TextMode="Date" CssClass="form-control"></asp:TextBox>
                                </div>

                                <!-- Celular -->
                                <div class="col-md-6">
                                    <label for="<%= txtCelular.ClientID %>" class="form-label text-secondary fw-semibold">Celular</label>
                                    <asp:TextBox ID="txtCelular" runat="server" TextMode="Phone" CssClass="form-control" placeholder="Ej: 1123456789"></asp:TextBox>
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
                                </div>


                                  <div class="col-md-6">
      <label for="<%= pssw1.ClientID %>" class="form-label text-secondary fw-semibold">Contraseña</label>
      <asp:TextBox ID="pssw1" runat="server" CssClass="form-control" TextMode="Password" placeholder="Ingrese su Contraseña"></asp:TextBox>
  </div>

                                  <div class="col-md-6">
      <label for="<%= pssw2.ClientID %>" class="form-label text-secondary fw-semibold">Repetir Contraseña</label>
      <asp:TextBox ID="pssw2" runat="server" CssClass="form-control" TextMode="Password" placeholder="Repita su Contraseña"></asp:TextBox>
  </div>


                                <!-- Botón Registrar (Azul) -->
                                <div class="col-12 mt-4">
                                    <asp:Button ID="btnRegistrar" runat="server" Text="Registrar"
                                        CssClass="btn btn-primary w-100 py-2 fw-semibold" OnClick="btnRegistrar_Click" />
                                </div>

                            </div>
                        </asp:Panel>

                        <!-- Panel Empresa (Deshabilitado por ahora) -->
                        <asp:Panel ID="pnlEmpresa" runat="server" Visible="false">
                            <div class="text-center py-4 text-muted">
                                Formulario de Empresa (En desarrollo)
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
