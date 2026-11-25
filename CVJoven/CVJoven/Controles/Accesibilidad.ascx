<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Accesibilidad.ascx.cs" Inherits="CVJoven.Controles.Accesibilidad" %>

<link href="<%= ResolveUrl("~/Content/accesibilidad.css") %>" rel="stylesheet" />

<!-- Botón de accesibilidad -->
<button type="button"
    class="btn btn-primary boton-accesibilidad"
    data-bs-toggle="modal"
    data-bs-target="#modalAccesibilidad"
    title="Accesibilidad"
    aria-label="Abrir menú de accesibilidad">

    <i class="bi bi-universal-access" aria-hidden="true"></i>
    Accesibilidad
</button>

<!-- Modal de accesibilidad -->
<div class="modal fade"
    id="modalAccesibilidad"
    tabindex="-1"
    aria-labelledby="tituloAccesibilidad"
    aria-hidden="true">

    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content">

            <div class="modal-header">
                <h2 class="modal-title fs-5" id="tituloAccesibilidad">
                    <i class="bi bi-universal-access" aria-hidden="true"></i>
                    Accesibilidad
                </h2>

                <button type="button"
                    class="btn-close"
                    data-bs-dismiss="modal"
                    aria-label="Cerrar">
                </button>
            </div>

            <div class="modal-body">

                <!-- Tamaño de letra -->
                <div class="mb-3">
                    <p class="fw-semibold">Tamaño de letra</p>

                    <div class="d-flex gap-2">
                        <button type="button"
                            class="btn btn-outline-primary"
                            onclick="cambiarTamanio(-10)">
                            A-
                        </button>

                        <button type="button"
                            class="btn btn-outline-primary"
                            onclick="cambiarTamanio(10)">
                            A+
                        </button>
                    </div>
                </div>

                <!-- Tipografía -->
                <div class="mb-3">
                    <label for="selectTipografia" class="form-label fw-semibold">
                        Tipografía
                    </label>

                    <select id="selectTipografia"
                        class="form-select"
                        onchange="cambiarTipografia(this.value)">

                        <option value="original">Predeterminada</option>
                        <option value="Arial">Arial</option>
                        <option value="Verdana">Verdana</option>
                        <option value="OpenDyslexic">OpenDyslexic</option>

                    </select>
                </div>

                <!-- Interlineado -->
                <div class="mb-3">
                    <label for="rangoInterlineado" class="form-label fw-semibold">
                        Interlineado
                    </label>

                    <input type="range"
                        class="form-range"
                        id="rangoInterlineado"
                        min="1.5"
                        max="3"
                        step="0.1"
                        value="1.5"
                        oninput="cambiarInterlineado(this.value)" />
                </div>

                <!-- Espaciado entre letras -->
                <div class="mb-3">
                    <label for="rangoEspaciado" class="form-label fw-semibold">
                        Espaciado entre letras
                    </label>

                    <input type="range"
                        class="form-range"
                        id="rangoEspaciado"
                        min="0"
                        max="0.2"
                        step="0.01"
                        value="0"
                        oninput="cambiarEspaciado(this.value)" />
                </div>

                <!-- Alto contraste -->
                <div class="form-check form-switch mb-3">

                    <input type="checkbox"
                        class="form-check-input"
                        id="checkContraste"
                        onchange="cambiarContraste(this.checked)" />

                    <label class="form-check-label" for="checkContraste">
                        Alto contraste
                    </label>
                </div>

                <!-- Resaltar enlaces -->
                <div class="form-check form-switch mb-3">

                    <input type="checkbox"
                        class="form-check-input"
                        id="checkEnlaces"
                        onchange="resaltarEnlaces(this.checked)" />

                    <label class="form-check-label" for="checkEnlaces">
                        Resaltar enlaces
                    </label>
                </div>

            </div>

            <div class="modal-footer">

                <button type="button"
                    class="btn btn-outline-secondary"
                    onclick="restablecerAccesibilidad()">

                    <i class="bi bi-arrow-counterclockwise" aria-hidden="true"></i>
                    Restablecer
                </button>

                <button type="button"
                    class="btn btn-primary"
                    data-bs-dismiss="modal">
                    Cerrar
                </button>

            </div>
        </div>
    </div>
</div>

<script src="<%= ResolveUrl("~/Scripts/accesibilidad.js") %>" defer></script>