<%-- 
    Document   : students
    Created on : 06/07/2021, 11:47:57
    Author     : Gabriel Moraes
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="model.SchoolDAO"%>
<%@page import="model.StudentDAO"%>
<%@page import="model.Student"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Menu"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="validate_login.jsp" %>
<%
    String url = request.getRequestURI();
    ArrayList<Student> list = new ArrayList<Student>();
    ArrayList<Login> listL = new ArrayList<Login>();
    
    StudentDAO sDAO = new StudentDAO();
    SchoolDAO scDAO = new SchoolDAO();
    
    try{
        
        if(u.getProfile().getId() == 50){
            //Carregar por Responsavel da Escola
            int idSchool = scDAO.uploadByIdResponsibleSchoolUser(u.getId());
            list = sDAO.uploadBySchool(idSchool);
        } else if(u.getProfileSchool().getId() != 0){
            //Carregar por funcionario da Escola
            list = sDAO.uploadBySchool(u.getProfileSchool().getSchool().getId());
        }
        
        for(Student s:list){
            listL.add(lDAO.uploadByUser(s.getUser().getId()));
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
        <title>OnGes - Alunos</title>
        <link rel="icon" href="./assets/icon/favicon.png" type="image/png">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700">
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
                                <h6 class="h2 text-white d-inline-block mb-0">Alunos</h6>
                                <nav aria-label="breadcrumb" class="d-none d-md-inline-block ml-md-4">
                                  <ol class="breadcrumb breadcrumb-links breadcrumb-dark">
                                    <li class="breadcrumb-item"><a><i class="fas fa-home"></i></a></li>
                                    <li class="breadcrumb-item active" aria-current="page">Gerenciar</li>
                                  </ol>
                                </nav>
                            </div>
                            <div class="col-lg-6 col-5 text-right">
                                <a href="add_student.jsp" class="btn btn-sm btn-neutral">Adicionar</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="container-fluid mt--6">
                <div class="col">
                    <div class="card">
                        <div class="card-header">
                            <h3 class="mb-0">Alunos</h3>
                        </div>
                        <div class="table-responsive">
                            <table class="table align-items-center table-flush">
                                <thead class="thead-light">
                                    <tr>
                                        <th scope="col">#</th>
                                        <th scope="col">Nome</th>
                                        <th scope="col">CPF</th>
                                        <th scope="col">Email</th>
                                        <th scope="col">Ações</th>
                                    </tr>
                                </thead>
                                <tbody class="list">
                                    <%
                                        for(Student s:list){
                                        Login l = listL.get(list.indexOf(s));
                                    %>
                                    <tr>
                                        <th scope="row"><%=list.indexOf(s)+1 %></th>
                                        <td><%=s.getFullName() %></td>
                                        <td><%=s.getCpf() %></td>
                                        <td><%=l.getEmail() %></td>
                                        <td>
                                            <span data-toggle="modal" data-target="#modal-view<%=s.getId() %>">
                                                <a class="table-action" data-toggle="tooltip" data-original-title="Visualizar">
                                                    <i class="far fa-eye"></i>
                                                </a>
                                            </span>
                                            <a class="table-action" data-toggle="tooltip" data-original-title="Editar" href="alter_student.jsp?id=<%=s.getId() %>">
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
            for(Student sModal: list){
                DateFormat fmt = new SimpleDateFormat("dd/MM/yyyy");
        %>
        <div class="modal fade" id="modal-view<%=sModal.getId() %>" tabindex="-1" role="dialog" aria-labelledby="modal-default" aria-hidden="true">
            <div class="modal-dialog modal- modal-dialog-centered modal-" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h6 class="modal-title" id="modal-title-default">Dados do aluno</h6>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <p>
                            Nome: <b><%=sModal.getFullName() %></b></br>
                            CPF: <b><%=sModal.getCpf() %></b></br>
                            Gênero: <b><%=sModal.getGender() %></b></br>
                            Data de Nascimento: <b><%=fmt.format(sModal.getBirthDate()) %></b></br>
                            Nacinalidade: <b><%=sModal.getNationality() %></b></br>
                            Naturalidade:<%if(sModal.getNaturalness() != null) {%> <b><%=sModal.getNaturalness() %></b><% } %></br>
                            RG: <b><%=sModal.getRg() %></b></br>
                            Orgão Emissor: <b><%=sModal.getIssuingAgencyRg() %></b></br>
                            Estado RG: <b><%=sModal.getStateRg() %></b></br>
                            Data RG: <b><%=fmt.format(sModal.getDateRg()) %></b></br>
                            Nome da Mãe: <b><%=sModal.getMothersName() %></b></br>
                            Nome do Pai: <b><%=sModal.getFathersName() %></b></br>
                        </p>
                    <%
                        if(sModal.getAddress().getStreet() != null){
                    %>
                        <p>
                            Encereço: <b><%=sModal.getAddress().getStreet()+", "+sModal.getAddress().getNumber() %></b></br>
                            Bairro: <b><%=sModal.getAddress().getDistrict() %></b></br>
                            Cidade: <b><%=sModal.getAddress().getCity() %></b></br>
                            Estado: <b><%=sModal.getAddress().getState() %></b></br>
                            País: <b><%=sModal.getAddress().getCountry() %></b></br>
                            Complemento: <b><%=sModal.getAddress().getComplement() %></b></br>
                            CEP: <b><%=sModal.getAddress().getPostalCode() %></b></br>
                        </p>
                    <%
                        }

                        if(sModal.getTelephone().getNumber() != null){
                    %>
                        <p>
                            Numero de Telephone: <b><%=sModal.getTelephone().getNumber() %></b></br>
                            Tipo: <b><%=sModal.getTelephone().getType() %></b></br>
                        </p>
                    <%
                        }
                    %>
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
        <script src="./assets/js/argon.js?v=1.1.0"></script>
        <script src="./assets/js/demo.min.js"></script>
    </body>
</html>
