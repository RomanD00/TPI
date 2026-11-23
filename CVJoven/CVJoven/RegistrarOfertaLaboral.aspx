
<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RegistrarOfertaLaboral.aspx.cs" Inherits="CVJoven.RegistrarOfertaLaboral" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Registrar Oferta Laboral</title>

    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>

<body class="bg-light d-flex align-items-center min-vh-100 py-4">

    <form id="form1" runat="server" class="w-100">

        <!-- BARRA SUPERIOR -->
<nav class="navbar navbar-expand-lg bg-white border-bottom shadow-sm">
    <div class="container-fluid px-4">
        <a class="navbar-brand fw-bold text-primary fs-4" href="MiEmpresa.aspx">
            <i class="bi bi-file-earmark-person-fill me-2"></i>CVJoven
        </a>
        <div class="d-flex align-items-center gap-3">
            <div class="bg-primary-subtle text-primary rounded-circle d-flex align-items-center justify-content-center"
                style="width: 45px; height: 45px;">
                <i class="bi bi-person-fill fs-4"></i>
            </div>
            <div class="d-flex flex-column">
                <asp:Label ID="lblNombreComercialNavbar" runat="server" CssClass="fw-bold text-dark" />
                <asp:Label ID="lblEmailUsuario" runat="server" CssClass="text-secondary small" />
                <a href="Logout.aspx" class="nav-link text-danger">
                <i class="bi bi-box-arrow-right me-2"></i>
                Cerrar sesión
            </a>
            </div>
        </div>
    </div>
