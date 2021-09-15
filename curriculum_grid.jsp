<%-- 
    Document   : manage_curriculum_grid
    Created on : 02/07/2021, 15:21:23
    Author     : Gabriel Moraes
--%>

<%@page import="model.DisciplineDAO"%>
<%@page import="model.Discipline"%>
<%@page import="model.SchoolDAO"%>
<%@page import="model.ResponsibleSchoolDAO"%>
<%@page import="model.FuncionaryDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.CourseDAO"%>
<%@page import="model.Course"%>
<%@page import="model.Menu"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="validate_login.jsp" %>
<%
    String url = request.getRequestURI();
    ArrayList<Course> list = new ArrayList<Course>();
    Discipline d = new Discipline();
    FuncionaryDAO fDAO = new FuncionaryDAO();
    ResponsibleSchoolDAO rsDAO = new ResponsibleSchoolDAO();
    SchoolDAO sDAO = new SchoolDAO();
    CourseDAO cDAO = new CourseDAO();
    DisciplineDAO dDAO = new DisciplineDAO();
    int idSchool = 0;
    int idDiscipline = Integer.parseInt(request.getParameter("id_discipline"));
    
    d = dDAO.uploadByIdLite(idDiscipline);
    
    try{
        if(u.getProfile().getId() == 50){
            idSchool = sDAO.uploadByResponsibleSchool(rsDAO.uploadByUser(u.getId()).getId()).getId();
            list = cDAO.uploadBySchool(idSchool);
        }else if(u.getProfileSchool().getId() != 0){
            idSchool = fDAO.uploadByIdUser(u.getId()).getSchool().getId();
            list = cDAO.uploadBySchool(idSchool);
        }
    }catch(Exception e){
        out.print("Erro:"+e);
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="user-scalable=no, initial-scale=1, maximum-scale=1, minimum-scale=1, width=device-width, height=device-height, target-densitydpi=device-dpi" />
        <link rel="icon" href="./assets/icon/favicon.png" type="image/png">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700">
        <link rel="stylesheet" href="./assets/vendor/nucleo/css/nucleo.css" type="text/css">
        <link rel="stylesheet" href="./assets/vendor/@fortawesome/fontawesome-free/css/all.min.css" type="text/css">
        <link rel="stylesheet" href="./assets/vendor/datatables.net-bs4/css/dataTables.bootstrap4.min.css">
        <link rel="stylesheet" href="./assets/vendor/datatables.net-buttons-bs4/css/buttons.bootstrap4.min.css">
        <link rel="stylesheet" href="./assets/vendor/datatables.net-select-bs4/css/select.bootstrap4.min.css">
        <link rel="stylesheet" href="./assets/css/argon.min.css?v=1.2.0" type="text/css">
        <title>OnGes - Grade Curricular</title>
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
                                <h6 class="h2 text-white d-inline-block mb-0">Grade Curricular</h6>
                                <nav aria-label="breadcrumb" class="d-none d-md-inline-block ml-md-4">
                                    <ol class="breadcrumb breadcrumb-links breadcrumb-dark">
                                        <li class="breadcrumb-item"><a><i class="fas fa-home"></i></a></li>
                                        <li class="breadcrumb-item"><a>Disciplina</a></li>
                                        <li class="breadcrumb-item active" aria-current="page">Grade Curricular: <%=d.getName() %></li>
                                    </ol>
                                </nav>
                            </div>
                            <div class="col-lg-6 col-5 text-right">
                                <a class="btn btn-sm btn-neutral" href="discipline.jsp">
                                    Voltar
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="container-fluid mt--6">
                <div class="col">
                    <div class="card">
                        <form action="./alter_teachdfsder.do" method="get">
                        <div class="card-header">
                            <div class="row align-items-center">
                                <div class="col-8">
                                    <h3 class="mb-0">Grade Curricular</h3>
                                </div>
                                <div class="col-4 text-right">
                                    <button type="submit" class="btn btn-sm btn-primary">Salvar</button>
                                </div>
                            </div>
                        </div>
                        <div class="table-responsive">
                            <table class="table align-items-center table-flush">
                                <thead class="thead-light">
                                    <tr>
                                        <!--<th scope="col">#</th>-->
                                        <th scope="col">Nome do Curso</th>
                                        <th scope="col">Ano</th>
                                        <th scope="col">Carga Horária</th>
                                    </tr>
                                </thead>
                                <tbody class="list">
                                    <%
                                        for(Course c:list){
                                            for(int i=c.getNumberSeries();i >= 1;i--){
                                    %>
                                    <tr>
                                        <!--<th scope="row"></th>-->
                                        <td><b><%=c.getName() %></b></td>
                                        <td><b><%=i+"ª" %></b></td>
                                        <td>
                                            <input type="hidden" name="id_course" value="<%=c.getId() %>">
                                            <input type="hidden" name="year" value="<%=i %>">
                                            <input type="number" class="col-md-3 form-control form-control-sm" name="workload">
                                            <input type="hidden" name="id_discipline" value="<%=idDiscipline %>">
                                        </td>
                                    </tr>
                                    <%
                                            }
                                        }
                                    %>
                                </tbody>
                            </table>
                        </div>
                        </form>
                    </div>
                </div>
                <footer class="footer pt-0">
                    <div class="row align-items-center justify-content-lg-between">
                        <div class="col-lg-6">
                            <div class="copyright text-center text-lg-left text-muted">
                                &copy; 2021 <a href="" class="font-weight-bold ml-1" target="_blank">OnGes</a>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <ul class="nav nav-footer justify-content-center justify-content-lg-end">
                                <li class="nav-item">
                                    <a href="" class="nav-link" target="_blank">OnGes</a>
                                </li>
                                <li class="nav-item">
                                    <a href="" class="nav-link" target="_blank">Sobre</a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </footer>
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
