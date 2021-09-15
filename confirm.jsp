<%-- 
    Document   : confirm
    Created on : 05/05/2021, 11:04:27
    Author     : Gabriel Moraes
--%>
<%@page import="model.EmailConfirmation"%>
<%@page import="model.EmailConfirmationDAO"%>
<%@page import="model.Login"%>
<%@page import="model.LoginDAO"%>
<%
    String email = request.getParameter("email");
    String hash = request.getParameter("hash");
    Login l = new Login();
    try{
        if(email != null && hash != null){
            LoginDAO lDAO = new LoginDAO();
            l = lDAO.uploadByEmail(email);
            EmailConfirmationDAO ecDAO = new EmailConfirmationDAO();
            EmailConfirmation ec = ecDAO.uploadByEmail(hash, l.getId());
        }
    }catch(Exception e){
        out.print("Erro:"+e);
    }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="user-scalable=no, initial-scale=1, maximum-scale=1, minimum-scale=1, width=device-width, height=device-height, target-densitydpi=device-dpi" />
        <!--<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">-->
        <title>OnGes</title>
        <link rel="icon" href="./assets/icon/favicon.png" type="image/png">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700">
        <link rel="stylesheet" href="./assets/vendor/nucleo/css/nucleo.css" type="text/css">
        <link rel="stylesheet" href="./assets/vendor/@fortawesome/fontawesome-free/css/all.min.css" type="text/css">
        <link rel="stylesheet" href="./assets/css/argon.css?v=1.1.0" type="text/css">
    </head>
    <body class="bg-default">
        <nav id="navbar-main" class="navbar navbar-horizontal navbar-transparent navbar-main navbar-expand-lg navbar-light">
            <div class="container">
                <a class="navbar-brand">
                    <img src="./assets/icon/onges_white.png">
                </a>
            </div>
        </nav>
        <div class="main-content">
            <div class="header bg-gradient-primary py-7 py-lg-8 pt-lg-9">
                <div class="container">
                    <div class="header-body text-center mb-7">
                        <div class="row justify-content-center">
                            <div class="col-xl-5 col-lg-6 col-md-8 px-5">
                                <h1 class="text-white">Bem-Vindo ao OnGes</h1>
                                <p class="text-lead text-white">Para confirmação da conta é necessario o cadastro de uma senha por favor confirme a senha </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="container mt--8 pb-5">
                <div class="row justify-content-center">
                    <div class="col-lg-5 col-md-7">
                        <div class="card bg-secondary border-0 mb-0">
                            <div class="card-body px-lg-5 py-lg-5">
                                <div class="text-center text-muted mb-4">
                                    <!--<small><b>Tenha deve conter:</b></small>-->
                                </div>
                                <form role="form" action="email_confirmation.do" method="post">
                                    <input type="hidden" name="id_login" value="<%=l.getId() %>">
                                    <div class="form-group">
                                        <div class="input-group input-group-merge input-group-alternative">
                                            <div class="input-group-prepend">
                                                <span class="input-group-text"><i class="ni ni-lock-circle-open"></i></span>
                                            </div>
                                            <input class="form-control" placeholder="Senha" name="password" type="password">
                                        </div>
                                    </div>
                                    <div class="text-center">
                                        <button type="submit" class="btn btn-primary my-4">Registra-se</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script src="./assets/vendor/jquery/dist/jquery.min.js"></script>
        <script src="./assets/vendor/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
        <script src="./assets/vendor/js-cookie/js.cookie.js"></script>
        <script src="./assets/vendor/jquery.scrollbar/jquery.scrollbar.min.js"></script>
        <script src="./assets/vendor/jquery-scroll-lock/dist/jquery-scrollLock.min.js"></script>
        <script src="./assets/js/argon.js?v=1.1.0"></script>
        <script src="./assets/js/demo.min.js"></script>
    </body>
</html>
