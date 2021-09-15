<%-- 
    Document   : class_room
    Created on : 12/06/2021, 10:10:42
    Author     : Gabriel Moraes
--%>

<%@page import="model.ClassRoomDAO"%>
<%@page import="model.CourseDAO"%>
<%@page import="model.SchoolDAO"%>
<%@page import="model.ResponsibleSchoolDAO"%>
<%@page import="model.FuncionaryDAO"%>
<%@page import="model.Funcionary"%>
<%@page import="model.Course"%>
<%@page import="model.ClassRoom"%>
<%@page import="model.Menu"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="validate_login.jsp" %>
<%
    ArrayList<ClassRoom> list = new ArrayList<ClassRoom>();
    ArrayList<Course> listCo = new ArrayList<Course>();
    ArrayList<Funcionary> listF = new ArrayList<Funcionary>();
    String url = request.getRequestURI();
    
    int idSchool = 0;
    ClassRoomDAO crDAO = new ClassRoomDAO();
    CourseDAO cDAO = new CourseDAO();
    FuncionaryDAO fDAO = new FuncionaryDAO();
    SchoolDAO sDAO = new SchoolDAO();
    
    try{
        if(u.getProfile().getId() == 50){
            idSchool = sDAO.uploadByIdResponsibleSchoolUser(u.getId());
            list = crDAO.uploadBySchool(idSchool);
            listCo = cDAO.uploadBySchoolLite(idSchool);
            listF = fDAO.uploadBySchoolLite(idSchool);
        }else if(u.getProfileSchool().getId() != 0){
            idSchool = fDAO.uploadByIdUser(u.getId()).getSchool().getId();
            list = crDAO.uploadBySchool(idSchool);
            listCo = cDAO.uploadBySchoolLite(idSchool);
            listF = fDAO.uploadBySchoolLite(idSchool);
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
        <title>OnGes - Sala de Aula</title>
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
                                <h6 class="h2 text-white d-inline-block mb-0">Salas de aula</h6>
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
                            <h3 class="mb-0">Salas de aula</h3>
                        </div>
                        <div class="table-responsive">
                            <table class="table align-items-center table-flush">
                                <thead class="thead-light">
                                    <tr>
                                        <th scope="col">#</th>
                                        <th scope="col">Ano/Turma</th>
                                        <th scope="col">Curso</th>
                                        <th scope="col">Turno</th>
                                        <th scope="col">Coordenador(a)</th>
                                        <th scope="col">Ações</th>
                                    </tr>
                                </thead>
                                <tbody class="list">
                                    <%
                                        for(ClassRoom cr:list){
                                    %>
                                    <tr>
                                        <th scope="row"><%=list.indexOf(cr)+1 %></th>
                                        <td><%=cr.getYear()+"ª "+cr.getTeam() %></td>
                                        <td><%=cr.getCourse().getName() %></td>
                                        <td><%=cr.getShift() %></td>
                                        <td><%=cr.getFuncionary().getFullName() %></td>
                                        <td>
                                            <span data-toggle="modal" data-target="#modal-alter<%=cr.getId() %>">
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
            for(ClassRoom cr:list){
        %>
        <div class="modal fade" id="modal-alter<%=cr.getId() %>" tabindex="-1" role="dialog" aria-labelledby="modal-default" aria-hidden="true">
            <div class="modal-dialog modal- modal-dialog-centered modal-" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h6 class="modal-title" id="modal-title-default">Editar Sala de Aula:</h6>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form name="alter_class_room" action="./alter_class_room.do" method="post" class="needs-validation" novalidate>
                            <input type="hidden" name="id" value="<%=cr.getId() %>">
                            <div class="form-row">
                                <div class="col-md-12 mb-3">
                                    <label class="form-control-label">Escolher Curso</label>
                                    <select class="form-control" name="id_course">
                                    <%
                                        for(Course co:listCo){
                                    %>
                                        <option value="<%=co.getId() %>" <% if(co.getId() == cr.getCourse().getId()){%>selected<%}%>><%=co.getName() %></option>
                                    <%
                                        }
                                    %>
                                    </select>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="col-md-3 mb-3">
                                    <label class="form-control-label" for="validationYear">Ano</label>
                                    <input type="number" class="form-control" id="validationYear" name="year" value="<%=cr.getYear() %>" placeholder="Ano" required>
                                </div>
                                <div class="col-md-3 mb-3">
                                    <label class="form-control-label" for="validationTeam">Turma</label>
                                    <input type="text" class="form-control" id="validationTeam" name="team" value="<%=cr.getTeam() %>" placeholder="Turma" required>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-control-label" for="validationShift">Turno</label>
                                    <select class="form-control" name="shift">
                                        <option value="Matutino" <% if(cr.getShift().equals("Matutino")){%>selected<%}%>>Matutino</option>
                                        <option value="Vespertino" <% if(cr.getShift().equals("Vespertino")){%>selected<%}%>>Vespertino</option>
                                        <option value="Noturno" <% if(cr.getShift().equals("Noturno")){%>selected<%}%>>Noturno</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-control-label" for="validationTotalStudents">Total de Alunos</label>
                                    <input type="number" class="form-control" id="validationTotalStudents" name="total_students" value="<%=cr.getTotalStudents() %>" placeholder="Total de Alunos" required>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-control-label" for="validationClassNumber">N° da Sala</label>
                                    <input type="number" class="form-control" id="validationClassNumber" name="class_number" value="<%=cr.getClassNumber() %>" placeholder="N° da Sala" required>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="col-md-12 mb-3">
                                    <label class="form-control-label" for="validationCoordinator">Coordenador(a)</label>
                                    <select class="form-control" data-toggle="select" name="id_funcionary">
                                    <%
                                        for(Funcionary f:listF){
                                    %>
                                        <option value="<%=f.getId() %>" <% if(f.getId() == cr.getFuncionary().getId()){%>selected<%}%>><%=f.getFullName() %></option>
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
                        <h6 class="modal-title" id="modal-title-default">Adicionar Sala de Aula:</h6>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form name="create_class_room" action="./create_class_room.do" method="post" class="needs-validation" novalidate>
                            <input type="hidden" name="id_school" value="<%=idSchool %>">
                            <div class="form-row">
                                <div class="col-md-12 mb-3">
                                    <label class="form-control-label">Escolher Curso</label>
                                    <select class="form-control" name="id_course">
                                    <%
                                        for(Course co:listCo){
                                    %>
                                        <option value="<%=co.getId() %>"><%=co.getName() %></option>
                                    <%
                                        }
                                    %>
                                    </select>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="col-md-3 mb-3">
                                    <label class="form-control-label" for="validationYear">Ano</label>
                                    <input type="number" class="form-control" id="validationYear" name="year" placeholder="Ano" required>
                                </div>
                                <div class="col-md-3 mb-3">
                                    <label class="form-control-label" for="validationTeam">Turma</label>
                                    <input type="text" class="form-control" id="validationTeam" name="team" placeholder="Turma" required>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-control-label" for="validationShift">Turno</label>
                                    <select class="form-control" name="shift">
                                        <option value="Matutino">Matutino</option>
                                        <option value="Vespertino">Vespertino</option>
                                        <option value="Noturno">Noturno</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-control-label" for="validationTotalStudents">Total de Alunos</label>
                                    <input type="number" class="form-control" id="validationTotalStudents" name="total_students" placeholder="Total de Alunos" required>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-control-label" for="validationClassNumber">N° da Sala</label>
                                    <input type="number" class="form-control" id="validationClassNumber" name="class_number" placeholder="N° da Sala" required>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="col-md-12 mb-3">
                                    <label class="form-control-label" for="validationCoordinator">Coordenador(a)</label>
                                    <select class="form-control" data-toggle="select" name="id_funcionary">
                                        <option></option>
                                    <%
                                        for(Funcionary f:listF){
                                    %>
                                        <option value="<%=f.getId() %>"><%=f.getFullName() %></option>
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
