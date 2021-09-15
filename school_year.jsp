<%-- 
    Document   : school_year
    Created on : 30/06/2021, 15:07:23
    Author     : Gabriel Moraes
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="model.FuncionaryDAO"%>
<%@page import="model.SchoolDAO"%>
<%@page import="model.SchoolYearDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.SchoolYear"%>
<%@page import="model.Menu"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="validate_login.jsp" %>
<%
    ArrayList<SchoolYear> list = new ArrayList<SchoolYear>();
    String url = request.getRequestURI();
    int idSchool = 0;
    FuncionaryDAO fDAO = new FuncionaryDAO();
    SchoolYearDAO syDAO = new SchoolYearDAO();
    SchoolDAO sDAO = new SchoolDAO();
    DateFormat fmt = new SimpleDateFormat("dd/MM/yyyy");
    
    try{
        if(u.getProfile().getId() == 50){
            idSchool = sDAO.uploadByIdResponsibleSchoolUser(u.getId());
            list = syDAO.uploadBySchoolLite(idSchool);
        }else if(u.getProfileSchool().getId() != 0){
            idSchool = fDAO.uploadByIdUser(u.getId()).getSchool().getId();
            list = syDAO.uploadBySchoolLite(idSchool);
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
        <link rel="stylesheet" href="./assets/vendor/select2/dist/css/select2.min.css">
        <link rel="stylesheet" href="./assets/vendor/quill/dist/quill.core.css">
        <link rel="stylesheet" href="./assets/css/argon.min.css?v=1.2.1" type="text/css">
        <title>OnGes - Ano Letivo</title>
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
                                <h6 class="h2 text-white d-inline-block mb-0">Anos Letivos</h6>
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
                            <h3 class="mb-0">Anos Letivos</h3>
                        </div>
                        <div class="table-responsive">
                            <table class="table align-items-center table-flush">
                                <thead class="thead-light">
                                    <tr>
                                        <th scope="col">#</th>
                                        <th scope="col">Ano</th>
                                        <th scope="col">Data de Inicio</th>
                                        <th scope="col">N° Período</th>
                                        <th scope="col">Tipo</th>
                                        <th scope="col">Ações</th>
                                    </tr>
                                </thead>
                                <tbody class="list">
                                    <%
                                        for(SchoolYear sy:list){
                                    %>
                                    <tr>
                                        <th scope="row"><%=list.indexOf(sy)+1 %></th>
                                        <td><%=sy.getYear() %></td>
                                        <td><%=fmt.format(sy.getStartingMonth()) %></td>
                                        <td><%=sy.getPeriodNumber() %></td>
                                        <td><%=sy.getPeriodType() %></td>
                                        <td>
                                            <span data-toggle="modal" data-target="#modal-alter<%=sy.getId() %>">
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
            for(SchoolYear sy:list){
        %>
        <div class="modal fade" id="modal-alter<%=sy.getId() %>" tabindex="-1" role="dialog" aria-labelledby="modal-default" aria-hidden="true">
            <div class="modal-dialog modal- modal-dialog-centered modal-" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h6 class="modal-title" id="modal-title-default">Editar Anos Letivos:</h6>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form name="create_school_year" action="./alter_school_year.do" method="post" class="needs-validation" novalidate>
                            <input type="hidden" name="id" value="<%=sy.getId() %>">
                            <input type="hidden" name="id_school" value="<%=idSchool %>">
                            <div class="form-row">
                                <div class="col-md-3 mb-3">
                                    <label class="form-control-label" for="validationYear">Ano</label>
                                    <input type="number" class="form-control" id="validationYear" name="year" placeholder="2021" value="<%=sy.getYear() %>" required>
                                </div>
                                <div class="col-md-4 mb-3">
                                    <label class="form-control-label" for="validationDescription">Descrição</label>
                                    <input type="text" class="form-control" id="validationDescription" name="description" placeholder="2021" value="<%=sy.getDescription() %>" required>
                                </div>
                                <div class="col-md-5 mb-3">
                                    <label for="example-date-input" class="form-control-label" for="startingMonth">Data de Inicio</label>
                                    <div>
                                        <input class="form-control" name="starting_month" type="date" id="startingMonth" value="<%=sy.getStartingMonth() %>" required>
                                    </div>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-control-label" for="validationPeriodNumber">N° de Períodos</label>
                                    <input type="number" class="form-control" id="validationPeriodNumber" name="period_number" placeholder="4" value="<%=sy.getPeriodNumber() %>" required>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-control-label" for="validationShift">Tipo do Período</label>
                                    <select class="form-control" name="period_type">
                                        <option value="Bismestre" <% if(sy.getPeriodType().equals("Bismestre")){%>selected<%}%>>Bismestre</option>
                                        <option value="Semestre" <% if(sy.getPeriodType().equals("Semestre")){%>selected<%}%>>Semestre</option>
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
                        <h6 class="modal-title" id="modal-title-default">Adicionar Anos Letivos:</h6>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form name="create_school_year" action="./create_school_year.do" method="post" class="needs-validation" novalidate>
                            <input type="hidden" name="id_school" value="<%=idSchool %>">
                            <div class="form-row">
                                <div class="col-md-3 mb-3">
                                    <label class="form-control-label" for="validationYear">Ano</label>
                                    <input type="number" class="form-control" id="validationYear" name="year" placeholder="2021" required>
                                </div>
                                <div class="col-md-4 mb-3">
                                    <label class="form-control-label" for="validationDescription">Descrição</label>
                                    <input type="text" class="form-control" id="validationDescription" name="description" placeholder="2021" required>
                                </div>
                                <div class="col-md-5 mb-3">
                                    <label for="example-date-input" class="form-control-label" for="startingMonth">Data de Inicio</label>
                                    <div>
                                        <input class="form-control" name="starting_month" type="date" id="startingMonth" required>
                                    </div>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-control-label" for="validationPeriodNumber">N° de Períodos</label>
                                    <input type="number" class="form-control" id="validationPeriodNumber" name="period_number" placeholder="4" required>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-control-label" for="validationPediodType">Tipo do Período</label>
                                    <select class="form-control" name="period_type">
                                        <option value="Bimestre">Bimestre</option>
                                        <option value="Semestre">Semestre</option>
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
        <script src="./assets/vendor/select2/dist/js/select2.min.js"></script>
        <script src="./assets/vendor/bootstrap-datepicker/dist/js/bootstrap-datepicker.min.js"></script>
        <script src="./assets/vendor/moment.min.js"></script>
        <script src="./assets/vendor/bootstrap-datetimepicker.js"></script>
        <script src="./assets/vendor/nouislider/distribute/nouislider.min.js"></script>
        <script src="./assets/vendor/quill/dist/quill.min.js"></script>
        <script src="./assets/vendor/dropzone/dist/min/dropzone.min.js"></script>
        <script src="./assets/vendor/bootstrap-tagsinput/dist/bootstrap-tagsinput.min.js"></script>
        <script src="./assets/js/argon.js?v=1.2.1"></script>
        <script src="./assets/js/demo.min.js"></script>
    </body>
</html>
