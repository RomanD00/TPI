<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MiEmpresa.aspx.cs" Inherits="CVJoven.MiEmpresa" %>

<!DOCTYPE html>

<html lang="es">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <title>Mi empresa | CVJoven</title>

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

            <asp:Label ID="lblMensaje"
                runat="server"
                Visible="false"
                CssClass="alert alert-danger d-block">
            </asp:Label>

        <div class="container-fluid">
            <div class="row">

            <!-- PERFIL DE LA EMPRESA -->
            <div class="card border-0 shadow-sm rounded-4 mb-4">

                <div class="card-body p-4">

                    <div class="d-flex align-items-center gap-3 mb-4">

                        <div class="bg-primary-subtle text-primary
                            rounded-3 p-3">

                            <i class="bi bi-buildings fs-1"></i>

                        </div>

                        <div>
                            <h2 class="h3 fw-bold mb-1">
                                <asp:Label ID="lblNombreEmpresa"
                                    runat="server" />
                            </h2>

                            <span class="text-secondary">
                                Perfil empresarial
                            </span>
                        </div>

                    </div>

                    <hr />

                    <div class="row g-4 mt-2">

                        <div class="col-md-6">
                            <p class="text-secondary mb-1">
                                Nombre legal
                            </p>
                            <asp:Label ID="lblNombreLegal"
                                runat="server" CssClass="fw-semibold" />
                        </div>

                        <div class="col-md-6">
                            <p class="text-secondary mb-1">
                                Nombre comercial
                            </p>
                            <asp:Label ID="lblNombreComercial"
                                runat="server" CssClass="fw-semibold" />
                        </div>

                        <div class="col-md-6">
                            <p class="text-secondary mb-1">CUIT</p>

                            <asp:Label ID="lblCUIT"
                                runat="server" CssClass="fw-semibold" />
                        </div>

                        <div class="col-md-6">
                            <p class="text-secondary mb-1">Sector</p>

                            <asp:Label ID="lblSector"
                                runat="server" CssClass="fw-semibold" />
                        </div>

                        <div class="col-md-6">
                            <p class="text-secondary mb-1">
                                Tamaño de empresa
                            </p>
                            <asp:Label ID="lblTamanio"
                                runat="server" CssClass="fw-semibold" />
                        </div>

                        <div class="col-md-6">
                            <p class="text-secondary mb-1">
                                Correo electrónico
                            </p>
                            <asp:Label ID="lblMail"
                                runat="server" CssClass="fw-semibold" />
                        </div>

                        <div class="col-md-6">
                            <p class="text-secondary mb-1">
                                Correo de Recursos Humanos
                            </p>
                            <asp:Label ID="lblCorreoRRHH"
                                runat="server" CssClass="fw-semibold" />
                        </div>

                        <div class="col-md-6">
                            <p class="text-secondary mb-1">
                                Página web
                            </p>
                            <asp:Label ID="lblPaginaWeb"
                                runat="server" CssClass="fw-semibold" />
                        </div>

                    </div>

                    <div class="text-end mt-4">

                    <asp:Button ID="btnEditarPerfil"
                        runat="server"
                        Text="Editar perfil"
                        CausesValidation="false"
                        OnClick="btnEditarPerfil_Click"
                        CssClass="btn btn-primary px-4" />

                    </div>

                </div>
            </div>

