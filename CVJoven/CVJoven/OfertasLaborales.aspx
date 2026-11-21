<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="OfertasLaborales.aspx.cs" Inherits="CVJoven.OfertasLaborales" %>

<!DOCTYPE html>
<html lang="es">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>CVJoven - Ofertas Laborales</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body class="bg-light text-dark">
    <form id="form1" runat="server">
        
        <!-- 1. CABECERA SUPERIOR -->
        <header class="bg-white border-bottom px-4 d-flex align-items-center justify-content-between" style="height: 70px;">
            <div class="d-flex align-items-center gap-3">
                <a href="MisCurriculums.aspx" class="text-primary text-decoration-none fw-bold fs-4 d-flex align-items-center gap-2">
                    <i class="bi bi-file-earmark-person-fill"></i>
                    <span>CVJoven</span>
                </a>
               

            </div>

            <!-- Perfil de Usuario -->
            <div class="d-flex align-items-center gap-2">
                <div class="rounded-circle bg-primary bg-opacity-10 text-primary d-flex align-items-center justify-content-center fw-semibold" style="width: 38px; height: 38px;">
                    <i class="bi bi-person-fill fs-5"></i>
                </div>
                     <div class="d-flex flex-column">

                        <asp:Label
                            ID="lblNombreUsuario"
                            runat="server"
                            CssClass="fw-bold text-dark" />

                        <asp:Label
                            ID="lblEmailUsuario"
                            runat="server"
                            CssClass="text-secondary small" />

                    </div>

            </div>
        </header>

         <div class="container-fluid">

            <div class="row">
        <!-- MENÚ LATERAL -->
<aside class="col-12 col-lg-2 bg-white border-end p-4"
       style="min-height: calc(100vh - 70px);">

    <p class="text-secondary small fw-bold mb-3">
        MENÚ PRINCIPAL
    </p>

    <div class="nav flex-column nav-pills gap-2">

        <a href="MisCurriculums.aspx"
           class="nav-link text-secondary">

            <i class="bi bi-file-earmark-text me-2"></i>
            Mis currículums
        </a>

        <a href="OfertasLaborales.aspx"
           class="nav-link active"
           aria-current="page">

            <i class="bi bi-briefcase me-2"></i>
            Ofertas laborales
        </a>

        <a href="MisPostulaciones.aspx"
           class="nav-link text-secondary">

            <i class="bi bi-send me-2"></i>
            Mis postulaciones
        </a>

    </div>

    <hr class="my-4" />

    <p class="text-secondary small fw-bold">
        MI CUENTA
    </p>

    <div class="nav flex-column gap-2">

        <a href="MiPerfil.aspx" class="nav-link text-secondary">
    <i class="bi bi-person me-2"></i>
    Mi perfil
</a>
<a href="Logout.aspx" class="nav-link text-danger">
    <i class="bi bi-box-arrow-right me-2"></i>
    Cerrar sesión
</a>

    </div>

    <div class="card bg-primary-subtle border-0 mt-5">

        <div class="card-body">

            <h6 class="fw-bold text-primary">
                Tu futuro empieza acá
            </h6>

            <p class="small text-secondary mb-0">
                Creá tu currículum profesional
                y preparate para tu próxima
                oportunidad laboral.
            </p>

        </div>

    </div>

</aside>

