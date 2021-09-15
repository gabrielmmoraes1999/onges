<%-- 
    Document   : course
    Created on : 06/06/2021, 16:33:54
    Author     : Gabriel Moraes
--%>

<%@page import="model.FuncionaryDAO"%>
<%@page import="model.SchoolDAO"%>
<%@page import="model.ResponsibleSchoolDAO"%>
<%@page import="model.CourseDAO"%>
<%@page import="model.Course"%>
<%@page import="model.Menu"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="validate_login.jsp" %>
<%
    String url = request.getRequestURI();
    ArrayList<Course> list = new ArrayList<Course>();
    CourseDAO cDAO = new CourseDAO();
    FuncionaryDAO fDAO = new FuncionaryDAO();
    SchoolDAO sDAO = new SchoolDAO();
    int idSchool = 0;
    
    try{
        if(u.getProfile().getId() == 50){
            idSchool = sDAO.uploadByIdResponsibleSchoolUser(u.getId());
            list = cDAO.uploadBySchoolLite(idSchool);
        }else if(u.getProfileSchool().getId() != 0){
            idSchool = fDAO.uploadByIdUser(u.getId()).getSchool().getId();
            list = cDAO.uploadBySchoolLite(idSchool);
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
        <!--<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">-->
        <link rel="icon" href="./assets/icon/favicon.png" type="image/png">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700">
        <link rel="stylesheet" href="./assets/vendor/nucleo/css/nucleo.css" type="text/css">
        <link rel="stylesheet" href="./assets/vendor/@fortawesome/fontawesome-free/css/all.min.css" type="text/css">
        <link rel="stylesheet" href="./assets/vendor/datatables.net-bs4/css/dataTables.bootstrap4.min.css">
        <link rel="stylesheet" href="./assets/vendor/datatables.net-buttons-bs4/css/buttons.bootstrap4.min.css">
        <link rel="stylesheet" href="./assets/vendor/datatables.net-select-bs4/css/select.bootstrap4.min.css">
        <link rel="stylesheet" href="./assets/css/argon.min.css?v=1.2.0" type="text/css">
        <title>OnGes - Cursos</title>
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
                                <h6 class="h2 text-white d-inline-block mb-0">Cursos</h6>
                                <nav aria-label="breadcrumb" class="d-none d-md-inline-block ml-md-4">
                                    <ol class="breadcrumb breadcrumb-links breadcrumb-dark">
                                        <li class="breadcrumb-item"><a><i class="fas fa-home"></i></a></li>
                                        <li class="breadcrumb-item"><a>Gerenciar</a></li>
                                    </ol>
                                </nav>
                            </div>
                            <div class="col-lg-6 col-5 text-right">
                                <button class="btn btn-sm btn-neutral" data-toggle="modal" data-target="#modal-create" >
                                    Adicionar
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="container-fluid mt--6">
                <div class="col">
                    <div class="card">
                        <div class="card-header">
                            <h3 class="mb-0">Cursos</h3>
                        </div>
                        <div class="table-responsive">
                            <table class="table align-items-center table-flush">
                                <thead class="thead-light">
                                    <tr>
                                        <th scope="col">#</th>
                                        <th scope="col">Nome</th>
                                        <th scope="col">Abreviação</th>
                                        <th scope="col">Ações</th>
                                    </tr>
                                </thead>
                                <tbody class="list">
                                    <%
                                        for(Course c:list){
                                    %>
                                    <tr>
                                        <th scope="row">
                                            <%=list.indexOf(c)+1 %>
                                        </th>
                                        <td>
                                            <%=c.getName() %>
                                        </td>
                                        <td>
                                            <%=c.getAbbreviation() %>
                                        </td>
                                        <td>
                                            <span data-toggle="modal" data-target="#modal-alter<%=c.getId() %>">
                                                <a class="table-action" data-toggle="tooltip" data-original-title="Editar">
                                                    <i class="fas fa-user-edit"></i>
                                                </a>
                                            </span>
                                        </td>
                                    </tr>
                                    <%
                                        }
                                    %>
                                </tbody>
                            </table>
                        </div>
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
        <%
            for(Course c:list){
        %>
        <div class="modal fade" id="modal-alter<%=c.getId() %>" tabindex="-1" role="dialog" aria-labelledby="modal-default" aria-hidden="true">
            <div class="modal-dialog modal- modal-dialog-centered modal-" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h6 class="modal-title" id="modal-title-default">Editar Curso:</h6>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form name="alter_profile" action="./alter_course.do" method="post" class="needs-validation" novalidate>
                            <input type="hidden" name="id" value="<%=c.getId() %>">
                            <input type="hidden" name="id_school" value="<%=idSchool %>">
                            <div class="form-row">
                                <div class="col-md-12 mb-3">
                                    <label class="form-control-label" for="validationName">Nome</label>
                                    <input type="text" class="form-control" id="validationName" name="name" value="<%=c.getName() %>" placeholder="Nome do curso" required>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-control-label" for="validationNumberSeries">Quantidade de Séries</label>
                                    <input type="text" class="form-control" id="validationNumberSeries" name="number_series" value="<%=c.getNumberSeries() %>" placeholder="Quantidade de Séries" required>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-control-label" for="validationAbbreviation">Abreviação</label>
                                    <input type="text" class="form-control" id="validationAbbreviation" name="abbreviation" value="<%=c.getAbbreviation() %>" placeholder="Abreviação" required>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="col-md-12 mb-3">
                                    <label class="form-control-label" for="validationNextCourse">Próximo Curso</label>
                                    <select name="id_course" class="form-control" id="validationNextCourse">
                                        <option value="0">Nenhum</option>
                                    <%
                                        for(Course cs:list){
                                    %>
                                        <option value="<%=cs.getId() %>" <%if(cs.getId() == c.getCourse().getId()){%>selected<%} %>><%=cs.getName() %></option>
                                    <%
                                        }
                                    %>
                                    </select>
                                </div>
                            </div>
                            <button type="submit" class="btn btn-primary">Salvar</button>
                            <button type="button" class="btn btn-link  ml-auto" data-dismiss="modal">Fechar</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <%
            }
        %>
        <div class="modal fade" id="modal-create" tabindex="-1" role="dialog" aria-labelledby="modal-default" aria-hidden="true">
            <div class="modal-dialog modal- modal-dialog-centered modal-" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h6 class="modal-title" id="modal-title-default">Adicionar Curso:</h6>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form name="create_profile" action="./create_course.do" method="post" class="needs-validation" novalidate>
                            <input type="hidden" name="id_school" value="<%=idSchool %>">
                            <div class="form-row">
                                <div class="col-md-12 mb-3">
                                    <label class="form-control-label" for="validationName">Nome</label>
                                    <input type="text" class="form-control" id="validationName" name="name" placeholder="Nome do curso" required>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-control-label" for="validationNumberSeries">Quantidade de Séries</label>
                                    <input type="text" class="form-control" id="validationNumberSeries" name="number_series" placeholder="Quantidade de Séries" required>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-control-label" for="validationAbbreviation">Abreviação</label>
                                    <input type="text" class="form-control" id="validationAbbreviation" name="abbreviation" placeholder="Abreviação" required>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="col-md-12 mb-3">
                                    <label class="form-control-label" for="validationNextCourse">Próximo Curso</label>
                                    <select name="id_course" class="form-control" id="validationNextCourse">
                                        <option value="0">Nenhum</option>
                                    <%
                                        for(Course c:list){
                                    %>
                                        <option value="<%=c.getId() %>"><%=c.getName() %></option>
                                    <%
                                        }
                                    %>
                                    </select>
                                </div>
                            </div>
                            <button type="submit" class="btn btn-primary">Salvar</button>
                            <button type="button" class="btn btn-link  ml-auto" data-dismiss="modal">Fechar</button>
                        </form>
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