<!-- OFERTAS LABORALES -->
<div class="card border-0 shadow-sm rounded-4">

    <div class="card-body p-4">

        <div class="d-flex flex-wrap justify-content-between
            align-items-center gap-3 mb-4">

            <div>
                <h3 class="h4 fw-bold">
                    Mis ofertas laborales
                </h3>

                <p class="text-secondary mb-0">
                    Administrá las ofertas publicadas por tu empresa.
                </p>
            </div>

            <a href="RegistrarOfertaLaboral.aspx"
                class="btn btn-primary">

                <i class="bi bi-plus-lg"></i>
                Nueva oferta

            </a>

        </div>

        <!-- ESTADISTICAS -->
        <div class="row g-3 mb-4">

            <div class="col-md-4">
                <div class="border rounded-3 p-3">
                    <p class="text-secondary mb-1">
                        Total de ofertas
                    </p>

                    <asp:Label ID="lblTotalOfertas"
                        runat="server"
                        CssClass="fs-2 fw-bold text-primary" />
                </div>
            </div>

            <div class="col-md-4">
                <div class="border rounded-3 p-3">
                    <p class="text-secondary mb-1">
                        Ofertas activas
                    </p>

                    <asp:Label ID="lblOfertasActivas"
                        runat="server"
                        CssClass="fs-2 fw-bold text-success" />
                </div>
            </div>

            <div class="col-md-4">
                <div class="border rounded-3 p-3">

                    <p class="text-secondary mb-1">
                        Postulaciones
                    </p>

                    <asp:Label ID="lblTotalPostulaciones"
                        runat="server"
                        CssClass="fs-2 fw-bold text-primary" />
                </div>
            </div>

        </div>

        <!-- LISTADO DE OFERTAS -->
        <asp:Repeater ID="rptMisOfertas"
                    runat="server"
                    OnItemCommand="rptMisOfertas_ItemCommand">

            <ItemTemplate>

                <div class="border rounded-3 p-4 mb-3">

                    <div class="d-flex justify-content-between
                        align-items-center gap-2">

                        <h4 class="h5 fw-bold">

                            <%#: Eval("TituloOferta") %>

                        </h4>

                        <span class='<%# ObtenerClaseEstado(
                            Eval("EstadoOferta").ToString()) %>'>

                            <%#: Eval("EstadoOferta") %>

                        </span>

                    </div>

                    <p class="text-secondary mb-2">

                        <i class="bi bi-geo-alt"></i>

                        <%#: Eval("Zona") %>

                        &nbsp; | &nbsp;

                        <%#: Eval("TipoDeJornada") %>

                    </p>

                    <p class="text-secondary mb-2">

                        <i class="bi bi-calendar3"></i>

                        Publicada el

                        <%#: Eval("FechaPublicacion", "{0:dd/MM/yyyy}") %>

                    </p>

                    <p class="text-primary fw-semibold">

                        <i class="bi bi-people"></i>

                        <%#: Eval("CantidadPostulaciones") %>
                        postulaciones

                    </p>

                    <hr />

                    <div class="d-flex flex-wrap gap-2">

                        <asp:Button ID="btnVerCandidatos"
                            runat="server"
                            Text="Ver candidatos"
                            CommandName="VerCandidatos"
                            CommandArgument='<%# Eval("IdOferta") %>'
                            CausesValidation="false"
                            CssClass="btn btn-primary btn-sm" />

                        <asp:Button ID="btnEditarOferta"
                            runat="server"
                            Text="Editar"
                            CommandName="EditarOferta"
                            CommandArgument='<%# Eval("IdOferta") %>'
                            CausesValidation="false"
                            Visible='<%# Eval("EstadoOferta").ToString() == "Activa" %>'
                            CssClass="btn btn-outline-secondary btn-sm" />

                        <asp:Button ID="btnCancelarOferta"
                            runat="server"
                            Text="Cancelar oferta"
                            CommandName="CancelarOferta"
                            CommandArgument='<%# Eval("IdOferta") %>'
                            CausesValidation="false"
                            Visible='<%# Eval("EstadoOferta").ToString() == "Activa" %>'
                            CssClass="btn btn-outline-danger btn-sm" />

                    </div>

                </div>

            </ItemTemplate>

        </asp:Repeater>

        <!-- SIN OFERTAS -->
        <asp:Panel ID="pnlSinOfertas"
            runat="server"
            Visible="false"
            CssClass="text-center bg-light rounded-3 py-5">

            <i class="bi bi-clipboard-data fs-1 text-secondary"></i>

            <h5 class="mt-3">
                Todavía no publicaste ofertas laborales
            </h5>

            <p class="text-secondary">
                Publicá tu primera oferta para comenzar
                a recibir postulaciones.
            </p>

        </asp:Panel>

    </div>

</div>

        </main>


        <!-- MODAL EDITAR PERFIL -->

