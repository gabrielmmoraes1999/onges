<%-- 
    Document   : login
    Created on : 21/03/2021, 21:42:52
    Author     : Gabriel Moraes
--%>

<%@page import="model.Login"%>
<%@page import="model.User"%>
<%@page import="model.UserDAO"%>
<%@page import="model.PasswordCrypt"%>
<%@page import="model.LoginDAO"%>
<%@page import="model.EmailConfirmation"%>
<%@page import="model.EmailConfirmationDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    int alert = 0;
    String emailLogin = (String) session.getAttribute("email");
    String passwordLogin = (String) session.getAttribute("password");
    if(emailLogin != null && passwordLogin != null){
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
    
    String emailValidate = request.getParameter("email_login");
    String passwordValidate = request.getParameter("password_login");
    
    if(emailValidate != null && passwordValidate != null){
        try {
            String rememberMe = request.getParameter("remember_me_login");
                
            LoginDAO lDAO = new LoginDAO();
            UserDAO uDAO = new UserDAO();
            PasswordCrypt pc = new PasswordCrypt();
            String passC;
            pc.passCrypt(passwordValidate);
            passC = pc.passCrypt(passwordValidate);

            if(rememberMe == null){
                session.setMaxInactiveInterval(3600); //Sessão em segundos
            }
                
            Login l = lDAO.login(emailValidate, passC);
            User u = uDAO.uploadById(l.getUser().getId());
            if(u.getId() > 0 & u.isStatus() == true){
                session.setAttribute("email", emailValidate);
                session.setAttribute("password", passC);
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
            }else if(u.getId() > 0 & u.isStatus() == false){
                alert = 1;
            }
        } catch (Exception e) {
            alert = 2;
        }
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="user-scalable=no, initial-scale=1, maximum-scale=1, minimum-scale=1, width=device-width, height=device-height, target-densitydpi=device-dpi" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>OnGes - Login</title>
        <link rel="icon" href="./assets/icon/favicon.png" type="image/png">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700">
        <link rel="stylesheet" href="./assets/vendor/nucleo/css/nucleo.css" type="text/css">
        <link rel="stylesheet" href="./assets/vendor/animate.css/animate.min.css">
        <link rel="stylesheet" href="./assets/vendor/sweetalert2/dist/sweetalert2.min.css">
        <link rel="stylesheet" href="./assets/vendor/@fortawesome/fontawesome-free/css/all.min.css" type="text/css">
        <link rel="stylesheet" href="./assets/css/argon.css?v=1.1.0" type="text/css">
    </head>
    <body class="bg-default">
        <nav id="navbar-main" class="navbar navbar-horizontal navbar-transparent navbar-main navbar-expand-lg navbar-light">
            <div class="container">
                <a href="/" class="navbar-brand">
                    <img src="./assets/icon/onges_white.png">
                </a>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar-collapse" aria-controls="navbar-collapse" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="navbar-collapse navbar-custom-collapse collapse" id="navbar-collapse">
                    <div class="navbar-collapse-header">
                        <div class="row">
                            <div class="col-6 collapse-brand">
                                <a href="/"><img src="./assets/icon/onges_home.png"></a>
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
                            
                    </ul>
                    <hr class="d-lg-none" />
                    <ul class="navbar-nav align-items-lg-center ml-lg-auto">
                        <li class="nav-item">
                            <a class="nav-link nav-link-icon" href="" target="_blank" data-toggle="tooltip" data-original-title="Like us on Facebook">
                                <i class="fab fa-facebook-square"></i>
                                <span class="nav-link-inner--text d-lg-none">Facebook</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link nav-link-icon" href="" target="_blank" data-toggle="tooltip" data-original-title="Follow us on Instagram">
                                <i class="fab fa-instagram"></i>
                                <span class="nav-link-inner--text d-lg-none">Instagram</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link nav-link-icon" href="" target="_blank" data-toggle="tooltip" data-original-title="Follow us on Twitter">
                                <i class="fab fa-twitter-square"></i>
                                <span class="nav-link-inner--text d-lg-none">Twitter</span>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
        <div class="main-content">
            <div class="header bg-gradient-primary py-7 py-lg-8 pt-lg-9">
                <div class="container">
                    <div class="header-body text-center mb-7">
                        <div class="row justify-content-center">
                            <div class="col-xl-5 col-lg-6 col-md-8 px-5">
                                <h1 class="text-white">Bem-Vindo ao OnGes</h1>
                                <p class="text-lead text-white"></p>
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
            <div class="container mt--8 pb-5">
                <div class="row justify-content-center">
                    <div class="col-lg-5 col-md-7">
                        <div class="card bg-secondary border-0 mb-0">
                            <div class="card-body px-lg-5 py-lg-5">
                                <div class="text-center text-muted mb-4">
                                    <small>Faça login no OnGes</small>
                                </div>
                                <form role="form" action="" method="post">
                                    <div class="form-group mb-3">
                                        <div class="input-group input-group-merge input-group-alternative">
                                            <div class="input-group-prepend">
                                                <span class="input-group-text"><i class="ni ni-email-83"></i></span>
                                            </div>
                                            <input class="form-control" placeholder="Email" name="email_login" type="email">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="input-group input-group-merge input-group-alternative">
                                            <div class="input-group-prepend">
                                                <span class="input-group-text"><i class="ni ni-lock-circle-open"></i></span>
                                            </div>
                                            <input class="form-control" placeholder="Senha" name="password_login" type="password">
                                        </div>
                                    </div>
                                    <div class="custom-control custom-control-alternative custom-checkbox">
                                        <input class="custom-control-input" id=" customCheckLogin" name="remember_me_login" type="checkbox">
                                        <label class="custom-control-label" for=" customCheckLogin">
                                            <span class="text-muted">Lembre de mim</span>
                                        </label>
                                    </div>
                                    <div class="text-center">
                                        <button type="submit" class="btn btn-primary my-4">Entrar</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-6">
                                <a href="forgot-password" class="text-light"><small>Esqueceu a senha?</small></a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script src="./assets/vendor/jquery/dist/jquery.min.js"></script>
        <script src="./assets/vendor/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
        <script src="./assets/vendor/js-cookie/js.cookie.js"></script>
        <script src="./assets/vendor/sweetalert2/dist/sweetalert2.min.js"></script>
        <script src="./assets/vendor/bootstrap-notify/bootstrap-notify.min.js"></script>
        <script src="./assets/vendor/jquery.scrollbar/jquery.scrollbar.min.js"></script>
        <script src="./assets/vendor/jquery-scroll-lock/dist/jquery-scrollLock.min.js"></script>
        <script src="./assets/js/argon.js?v=1.1.0"></script>
        <script src="./assets/js/demo.min.js"></script>
        <%
            String hash = request.getParameter("hash");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            if (hash != null && email != null && password != null){
                PasswordCrypt pc = new PasswordCrypt();
                LoginDAO lDAO = new LoginDAO();
                EmailConfirmationDAO ecDAO = new EmailConfirmationDAO();
                int idLogin = lDAO.uploadByEmail(email).getId();
                EmailConfirmation ec = ecDAO.uploadByEmail(hash, idLogin);
                if(ec.getType().equals("forgot-password")){
                    lDAO.forgotPassword(email, pc.passCrypt(password));
                    ecDAO.usedHash(hash, idLogin);
        %>
        <script>
            $(document).ready(function(){
                alerta();
            });
            function alerta(){
                swal('Muito Bom!', 'Senha atualizada com sucesso!', 'success');
                }
        </script>
        <%
                }
                
            }else if(hash != null || email != null || password != null){
        %>
        <script>
            $(document).ready(function(){
                alerta();
            });
            function alerta(){
                swal('Oops...', 'Ocorreu um erro inesperado!', 'error');
            }
        </script>
        <%
            }

            if(alert == 1) {
        %>
        <script>
            $(document).ready(function(){
                userInative();
            });
            function userInative(){
                $.notify("Usuário Desativado!", {
                    animate: {
                        enter: 'animated fadeInDown',
                        exit: 'animated fadeOutUp'
                    },
                    placement: {
                        from: 'top',
                        align: 'center'
                    },
                    offset: {
                        x: 15, // Keep this as default
                        y: 15 // Unless there'll be alignment issues as this value is targeted in CSS
                    },
                    spacing: 10,
                    z_index: 1080,
                    mouse_over: false,
                    element: 'body',
                    allow_dismiss: true,
                    type: 'danger',
                    template: '<div data-notify="container" class="alert alert-dismissible alert-{0} alert-notify" role="alert">' +
                    '<div class="alert-text"> ' +
                    '<span class="alert-title" data-notify="title">{1}</span> ' +
                    '<span data-notify="message">{2}</span>' +
                    '</div>' +
                    '<button type="button" class="close" data-notify="dismiss" aria-label="Close"><span aria-hidden="true">&times;</span></button>' +
                    '</div>'
                });
            }
        </script>
        <%
            } else if(alert == 2){
        %>
        <script>
            $(document).ready(function(){
                userOrPassInvalidate();
            });
            function userOrPassInvalidate(){
                $.notify("Usuário ou senha inválidos!", {
                    animate: {
                        enter: 'animated fadeInDown',
                        exit: 'animated fadeOutUp'
                    },
                    placement: {
                        from: 'top',
                        align: 'center'
                    },
                    offset: {
                        x: 15, // Keep this as default
                        y: 15 // Unless there'll be alignment issues as this value is targeted in CSS
                    },
                    spacing: 10,
                    z_index: 1080,
                    mouse_over: false,
                    element: 'body',
                    allow_dismiss: true,
                    type: 'danger',
                    template: '<div data-notify="container" class="alert alert-dismissible alert-{0} alert-notify" role="alert">' +
                    '<div class="alert-text"> ' +
                    '<span class="alert-title" data-notify="title">{1}</span> ' +
                    '<span data-notify="message">{2}</span>' +
                    '</div>' +
                    '<button type="button" class="close" data-notify="dismiss" aria-label="Close"><span aria-hidden="true">&times;</span></button>' +
                    '</div>'
                });
            }
        </script>
        <%
            }
        %>
    </body>
</html>
