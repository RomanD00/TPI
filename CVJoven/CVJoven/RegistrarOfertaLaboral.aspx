
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

</body>
</html>
