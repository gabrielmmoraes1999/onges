<%-- 
    Document   : forgot-password
    Created on : 28/06/2021, 13:44:55
    Author     : Gabriel Moraes
--%>

<%@page import="model.EmailConfirmationDAO"%>
<%@page import="model.EmailConfirmation"%>
<%@page import="model.Login"%>
<%@page import="model.UserDAO"%>
<%@page import="model.LoginDAO"%>
<%@page import="model.Emails"%>
<%@page import="model.EmailUtility"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String email = request.getParameter("email");
    String hash = request.getParameter("hash");
    EmailConfirmation ec = new  EmailConfirmation();
    try{
        if(email != null && hash != null){
            LoginDAO lDAO = new LoginDAO();
            Login l = lDAO.uploadByEmail(email);
            EmailConfirmationDAO ecDAO = new EmailConfirmationDAO();
            ec = ecDAO.uploadByEmail(hash, l.getId());
            
            if(ec.getType() == "forgot-password"){
                
            }
        }
    }catch(Exception e){
        out.print("Erro:"+e);
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="user-scalable=no, initial-scale=1, maximum-scale=1, minimum-scale=1, width=device-width, height=device-height, target-densitydpi=device-dpi" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>OnGes - Redefinir Senha</title>
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
                    <div class="header-body text-center mb-4">
                        <div class="row justify-content-center">
                            <div class="col-xl-5 col-lg-6 col-md-8 px-5">
                                <h1 class="text-white">Redefinir senha OnGes</h1>
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
            <%
                if(email == null && hash == null) {
            %>
            <div class="container mt--8 pb-5">
                <div class="row justify-content-center">
                    <div class="col-lg-5 col-md-7">
                        <div class="card bg-secondary border-0 mb-0">
                            <div class="card-body px-lg-5 py-lg-5">
                                <div class="text-center text-muted mb-4">
                                    <small>Insira seu endereço de e-mail.</small>
                                </div>
                                <form role="form" action="" method="post">
                                    <div class="form-group mb-3">
                                        <div class="input-group input-group-merge input-group-alternative">
                                            <div class="input-group-prepend">
                                                <span class="input-group-text"><i class="ni ni-email-83"></i></span>
                                            </div>
                                            <input class="form-control" placeholder="Endereço de E-mail (OnGes ID)" name="email_cheking" type="email">
                                        </div>
                                    </div>
                                    <div class="text-center">
                                        <button type="submit" class="btn btn-primary my-4">Redefinir Minha Senha</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <%
                } else {
            %>
            <div class="container mt--8 pb-5">
                <div class="row justify-content-center">
                    <div class="col-lg-5 col-md-7">
                        <div class="card bg-secondary border-0 mb-0">
                            <div class="card-body px-lg-5 py-lg-5">
                                <div class="text-center text-muted mb-4">
                                    <small>Nível de Segurança: <div id="erroSenhaForca"></div></small>
                                </div>
                                <form role="form" action="Login" method="post">
                                    <input type="hidden" name="hash" value="<%=hash %>">
                                    <input type="hidden" name="email" value="<%=email %>">
                                    <div class="form-group mb-3">
                                        <div class="input-group input-group-merge input-group-alternative">
                                            <div class="input-group-prepend">
                                                <span class="input-group-text"><i class="ni ni-email-83"></i></span>
                                            </div>
                                            <input class="form-control"  id="email" type="email" value="<%=ec.getLogin().getEmail() %>" disabled>
                                        </div>
                                    </div>
                                    <div class="form-group mb-3">
                                        <div class="input-group input-group-merge input-group-alternative">
                                            <div class="input-group-prepend">
                                                <span class="input-group-text"><i class="ni ni-lock-circle-open"></i></span>
                                            </div>
                                            <input class="form-control" placeholder="Nova Senha" name="password" id="password" type="password" onkeyup="validarSenhaForca()">
                                        </div>
                                    </div>
                                    <div class="form-group mb-3">
                                        <div class="input-group input-group-merge input-group-alternative">
                                            <div class="input-group-prepend">
                                                <span class="input-group-text"><i class="ni ni-lock-circle-open"></i></span>
                                            </div>
                                            <input class="form-control" placeholder="Confirmar Senha" id="confirmPassword" type="password">
                                        </div>
                                    </div>
                                    <div class="text-center">
                                        <button type="submit" class="btn btn-primary my-4">Redefinir Minha Senha</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <%
                }
            %>
        </div>
        <script src="./assets/vendor/jquery/dist/jquery.min.js"></script>
        <script src="./assets/vendor/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
        <script src="./assets/vendor/js-cookie/js.cookie.js"></script>
        <script src="./assets/vendor/jquery.scrollbar/jquery.scrollbar.min.js"></script>
        <script src="./assets/vendor/jquery-scroll-lock/dist/jquery-scrollLock.min.js"></script>
        <script src="./assets/js/argon.js?v=1.1.0"></script>
        <script src="./assets/vendor/sweetalert2/dist/sweetalert2.min.js"></script>
        <script src="./assets/vendor/bootstrap-notify/bootstrap-notify.min.js"></script>
        <script src="./assets/js/demo.min.js"></script>
        <script>
            function validarSenhaForca(){
                var senha = document.getElementById('password').value;
                var forca = 0;

                if((senha.length >= 4) && (senha.length <= 7)){
                    forca += 10;
                }else if(senha.length > 7){
                    forca += 25;
                }

                if((senha.length >= 5) && (senha.match(/[a-z]+/))){
                    forca += 10;
                }

                if((senha.length >= 6) && (senha.match(/[A-Z]+/))){
                    forca += 20;
                }

                if((senha.length >= 7) && (senha.match(/[@#$%&;*]/))){
                    forca += 25;
                }

                if(senha.match(/([1-9]+)\1{1,}/)){
                    forca += -25;
                }
            
                mostrarForca(forca);
            }

            function mostrarForca(forca){
                
                if(forca < 30 ){
                    document.getElementById("erroSenhaForca").innerHTML = "<span style='color: #ff0000'>Fraca</span>";
                }else if((forca >= 30) && (forca < 50)){
                    document.getElementById("erroSenhaForca").innerHTML = "<span style='color: #FFD700'>Média</span>";
                }else if((forca >= 50) && (forca < 70)){
                    document.getElementById("erroSenhaForca").innerHTML = "<span style='color: #7FFF00'>Forte</span>";
                }else if((forca >= 70) && (forca < 100)){
                    document.getElementById("erroSenhaForca").innerHTML = "<span style='color: #008000'>Excelente</span>";
                }
            }
        </script>
    <%
        String address = request.getParameter("email_cheking");
        if (address != null){
            EmailUtility eu = new EmailUtility();
            Emails e = new Emails();
            LoginDAO lDAO = new LoginDAO();
            EmailConfirmationDAO ecDAO = new EmailConfirmationDAO();
            Login l = lDAO.uploadByEmail(address);
            
            if(l.getId() != 0 && l.isEmailConfirm()){
                java.util.Date dataUtil = new java.util.Date();
                java.sql.Date dataSql = new java.sql.Date(dataUtil.getTime());
                EmailConfirmation eco = new EmailConfirmation();
                String name = l.getUser().getName();
                String subject = "Redefinição de senha do seu Onges ID";
                eco.setHash(eco.hashRandom());
                eco.setType("forgot-password");
                eco.setRegistrationDate(dataSql);
                eco.setLogin(l);
                ecDAO.create(eco);
                eu.sendEmail(address, subject, e.forgotPassword(name,l.getEmail(),eco.getHash()));
    %>
        <script>
            $(document).ready(function(){
                alerta();
            });
            function alerta(){
                swal('Muito Bom!', 'E-mail enviado com sucesso!', 'success');
                }
        </script>
    <%
            } else if(l.getId() != 0 && l.isEmailConfirm() == false) {
    %>
        <script>
            $(document).ready(function(){
                alerta();
            });
            function alerta(){
                swal('Aviso!', 'Endereço de E-mail não confirmado!</br>Por favor realizar a confirmação do E-mail!', 'warning');
                }
        </script> 
    <%
            } else {
    %>
        <script>
            $(document).ready(function(){
                alerta();
            });
            function alerta(){
                swal('Aviso!', 'Endereço de E-mail não encontrador!', 'warning');
                }
        </script>
    <%
            }
        }
    %>
    </body>
</html>
