<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MisPostulaciones.aspx.cs" Inherits="CVJoven.MisPostulaciones" %>

<!DOCTYPE html>
<html lang="es">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Mis postulaciones | CVJoven</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet" />
</head>
<body class="bg-light">
    <form id="form1" runat="server">
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
                <aside class="col-lg-2 bg-white border-end min-vh-100 p-4">
                    <p class="text-secondary small fw-bold mb-3">MENÚ PRINCIPAL</p>
                    <div class="nav flex-column nav-pills gap-2">
                        <a href="MisCurriculums.aspx" class="nav-link text-secondary">
                            <i class="bi bi-file-earmark-text me-2"></i>Mis currículums
                        </a>
                        <a href="OfertasLaborales.aspx" class="nav-link text-secondary">
                            <i class="bi bi-briefcase me-2"></i>Ofertas laborales
                        </a>
                        <a href="MisPostulaciones.aspx" class="nav-link active">
                            <i class="bi bi-send me-2"></i>Mis postulaciones
                        </a>
                    </div>

                    <hr class="my-4" />

                    <p class="text-secondary small fw-bold">MI CUENTA</p>
                    <div class="nav flex-column gap-2">
                        <a href="MiPerfil.aspx" class="nav-link text-secondary">
                            <i class="bi bi-person me-2"></i>Mi perfil
                        </a>
                    </div>
                </aside>

                <!-- CONTENIDO PRINCIPAL -->
                <main class="col-lg-10 p-4 p-lg-5">
                    <div class="container-fluid">
                        <div class="d-flex flex-wrap justify-content-between align-items-center gap-3 mb-4">
                            <div>
                                <p class="text-secondary small mb-2">Mi espacio / Mis postulaciones</p>
                                <h1 class="fw-bold">Mis postulaciones</h1>
                                <p class="text-secondary mb-0">
                                    Hacé el seguimiento de las ofertas laborales a las que enviaste tu currículum.
                                </p>
                            </div>
                            <a href="OfertasLaborales.aspx" class="btn btn-primary btn-lg">
                                <i class="bi bi-search me-2"></i>Buscar más ofertas
                            </a>
                        </div>

                        <!-- TARJETAS DE RESUMEN -->
                        <div class="row g-3 mb-4">
                            <div class="col-md-4">
                                <div class="card border-0 shadow-sm rounded-4">
                                    <div class="card-body p-4 d-flex justify-content-between align-items-center">
                                        <div>
                                            <p class="text-secondary mb-1">Total enviadas</p>
                                            <h2 class="fw-bold mb-0"><asp:Literal ID="litTotal" runat="server" Text="0" /></h2>
                                        </div>
                                        <div class="bg-primary-subtle text-primary rounded-3 p-3">
                                            <i class="bi bi-send fs-3"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="card border-0 shadow-sm rounded-4">
                                    <div class="card-body p-4 d-flex justify-content-between align-items-center">
                                        <div>
                                            <p class="text-secondary mb-1">Pendientes / En revisión</p>
                                            <h2 class="fw-bold mb-0"><asp:Literal ID="litPendientes" runat="server" Text="0" /></h2>
                                        </div>
                                        <div class="bg-warning-subtle text-warning-emphasis rounded-3 p-3">
                                            <i class="bi bi-hourglass-split fs-3"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="card border-0 shadow-sm rounded-4">
                                    <div class="card-body p-4 d-flex justify-content-between align-items-center">
                                        <div>
                                            <p class="text-secondary mb-1">Aceptadas</p>
                                            <h2 class="fw-bold mb-0"><asp:Literal ID="litAceptadas" runat="server" Text="0" /></h2>
                                        </div>
                                        <div class="bg-success-subtle text-success rounded-3 p-3">
                                            <i class="bi bi-check-circle fs-3"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <asp:Label ID="lblMensaje" runat="server" EnableViewState="false" CssClass="d-block mb-3" />

                        <!-- LISTADO DE POSTULACIONES -->
                        <div class="card border-0 shadow-sm rounded-4">
                            <div class="card-body p-4">
                                <h5 class="fw-bold mb-3">Historial de postulaciones</h5>

                                <asp:Repeater ID="rptPostulaciones" runat="server" OnItemCommand="rptPostulaciones_ItemCommand">
                                    <HeaderTemplate>
                                        <div class="table-responsive">
                                            <table class="table align-middle mb-0">
                                                <thead class="table-light">
                                                    <tr>
                                                        <th>Oferta laboral</th>
                                                        <th>CV enviado</th>
                                                        <th>Fecha</th>
                                                        <th>Estado de oferta</th>
                                                        <th>Resultado</th>
                                                        <th class="text-end">Acciones</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <tr>
                                            <td class="fw-bold text-dark">
                                                <%# Eval("TituloOferta") %>
                                            </td>
                                            <td>
                                                <span class="text-secondary">
                                                    <i class="bi bi-file-earmark-text me-1"></i><%# Eval("nombreDelCV") %>
                                                </span>
                                            </td>
                                            <td class="text-secondary small">
                                                <%# Eval("FechaPostulacion", "{0:dd/MM/yyyy HH:mm}") %>
                                            </td>
                                            <td>
                                                <span class='badge <%# Eval("EstadoOferta").ToString() == "Activa" ? "bg-primary-subtle text-primary" : "bg-secondary-subtle text-secondary" %>'>
                                                    <%# Eval("EstadoOferta") %>
                                                </span>
                                            </td>
                                            <td>
                                                <span class='badge px-3 py-2 <%# ObtenerClaseEstado(Eval("EstadoPostulacion").ToString()) %>'>
                                                    <%# Eval("EstadoPostulacion") %>
                                                </span>
                                            </td>
                                            <td class="text-end">
                                                <a href='VerCV.aspx?id=<%# Eval("IdCV") %>' class="btn btn-sm btn-outline-primary me-1">
                                                    <i class="bi bi-eye me-1"></i>Ver CV
                                                </a>
                                                <asp:LinkButton ID="btnCancelar" runat="server"
                                                    CssClass="btn btn-sm btn-outline-danger"
                                                    CommandName="Cancelar"
                                                    CommandArgument='<%# Eval("IdPostulacion") %>'
                                                    Visible='<%# Eval("EstadoPostulacion").ToString() == "Pendiente" %>'
                                                    OnClientClick="return confirm('¿Querés cancelar esta postulación?');">
                                                    <i class="bi bi-x-circle me-1"></i>Cancelar
                                                </asp:LinkButton>
                                            </td>
                                        </tr>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                                </tbody>
                                            </table>
                                        </div>
                                    </FooterTemplate>
                                </asp:Repeater>

                                <asp:Panel ID="pnlSinPostulaciones" runat="server" Visible="false">
                                    <div class="alert alert-info mb-0">
                                        <i class="bi bi-info-circle me-2"></i>
                                        Todavía no te postulaste a ninguna oferta laboral. Podés explorar los avisos disponibles desde <strong>Ofertas laborales</strong>.
                                    </div>
                                </asp:Panel>
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