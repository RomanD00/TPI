<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="CVJoven.Login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>CV Joven - Iniciar Sesión</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body class="bg-light d-flex align-items-center" style="min-height: 100vh;">
    <form id="form1" runat="server" class="w-100">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-5 col-lg-4">
                    <div class="card shadow-sm border-0 rounded-3">
                        <div class="card-body p-4">
                            <h3 class="text-center fw-bold mb-1">CV Joven</h3>
                            <p class="text-center text-muted mb-4">Ingresá a tu cuenta</p>

                            <div class="mb-3">
                                <label class="form-label fw-semibold">Correo electrónico</label>
                                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="ejemplo@correo.com"></asp:TextBox>
                            </div>

                            <div class="mb-3">
                                <label class="form-label fw-semibold">Contraseña</label>
                                <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="••••••••"></asp:TextBox>
                            </div>

                            <div class="mb-3 text-center">
                                <asp:Label ID="lblMensaje" runat="server" CssClass="text-danger fw-semibold"></asp:Label>
                            </div>

                            <div class="d-grid gap-2 mt-2">
                            <asp:Button ID="btnIngresar" runat="server"
                                Text="Iniciar Sesión"
                                CssClass="btn btn-primary py-2 fw-semibold"
                                OnClick="btnIngresar_Click" />                            
                            </div>

                            <hr class="my-4" />

                            <div class="text-center">
                                <span class="text-muted small">¿No tenés cuenta?</span>
                                <asp:HyperLink ID="hlRegistro" runat="server" NavigateUrl="RegistroUsuarios.aspx" CssClass="small text-decoration-none fw-semibold ms-1">Registrate acá</asp:HyperLink>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>