<!-- CONTENIDO PRINCIPAL -->
<div class="col-12 col-lg-10">


        <!-- 2. BARRA DE BÚSQUEDA Y FILTROS -->
        <section class="bg-white border-bottom py-3 px-3 px-lg-4 shadow-sm">
            <div class="container-fluid">
                <div class="row g-3 align-items-center">
                    
                    <!-- Buscador -->
                    <div class="col-12 col-lg-4">
                        <div class="input-group">
                            <asp:TextBox ID="txtBuscar" runat="server" CssClass="form-control bg-light rounded-start-pill ps-3 border-end-0" placeholder="Buscar puesto, empresa..."></asp:TextBox>
                            <asp:LinkButton ID="btnBuscar" runat="server" CssClass="btn btn-primary rounded-end-pill px-4" OnClick="btnBuscar_Click">
                                <i class="bi bi-search"></i>
                            </asp:LinkButton>
                        </div>
                    </div>

                    <!-- Filtros -->
                    <div class="col-12 col-lg-8">
                        <div class="row g-2">
                            <!-- Tiempo de publicación -->
                            <div class="col-6 col-md-3">
                                <asp:DropDownList ID="ddlTiempoPublicacion" runat="server" CssClass="form-select form-select-sm rounded-3 text-secondary" AutoPostBack="true" OnSelectedIndexChanged="Filtros_SelectedIndexChanged">
                                    <asp:ListItem Value="" Text="Publicación"></asp:ListItem>
                                    <asp:ListItem Value="1" Text="Últimas 24 hs"></asp:ListItem>
                                    <asp:ListItem Value="7" Text="Última semana"></asp:ListItem>
                                    <asp:ListItem Value="30" Text="Último mes"></asp:ListItem>
                                </asp:DropDownList>
                            </div>

                            <!-- Ubicación -->
                            <div class="col-6 col-md-3">
                                <asp:DropDownList ID="ddlUbicacion" runat="server" CssClass="form-select form-select-sm rounded-3 text-secondary" AutoPostBack="true" OnSelectedIndexChanged="Filtros_SelectedIndexChanged">
                                    <asp:ListItem Value="" Text="Ubicación"></asp:ListItem>
                                    <asp:ListItem Value="Remoto" Text="Remoto"></asp:ListItem>
                                    <asp:ListItem Value="CABA" Text="CABA"></asp:ListItem>
                                    <asp:ListItem Value="GBA" Text="GBA Norte"></asp:ListItem>
                                    <asp:ListItem Value="Interior" Text="Interior"></asp:ListItem>
                                </asp:DropDownList>
                            </div>

                            <!-- Tamaño de la empresa -->
                                   <!--  NO EXISTE LA EMPRESA de tipo STARTUP EN la BASE DE DATOS -->
                            <div class="col-6 col-md-3">
                                <asp:DropDownList ID="ddlTamanoEmpresa" runat="server" CssClass="form-select form-select-sm rounded-3 text-secondary" AutoPostBack="true" OnSelectedIndexChanged="Filtros_SelectedIndexChanged">
                                    <asp:ListItem Value="" Text="Tamaño empresa"></asp:ListItem>
                                    <asp:ListItem Value="Pyme" Text="Pyme (21-100)"></asp:ListItem>
                                    <asp:ListItem Value="Mediana" Text="Mediana (101-500)"></asp:ListItem>
                                    <asp:ListItem Value="Grande" Text="Corporación (500+)"></asp:ListItem>
                                </asp:DropDownList>
                            </div>

                            <!-- Área de interés -->
                            <div class="col-6 col-md-3">
                                <asp:DropDownList ID="ddlAreaInteres" runat="server" CssClass="form-select form-select-sm rounded-3 text-secondary" AutoPostBack="true" OnSelectedIndexChanged="Filtros_SelectedIndexChanged">
                                    <asp:ListItem Value="" Text="Área de interés"></asp:ListItem>
                                    <asp:ListItem Value="IT" Text="Tecnología / IT"></asp:ListItem>
                                    <asp:ListItem Value="Marketing" Text="Marketing / E-comm"></asp:ListItem>
                                    <asp:ListItem Value="Diseno" Text="Diseño UX/UI"></asp:ListItem>
                                    <asp:ListItem Value="Admin" Text="Administración"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </section>



        <!-- 3. LISTADO DE OFERTAS LABORALES -->
        <main class="container-fluid py-4 px-3 px-lg-4">
            
                        <asp:Label ID="lblMensajePostulacion"
                        runat="server"
                        Visible="false"
                        CssClass="d-block mt-3">
                    </asp:Label>
            <!--  Panel de OFERTA LABORAL -->
                                        <asp:Panel ID="pnlDetalleOferta" runat="server"
                                Visible="false"
                                CssClass="card border-0 shadow-sm rounded-4 p-4 my-4">

                                <div class="d-flex justify-content-between align-items-start mb-3">
                                    <h3 class="h4 fw-bold">Detalle de la oferta laboral</h3>

                                    <asp:Button ID="btnCerrarDetalle" runat="server"
                                        Text="Cerrar"
                                        CssClass="btn btn-outline-secondary btn-sm"
                                        CausesValidation="false"
                                        OnClick="btnCerrarDetalle_Click" />
                                </div>

                                <h4>
                                    <asp:Label ID="lblTituloDetalle" runat="server" />
                                </h4>

                                <p class="text-primary fw-semibold">
                                    <asp:Label ID="lblEmpresaDetalle" runat="server" />
                                </p>

                                <hr />

                                <p><strong>Zona:</strong>
                                    <asp:Label ID="lblZonaDetalle" runat="server" />
                                </p>

                                <p><strong>Jornada:</strong>
                                    <asp:Label ID="lblJornadaDetalle" runat="server" />
                                </p>

                                <p><strong>Sector:</strong>
                                    <asp:Label ID="lblSectorDetalle" runat="server" />
                                </p>

                                <p><strong>Tamaño de empresa:</strong>
                                    <asp:Label ID="lblTamanoDetalle" runat="server" />
                                </p>

                                <p><strong>Acepta discapacidad:</strong>
                                    <asp:Label ID="lblDiscapacidadDetalle" runat="server" />
                                </p>

                                <h5 class="fw-bold mt-3">Descripción del puesto</h5>

                                <p class="text-secondary">
                                    <asp:Label ID="lblDescripcionDetalle" runat="server" />
                                </p>

                                <h5 class="fw-bold mt-3">Requisitos</h5>

                                <asp:Repeater ID="rptRequisitos" runat="server">
                                    <HeaderTemplate>
                                        <ul class="list-group list-group-flush mb-3">
                                    </HeaderTemplate>

                                    <ItemTemplate>
                                        <li class="list-group-item">
                                            <%#: Eval("Descripcion") %>
                                        </li>
                                    </ItemTemplate>

                                    <FooterTemplate>
                                        </ul>
                                    </FooterTemplate>
                                </asp:Repeater>

                                <asp:Label ID="lblSinRequisitos" runat="server"
                                    Text="No se especificaron requisitos para esta oferta."
                                    CssClass="text-muted"
                                    Visible="false" />

                            </asp:Panel>

            <!-- Título y contador -->
            <div class="d-flex flex-wrap justify-content-between align-items-end mb-4">
                <div>
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb mb-1 small text-muted">
                            <li class="breadcrumb-item"><a href="MisCurriculums.aspx" class="text-decoration-none text-muted">Mi espacio</a></li>
                            <li class="breadcrumb-item active text-secondary" aria-current="page">Ofertas laborales</li>
                        </ol>
                    </nav>
                    <h1 class="h3 fw-bold mb-1 text-dark">Ofertas laborales disponibles</h1>
                    <p class="text-muted small mb-0">Explorá vacantes pensadas para tu perfil y postulate con un clic.</p>
                </div>
                <div class="text-muted small mt-2 mt-md-0">
                    Mostrando <strong><asp:Label ID="lblCantidadOfertas" runat="server" Text="3"></asp:Label></strong> oportunidades
                </div>
            </div>

            <!-- Contenedor de Ofertas (Repeater) -->
            <asp:Repeater ID="rptOfertas" runat="server" OnItemCommand="rptOfertas_ItemCommand">
                <ItemTemplate>
                    <div class="card border rounded-4 p-4 mb-3 shadow-sm bg-white border-light-subtle">
                        <div class="row align-items-center g-3">
                            
                            <!-- Ícono de Empresa -->
                            <div class="col-auto">
                                <div class="bg-primary bg-opacity-10 text-primary rounded-3 d-flex align-items-center justify-content-center" style="width: 52px; height: 52px; font-size: 1.5rem;">
                                    <i class="bi bi-building"></i>
                                </div>
                            </div>

                            <!-- Información de la Oferta -->
                            <div class="col">
                                <div class="d-flex flex-wrap align-items-center gap-2 mb-1">
                                    <h2 class="h5 fw-bold mb-0 text-dark"><%# Eval("TituloOferta") %></h2>
                                    <span class="badge bg-primary bg-opacity-10 text-primary fw-medium px-2 py-1"><%# Eval("Zona") %></span>
                                </div>
                                
                                <div class="text-secondary fw-semibold small mb-2">
                                    <%# Eval("Empresa") %>
                                </div>
                                 <!-- Información de si acepta discapacidad-->
                                <div class="d-flex flex-wrap align-items-center gap-2 mb-1">
                                <span class="badge bg-light text-secondary border fw-normal">
                                Acepta discapacidad:
                                <%# Eval("AceptaDiscapacidad") %>
                            </span>
                                    </div>

                                <!-- Badges de filtros -->
                                <div class="d-flex flex-wrap gap-2">
                                    <span class="badge bg-light text-secondary border fw-normal">
                                        <i class="bi bi-geo-alt me-1"></i><%# Eval("Ubicacion") %>
                                    </span>
                                    <span class="badge bg-light text-secondary border fw-normal">
                                        <i class="bi bi-people me-1"></i><%# Eval("TamanoEmpresa") %>
                                    </span>
                                    <!-- NO EXISTE FECHA DE PUBLICACIÓN EN LA OFERTA. 
                                        SOLO ESTA LA FECHA EN LA POSTULACIÓN -->
         
                                </div>
                            </div>

                            <!-- Botones -->
                            <div class="col-12 col-md-auto text-md-end border-top border-md-0 pt-3 pt-md-0">
                                <div class="d-flex flex-row flex-md-column gap-2 justify-content-end">
                                    <asp:Button ID="btnPostular" runat="server" 
                                        Text="Postularme" 
                                        CommandName="Postular" 
                                        CommandArgument='<%# Eval("IdOferta") %>' 
                                        CssClass="btn btn-primary btn-sm fw-medium px-4 py-2" 
                                        />
                                    
                                    <asp:LinkButton ID="btnVerDetalle" runat="server" 
                                        CommandName="VerDetalle" 
                                        CommandArgument='<%# Eval("IdOferta") %>' 
                                        CssClass="btn btn-outline-secondary btn-sm border-0 text-muted">
                                        Ver detalles
                                    </asp:LinkButton>
                                </div>
                            </div>

                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>

            
