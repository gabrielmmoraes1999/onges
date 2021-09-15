<%-- 
    Document   : user
    Created on : 29/03/2021, 17:34:39
    Author     : Gabriel Moraes
--%>

<%@page import="model.FuncionaryDAO"%>
<%@page import="model.ProfileDAO"%>
<%@page import="model.Profile"%>
<%@page import="model.Funcionary"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="validate_login.jsp" %>
<%
    String url = request.getRequestURI();
    ArrayList<Funcionary> listF = new ArrayList<Funcionary>();
    ArrayList<Profile> listP = new ArrayList<Profile>();
    ArrayList<User> list = new ArrayList<User>();
    ArrayList<Login> listL = new ArrayList<Login>();
    
    ProfileDAO pDAO = new ProfileDAO();
    FuncionaryDAO fDAO = new FuncionaryDAO();
    
    try{
        list = uDAO.uploadByProfileSystem();
        listP = pDAO.read();
        
        for(User uu:list){
            listF.add(fDAO.uploadByIdUser(uu.getId()));
            listL.add(lDAO.uploadByUser(uu.getId()));
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
        <title>OnGes - Usuários</title>
        <link rel="icon" href="../assets/icon/favicon.png" type="image/png">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700">
        <link rel="stylesheet" href="../assets/vendor/nucleo/css/nucleo.css" type="text/css">
        <link rel="stylesheet" href="../assets/vendor/@fortawesome/fontawesome-free/css/all.min.css" type="text/css">
        <link rel="stylesheet" href="../assets/vendor/datatables.net-bs4/css/dataTables.bootstrap4.min.css">
        <link rel="stylesheet" href="../assets/vendor/datatables.net-buttons-bs4/css/buttons.bootstrap4.min.css">
        <link rel="stylesheet" href="../assets/vendor/datatables.net-select-bs4/css/select.bootstrap4.min.css">
        <link rel="stylesheet" href="../assets/css/argon.css?v=1.1.0" type="text/css">
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
                                <h6 class="h2 text-white d-inline-block mb-0">Usuários</h6>
                                <nav aria-label="breadcrumb" class="d-none d-md-inline-block ml-md-4">
                                  <ol class="breadcrumb breadcrumb-links breadcrumb-dark">
                                    <li class="breadcrumb-item"><a><i class="fas fa-home"></i></a></li>
                                    <li class="breadcrumb-item active" aria-current="page">Gerenciar</li>
                                  </ol>
                                </nav>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="container-fluid mt--6">
                <div class="col">
                    <div class="card">
                        <div class="card-header">
                            <h3 class="mb-0">Usuários</h3>
                        </div>
                        <div class="table-responsive">
                            <table class="table align-items-center table-flush">
                                <thead class="thead-light">
                                    <tr>
                                        <th scope="col">#</th>
                                        <th scope="col">Nome</th>
                                        <th scope="col">Sobrenome</th>
                                        <th scope="col">Status</th>
                                        <th scope="col">Foto</th>
                                        <th scope="col">Ações</th>
                                    </tr>
                                </thead>
                                <tbody class="list">
                                    <%
                                        for(User uu:list){
                                            Login l = new Login();
                                            l = listL.get(list.indexOf(uu));
                                    %>
                                    <tr>
                                        <th scope="row">
                                            <%=list.indexOf(uu)+1 %>
                                        </th>
                                        <td>
                                            <%=uu.getName() %>
                                        </td>
                                        <td>
                                            <%=uu.getSurname() %>
                                        </td>
                                        <%
                                            if(uu.isStatus() && l.getEmail() != null && l.isEmailConfirm()){
                                        %>
                                        <td>
                                            <span class="badge badge-dot mr-4">
                                                <i class="bg-success"></i>
                                                <span class="status">Ativo</span>
                                            </span>
                                        </td>
                                        <%
                                            } else if(uu.isStatus() == false && l.getEmail() != null) {
                                        %>
                                        <td>
                                            <span class="badge badge-dot mr-4">
                                                <i class="bg-danger"></i>
                                                <span class="status">Inativo</span>
                                            </span>
                                        </td>
                                        <%
                                            } else {
                                        %>
                                        <td>
                                            <span class="badge badge-dot mr-4">
                                                <i class="bg-info"></i>
                                                <span class="status">Ativação Pendente</span>
                                            </span>
                                        </td>
                                        <%
                                            }
                                        %>
                                        <td>
                                            <div class="avatar-group">
                                                <a class="avatar avatar-sm rounded-circle" data-toggle="tooltip" data-original-title="<%=uu.getName()+" "+uu.getSurname() %>">
                                                    <img alt="Image placeholder" src="../<%=uu.getPhoto() %>">
                                                </a>
                                            </div>
                                        </td>
                                        <td>
                                            <%
                                                if(uu.getId() != 0 && l.getEmail() != null) {
                                            %>
                                            <span data-toggle="modal" data-target="#modal-alter-user<%=uu.getId() %>">
                                                <a class="table-action" data-toggle="tooltip" data-original-title="Editar usuario">
                                                    <i class="fas fa-cog"></i>
                                                </a>
                                            </span>
                                            <%
                                                } else {
                                            %>
                                            <span data-toggle="modal" data-target="#modal-create-login<%=uu.getId() %>">
                                                <a class="table-action" data-toggle="tooltip" data-original-title="Ativar Login">
                                                    <i class="fas fa-clipboard-check"></i>
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
            for(User uModal:list){
                Funcionary f = new Funcionary();
                f = listF.get(list.indexOf(uModal));
                Login lFor = new Login();
                lFor = listL.get(list.indexOf(uModal));
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
                                <form name="alter_user" action="../alter_user.do" method="post" class="needs-validation" novalidate>
                                    <input type="hidden" name="id" value="<%=f.getUser().getId() %>">
                                    <input type="hidden" name="id_login" value="<%=lFor.getId() %>">
                                    <input type="hidden" name="id_funcionary" value="<%=f.getId() %>">
                                    <input type="hidden" name="id_type" value="1">
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
                                    <input type="hidden" name="id_profile_school" value="<%=f.getUser().getProfileSchool().getId() %>">
                                    <div class="form-group">
                                        <label class="form-control-label" for="exampleFormControlSelect1">Perfil do Usuário</label>
                                        <select name="id_profile" class="form-control" id="exampleFormControlSelect1">
                                            <option> Selecione... </option>
                                        <%
                                            for(Profile p:listP){
                                        %>
                                            <option value="<%=p.getId() %>" <%if(p.getId() == f.getUser().getProfile().getId()){%>selected<%} %>><%=p.getName() %></option>
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
                %>
        <script src="../assets/vendor/jquery/dist/jquery.min.js"></script>
        <script src="../assets/vendor/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
        <script src="../assets/vendor/js-cookie/js.cookie.js"></script>
        <script src="../assets/vendor/jquery.scrollbar/jquery.scrollbar.min.js"></script>
        <script src="../assets/vendor/jquery-scroll-lock/dist/jquery-scrollLock.min.js"></script>
        <script src="../assets/js/argon.js?v=1.1.0"></script>
        <script src="../assets/js/demo.min.js"></script>
    </body>
</html>
