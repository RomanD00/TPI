<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Candidatos.aspx.cs" Inherits="CVJoven.Candidatos" %>

<!DOCTYPE html>

<html lang="es">
<head runat="server">

    <meta charset="utf-8" />

    <meta name="viewport"
        content="width=device-width, initial-scale=1" />

    <title>Candidatos | CVJoven</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
        rel="stylesheet" />

    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css"
        rel="stylesheet" />

</head>

<body class="bg-light">

    <form id="form1" runat="server">


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

            <asp:Label ID="Label1"
                runat="server"
                Visible="false"
                CssClass="alert alert-danger d-block">
            </asp:Label>

                   <!--
        <main class="container py-5"
            style="max-width: 1000px;">
            -->

            <a href="MiEmpresa.aspx"
                class="text-decoration-none">

                <i class="bi bi-arrow-left"></i>
                Volver a mi empresa

            </a>

            <h1 class="fw-bold mt-4">
                Candidatos
            </h1>

            <asp:Label ID="lblMensaje"
                runat="server"
                Visible="false"
                CssClass="alert alert-danger d-block" />

            <asp:Panel ID="pnlCandidatos"
                runat="server"
                Visible="false">

                <p class="text-secondary">

                    Oferta laboral:

                    <asp:Label ID="lblTituloOferta"
                        runat="server"
                        CssClass="fw-semibold" />

                </p>

                <!-- ESTADISTICAS -->

                <div class="card border-0 shadow-sm rounded-4 mb-4">

                    <div class="card-body p-4">

                        <p class="text-secondary mb-1">
                            Total de postulaciones
                        </p>

                        <asp:Label ID="lblTotalCandidatos"
                            runat="server"
                            CssClass="fs-2 fw-bold text-primary" />

                    </div>

                </div>

                <!-- LISTADO DE CANDIDATOS -->

            <asp:Repeater ID="rptCandidatos" runat="server"
                OnItemCommand="rptCandidatos_ItemCommand">

                    <ItemTemplate>

                        <div class="card border-0 shadow-sm
                            rounded-4 mb-3">

                            <div class="card-body p-4">

                                <div class="d-flex
                                    justify-content-between
                                    align-items-center gap-3">

                                    <div class="d-flex
                                        align-items-center gap-3">

                                        <div class="bg-primary-subtle
                                            text-primary rounded-circle p-3">

                                            <i class="bi bi-person fs-3"></i>

                                        </div>

                                        <div>

                                            <h5 class="fw-bold mb-1">

                                                <%#: Eval("Nombre") %>
                                                <%#: Eval("Apellido") %>

                                            </h5>

                                            <span class="text-secondary">

                                                <%#: Eval("nombreDelCV") %>

                                            </span>

                                        </div>

                                    </div>

                                    <span class='<%# ObtenerClaseEstado(
                                        Eval("EstadoPostulacion").ToString()) %>'>

                                        <%#: Eval("EstadoPostulacion") %>

                                    </span>

                                </div>

                                <hr />

                                <p class="text-secondary">

                                    <i class="bi bi-calendar3"></i>

                                    Fecha de postulación:

                                    <%#: Eval("FechaPostulacion",
                                        "{0:dd/MM/yyyy}") %>

                                </p>

                                <div class="d-flex flex-wrap gap-2">

                                    <asp:HyperLink ID="btnVerCV"
                                        runat="server"
                                        Text="Ver currículum"
                                        NavigateUrl='<%# Eval("IdPostulacion",
                                            "VerCV.aspx?idPostulacion={0}") %>'
                                        CssClass="btn btn-primary btn-sm" />

                                <asp:Button ID="btnSeleccionar"
                                    runat="server"
                                    Text="Seleccionar candidato"
                                    CommandName="SeleccionarCandidato"
                                    CommandArgument='<%# Eval("IdPostulacion") %>'
                                    Visible='<%# PuedeSeleccionar(
                                        Eval("EstadoPostulacion").ToString()) %>'
                                    CausesValidation="false"
                                    CssClass="btn btn-outline-success btn-sm" />

                                </div>

                            </div>

                        </div>

                    </ItemTemplate>

                </asp:Repeater>

                <!-- SIN CANDIDATOS -->

                <asp:Panel ID="pnlSinCandidatos"
                    runat="server"
                    Visible="false"
                    CssClass="text-center bg-white rounded-4 p-5">

                    <i class="bi bi-people display-4 text-secondary"></i>

                    <h5 class="mt-3">
                        Todavía no hay candidatos
                    </h5>

                    <p class="text-secondary">
                        Esta oferta laboral aún no recibió postulaciones.
                    </p>

                </asp:Panel>

            </asp:Panel>

        </main>

        <div class="modal fade"
    id="modalSeleccionarCandidato"
    tabindex="-1"
    aria-hidden="true">

    <div class="modal-dialog modal-dialog-centered">

        <div class="modal-content">

            <div class="modal-header">

                <h5 class="modal-title">
                    Seleccionar candidato
                </h5>

                <button type="button"
                    class="btn-close"
                    data-bs-dismiss="modal">
                </button>

            </div>

            <div class="modal-body">

                <div class="text-center mb-4">

                    <i class="bi bi-person-check-fill
                        text-success display-4"></i>

                    <h4 class="mt-3">

                        <asp:Label ID="lblCandidatoSeleccionado"
                            runat="server" />

                    </h4>

                </div>

                <p class="fw-semibold">
                    ¿Estás seguro de que querés seleccionar
                    a este candidato?
                </p>

                <p>Al confirmar la selección:</p>

                <ul>
                    <li>El candidato será aceptado.</li>
                    <li>Las demás postulaciones pendientes
                        serán rechazadas.</li>
                    <li>La oferta laboral se cerrará.</li>
                    <li>No se recibirán nuevas postulaciones.</li>
                </ul>

                <div class="alert alert-warning">
                    Esta acción no se podrá revertir.
                </div>

                <asp:Label ID="lblErrorSeleccion"
                    runat="server"
                    Visible="false"
                    CssClass="alert alert-danger d-block" />

            </div>

            <div class="modal-footer">

                <button type="button"
                    class="btn btn-secondary"
                    data-bs-dismiss="modal">

                    Volver

                </button>

                <asp:Button ID="btnConfirmarSeleccion"
                    runat="server"
                    Text="Confirmar selección"
                    CssClass="btn btn-success"
                    CausesValidation="false"
                    OnClick="btnConfirmarSeleccion_Click" />

            </div>

        </div>

    </div>

</div>

    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js">
    </script>

</body>
</html>


