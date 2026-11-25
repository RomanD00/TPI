const configuracionOriginal = {
    tamanio: 100,
    tipografia: "original",
    interlineado: 1.5,
    espaciado: 0,
    contraste: false,
    enlaces: false
};

let configuracionAccesibilidad = {
    ...configuracionOriginal
};

// Aumentar o reducir tamaño de letra
function cambiarTamanio(valor) {

    configuracionAccesibilidad.tamanio = Math.min(
        200,
        Math.max(80, configuracionAccesibilidad.tamanio + valor)
    );

    aplicarAccesibilidad();
}

// Cambiar tipografía
function cambiarTipografia(valor) {

    configuracionAccesibilidad.tipografia = valor;

    aplicarAccesibilidad();
}

// Cambiar interlineado
function cambiarInterlineado(valor) {

    configuracionAccesibilidad.interlineado = Number(valor);

    aplicarAccesibilidad();
}

// Cambiar espaciado entre letras
function cambiarEspaciado(valor) {

    configuracionAccesibilidad.espaciado = Number(valor);

    aplicarAccesibilidad();
}

// Activar o desactivar alto contraste
function cambiarContraste(valor) {

    configuracionAccesibilidad.contraste = valor;

    aplicarAccesibilidad();
}

// Resaltar enlaces
function resaltarEnlaces(valor) {

    configuracionAccesibilidad.enlaces = valor;

    aplicarAccesibilidad();
}

// Aplicar todas las configuraciones
function aplicarAccesibilidad() {

    const body = document.body;
    const html = document.documentElement;
    const config = configuracionAccesibilidad;

    // Tamaño de letra
    html.style.fontSize = config.tamanio === 100
        ? ""
        : config.tamanio + "%";

    // Tipografía
    body.style.setProperty(
        "--fuente-accesible",
        config.tipografia
    );

    body.classList.toggle(
        "accesibilidad-tipografia",
        config.tipografia !== "original"
    );

    // Interlineado
    body.style.setProperty(
        "--interlineado-accesible",
        config.interlineado
    );

    body.classList.toggle(
        "accesibilidad-interlineado",
        config.interlineado !== 1.5
    );

    // Espaciado
    body.style.setProperty(
        "--espaciado-accesible",
        config.espaciado + "em"
    );

    body.classList.toggle(
        "accesibilidad-espaciado",
        config.espaciado !== 0
    );

    // Alto contraste
    body.classList.toggle(
        "alto-contraste",
        config.contraste
    );

    // Resaltar enlaces
    body.classList.toggle(
        "enlaces-resaltados",
        config.enlaces
    );

    actualizarControles();
    guardarConfiguracion();
}

// Guardar preferencias
function guardarConfiguracion() {

    try {
        localStorage.setItem(
            "cvjovenAccesibilidad",
            JSON.stringify(configuracionAccesibilidad)
        );
    } catch (error) {
        console.warn("No se pudieron guardar las preferencias.", error);
    }
}

// Recuperar preferencias
function cargarConfiguracion() {

    try {
        const guardado = localStorage.getItem("cvjovenAccesibilidad");

        if (guardado) {
            configuracionAccesibilidad = {
                ...configuracionOriginal,
                ...JSON.parse(guardado)
            };
        }
    } catch (error) {
        configuracionAccesibilidad = {
            ...configuracionOriginal
        };
    }

    aplicarAccesibilidad();
}

// Actualizar controles del modal
function actualizarControles() {

    document.getElementById("selectTipografia").value =
        configuracionAccesibilidad.tipografia;

    document.getElementById("rangoInterlineado").value =
        configuracionAccesibilidad.interlineado;

    document.getElementById("rangoEspaciado").value =
        configuracionAccesibilidad.espaciado;

    document.getElementById("checkContraste").checked =
        configuracionAccesibilidad.contraste;

    document.getElementById("checkEnlaces").checked =
        configuracionAccesibilidad.enlaces;
}

// Restablecer configuración
function restablecerAccesibilidad() {

    configuracionAccesibilidad = {
        ...configuracionOriginal
    };

    aplicarAccesibilidad();
}

// Cargar preferencias cuando se abre la página
document.addEventListener(
    "DOMContentLoaded",
    cargarConfiguracion
);