<%-- 
    Document   : funcionary
    Created on : 29/03/2021, 13:32:41
    Author     : Gabriel Moraes
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="model.SchoolDAO"%>
<%@page import="model.ResponsibleSchoolDAO"%>
<%@page import="model.ProfileSchoolDAO"%>
<%@page import="model.FuncionaryDAO"%>
<%@page import="model.ProfileSchool"%>
<%@page import="model.Funcionary"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Menu"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="validate_login.jsp" %>
<%
    String url = request.getRequestURI();
    ArrayList<Funcionary> list = new ArrayList<Funcionary>();
    ArrayList<ProfileSchool> listPS = new ArrayList<ProfileSchool>();
    ArrayList<Login> listL = new ArrayList<Login>();
    
    boolean error = false;
    FuncionaryDAO fDAO = new FuncionaryDAO();
    ProfileSchoolDAO psDAO = new ProfileSchoolDAO();
    SchoolDAO sDAO = new SchoolDAO();
    
    try{
        
        if(u.getProfile().getId() == 50){
            //Carregar por Responsavel da Escola
            int idSchool = sDAO.uploadByIdResponsibleSchoolUser(u.getId());
            list = fDAO.uploadBySchool(idSchool);
            listPS = psDAO.uploadByIdSchoolLite(idSchool);
        } else if(u.getProfileSchool().getId() != 0){
            //Carregar por funcionario da Escola
            list = fDAO.uploadBySchool(u.getProfileSchool().getSchool().getId());
            listPS = psDAO.uploadByIdSchoolLite(u.getProfileSchool().getSchool().getId());
        }
        
        for(Funcionary f:list){
            listL.add(lDAO.uploadByUserLite(f.getUser().getId()));
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
        <meta name="viewport" content="user-scalable=no, initial-scale=1, maximum-scale=1, minimum-scale=1, width=device-width, height=device-height, target-densitydpi=device-dpi" />
        <title>OnGes - Funcionarios</title>
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
                                <h6 class="h2 text-white d-inline-block mb-0">Funcionário</h6>
                                <nav aria-label="breadcrumb" class="d-none d-md-inline-block ml-md-4">
                                  <ol class="breadcrumb breadcrumb-links breadcrumb-dark">
                                    <li class="breadcrumb-item"><a><i class="fas fa-home"></i></a></li>
                                    <li class="breadcrumb-item active" aria-current="page">Gerenciar</li>
                                  </ol>
                                </nav>
                            </div>
                            <div class="col-lg-6 col-5 text-right">
                                <a href="AddFuncionary" class="btn btn-sm btn-neutral">Adicionar</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="container-fluid mt--6">
                <div class="col">
                    <div class="card">
                        <div class="card-header">
                            <h3 class="mb-0">Funcionários</h3>
                        </div>
                        <div class="table-responsive">
                            <table class="table align-items-center table-flush">
                                <thead class="thead-light">
                                    <tr>
                                        <th scope="col">#</th>
                                        <th scope="col">Nome</th>
                                        <th scope="col">Cargo</th>
                                        <th scope="col">Ações</th>
                                    </tr>
                                </thead>
                                <tbody class="list">
                                    <%
                                        for(Funcionary f:list){
                                        Login l = listL.get(list.indexOf(f));
                                    %>
                                    <tr>
                                        <th scope="row">
                                            <%=list.indexOf(f)+1 %>
                                        </th>
                                        <td>
                                            <%=f.getFullName() %>
                                        </td>
                                        <td></td>
                                        <td>
                                            <span data-toggle="modal" data-target="#modal-view<%=f.getId() %>">
                                                <a class="table-action" data-toggle="tooltip" data-original-title="Visualizar">
                                                    <i class="far fa-eye"></i>
                                                </a>
                                            </span>
                                            <a class="table-action" data-toggle="tooltip" data-original-title="Editar" href="EditFuncionary?id=<%=f.getId() %>">
                                                <i class="fas fa-user-edit text-default"></i>
                                            </a>
                                            <%
                                                if(f.getUser().getId() != 0 && l.getEmail() != null) {
                                            %>
                                            <span data-toggle="modal" data-target="#modal-alter-user<%=f.getUser().getId() %>">
                                                <a class="table-action" data-toggle="tooltip" data-original-title="Editar usuario">
                                                    <i class="fas fa-cog"></i>
                                                </a>
                                            </span>
                                            <%
                                                } else {
                                            %>
                                            <span data-toggle="modal" data-target="#modal-create-user<%=f.getId() %>">
                                                <a class="table-action" data-toggle="tooltip" data-original-title="Adicionar usuario">
                                                    <i class="fas fa-user-plus"></i>
                                                </a>
                                            </span>
                                            <%
                                                }
                                            %>
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
            for(Funcionary f:list){
                Login lFor = listL.get(list.indexOf(f));
                if(f.getUser().getId() != 0){
        %>
        <div class="modal fade" id="modal-alter-user<%=f.getUser().getId() %>" tabindex="-1" role="dialog" aria-labelledby="modal-default" aria-hidden="true">
            <div class="modal-dialog modal- modal-dialog-centered modal-" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h6 class="modal-title" id="modal-title-default">Editar Usuário:</h6>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form name="alter_user" action="./alter_user.do" method="post" class="needs-validation" novalidate>
                            <input type="hidden" name="id" value="<%=f.getUser().getId() %>">
                            <input type="hidden" name="id_login" value="<%=lFor.getId() %>">
                            <input type="hidden" name="id_funcionary" value="<%=f.getId() %>">
                            <input type="hidden" name="id_type" value="2">
                            <input type="hidden" name="email" value="<%=lFor.getEmail() %>">
                            <div class="form-row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-control-label" for="validationName">Nome</label>
                                    <input type="text" class="form-control" id="validationName" name="name" placeholder="Nome" value="<%=f.getUser().getName() %>" required>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-control-label" for="validationSurname">Sobrenome</label>
                                    <input type="text" class="form-control" id="validationSurname" name="surname" placeholder="Sobrenome" value="<%=f.getUser().getSurname() %>" required>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="col-md-12 mb-3">
                                    <label class="form-control-label" for="validationEmail">Endereço de Email (OnGes ID):</label>
                                    <input type="text" class="form-control" id="validationEmail" placeholder="Email" value="<%=lFor.getEmail() %>" disabled>
                                </div>
                            </div>
                            <input type="hidden" name="id_profile" value="<%=f.getUser().getProfile().getId() %>">
                            <div class="form-group">
                                <label class="form-control-label" for="exampleFormControlSelect1">Perfil do Usuário</label>
                                <select name="id_profile_school" class="form-control" id="exampleFormControlSelect1">
                                    <option> Selecione... </option>
                                    <%
                                        for(ProfileSchool ps:listPS){
                                    %>
                                    <option value="<%=ps.getId() %>" <%if(ps.getId() == f.getUser().getProfileSchool().getId()){%>selected<%} %>><%=ps.getName() %></option>
                                    <%
                                        }
                                    %>
                                </select>
                            </div>
                            <div class="form-row">
                                <label class="form-control-label">Status</label>
                            </div>
                            <div class="form-group">
                                <label class="custom-toggle custom-toggle-success">
                                    <input type="checkbox" name="status" <%if(f.getUser().isStatus()) {%>checked<%}%>>
                                    <span class="custom-toggle-slider rounded-circle" data-label-off="" data-label-on="Ativo"></span>
                                </label>
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
            }

            for(Funcionary fModal: list){
                DateFormat fmt = new SimpleDateFormat("dd/MM/yyyy");
                if(fModal.getUser().getId() == 0) {
                    int spaceName = fModal.getFullName().indexOf(" ")+1;
                    String name = fModal.getFullName().substring(0,spaceName).trim();
                    String surName = fModal.getFullName().substring(spaceName);
        %>
        <div class="modal fade" id="modal-create-user<%=fModal.getId() %>" tabindex="-1" role="dialog" aria-labelledby="modal-default" aria-hidden="true">
            <div class="modal-dialog modal- modal-dialog-centered modal-" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h6 class="modal-title" id="modal-title-default">Adicionar Usuário:</h6>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form name="alter_user" action="./create_user.do" method="post" class="needs-validation" novalidate>
                            <input type="hidden" name="id_funcionary" value="<%=fModal.getId() %>">
                            <input type="hidden" name="id_responsible_school" value="0">
                            <input type="hidden" name="photo" value="assets/img/icons/user_default.png">
                            <div class="form-row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-control-label" for="validationName">Nome</label>
                                    <input type="text" class="form-control" id="validationName" name="name" placeholder="Nome" value="<%=name %>" required>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-control-label" for="validationSurname">Sobrenome</label>
                                    <input type="text" class="form-control" id="validationSurname" name="surname" placeholder="Sobrenome" value="<%=surName %>" required>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="col-md-12 mb-3">
                                    <label class="form-control-label" for="validationEmail">Endereço de Email (OnGes ID):</label>
                                    <input type="text" class="form-control" id="validationEmail" name="email" placeholder="Email" required>
                                </div>
                            </div>
                            <div class="form-group">
                                <input type="hidden" name="id_profile" value="0">
                                <label class="form-control-label" for="exampleFormControlSelect1">Perfil do Usuário</label>
                                <select name="id_profile_school" class="form-control" id="exampleFormControlSelect1">
                                    <option> Selecione... </option>
                                    <%
                                        for(ProfileSchool ps:listPS){
                                    %>
                                    <option value="<%=ps.getId() %>"><%=ps.getName() %></option>
                                    <%
                                        }
                                    %>
                                </select>
                            </div>
                            <div class="form-row">
                                <label class="form-control-label">Status</label>
                            </div>
                            <div class="form-group">
                                <label class="custom-toggle custom-toggle-success">
                                    <input type="checkbox" name="status" checked>
                                    <span class="custom-toggle-slider rounded-circle" data-label-off="" data-label-on="Ativo"></span>
                                </label>
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
        <div class="modal fade" id="modal-view<%=fModal.getId() %>" tabindex="-1" role="dialog" aria-labelledby="modal-default" aria-hidden="true">
            <div class="modal-dialog modal- modal-dialog-centered modal-" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h6 class="modal-title" id="modal-title-default">Funcionário</h6>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <p>
                            Nome: <b><%=fModal.getFullName() %></b></br>
                            CPF: <b><%=fModal.getCpf() %></b></br>
                            Gênero: <b><%=fModal.getGender() %></b></br>
                            Data de Nascimento: <b><%=fmt.format(fModal.getBirthDate()) %></b></br>
                            Nacinalidade: <b><%=fModal.getNationality() %></b></br>
                            Naturalidade:<%if(fModal.getNaturalness() != null) {%> <b><%=fModal.getNaturalness() %></b><% } %></br>
                            RG: <b><%=fModal.getRg() %></b></br>
                            Orgão Emissor: <b><%=fModal.getIssuingAgencyRg() %></b></br>
                            Estado RG: <b><%=fModal.getStateRg() %></b></br>
                            Data RG: <b><%=fmt.format(fModal.getDateRg()) %></b></br>
                            Nome da Mãe: <b><%=fModal.getMothersName() %></b></br>
                            Nome do Pai: <b><%=fModal.getFathersName() %></b></br>
                        </p>
                    <%
                        if(fModal.getAddress().getStreet() != null){
                    %>
                        <p>
                            Encereço: <b><%=fModal.getAddress().getStreet()+", "+fModal.getAddress().getNumber() %></b></br>
                            Bairro: <b><%=fModal.getAddress().getDistrict() %></b></br>
                            Cidade: <b><%=fModal.getAddress().getCity() %></b></br>
                            Estado: <b><%=fModal.getAddress().getState() %></b></br>
                            País: <b><%=fModal.getAddress().getCountry() %></b></br>
                            Complemento: <b><%=fModal.getAddress().getComplement() %></b></br>
                            CEP: <b><%=fModal.getAddress().getPostalCode() %></b></br>
                        </p>
                    <%
                        }

                        if(fModal.getTelephone().getNumber() != null){
                    %>
                        <p>
                            Numero de Telephone: <b><%=fModal.getTelephone().getNumber() %></b></br>
                            Tipo: <b><%=fModal.getTelephone().getType() %></b></br>
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
