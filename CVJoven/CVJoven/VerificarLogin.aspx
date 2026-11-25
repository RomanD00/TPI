<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="VerificarLogin.aspx.cs" Inherits="CVJoven.VerificarUsuario" %>
<%@ Register Src="~/Controles/Accesibilidad.ascx"
    TagPrefix="uc"
    TagName="Accesibilidad" %>
<!DOCTYPE html>
<html lang="es">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>CV Joven - Verificar Usuario</title>
    <!-- Bootstrap 5 CSS CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body class="bg-light d-flex justify-content-center align-items-center vh-100">
    <form id="form1" runat="server" class="w-100">
                <uc:Accesibilidad ID="Accesibilidad1" runat="server" />

        <div class="container d-flex justify-content-center">
            <div class="card border-0 shadow-sm p-4 p-md-5 rounded-4" style="max-width: 420px; width: 100%;">
                
                <!-- Encabezado de la marca -->
                <div class="text-center mb-4">
                    <h1 class="h3 fw-bold text-dark mb-1">CV Joven</h1>
                    <p class="text-muted small">Verificación de cuenta</p>
                </div>

                <!-- Ícono central (cambia de clases mediante code-behind) -->
                <div id="divIcono" runat="server" class="rounded-circle d-flex align-items-center justify-content-center mx-auto mb-4 bg-primary bg-opacity-10 text-primary" style="width: 64px; height: 64px;">
                    <svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z" />
                    </svg>
                </div>

                <!-- Descripción -->
                <p id="pDescripcion" runat="server" class="text-secondary text-center small mb-4 lh-sm">
                    Hacé clic en el botón de abajo para confirmar y activar tu usuario en la plataforma.
                </p>

                <!-- Botón de acción con Bootstrap -->
                <asp:Button ID="btnVerificar" runat="server" Text="Verificar Usuario" CssClass="btn btn-primary w-100 py-2 fw-semibold shadow-sm mb-2" OnClick="btnVerificar_Click" />

                <!-- Mensaje de éxito -->
                <asp:Label ID="lblMensaje" runat="server" CssClass="d-block text-center text-success fw-semibold small mt-2" Visible="false"></asp:Label>

                <hr class="text-muted my-4" />

                <!-- Enlace al inicio de sesión -->
                <div class="text-center">
                    <p class="text-muted small mb-0">
                        ¿Ya verificaste tu cuenta? <a href="Login.aspx" class="text-primary text-decoration-none fw-semibold">Iniciá sesión</a>
                    </p>
                </div>

            </div>
        </div>
    </form>

    <!-- Bootstrap 5 JS Bundle CDN -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>