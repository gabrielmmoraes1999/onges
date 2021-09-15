<%-- 
    Document   : dashboard
    Created on : 05/04/2021, 12:45:19
    Author     : Gabriel Moraes
--%>

<%@page import="model.TeacherDAO"%>
<%@page import="model.StudentDAO"%>
<%@page import="model.ResponsibleSchoolDAO"%>
<%@page import="model.FuncionaryDAO"%>
<%@page import="model.Funcionary"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.SchoolDAO"%>
<%@page import="model.School"%>
<%@page import="model.Menu"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="validate_login.jsp" %>
<%
    String url = request.getRequestURI();
    boolean error = false;
    int numberStudents = 0;
    int numberFuncionary = 0;
    int numberTeacher = 0;
    FuncionaryDAO fDAO = new FuncionaryDAO();
    TeacherDAO tDAO = new TeacherDAO();
    StudentDAO stDAO = new StudentDAO();
    SchoolDAO sDAO = new SchoolDAO();
    
    try{
        int idSchool = 0;
        if(u.getProfile().getId() < 50 && u.getProfile().getId() != 0){
            numberFuncionary = fDAO.countFuncionaryNoSchool();
        }else if(u.getProfile().getId() == 50){
            idSchool = sDAO.uploadByIdResponsibleSchoolUser(u.getId());
            numberFuncionary = fDAO.countFuncionarySchool(idSchool);
            numberStudents = stDAO.countStudentSchool(idSchool);
            numberTeacher = tDAO.countTeacherSchool(idSchool);
        }else if(u.getProfile().getId() == 0 && u.getProfileSchool().getId() != 0){
            numberFuncionary = fDAO.countFuncionarySchool(u.getProfileSchool().getSchool().getId());
        }
    }catch(Exception e){
        error = true;
        //out.print("Erro:"+e);
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>OnGes - Dashboard</title>
        <link rel="icon" href="./assets/icon/favicon.png" type="image/png">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700">
        <link rel="stylesheet" href="./assets/vendor/animate.css/animate.min.css">
        <link rel="stylesheet" href="./assets/vendor/nucleo/css/nucleo.css" type="text/css">
        <link rel="stylesheet" href="./assets/vendor/@fortawesome/fontawesome-free/css/all.min.css" type="text/css">
        <link rel="stylesheet" href="./assets/css/argon.css?v=1.1.0" type="text/css">
    </head>
    <body>
        <%@include file="list_menu.jsp" %>
        <div class="main-content" id="panel">
            <%@include file="info_user.jsp" %>
            <div class="header bg-default pb-6">
                <div class="container-fluid">
                    <div class="header-body">
                        <div class="row align-items-center py-4">
                            <div class="col-lg-6 col-7">
                                <h6 class="h2 text-white d-inline-block mb-0">Dashboard</h6>
                                <nav aria-label="breadcrumb" class="d-none d-md-inline-block ml-md-4">
                                    <ol class="breadcrumb breadcrumb-links breadcrumb-dark">
                                        <li class="breadcrumb-item"><a ><i class="fas fa-home"></i></a></li>
                                        <li class="breadcrumb-item"><a href="dashboard.jsp">Dashboard</a></li>
                                    </ol>
                                </nav>
                            </div>
                            <!--<div class="col-lg-6 col-5 text-right">
                                <a href="#" class="btn btn-sm btn-neutral">New</a>
                                <a href="#" class="btn btn-sm btn-neutral">Filters</a>
                            </div>-->
                        </div>
                        <div class="row">
                            <div class="col-xl-3 col-md-6">
                                <div class="card card-stats">
                                    <div class="card-body">
                                        <div class="row">
                                            <div class="col">
                                                <h5 class="card-title text-uppercase text-muted mb-0">Alunos</h5>
                                                <span class="h2 font-weight-bold mb-0"><%=numberStudents %></span>
                                            </div>
                                            <div class="col-auto">
                                                <div class="icon icon-shape bg-gradient-red text-white rounded-circle shadow">
                                                    <i class="fas fa-user-graduate"></i>
                                                </div>
                                            </div>
                                        </div>
                                        <!--<p class="mt-3 mb-0 text-sm">
                                            <span class="text-success mr-2"><i class="fa fa-arrow-up"></i> 3.48%</span>
                                            <span class="text-nowrap">Desde o último mês</span>
                                        </p>-->
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-3 col-md-6">
                                <div class="card card-stats">
                                    <div class="card-body">
                                        <div class="row">
                                            <div class="col">
                                                <h5 class="card-title text-uppercase text-muted mb-0">Funcionários</h5>
                                                <span class="h2 font-weight-bold mb-0"><%=numberFuncionary %></span>
                                            </div>
                                            <div class="col-auto">
                                                <div class="icon icon-shape bg-gradient-orange text-white rounded-circle shadow">
                                                    <i class="fas fa-user-tie"></i>
                                                </div>
                                            </div>
                                        </div>
                                        <!--<p class="mt-3 mb-0 text-sm">
                                            <span class="text-success mr-2"><i class="fa fa-arrow-up"></i> 3.48%</span>
                                            <span class="text-nowrap">Desde o último mês</span>
                                        </p>-->
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-3 col-md-6">
                                <div class="card card-stats">
                                    <div class="card-body">
                                        <div class="row">
                                            <div class="col">
                                                <h5 class="card-title text-uppercase text-muted mb-0">Professores</h5>
                                                <span class="h2 font-weight-bold mb-0"><%=numberTeacher %></span>
                                            </div>
                                            <div class="col-auto">
                                                <div class="icon icon-shape bg-gradient-green text-white rounded-circle shadow">
                                                    <i class="fas fa-chalkboard-teacher"></i>
                                                </div>
                                            </div>
                                        </div>
                                        <!--<p class="mt-3 mb-0 text-sm">
                                            <span class="text-success mr-2"><i class="fa fa-arrow-up"></i> 3.48%</span>
                                            <span class="text-nowrap">Desde o último mês</span>
                                        </p>-->
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-3 col-md-6">
                                <div class="card card-stats">
                                    <div class="card-body">
                                        <div class="row">
                                            <div class="col">
                                                <h5 class="card-title text-uppercase text-muted mb-0">Suporte</h5>
                                                <span class="h2 font-weight-bold mb-0">0%</span>
                                            </div>
                                            <div class="col-auto">
                                                <div class="icon icon-shape bg-gradient-info text-white rounded-circle shadow">
                                                    <i class="ni ni-chart-bar-32"></i>
                                                </div>
                                            </div>
                                        </div>
                                        <!--<p class="mt-3 mb-0 text-sm">
                                            <span class="text-success mr-2"><i class="fa fa-arrow-up"></i> 3.48%</span>
                                            <span class="text-nowrap">Desde o último mês</span>
                                        </p>-->
                                    </div>
                                </div>
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
        <script src="./assets/vendor/chart.js/dist/Chart.min.js"></script>
        <script src="./assets/vendor/chart.js/dist/Chart.extension.js"></script>
        <script src="./assets/vendor/bootstrap-notify/bootstrap-notify.min.js"></script>
        <script src="./assets/js/argon.js?v=1.1.0"></script>
        <script src="./assets/js/demo.min.js"></script>
        <%
            if(error){
        %>
        <script>
            $(document).ready(function(){
                alerta();
            });
            function alerta(){
                $.notify("Ocorreu um erro inesperado!", {
                    animate: {
                        enter: 'animated bounceInDown',
                        exit: 'animated bounceOutUp'
                    },
                    type: 'danger'
                });
            }
        </script>
        <%
            }
        %>
    </body>
</html>
