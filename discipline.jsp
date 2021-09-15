<%-- 
    Document   : discipline
    Created on : 02/07/2021, 11:32:54
    Author     : Gabriel Moraes
--%>
<%@page import="model.SchoolDAO"%>
<%@page import="model.DisciplineDAO"%>
<%@page import="model.FuncionaryDAO"%>
<%@page import="model.Discipline"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Menu"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="validate_login.jsp" %>
<%
    ArrayList<Discipline> list = new ArrayList<Discipline>();
    String url = request.getRequestURI();
    int idSchool = 0;
    DisciplineDAO dDAO = new DisciplineDAO();
    FuncionaryDAO fDAO = new FuncionaryDAO();
    SchoolDAO sDAO = new SchoolDAO();
    
    try{
        if(u.getProfile().getId() == 50){
            idSchool = sDAO.uploadByIdResponsibleSchoolUser(u.getId());
            list = dDAO.uploadBySchool(idSchool);
        }else if(u.getProfileSchool().getId() != 0){
            idSchool = fDAO.uploadByIdUser(u.getId()).getSchool().getId();
            list = dDAO.uploadBySchool(idSchool);
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
        <title>OnGes - Disciplinas</title>
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
                                <h6 class="h2 text-white d-inline-block mb-0">Disciplinas</h6>
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
                            <h3 class="mb-0">Disciplinas</h3>
                        </div>
                        <div class="table-responsive">
                            <table class="table align-items-center table-flush">
                                <thead class="thead-light">
                                    <tr>
                                        <th scope="col">#</th>
                                        <th scope="col">Nome</th>
                                        <th scope="col">Iniciais</th>
                                        <th scope="col">Tipo</th>
                                        <th scope="col">Ações</th>
                                    </tr>
                                </thead>
                                <tbody class="list">
                                    <%
                                        for(Discipline d :list){
                                    %>
                                    <tr>
                                        <th scope="row"><%=list.indexOf(d)+1 %></th>
                                        <td><%=d.getName() %></td>
                                        <td><%=d.getInitials() %></td>
                                        <%
                                            if("common".equals(d.getType())){
                                        %>
                                        <td>Comum</td>
                                        <%
                                            } else {
                                        %>
                                        <td>Diversificada</td>
                                        <%
                                            }
                                        %>
                                        <td>
                                            <a class="table-action" data-toggle="tooltip" data-original-title="Grade Curricular" href="curriculum_grid.jsp?id_discipline=<%=d.getId() %>">
                                                <i class="fas fa-list-ul text-default"></i>
                                            </a>
                                            <span data-toggle="modal" data-target="#modal-alter<%=d.getId() %>">
                                                <a class="table-action" data-toggle="tooltip" data-original-title="Editar">
                                                    <i class="fas fa-user-edit text-default"></i>
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
            int i = 0;
            for(Discipline d :list){
        %>
        <div class="modal fade" id="modal-alter<%=d.getId() %>" tabindex="-1" role="dialog" aria-labelledby="modal-default" aria-hidden="true">
            <div class="modal-dialog modal- modal-dialog-centered modal-" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h6 class="modal-title" id="modal-title-default">Editar Disciplina:</h6>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form name="edit_discipline" action="./alter_discipline.do" method="post" class="needs-validation" novalidate>
                            <input type="hidden" name="id" value="<%=d.getId() %>">
                            <div class="form-row">
                                <div class="col-md-8 mb-3">
                                    <label class="form-control-label" for="validationName">Nome</label>
                                    <input type="text" class="form-control" id="validationName" name="name" placeholder="Português" value="<%=d.getName() %>" required>
                                </div>
                                <div class="col-md-4 mb-3">
                                    <label class="form-control-label" for="validationInitials">Iniciais</label>
                                    <input type="text" class="form-control" id="validationInitials" name="initials" placeholder="Por" value="<%=d.getInitials() %>" required>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <label class="form-control-label">Tipo</label>
                                    <div class="custom-control custom-radio mb-3">
                                        <input name="common" class="custom-control-input" id="customRadio<%=i++ %>" checked="" type="radio">
                                        <label class="custom-control-label" for="customRadio<%=i-1 %>">Comum</label>
                                    </div>
                                    <div class="custom-control custom-radio mb-3">
                                        <input name="diversified" class="custom-control-input" id="customRadio<%=i++ %>" disabled="" type="radio">
                                        <label class="custom-control-label" for="customRadio<%=i-1 %>">Diversificada</label>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-control-label">Status</label>
                                    <div class="custom-control custom-checkbox mb-3">
                                        <input class="custom-control-input" id="customCheck<%=i++ %>" type="checkbox" name="additional" <%if(d.isAdditional()){%>checked<% } %> >
                                        <label class="custom-control-label" for="customCheck<%=i-1 %>">Suplementar</label>
                                    </div>
                                    <div class="custom-control custom-checkbox mb-3">
                                        <input class="custom-control-input" id="customCheck<%=i++ %>" type="checkbox" name="required" <%if(d.isRequired()){%>checked<% } %>>
                                        <label class="custom-control-label" for="customCheck<%=i-1 %>">Reprova</label>
                                    </div>
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
                        <h6 class="modal-title" id="modal-title-default">Adicionar Disciplina:</h6>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form name="create_discipline" action="./create_discipline.do" method="post" class="needs-validation" novalidate>
                            <input type="hidden" name="id_school" value="<%=idSchool %>">
                            <div class="form-row">
                                <div class="col-md-8 mb-3">
                                    <label class="form-control-label" for="validationName">Nome</label>
                                    <input type="text" class="form-control" id="validationName" name="name" placeholder="Português" required>
                                </div>
                                <div class="col-md-4 mb-3">
                                    <label class="form-control-label" for="validationInitials">Iniciais</label>
                                    <input type="text" class="form-control" id="validationInitials" name="initials" placeholder="Por" required>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <label class="form-control-label">Tipo</label>
                                    <div class="custom-control custom-radio mb-3">
                                        <input name="common" class="custom-control-input" id="customRadioAdd5" checked="" type="radio">
                                        <label class="custom-control-label" for="customRadioAdd5">Comum</label>
                                    </div>
                                    <div class="custom-control custom-radio mb-3">
                                        <input name="diversified" class="custom-control-input" id="customRadioAdd6" disabled="" type="radio">
                                        <label class="custom-control-label" for="customRadioAdd6">Diversificada</label>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-control-label">Status</label>
                                    <div class="custom-control custom-checkbox mb-3">
                                        <input class="custom-control-input" id="customCheckAdd1" type="checkbox" name="additional">
                                        <label class="custom-control-label" for="customCheckAdd1">Suplementar</label>
                                    </div>
                                    <div class="custom-control custom-checkbox mb-3">
                                        <input class="custom-control-input" id="customCheckAdd2" type="checkbox" name="required" checked="">
                                        <label class="custom-control-label" for="customCheckAdd2">Reprova</label>
                                    </div>
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
