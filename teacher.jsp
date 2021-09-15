<%-- 
    Document   : teacher
    Created on : 24/05/2021, 16:57:56
    Author     : Gabriel Moraes
--%>
<%@page import="model.Discipline"%>
<%@page import="model.FuncionaryDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="model.SchoolDAO"%>
<%@page import="model.ResponsibleSchoolDAO"%>
<%@page import="model.TeacherDAO"%>
<%@page import="model.Teacher"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Menu"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="validate_login.jsp" %>
<%
    ArrayList<Teacher> list = new ArrayList<Teacher>();
    ArrayList<Discipline> listD = new ArrayList<Discipline>();
    String url = request.getRequestURI();
    boolean error = false;
    int idSchool = 0;
    SchoolDAO sDAO = new SchoolDAO();
    FuncionaryDAO fDAO = new FuncionaryDAO();
    
    try{
        
        if(u.getProfile().getId() == 50){
            //Carregar por Responsavel da Escola
            idSchool = sDAO.uploadByIdResponsibleSchoolUser(u.getId());
        } else if(u.getProfileSchool().getId() != 0){
            //Carregar por Funcionario da Escola
            idSchool = fDAO.uploadByIdUser(u.getId()).getSchool().getId();
        }
        list = sDAO.myTeacher(idSchool);
    }catch(Exception e){
        error = true;
        //out.print("Erro:"+e);
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="user-scalable=no, initial-scale=1, maximum-scale=1, minimum-scale=1, width=device-width, height=device-height, target-densitydpi=device-dpi" />
        <title>OnGes - Professores</title>
        <link rel="icon" href="./assets/icon/favicon.png" type="image/png">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700">
        <link rel="stylesheet" href="./assets/vendor/nucleo/css/nucleo.css" type="text/css">
        <link rel="stylesheet" href="./assets/vendor/animate.css/animate.min.css">
        <link rel="stylesheet" href="./assets/vendor/@fortawesome/fontawesome-free/css/all.min.css" type="text/css">
        <link rel="stylesheet" href="./assets/vendor/datatables.net-bs4/css/dataTables.bootstrap4.min.css">
        <link rel="stylesheet" href="./assets/vendor/datatables.net-buttons-bs4/css/buttons.bootstrap4.min.css">
        <link rel="stylesheet" href="./assets/vendor/datatables.net-select-bs4/css/select.bootstrap4.min.css">
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
                                <h6 class="h2 text-white d-inline-block mb-0">Professores</h6>
                                <nav aria-label="breadcrumb" class="d-none d-md-inline-block ml-md-4">
                                  <ol class="breadcrumb breadcrumb-links breadcrumb-dark">
                                    <li class="breadcrumb-item"><a><i class="fas fa-home"></i></a></li>
                                    <li class="breadcrumb-item active" aria-current="page">Gerenciar</li>
                                  </ol>
                                </nav>
                            </div>
                            <div class="col-lg-6 col-5 text-right">
                                <form name="add_teacher" action="./add_teacher.jsp" method="post">
                                    <input type="hidden" name="id_school" value="<%=idSchool %>">
                                    <button class="btn btn-sm btn-neutral" type="submit">Adicionar</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="container-fluid mt--6">
                <div class="col">
                    <div class="card">
                        <div class="card-header">
                            <h3 class="mb-0">Professores</h3>
                        </div>
                        <div class="table-responsive">
                            <table class="table align-items-center table-flush">
                                <thead class="thead-light">
                                    <tr>
                                        <th>#</th>
                                        <th>Nome</th>
                                        <th>CPF</th>
                                        <th>Email</th>
                                        <th>Ações</th>
                                    </tr>
                                </thead>
                                <tbody class="list">
                                    <%
                                        for(Teacher t:list){
                                    %>
                                    <tr>
                                        <td><%=t.getId() %></td>
                                        <td><%=t.getFullName() %></td>
                                        <td><%=t.getCpf() %></td>
                                        <td><%=lDAO.uploadByUser(t.getUser().getId()).getEmail() %></td>
                                        <td>
                                            <span data-toggle="modal" data-target="#modal-view<%=t.getId() %>">
                                                <a class="table-action" data-toggle="tooltip" data-original-title="Visualizar">
                                                    <i class="far fa-eye"></i>
                                                </a>
                                            </span>
                                            <span data-toggle="modal" data-target="#modal-dicipline<%=t.getId() %>">
                                                <a class="table-action" data-toggle="tooltip" data-original-title="Disciplinas">
                                                    <i class="fas fa-pencil-ruler"></i>
                                                </a>
                                            </span>
                                            <a class="table-action" data-toggle="tooltip" data-original-title="Editar" href="alter_teacher.jsp?id=<%=t.getId() %>">
                                                <i class="fas fa-user-edit text-default"></i>
                                            </a>
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
            for(Teacher tModal: list){
                DateFormat fmt = new SimpleDateFormat("dd/MM/yyyy");
        %>
        <div class="modal fade" id="modal-view<%=tModal.getId() %>" tabindex="-1" role="dialog" aria-labelledby="modal-default" aria-hidden="true">
            <div class="modal-dialog modal- modal-dialog-centered modal-" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h6 class="modal-title" id="modal-title-default">Professor</h6>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <p>
                            Nome: <b><%=tModal.getFullName() %></b></br>
                            CPF: <b><%=tModal.getCpf() %></b></br>
                            Gênero: <b><%=tModal.getGender() %></b></br>
                            Data de Nascimento: <b><%=fmt.format(tModal.getBirthDate()) %></b></br>
                            Nacinalidade: <b><%=tModal.getNationality() %></b></br>
                            Naturalidade:<%if(tModal.getNaturalness() != null) {%> <b><%=tModal.getNaturalness() %></b><% } %></br>
                            RG: <b><%=tModal.getRg() %></b></br>
                            Orgão Emissor: <b><%=tModal.getIssuingAgencyRg() %></b></br>
                            Estado RG: <b><%=tModal.getStateRg() %></b></br>
                            Data RG: <b><%=fmt.format(tModal.getDateRg()) %></b></br>
                        </p>
                        <%
                            if(tModal.getAddress().getStreet() != null){
                        %>
                        <p>
                            Encereço: <b><%=tModal.getAddress().getStreet()+", "+tModal.getAddress().getNumber() %></b></br>
                            Bairro: <b><%=tModal.getAddress().getDistrict() %></b></br>
                            Cidade: <b><%=tModal.getAddress().getCity() %></b></br>
                            Estado: <b><%=tModal.getAddress().getState() %></b></br>
                            País: <b><%=tModal.getAddress().getCountry() %></b></br>
                            Complemento: <b><%=tModal.getAddress().getComplement() %></b></br>
                            CEP: <b><%=tModal.getAddress().getPostalCode() %></b></br>
                        </p>
                        <%
                            }

                            if(tModal.getTelephone().getNumber() != null){
                        %>
                        <p>
                            Numero de Telephone: <b><%=tModal.getTelephone().getNumber() %></b></br>
                            Tipo: <b><%=tModal.getTelephone().getType() %></b></br>
                        </p>
                        <%
                            }
                        %>
                        <p>
                            Disciplinas: 
                        <%
                            for(Discipline d:tModal.getDiscipline()){
                        %>
                            <b><%=d.getName() %></b> 
                        <%
                            }
                        %>
                        </p>
                    </div>
                </div>
            </div>
        </div>
        <%
            }
        %>
        <script src="./assets/vendor/jquery/dist/jquery.min.js"></script>
        <script src="./assets/vendor/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
        <script src="./assets/vendor/js-cookie/js.cookie.js"></script>
        <script src="./assets/vendor/jquery.scrollbar/jquery.scrollbar.min.js"></script>
        <script src="./assets/vendor/jquery-scroll-lock/dist/jquery-scrollLock.min.js"></script>
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
