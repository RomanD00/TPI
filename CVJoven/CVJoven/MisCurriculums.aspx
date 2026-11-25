<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="MisCurriculums.aspx.cs"
    Inherits="CVJoven.MisCurriculums" %>
<%@ Register Src="~/Controles/Accesibilidad.ascx"
    TagPrefix="uc"
    TagName="Accesibilidad" %>
<!DOCTYPE html>
<html lang="es">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <title>Mis currículums | CVJoven</title>

    <!-- BOOTSTRAP 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
        rel="stylesheet" />

    <!-- ICONOS BOOTSTRAP -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css"
        rel="stylesheet" />

</head>

<body class="bg-light">

    <form id="form1" runat="server">
        <uc:Accesibilidad ID="Accesibilidad1" runat="server" />

        <!-- BARRA SUPERIOR -->
        <nav class="navbar navbar-expand-lg bg-white border-bottom shadow-sm">

            <div class="container-fluid px-4">

                <a class="navbar-brand fw-bold text-primary fs-4"
                    href="MisCurriculums.aspx">

                    <i class="bi bi-file-earmark-person-fill me-2"></i>
                    CVJoven
                </a>

                <div class="d-flex align-items-center gap-3">

                    <div class="bg-primary-subtle text-primary rounded-circle
                d-flex align-items-center justify-content-center"
                        style="width: 45px; height: 45px;">

                        <i class="bi bi-person-fill fs-4"></i>

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

            </div>

        </nav>


        <div class="container-fluid">

            <div class="row">

                <!-- MENÚ LATERAL -->
                <aside class="col-lg-2 bg-white border-end min-vh-100 p-4">

                    <p class="text-secondary small fw-bold mb-3">
                        MENÚ PRINCIPAL
                   
                    </p>

                    <div class="nav flex-column nav-pills gap-2">

                        <a href="MisCurriculums.aspx"
                            class="nav-link active">

                            <i class="bi bi-file-earmark-text me-2"></i>
                            Mis currículums
                        </a>

                        <a href="OfertasLaborales.aspx"
                            class="nav-link text-secondary">
                            <i class="bi bi-briefcase me-2"></i>
                            Ofertas laborales
                        </a>

                        <a href="MisPostulaciones.aspx" class="nav-link text-secondary">
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

                            <h6 class="fw-bold text-primary">Tu futuro empieza acá
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
                <main class="col-lg-10 p-4 p-lg-5">

                    <div class="container-fluid">

                        <!-- ENCABEZADO -->
                        <div class="d-flex flex-wrap
                                    justify-content-between
                                    align-items-center
                                    gap-3 mb-4">

                            <div>

                                <p class="text-secondary small mb-2">
                                    Mi espacio / Mis currículums
                               
                                </p>

                                <h1 class="fw-bold">Mis currículums 👋
                                </h1>

                                <p class="text-secondary mb-0">
                                    Administrá tus currículums
                                    y destacá tus habilidades
                                    para encontrar tu próximo empleo.
                               
                                </p>

                            </div>


                            <asp:HyperLink
                                ID="lnkCrearCV"
                                runat="server"
                                NavigateUrl="~/CrearCurriculum.aspx"
                                CssClass="btn btn-primary btn-lg">

                                <i class="bi bi-plus-lg me-2"></i>
                                Crear nuevo CV

                            </asp:HyperLink>

                        </div>


                        <!-- ESTADÍSTICAS -->
                        <div class="row mb-4">

                            <div class="col-md-4">

                                <div class="card border-0 shadow-sm rounded-4">

                                    <div class="card-body p-4">

                                        <div class="d-flex
                                                    justify-content-between
                                                    align-items-center">

                                            <div>

                                                <p class="text-secondary mb-2">
                                                    Total de currículums
                                               
                                                </p>

                                                <h2 class="fw-bold mb-0">

                                                    <asp:Literal
                                                        ID="litTotalCV"
                                                        runat="server" />

                                                </h2>

                                            </div>

                                            <div class="bg-primary-subtle
                                                        text-primary
                                                        rounded-3 p-3">

                                                <i class="bi bi-file-earmark-text fs-3"></i>

                                            </div>

                                        </div>

                                    </div>

                                </div>

                            </div>

                        </div>


                        <!-- MENSAJES -->
                        <asp:Label
                            ID="lblMensaje"
                            runat="server"
                            EnableViewState="false"
                            CssClass="d-block mb-3"
                            role="status" />


                        <!-- TÍTULO DOCUMENTOS -->
                        <div class="d-flex
                                    justify-content-between
                                    align-items-center mb-4">

                            <h3 class="fw-bold mb-0">Mis documentos
                            </h3>

                            <span class="text-secondary">Currículums guardados
                            </span>

                        </div>


                        <!-- LISTADO DE CURRÍCULUMS -->
                        <div class="row g-4">


                            <asp:Repeater
                                ID="rptCurriculums"
                                runat="server"
                                OnItemCommand="rptCurriculums_ItemCommand">

                                <ItemTemplate>

                                    <div class="col-md-6 col-xl-4">

                                        <div class="card border-0
                                                    shadow-sm rounded-4
                                                    h-100 overflow-hidden">

                                            <!-- VISTA PREVIA -->
                                            <div class="bg-primary-subtle
                                                        p-4 text-center">

                                                <div class="bg-white
                                                            rounded-3
                                                            shadow-sm
                                                            mx-auto p-4"
                                                    style="max-width: 180px; min-height: 180px;">

                                                    <i class="bi bi-file-earmark-person
                                                              text-primary"
                                                        style="font-size: 65px;"></i>

                                                    <hr />

                                                    <div class="bg-light
                                                                rounded mb-2"
                                                        style="height: 8px;">
                                                    </div>

                                                    <div class="bg-light
                                                                rounded mb-2"
                                                        style="height: 8px;">
                                                    </div>

                                                    <div class="bg-light
                                                                rounded"
                                                        style="height: 8px; width: 70%;">
                                                    </div>

                                                </div>

                                            </div>


                                            <!-- INFORMACIÓN CV -->
                                            <div class="card-body p-4">

                                                <h5 class="fw-bold">

                                                    <%#: Eval("nombreDelCV") %>

                                                </h5>

                                                <p class="text-secondary small">

                                                    <i class="bi bi-clock me-1"></i>

                                                    Disponibilidad:
                                                   
                                                    <%#: Eval("DisponibilidadHoraria") %>
                                                </p>

                                            </div>


                                            <!-- BOTONES WEBFORMS -->
                                            <div class="card-footer
                                                        bg-white border-0
                                                        px-4 pb-4">

                                                <div class="d-flex gap-2">


                                                    <!-- VER -->
                                                    <asp:LinkButton
                                                        ID="btnVer"
                                                        runat="server"
                                                        CssClass="btn btn-outline-primary flex-fill"
                                                        CommandName="Ver"
                                                        CommandArgument='<%# Eval("IdCV") %>'
                                                        CausesValidation="false">

                                                        <i class="bi bi-eye"></i>
                                                        Ver

                                                    </asp:LinkButton>


                                                    <!-- EDITAR -->
                                                    <asp:LinkButton
                                                        ID="btnEditar"
                                                        runat="server"
                                                        CssClass="btn btn-outline-secondary flex-fill"
                                                        CommandName="Editar"
                                                        CommandArgument='<%# Eval("IdCV") %>'
                                                        CausesValidation="false">

                                                        <i class="bi bi-pencil"></i>
                                                        Editar

                                                    </asp:LinkButton>


                                                    <!-- ELIMINAR -->
                                                    <asp:LinkButton
                                                        ID="btnEliminar"
                                                        runat="server"
                                                        CssClass="btn btn-outline-danger"
                                                        CommandName="Eliminar"
                                                        CommandArgument='<%# Eval("IdCV") %>'
                                                        CausesValidation="false"
                                                        OnClientClick="return confirm('¿Querés eliminar este currículum?');">

                                                        <i class="bi bi-trash"></i>

                                                    </asp:LinkButton>


                                                </div>

                                            </div>

                                        </div>

                                    </div>

                                </ItemTemplate>

                            </asp:Repeater>



                            <!-- TARJETA NUEVO CV -->
                            <div class="col-md-6 col-xl-4">

                                <div class="card border-primary
                                            border-2 border-opacity-25
                                            rounded-4 h-100">

                                    <div class="card-body p-4
                                                d-flex flex-column
                                                justify-content-center
                                                align-items-center
                                                text-center">

                                        <div class="bg-primary-subtle
                                                    text-primary
                                                    rounded-circle
                                                    d-flex align-items-center
                                                    justify-content-center mb-3"
                                            style="width: 75px; height: 75px;">

                                            <i class="bi bi-plus-lg fs-2"></i>

                                        </div>

                                        <h5 class="fw-bold">Creá otro currículum
                                        </h5>

                                        <p class="text-secondary">
                                            Organizá tus experiencias,
                                            estudios y habilidades
                                            en un CV profesional.
                                       
                                        </p>


                                        <asp:HyperLink
                                            ID="lnkNuevoCurriculum"
                                            runat="server"
                                            NavigateUrl="~/CrearCurriculum.aspx"
                                            CssClass="btn btn-primary">

                                            <i class="bi bi-plus-lg me-2"></i>
                                            Nuevo currículum

                                        </asp:HyperLink>

                                    </div>

                                </div>

                            </div>


                        </div>


                        <!-- SIN CURRÍCULUMS -->
                        <asp:Panel
                            ID="pnlSinCV"
                            runat="server"
                            Visible="false">

                            <div class="alert alert-info mt-4">

                                <i class="bi bi-info-circle me-2"></i>

                                Todavía no tenés currículums guardados.
                                Podés crear tu primer CV con el botón
                                Crear nuevo CV.

                           
                            </div>

                        </asp:Panel>


                    </div>

                </main>

            </div>

        </div>

    </form>


    <!-- JAVASCRIPT BOOTSTRAP -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>


