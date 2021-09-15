<%-- 
    Document   : index
    Created on : 21/03/2021, 13:36:47
    Author     : Gabriel Moraes
--%>
<%@page import="model.User"%>
<%@page import="model.UserDAO"%>
<%@page import="model.LoginDAO"%>
<%
    String emailLogin = (String) session.getAttribute("email");
    if(emailLogin != null){
        LoginDAO lDAO = new LoginDAO();
        UserDAO uDAO = new UserDAO();
        User u = uDAO.uploadById(lDAO.uploadByEmail(emailLogin).getId());
        if(u.getProfile().getId() < 50 && u.getProfile().getId() != 0){
            response.sendRedirect("admin/Dashboard");
        } else if(u.getProfileSchool().getId() != 0){
            response.sendRedirect("Dashboard");
        } else if(u.getProfile().getId() >= 50) {
            switch (u.getProfile().getId()){
                case 50:
                    response.sendRedirect("Dashboard");
                    break;
                case 51:
                    response.sendRedirect("portaldoprofessor/dashboard.jsp");
                    break;
                case 52:
                    response.sendRedirect("portaldoaluno/dashboard.jsp");
                    break;
            }
        }
    }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700">
        <link rel="stylesheet" href="./assets/vendor/nucleo/css/nucleo.css" type="text/css">
        <link rel="stylesheet" href="./assets/vendor/@fortawesome/fontawesome-free/css/all.min.css" type="text/css">
        <link rel="stylesheet" href="./assets/css/argon.css?v=1.1.0" type="text/css">
        <link rel="icon" href="./assets/icon/favicon.png" type="image/png">
        <title>OnGes</title>
    </head>
    <body>
        <!-- Navabr -->
        <nav id="navbar-main" class="navbar navbar-horizontal navbar-main navbar-expand-lg navbar-dark bg-primary">
            <div class="container">
                <a class="navbar-brand">
                    <img src="./assets/icon/onges_white.png">
                </a>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar-collapse" aria-controls="navbar-collapse" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="navbar-collapse navbar-custom-collapse collapse" id="navbar-collapse">
                    <div class="navbar-collapse-header">
                        <div class="row">
                            <div class="col-6 collapse-brand">
                                <a href="./pages/dashboards/dashboard.html">
                                    <img src="./assets/icon/onges_home.png">
                                </a>
                            </div>
                            <div class="col-6 collapse-close">
                                <button type="button" class="navbar-toggler" data-toggle="collapse" data-target="#navbar-collapse" aria-controls="navbar-collapse" aria-expanded="false" aria-label="Toggle navigation">
                                    <span></span>
                                    <span></span>
                                </button>
                            </div>
                        </div>
                    </div>
                    <ul class="navbar-nav mr-auto">
                        <li class="nav-item">
                            <a href="./Login" class="nav-link">
                                <span class="nav-link-inner--text">Começar</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="./portaldoprofessor" class="nav-link">
                                <span class="nav-link-inner--text">Portal do Professor</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="" class="nav-link">
                                <span class="nav-link-inner--text">Portal do Aluno</span>
                            </a>
                        </li>
                    </ul>
                    <hr class="d-lg-none" />
                    <ul class="navbar-nav align-items-lg-center ml-lg-auto">
                        <li class="nav-item">
                            <a class="nav-link nav-link-icon" href="" target="_blank" data-toggle="tooltip" title="" data-original-title="Curta-nos no Facebook">
                                <i class="fab fa-facebook-square"></i>
                                <span class="nav-link-inner--text d-lg-none">Facebook</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link nav-link-icon" href="" target="_blank" data-toggle="tooltip" title="" data-original-title="Siga-nos no Instagram">
                                <i class="fab fa-instagram"></i>
                                <span class="nav-link-inner--text d-lg-none">Instagram</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link nav-link-icon" href="" target="_blank" data-toggle="tooltip" title="" data-original-title="Siga-nos no Twitter">
                                <i class="fab fa-twitter-square"></i>
                                <span class="nav-link-inner--text d-lg-none">Twitter</span>
                            </a>
                        </li>
                        <!--<li class="nav-item d-none d-lg-block ml-lg-4">
                            <a href="purchase.jsp" target="_blank" class="btn btn-neutral btn-icon">
                                <span class="btn-inner--icon">
                                    <i class="fas fa-shopping-cart mr-2"></i>
                                </span>
                              <span class="nav-link-inner--text">Contrate agora</span>
                            </a>
                        </li>-->
                    </ul>
                </div>
            </div>
        </nav>
        <!-- Main content -->
        <div class="main-content">
            <!-- Header -->
            <div class="header bg-primary pt-5 pb-7">
                <div class="container">
                    <div class="header-body">
                        <div class="row align-items-center">
                            <div class="col-lg-6">
                                <div class="pr-5">
                                    <h1 class="display-2 text-white font-weight-bold mb-0">OnGes</h1>
                                    <h2 class="display-4 text-white font-weight-light">Sistema de Gestão Escolar Online</h2>
                                    <p class="text-white mt-4">
                                        Você quer facilidade e praticidade na sua gestão escolar?</br>
                                        Reduza a inadimplência, o retrabalho e automatize os processos da sua escola ou curso.
                                    </p>
                                    <div class="mt-5">
                                        <a href="./Dashboard" class="btn btn-neutral my-2">Dashboard</a>
                                        <!--<a href="" class="btn btn-default my-2">Contrate agora</a>-->
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-6">
                                <div class="row pt-5">
                                    <div class="col-md-6">
                                        <div class="card">
                                            <div class="card-body">
                                                <div class="icon icon-shape bg-gradient-red text-white rounded-circle shadow mb-4">
                                                    <i class="fas fa-chart-pie"></i>
                                                </div>
                                                <h5 class="h3">Gestão Acadêmica</h5>
                                                <p>Reduza retrabalho, automatizando suas tarefas de secretaria com o onges e imprimindo documentos em um clique.</p>
                                            </div>
                                        </div>
                                        <div class="card">
                                            <div class="card-body">
                                                <div class="icon icon-shape bg-gradient-info text-white rounded-circle shadow mb-4">
                                                    <i class="fas fa-chart-line"></i>
                                                </div>
                                                <h5 class="h3">Gestão Pedagógica</h5>
                                                <p>Acompanhe de perto a evolução dos alunos e o que é trabalhado em sala, com seus documentos pedagógicos integrados.</p>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6 pt-lg-5 pt-4">
                                        <div class="card mb-4">
                                            <div class="card-body">
                                                <div class="icon icon-shape bg-gradient-success text-white rounded-circle shadow mb-4">
                                                    <i class="fas fa-chalkboard-teacher"></i>
                                                </div>
                                                <h5 class="h3">Ensino remoto</h5>
                                                <p>Facilite o trabalho do professor tendo um ambiente unificado de diário online e comunicação remota com os alunos.</p>
                                            </div>
                                        </div>
                                        <div class="card mb-4">
                                            <div class="card-body">
                                                <div class="icon icon-shape bg-gradient-warning text-white rounded-circle shadow mb-4">
                                                    <i class="fas fa-user-lock"></i>
                                                </div>
                                              <h5 class="h3">Portal de Pais e Alunos</h5>
                                              <p>Aumente a satisfação dos pais e alunos com o aplicativo de comunicação do onges, com acessos pedagógicos e financeiro.</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="separator separator-bottom separator-skew zindex-100">
                    <svg x="0" y="0" viewBox="0 0 2560 100" preserveAspectRatio="none" version="1.1" xmlns="http://www.w3.org/2000/svg">
                        <polygon class="fill-default" points="2560 0 2560 100 0 100"></polygon>
                    </svg>
                </div>
            </div>
            <section class="py-6 pb-9 bg-default">
                <div class="container">
                    <div class="row justify-content-center text-center">
                        <div class="col-md-8">
                          <h2 class="display-3 text-white">Sobre OnGes</h2>
                            <p class="lead text-white">
                                O OnGes é um sistema de gestão escolar online especialista em pedagógica de escolas e cursos, pode ser utilizado por escolas públicas e privadas, faculdades, escolas de línguas, dentre outras, possuindo flexibilidade para ser personalizado e ajustado de acordo com a necessidade do cliente.
                                O OnGes possibilita a gestão integrada de todas as escolas de uma secretaria de educação. As rotinas administrativas, acadêmicas e financeiras de uma instituição de ensino, bem como a comunicação com os pais e alunos, tornam-se mais fáceis com o OnGes.
                            </p>
                        </div>
                    </div>
                </div>
            </section>
            <section class="section section-lg pt-lg-0 mt--7">
                <div class="container">
                    <div class="row justify-content-center">
                        <div class="col-lg-12">
                            <div class="row">
                                <div class="col-lg-4">
                                    <div class="card card-lift--hover shadow border-0">
                                        <div class="card-body py-5">
                                            <div class="icon icon-shape bg-gradient-primary text-white rounded-circle mb-4">
                                                <i class="fas fa-user-graduate"></i>
                                            </div>
                                            <h4 class="h3 text-primary text-uppercase">Portal do Aluno</h4>
                                            <p class="description mt-3">Faça o companhamento em tempo real das notas, aulas, avaliações, conteúdos, frequências e atividades.</p>
                                            <div>
                                                <span class="badge badge-pill badge-primary">mais controle</span>
                                                <span class="badge badge-pill badge-primary">melhor comunicação</span>
                                                <span class="badge badge-pill badge-primary">mais praticidade</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-4">
                                    <div class="card card-lift--hover shadow border-0">
                                        <div class="card-body py-5">
                                            <div class="icon icon-shape bg-gradient-success text-white rounded-circle mb-4">
                                                <i class="fas fa-chalkboard-teacher"></i>
                                            </div>
                                            <h4 class="h3 text-success text-uppercase">Portal do Professor</h4>
                                            <p class="description mt-3">Faça o lançamento de aulas, avaliações, frequência, atividades e notas com praticidade. Tenha agilidade no registro dos horários das turmas de forma totalmente online.</p>
                                            <div>
                                                <span class="badge badge-pill badge-success">mais praticidade</span>
                                                <span class="badge badge-pill badge-success">mais agilidade</span>
                                                <span class="badge badge-pill badge-success">mais controle</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-4">
                                    <div class="card card-lift--hover shadow border-0">
                                        <div class="card-body py-5">
                                            <div class="icon icon-shape bg-gradient-warning text-white rounded-circle mb-4">
                                                <i class="fas fa-user-lock"></i>
                                            </div>
                                            <h4 class="h3 text-warning text-uppercase">Portal do Responsável</h4>
                                            <p class="description mt-3">Faça o companhamento em tempo real das notas, aulas, avaliações, conteúdos, frequências e atividades.</p>
                                            <div>
                                                <span class="badge badge-pill badge-warning">mais controle</span>
                                                <span class="badge badge-pill badge-warning">menos burocracia</span>
                                                <span class="badge badge-pill badge-warning">mais praticidade</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </div>
        <%@include file="footer.jsp" %>
        <script src="./assets/vendor/jquery/dist/jquery.min.js"></script>
        <script src="./assets/vendor/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
        <script src="./assets/vendor/js-cookie/js.cookie.js"></script>
        <script src="./assets/vendor/jquery.scrollbar/jquery.scrollbar.min.js"></script>
        <script src="./assets/vendor/jquery-scroll-lock/dist/jquery-scrollLock.min.js"></script>
        <script src="./assets/vendor/onscreen/dist/on-screen.umd.min.js"></script>
        <script src="./assets/js/argon.min.js?v=1.2.0"></script>
        <script src="./assets/js/demo.min.js"></script>
    </body>
</html>