<!-- MODAL DE POSTULACIÓN -->
<div class="modal fade" id="modalPostulacion"
     tabindex="-1" aria-hidden="true">

    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 shadow rounded-4">

            <div class="modal-header">
                <h5 class="modal-title fw-bold">
                    Postularme a la oferta
                </h5>

                <button type="button"
                        class="btn-close"
                        data-bs-dismiss="modal"
                        aria-label="Cerrar">
                </button>
            </div>

            <div class="modal-body">

                <p class="text-secondary">
                    Seleccioná el currículum que querés
                    enviar a la empresa.
                </p>

                <asp:DropDownList
                    ID="ddlCurriculums"
                    runat="server"
                    CssClass="form-select">
                </asp:DropDownList>

                <asp:HiddenField
                    ID="hfIdOferta"
                    runat="server" />
                <asp:Label
    ID="lblErrorModalPostulacion"
    runat="server"
    Visible="false"
    CssClass="alert alert-danger d-block mt-3">
</asp:Label>

            </div>

            <div class="modal-footer">

                <button type="button"
                        class="btn btn-secondary"
                        data-bs-dismiss="modal">
                    Cancelar
                </button>

                <asp:Button
                    ID="btnConfirmarPostulacion"
                    runat="server"
                    Text="Confirmar postulación"
                    CssClass="btn btn-primary"
                    OnClick="btnConfirmarPostulacion_Click" />

            </div>

        </div>
    </div>
</div>

       

            <!-- Alerta sin resultados -->
            <asp:Panel ID="pnlSinResultados" runat="server" Visible="false" class="alert alert-info border-0 bg-info bg-opacity-10 text-info d-flex align-items-center gap-2 mt-3">
                <i class="bi bi-info-circle-fill"></i>
                <span>No encontramos ofertas laborales que coincidan con los filtros seleccionados.</span>
            </asp:Panel>

        </main>
    </div> <!-- Fin de la columna derecha -->
    </div> <!-- Fin de la fila -->
    </div> <!-- Fin del contenedor general -->
    </form>

</body>
</html>