<div class="modal fade" id="modalEditarPerfil"
    tabindex="-1" aria-hidden="true"
    aria-labelledby="tituloEditarPerfil">

    <div class="modal-dialog modal-lg modal-dialog-centered
        modal-dialog-scrollable">

        <div class="modal-content border-0 shadow rounded-4">

            <div class="modal-header">

                <h5 class="modal-title fw-bold"
                    id="tituloEditarPerfil">
                    Editar perfil empresarial
                </h5>

                <button type="button"
                    class="btn-close"
                    data-bs-dismiss="modal"
                    aria-label="Cerrar">
                </button>

            </div>

            <div class="modal-body">

                <div class="row g-3">

                    <div class="col-md-6">
                        <asp:Label runat="server"
                            AssociatedControlID="txtNombreLegal"
                            CssClass="form-label"
                            Text="Nombre legal" />

                        <asp:TextBox ID="txtNombreLegal"
                            runat="server"
                            MaxLength="150"
                            CssClass="form-control" />
                    </div>

                    <div class="col-md-6">
                        <asp:Label runat="server"
                            AssociatedControlID="txtNombreComercial"
                            CssClass="form-label"
                            Text="Nombre comercial" />

                        <asp:TextBox ID="txtNombreComercial"
                            runat="server"
                            MaxLength="150"
                            CssClass="form-control" />
                    </div>

                    <div class="col-md-6">
                        <asp:Label runat="server"
                            AssociatedControlID="txtCUIT"
                            CssClass="form-label"
                            Text="CUIT" />

                        <asp:TextBox ID="txtCUIT"
                            runat="server"
                            MaxLength="20"
                            CssClass="form-control" />
                    </div>

                    <div class="col-md-6">
                        <asp:Label runat="server"
                            AssociatedControlID="txtSector"
                            CssClass="form-label"
                            Text="Sector" />

                        <asp:TextBox ID="txtSector"
                            runat="server"
                            MaxLength="100"
                            CssClass="form-control" />
                    </div>

                    <div class="col-12">
                        <asp:Label runat="server"
                            AssociatedControlID="ddlTamanio"
                            CssClass="form-label"
                            Text="Tamaño de empresa" />

                        <asp:DropDownList ID="ddlTamanio"
                            runat="server"
                            CssClass="form-select">

                            <asp:ListItem Text="Pyme" Value="Pyme" />
                            <asp:ListItem Text="Mediana" Value="Mediana" />
                            <asp:ListItem Text="Grande" Value="Grande" />

                        </asp:DropDownList>
                    </div>

                    <div class="col-12">
                        <asp:Label runat="server"
                            AssociatedControlID="txtMail"
                            CssClass="form-label"
                            Text="Correo electrónico" />

                        <asp:TextBox ID="txtMail"
                            runat="server"
                            TextMode="Email"
                            MaxLength="150"
                            CssClass="form-control" />
                    </div>

                    <div class="col-12">
                        <asp:Label runat="server"
                            AssociatedControlID="txtCorreoRRHH"
                            CssClass="form-label"
                            Text="Correo de Recursos Humanos" />

                        <asp:TextBox ID="txtCorreoRRHH"
                            runat="server"
                            TextMode="Email"
                            MaxLength="150"
                            CssClass="form-control" />
                    </div>

                    <div class="col-12">
                        <asp:Label runat="server"
                            AssociatedControlID="txtPaginaWeb"
                            CssClass="form-label"
                            Text="Página web (opcional)" />

                        <asp:TextBox ID="txtPaginaWeb"
                            runat="server"
                            MaxLength="255"
                            CssClass="form-control" />
                    </div>

                </div>

                <asp:Label ID="lblErrorEdicion"
                    runat="server"
                    Visible="false"
                    CssClass="alert alert-danger d-block mt-3" />

            </div>

            <div class="modal-footer">

                <button type="button"
                    class="btn btn-secondary"
                    data-bs-dismiss="modal">
                    Cancelar
                </button>

                <asp:Button ID="btnGuardarCambios"
                    runat="server"
                    Text="Guardar cambios"
                    OnClick="btnGuardarCambios_Click"
                    CssClass="btn btn-primary" />

            </div>

        </div>

    </div>

</div>


        <!-- MODAL EDITAR OFERTA LABORAL -->