</nav>
       <main class="container py-5"
    style="max-width: 1140px;">

    <h1 class="fw-bold">Mi empresa</h1>

    <p class="text-secondary mb-4">
        Administrá tu perfil empresarial
        y tus ofertas laborales.
    </p>

    <asp:Label ID="lblMensaje"
        runat="server"
        Visible="false"
        CssClass="alert alert-danger d-block">
    </asp:Label>
           </main>


        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8 col-md-10">

                    <div class="card shadow-sm border-0">
                        <div class="card-body p-4 p-md-5">

                            <!-- Título -->
                            <div class="text-center mb-4">
                                <h2 class="fw-bold text-primary">Registrar Oferta Laboral</h2>
                                <p class="text-secondary">
                                    Complete los datos para publicar una nueva oferta laboral.
                                </p>
                            </div>

                            <!-- Formulario Oferta Laboral -->
                            <asp:Panel ID="pnlOfertaLaboral" runat="server">

                                <div class="row g-3">

                                    <!-- Título de la oferta -->
                                    <div class="col-12">
                                        <label for="<%= txtTituloOferta.ClientID %>"
                                            class="form-label text-secondary fw-semibold">
                                            Título de la oferta
                                        </label>

                                        <asp:TextBox ID="txtTituloOferta" runat="server"
                                            CssClass="form-control"
                                            placeholder="Ej: Desarrollador Junior">
                                        </asp:TextBox>

                                     <asp:RequiredFieldValidator
                                        ID="rfvTituloOferta"
                                        runat="server"
                                        ControlToValidate="txtTituloOferta"
                                        ErrorMessage="El título de la oferta es obligatorio."
                                        Display="Dynamic"
                                        CssClass="text-danger small"
                                        ValidationGroup="Oferta">
                                    </asp:RequiredFieldValidator>

                                    <asp:RegularExpressionValidator
                                        ID="revTituloOferta"
                                        runat="server"
                                        ControlToValidate="txtTituloOferta"
                                        ValidationExpression=".{5,}"
                                        ErrorMessage="El título debe tener al menos 5 caracteres."
                                        Display="Dynamic"
                                        CssClass="text-danger small"
                                        ValidationGroup="Oferta">
                                    </asp:RegularExpressionValidator>
                                    </div>

                                    <!-- Zona -->
                                    <div class="col-md-6">
                                        <label for="<%= txtZona.ClientID %>"
                                            class="form-label text-secondary fw-semibold">
                                            Zona
                                        </label>

                                        <asp:TextBox ID="txtZona" runat="server"
                                            CssClass="form-control"
                                            placeholder="Ej: Bahía Blanca">
                                        </asp:TextBox>

                                        <asp:RequiredFieldValidator
                                        ID="rfvZona"
                                        runat="server"
                                        ControlToValidate="txtZona"
                                        ErrorMessage="La zona es obligatoria."
                                        Display="Dynamic"
                                        CssClass="text-danger small"
                                        ValidationGroup="Oferta">
                                    </asp:RequiredFieldValidator>
                                    </div>

                                    <!-- Tipo de jornada -->
                                    <div class="col-md-6">
                                        <label for="<%= ddlTipoJornada.ClientID %>"
                                            class="form-label text-secondary fw-semibold">
                                            Tipo de jornada
                                        </label>

                                        <asp:DropDownList ID="ddlTipoJornada" runat="server"
                                            CssClass="form-select">

                                            <asp:ListItem Text="Seleccione una opción" Value="" />
                                            <asp:ListItem Text="Part-time" Value="Part-time" />
                                            <asp:ListItem Text="Full-time" Value="Full-time" />
                                          

                                        </asp:DropDownList>

                                        <asp:RequiredFieldValidator
                                        ID="rfvTipoJornada"
                                        runat="server"
                                        ControlToValidate="ddlTipoJornada"
                                        InitialValue=""
                                        ErrorMessage="Debe seleccionar un tipo de jornada."
                                        Display="Dynamic"
                                        CssClass="text-danger small"
                                        ValidationGroup="Oferta">
                                    </asp:RequiredFieldValidator>

                                    </div>

                                    <!-- Descripción -->
                                    <div class="col-12">
                                        <label for="<%= txtDescripcion.ClientID %>"
                                            class="form-label text-secondary fw-semibold">
                                            Descripción
                                        </label>

                                        <asp:TextBox ID="txtDescripcion" runat="server"
                                            TextMode="MultiLine"
                                            Rows="5"
                                            CssClass="form-control"
                                            placeholder="Describa las tareas, responsabilidades y requisitos del puesto...">
                                        </asp:TextBox>


                                        <asp:RequiredFieldValidator
                                        ID="rfvDescripcion"
                                        runat="server"
                                        ControlToValidate="txtDescripcion"
                                        ErrorMessage="La descripción es obligatoria."
                                        Display="Dynamic"
                                        CssClass="text-danger small"
                                        ValidationGroup="Oferta">
                                    </asp:RequiredFieldValidator>

                                    <asp:RegularExpressionValidator
                                        ID="revDescripcion"
                                        runat="server"
                                        ControlToValidate="txtDescripcion"
                                        ValidationExpression="[\s\S]{10,}"
                                        ErrorMessage="La descripción debe tener al menos 10 caracteres."
                                        Display="Dynamic"
                                        CssClass="text-danger small"
                                        ValidationGroup="Oferta">
                                    </asp:RegularExpressionValidator>
                                    </div>

                                    <!-- Acepta discapacidad -->
                                    <div class="col-12">
                                        <div class="form-check mt-2">

                                            <asp:CheckBox ID="chkAceptaDiscapacidad" runat="server"
                                                CssClass="form-check-input" />

                                            <label for="<%= chkAceptaDiscapacidad.ClientID %>"
                                                class="form-check-label text-secondary fw-semibold">
                                                Acepta postulantes con discapacidad
                                            </label>

                                        </div>
                                    </div>


                                    <asp:ValidationSummary
                                    ID="vsOferta"
                                    runat="server"
                                    HeaderText="Por favor, corrija los siguientes errores:"
                                    CssClass="alert alert-danger mt-3"
                                    ValidationGroup="Oferta"
                                    DisplayMode="BulletList" />


                                    <!-- Requisitos de la oferta -->
                                        <div class="col-12">
                                            <label class="form-label text-secondary fw-semibold">
                                                Requisitos del puesto
                                            </label>

                                            <div id="contenedorRequisitos">
                                                <div class="input-group mb-2 requisito-item">
                                                    <input type="text"
                                                           name="requisitos"
                                                           class="form-control"
                                                           maxlength="255"
                                                           placeholder="Ej: Experiencia mínima de 1 año" />
                                                </div>
                                            </div>

                                            <button type="button"
                                                    class="btn btn-outline-primary btn-sm mt-2"
                                                    onclick="agregarRequisito()">
                                                + Agregar otro requisito
                                            </button>

                                            <p class="text-muted small mt-2">
                                                Podés agregar tantos requisitos como necesites.
                                            </p>
                                        </div>

                                    <!-- Botón Registrar -->
                                    <div class="col-12 mt-4">
                                        <asp:Button ID="btnRegistrarOferta" runat="server"
                                            Text="Registrar Oferta"
                                            CssClass="btn btn-primary w-100 py-2 fw-semibold"
                                            OnClick="btnRegistrarOferta_Click"
                                            ValidationGroup="Oferta" />
                                    </div>
                                </div>
                            </asp:Panel>




                        </div>
                    </div>

                </div>
            </div>
        </div>

    </form>
                <script>
                function agregarRequisito() {
                    const contenedor = document.getElementById("contenedorRequisitos");

                    const div = document.createElement("div");
                    div.className = "input-group mb-2 requisito-item";

                    const input = document.createElement("input");
                    input.type = "text";
                    input.name = "requisitos";
                    input.className = "form-control";
                    input.maxLength = 255;
                    input.placeholder = "Escribí otro requisito";

                    const boton = document.createElement("button");
                    boton.type = "button";
                    boton.className = "btn btn-outline-danger";
                    boton.textContent = "Eliminar";

                    boton.addEventListener("click", function () {
                        div.remove();
                    });

                    div.appendChild(input);
                    div.appendChild(boton);
                    contenedor.appendChild(div);

                    input.focus();
                }
            </script>

</body>
</html>
