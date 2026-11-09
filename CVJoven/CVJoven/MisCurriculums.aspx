<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MisCurriculums.aspx.cs" Inherits="CVJoven.MisCurriculums" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="es">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Mis Currículums | CVJoven</title>

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet" />

    <style>
        :root {
            --primary: #6258ed;
            --primary-light: #f0eeff;
            --navy: #171b37;
            --muted: #81879a;
            --border: #e9ebf2;
            --background: #f7f8fc;
        }

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: 'Inter', sans-serif;
            background: var(--background);
            color: var(--navy);
        }

        .app {
            display: flex;
            min-height: 100vh;
        }

        /* MENÚ LATERAL */

        .sidebar {
            width: 255px;
            background: #171b37;
            color: white;
            padding: 30px 18px;
            flex-shrink: 0;
        }

        .brand {
            display: flex;
            align-items: center;
            gap: 12px;
            font-size: 23px;
            font-weight: 800;
            margin-bottom: 55px;
            padding-left: 13px;
        }

        .brand-icon {
            display: grid;
            place-items: center;
            width: 39px;
            height: 39px;
            background: var(--primary);
            border-radius: 12px;
        }

        .menu-label {
            font-size: 11px;
            font-weight: 700;
            letter-spacing: 1.5px;
            color: #7f86a5;
            padding: 0 16px;
            margin: 24px 0 12px;
        }

        .nav-link {
            display: flex;
            align-items: center;
            gap: 14px;
            padding: 14px 16px;
            text-decoration: none;
            color: #aeb4d0;
            border-radius: 12px;
            font-size: 14px;
            font-weight: 500;
            margin-bottom: 6px;
            transition: .2s;
        }

            .nav-link i {
                font-size: 19px;
            }

            .nav-link:hover {
                color: white;
                background: #272b4c;
            }

            .nav-link.active {
                background: var(--primary);
                color: white;
            }

        .sidebar-footer {
            margin-top: 80px;
            padding: 20px 15px;
            background: #252948;
            border-radius: 15px;
        }

            .sidebar-footer p {
                color: #afb5d2;
                font-size: 12px;
                line-height: 1.7;
            }

        /* CONTENIDO */

        .main {
            flex: 1;
            min-width: 0;
        }

        .topbar {
            height: 85px;
            background: white;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 45px;
            border-bottom: 1px solid var(--border);
        }

        .breadcrumb {
            color: #858ba1;
            font-size: 13px;
        }

            .breadcrumb strong {
                color: var(--navy);
            }

        .profile {
            display: flex;
            align-items: center;
            gap: 12px;
            font-weight: 600;
            font-size: 13px;
        }

        .avatar {
            background: #ebe8ff;
            color: var(--primary);
            width: 38px;
            height: 38px;
            display: grid;
            place-items: center;
            border-radius: 50%;
            font-weight: 800;
        }

        .content {
            max-width: 1400px;
            margin: auto;
            padding: 42px 45px;
        }

        .heading {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 20px;
            margin-bottom: 33px;
        }

        h1 {
            font-size: 30px;
            letter-spacing: -1px;
            margin: 0 0 10px;
        }

        .subtitle {
            color: var(--muted);
            font-size: 14px;
            margin: 0;
            line-height: 1.7;
        }

        .btn-primary {
            background: var(--primary);
            color: white;
            border: none;
            padding: 15px 23px;
            border-radius: 12px;
            font-weight: 700;
            font-family: inherit;
            cursor: pointer;
            box-shadow: 0 6px 15px #6258ed29;
            transition: .2s;
            white-space: nowrap;
        }

            .btn-primary:hover {
                background: #4c42d7;
                transform: translateY(-2px);
            }

        /* ESTADÍSTICAS */

        .stats {
            display: grid;
            grid-template-columns: repeat(3, minmax(0, 1fr));
            gap: 20px;
            margin-bottom: 34px;
        }

        .stat {
            background: white;
            padding: 25px;
            border-radius: 18px;
            border: 1px solid var(--border);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .stat-label {
            color: var(--muted);
            font-size: 13px;
            font-weight: 500;
        }

        .stat-value {
            font-size: 30px;
            font-weight: 800;
            margin-top: 10px;
        }

        .stat-icon {
            height: 50px;
            width: 50px;
            border-radius: 14px;
            display: grid;
            place-items: center;
            font-size: 23px;
            background: #f0eeff;
            color: var(--primary);
        }

            .stat-icon.green {
                color: #15a57a;
                background: #e7f9f1;
            }

            .stat-icon.orange {
                color: #ef9b27;
                background: #fff4e3;
            }

        /* LISTADO */

        .section-head {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 22px;
            gap: 16px;
        }

            .section-head h2 {
                font-size: 20px;
                margin: 0;
            }

        .cv-grid {
            display: grid;
            grid-template-columns: repeat(3, minmax(0, 1fr));
            gap: 22px;
        }

        .cv-card {
            background: white;
            border: 1px solid var(--border);
            border-radius: 18px;
            padding: 20px;
            transition: .2s;
        }

            .cv-card:hover {
                transform: translateY(-4px);
                box-shadow: 0 15px 30px #20284912;
            }

        .preview {
            background: #f0f1f9;
            height: 195px;
            border-radius: 12px;
            padding: 20px;
            display: flex;
            justify-content: center;
            overflow: hidden;
        }

        .paper {
            background: white;
            width: 145px;
            min-width: 145px;
            height: 190px;
            padding: 17px 15px;
            box-shadow: 0 5px 20px #00000012;
            border-radius: 4px;
        }

        .paper-title {
            width: 70%;
            height: 10px;
            background: #29304c;
            border-radius: 3px;
            margin-bottom: 10px;
        }

        .paper-sub {
            height: 5px;
            background: #a2a9bd;
            width: 55%;
            margin-bottom: 20px;
            border-radius: 3px;
        }

        .paper-line {
            height: 4px;
            background: #e4e6ef;
            margin: 8px 0;
            border-radius: 3px;
        }

            .paper-line.short {
                width: 65%;
            }

        .paper-heading {
            background: var(--primary);
            width: 48%;
            height: 6px;
            border-radius: 2px;
            margin-top: 16px;
        }

        .card-info {
            padding: 20px 3px 10px;
        }

            .card-info h3 {
                margin: 0 0 8px;
                font-size: 16px;
            }

        .date {
            color: var(--muted);
            font-size: 12px;
            margin: 0 0 18px;
        }

        .status {
            display: inline-block;
            background: #e8f8f0;
            color: #14966a;
            padding: 7px 11px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 700;
        }

            .status.draft {
                color: #ce8720;
                background: #fff3e0;
            }

        .card-actions {
            display: flex;
            gap: 10px;
            padding-top: 18px;
            margin-top: 18px;
            border-top: 1px solid var(--border);
        }

        .btn-outline {
            flex: 1;
            border: 1px solid var(--border);
            background: white;
            padding: 11px 8px;
            color: #40465d;
            font-family: inherit;
            font-size: 12px;
            font-weight: 700;
            border-radius: 9px;
            cursor: pointer;
            transition: .2s;
        }

            .btn-outline:hover {
                background: var(--primary-light);
                color: var(--primary);
            }

        .create-card {
            border: 2px dashed #c9c8e9;
            background: #faf9ff;
            border-radius: 18px;
            min-height: 385px;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-direction: column;
            padding: 30px;
            text-align: center;
        }

        .create-icon {
            width: 75px;
            height: 75px;
            display: grid;
            place-items: center;
            font-size: 30px;
            background: #eeecff;
            color: var(--primary);
            border-radius: 20px;
            margin-bottom: 20px;
        }

        .create-card h3 {
            font-size: 17px;
            margin: 0 0 10px;
        }

        .create-card p {
            font-size: 13px;
            line-height: 1.8;
            color: var(--muted);
            margin-bottom: 22px;
        }

        @media (max-width: 1100px) {
            .cv-grid {
                grid-template-columns: repeat(2, minmax(0, 1fr));
            }
        }

        @media (max-width: 850px) {
            .sidebar {
                display: none;
            }

            .content {
                padding: 25px 20px;
            }

            .topbar {
                padding: 0 20px;
            }

            .stats {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 600px) {
            .heading {
                align-items: stretch;
                flex-direction: column;
            }

            .cv-grid {
                grid-template-columns: 1fr;
            }

            h1 {
                font-size: 25px;
            }

            .profile span {
                display: none;
            }
        }
    </style>
</head>

<body>
    <form id="form1" runat="server">

        <div class="app">

            <!-- SIDEBAR -->
            <aside class="sidebar">

                <div class="brand">
                    <div class="brand-icon">
                        <i class="bi bi-file-earmark-person"></i>
                    </div>
                    CVJoven
       
                </div>

                <div class="menu-label">MENÚ PRINCIPAL</div>

                <a href="#" class="nav-link">
                    <i class="bi bi-grid-1x2"></i>
                    Inicio
        </a>

                <a href="MisCurriculums.aspx" class="nav-link active">
                    <i class="bi bi-file-earmark-text"></i>
                    Mis currículums
        </a>

                <a href="#" class="nav-link">
                    <i class="bi bi-briefcase"></i>
                    Ofertas laborales
        </a>

                <a href="#" class="nav-link">
                    <i class="bi bi-send"></i>
                    Mis postulaciones
        </a>

                <div class="menu-label">MI CUENTA</div>

                <a href="#" class="nav-link">
                    <i class="bi bi-person-circle"></i>
                    Mi perfil
        </a>

                <a href="#" class="nav-link">
                    <i class="bi bi-gear"></i>
                    Configuración
        </a>

                <div class="sidebar-footer">
                    <strong>Tu futuro empieza acá</strong>
                    <p>
                        Creá un currículum profesional
                y preparate para tu próxima oportunidad.
           
                    </p>
                </div>

            </aside>

            <!-- CONTENIDO PRINCIPAL -->
            <main class="main">

                <header class="topbar">

                    <div class="breadcrumb">
                        Mi espacio / <strong>Mis currículums</strong>
                    </div>

                    <div class="profile">
                        <i class="bi bi-bell" style="font-size: 20px;"></i>
                        <span>Mi cuenta</span>
                        <div class="avatar">U</div>
                    </div>

                </header>

                <div class="content">

                    <!-- TÍTULO -->
                    <div class="heading">

                        <div>
                            <h1>Mis currículums <span>👋</span></h1>
                            <p class="subtitle">
                                Administrá tus currículums y destacá
                        tus habilidades para encontrar tu próximo empleo.
                   
                            </p>
                        </div>

                        <button type="button" class="btn-primary">
                            <i class="bi bi-plus-lg"></i>
                            Crear nuevo CV
               
                        </button>

                    </div>

                    <!-- ESTADÍSTICAS DE EJEMPLO -->
                    <div class="stats">

                        <div class="stat">
                            <div>
                                <div class="stat-label">Total de currículums</div>
                                <div class="stat-value">2</div>
                            </div>
                            <div class="stat-icon">
                                <i class="bi bi-file-earmark-text"></i>
                            </div>
                        </div>

                        <div class="stat">
                            <div>
                                <div class="stat-label">CV completos</div>
                                <div class="stat-value">1</div>
                            </div>
                            <div class="stat-icon green">
                                <i class="bi bi-check-circle"></i>
                            </div>
                        </div>

                        <div class="stat">
                            <div>
                                <div class="stat-label">Borradores</div>
                                <div class="stat-value">1</div>
                            </div>
                            <div class="stat-icon orange">
                                <i class="bi bi-pencil-square"></i>
                            </div>
                        </div>

                    </div>

                    <!-- CURRÍCULUMS -->
                    <div class="section-head">
                        <h2>Mis documentos</h2>
                        <span class="subtitle">Ejemplos de diseño</span>
                    </div>

                    <div class="cv-grid">

                        <!-- CV 1 -->
                        <div class="cv-card">

                            <div class="preview">
                                <div class="paper">
                                    <div class="paper-title"></div>
                                    <div class="paper-sub"></div>
                                    <div class="paper-heading"></div>
                                    <div class="paper-line"></div>
                                    <div class="paper-line"></div>
                                    <div class="paper-line short"></div>
                                    <div class="paper-heading"></div>
                                    <div class="paper-line"></div>
                                    <div class="paper-line short"></div>
                                </div>
                            </div>

                            <div class="card-info">
                                <h3>Mi currículum profesional</h3>
                                <p class="date">Documento de demostración</p>
                                <span class="status">Completo</span>
                            </div>

                            <div class="card-actions">
                                <button type="button" class="btn-outline">
                                    <i class="bi bi-eye"></i>Ver
                       
                                </button>
                                <button type="button" class="btn-outline">
                                    <i class="bi bi-pencil"></i>Editar
                       
                                </button>
                                <button type="button" class="btn-outline">
                                    <i class="bi bi-trash"></i>
                                </button>
                            </div>

                        </div>

                        <!-- CV 2 -->
                        <div class="cv-card">

                            <div class="preview">
                                <div class="paper">
                                    <div class="paper-title"></div>
                                    <div class="paper-sub"></div>
                                    <div class="paper-heading"></div>
                                    <div class="paper-line"></div>
                                    <div class="paper-line short"></div>
                                    <div class="paper-heading"></div>
                                    <div class="paper-line"></div>
                                </div>
                            </div>

                            <div class="card-info">
                                <h3>CV para primer empleo</h3>
                                <p class="date">Documento de demostración</p>
                                <span class="status draft">Borrador</span>
                            </div>

                            <div class="card-actions">
                                <button type="button" class="btn-outline">
                                    <i class="bi bi-eye"></i>Ver
                       
                                </button>
                                <button type="button" class="btn-outline">
                                    <i class="bi bi-pencil"></i>Editar
                       
                                </button>
                                <button type="button" class="btn-outline">
                                    <i class="bi bi-trash"></i>
                                </button>
                            </div>

                        </div>

                        <!-- NUEVO CV -->
                        <div class="create-card">

                            <div class="create-icon">
                                <i class="bi bi-plus-lg"></i>
                            </div>

                            <h3>Creá otro currículum</h3>

                            <p>
                                Organizá tus experiencias, estudios
                        y habilidades en un CV que destaque
                        tu potencial.
                   
                            </p>

                            <button type="button" class="btn-primary">
                                <i class="bi bi-plus-lg"></i>
                                Nuevo currículum
                   
                            </button>

                        </div>

                    </div>

                </div>

            </main>

        </div>

    </form>
</body>
</html>