<div class="modal fade" id="modalEditarOferta"
    tabindex="-1" aria-hidden="true"
    aria-labelledby="tituloModalOferta">

    <div class="modal-dialog modal-lg modal-dialog-centered
        modal-dialog-scrollable">

        <div class="modal-content border-0 shadow rounded-4">

            <div class="modal-header">

                <h5 class="modal-title fw-bold" id="tituloModalOferta">
                    Editar oferta laboral
                </h5>

                <button type="button"
                    class="btn-close"
                    data-bs-dismiss="modal"
                    aria-label="Cerrar">
                </button>

            </div>

            <div class="modal-body">

                <div class="row g-3">

                    <div class="col-12">
                        <asp:Label runat="server"
                            AssociatedControlID="txtEditarTitulo"
                            CssClass="form-label"
                            Text="Título de la oferta" />

                        <asp:TextBox ID="txtEditarTitulo"
                            runat="server"
                            MaxLength="150"
                            CssClass="form-control" />
                    </div>

                    <div class="col-md-6">
                        <asp:Label runat="server"
                            AssociatedControlID="txtEditarZona"
                            CssClass="form-label"
                            Text="Zona" />

                        <asp:TextBox ID="txtEditarZona"
                            runat="server"
                            MaxLength="100"
                            CssClass="form-control" />
                    </div>

                    <div class="col-md-6">
                        <asp:Label runat="server"
                            AssociatedControlID="ddlEditarJornada"
                            CssClass="form-label"
                            Text="Tipo de jornada" />

                        <asp:DropDownList ID="ddlEditarJornada"
                            runat="server"
                            CssClass="form-select">

                            <asp:ListItem Text="Full-time"
                                Value="Full-time" />

                            <asp:ListItem Text="Part-time"
                                Value="Part-time" />

                        </asp:DropDownList>
                    </div>

                    <div class="col-12">
                        <asp:Label runat="server"
                            AssociatedControlID="txtEditarDescripcion"
                            CssClass="form-label"
                            Text="Descripción del puesto" />

                        <asp:TextBox ID="txtEditarDescripcion"
                            runat="server"
                            TextMode="MultiLine"
                            Rows="6"
                            CssClass="form-control" />
                    </div>

                    <div class="col-12">

                        <asp:CheckBox ID="chkEditarDiscapacidad"
                            runat="server"
                            Text=" Acepta personas con discapacidad" />

                    </div>

                </div>

                <asp:Label ID="lblErrorEditarOferta"
                    runat="server"
                    Visible="false"
                    CssClass="alert alert-danger d-block mt-3" />

            </div>

            <div class="modal-footer">

                <button type="button"
                    class="btn btn-secondary"
                    data-bs-dismiss="modal">
                    Cancelar
                </button>

                <asp:Button ID="btnGuardarOferta"
                    runat="server"
                    Text="Guardar cambios"
                    CausesValidation="false"
                    OnClick="btnGuardarOferta_Click"
                    CssClass="btn btn-primary" />

            </div>

        </div>

    </div>

</div>


        <!-- MODAL CANCELAR OFERTA -->

<div class="modal fade" id="modalCancelarOferta"
    tabindex="-1" aria-hidden="true"
    aria-labelledby="tituloCancelarOferta">

    <div class="modal-dialog modal-dialog-centered">

        <div class="modal-content border-0 shadow rounded-4">

            <div class="modal-header">

                <h5 class="modal-title fw-bold"
                    id="tituloCancelarOferta">
                    Cancelar oferta laboral
                </h5>

                <button type="button"
                    class="btn-close"
                    data-bs-dismiss="modal"
                    aria-label="Cerrar">
                </button>

            </div>

            <div class="modal-body">

                <div class="text-center mb-3">
                    <i class="bi bi-exclamation-triangle
                        text-warning display-4"></i>
                </div>

                <p class="fw-semibold">
                    ¿Estás seguro de que querés cancelar
                    esta oferta laboral?
                </p>

                <p class="text-secondary">
                    La oferta dejará de estar disponible
                    para los postulantes.
                </p>

                <p class="text-secondary">
                    Las postulaciones pendientes o en revisión
                    serán rechazadas.
                    Esta acción no se puede deshacer.
                </p>

                <asp:Label ID="lblErrorCancelarOferta"
                    runat="server"
                    Visible="false"
                    CssClass="alert alert-danger d-block mt-3" />

            </div>

            <div class="modal-footer">

                <button type="button"
                    class="btn btn-secondary"
                    data-bs-dismiss="modal">
                    Volver
                </button>

                <asp:Button ID="btnConfirmarCancelacion"
                    runat="server"
                    Text="Cancelar oferta"
                    CausesValidation="false"
                    OnClick="btnConfirmarCancelacion_Click"
                    CssClass="btn btn-danger" />

            </div>

        </div>

    </div>

</div>


    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js">
    </script>

</body>
</html>