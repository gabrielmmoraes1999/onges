<%-- 
    Document   : profile
    Created on : 11/05/2021, 10:27:27
    Author     : Gabriel Moraes
--%>
<%@page import="model.FuncionaryDAO"%>
<%@page import="model.SchoolDAO"%>
<%@page import="model.School"%>
<%@page import="model.ResponsibleSchool"%>
<%@page import="model.ResponsibleSchoolDAO"%>
<%@page import="model.ProfileSchoolDAO"%>
<%@page import="model.ProfileSchool"%>
<%@page import="model.Menu"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="validate_login.jsp" %>
<%
    ArrayList<ProfileSchool> list = new ArrayList<ProfileSchool>();
    String url = request.getRequestURI();
    
    boolean error = false;
    ResponsibleSchool rs = new ResponsibleSchool();
    ResponsibleSchoolDAO rsDAO = new ResponsibleSchoolDAO();
    
    School s = new School();
    SchoolDAO sDAO = new SchoolDAO();
    
    FuncionaryDAO fDAO = new FuncionaryDAO();
    ProfileSchoolDAO psDAO = new ProfileSchoolDAO();
    
    try{
        rs = rsDAO.uploadByUser(u.getId());
        
        if(rs.getId() != 0){
            s = sDAO.uploadByResponsibleSchool(rs.getId());
            list = psDAO.uploadByIdSchoolLite(s.getId());
        } else {
            int idSchool = fDAO.uploadByIdUser(u.getId()).getSchool().getId();
            list = psDAO.uploadByIdSchoolLite(idSchool);
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
        <!--<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">-->
        <link rel="icon" href="./assets/icon/favicon.png" type="image/png">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700">
        <link rel="stylesheet" href="./assets/vendor/animate.css/animate.min.css">
        <link rel="stylesheet" href="./assets/vendor/nucleo/css/nucleo.css" type="text/css">
        <link rel="stylesheet" href="./assets/vendor/@fortawesome/fontawesome-free/css/all.min.css" type="text/css">
        <link rel="stylesheet" href="./assets/vendor/datatables.net-bs4/css/dataTables.bootstrap4.min.css">
        <link rel="stylesheet" href="./assets/vendor/datatables.net-buttons-bs4/css/buttons.bootstrap4.min.css">
        <link rel="stylesheet" href="./assets/vendor/datatables.net-select-bs4/css/select.bootstrap4.min.css">
        <link rel="stylesheet" href="./assets/css/argon.min.css?v=1.2.0" type="text/css">
        <title>OnGes - Perfil</title>
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
                                <h6 class="h2 text-white d-inline-block mb-0">Perfil</h6>
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
                            <h3 class="mb-0">Perfis</h3>
                        </div>
                        <div class="table-responsive">
                            <table class="table align-items-center table-flush">
                                <thead class="thead-light">
                                    <tr>
                                        <th scope="col">#</th>
                                        <th scope="col">Nome</th>
                                        <th scope="col">Descrição</th>
                                        <th scope="col">Ações</th>
                                    </tr>
                                </thead>
                                <tbody class="list">
                                    <%
                                        for(ProfileSchool ps:list){
                                    %>
                                    <tr>
                                        <th scope="row">
                                            <%=list.indexOf(ps)+1 %>
                                        </th>
                                        <td>
                                            <%=ps.getName() %>
                                        </td>
                                        <td>
                                            <%=ps.getDescription() %>
                                        </td>
                                        <td>
                                            <a class="table" data-toggle="tooltip" data-original-title="Gerenciar Perfil" href="manage_profile_school_menu.jsp?id=<%=ps.getId() %>">
                                                <i class="fas fa-bars"></i>
                                            </a>&nbsp;
                                            <span data-toggle="modal" data-target="#modal-alter<%=ps.getId() %>">
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
            for(ProfileSchool ps:list){
        %>
        <div class="modal fade" id="modal-alter<%=ps.getId() %>" tabindex="-1" role="dialog" aria-labelledby="modal-default" aria-hidden="true">
            <div class="modal-dialog modal- modal-dialog-centered modal-" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h6 class="modal-title" id="modal-title-default">Editar Perfil:</h6>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form name="alter_profile" action="./alter_profile_school.do" method="post" class="needs-validation" novalidate>
                            <input type="hidden" name="id" value="<%=ps.getId() %>">
                            <div class="form-row">
                                <div class="col-md-12 mb-3">
                                    <label class="form-control-label" for="validationName">Nome</label>
                                    <input type="text" class="form-control" id="validationName" name="name" placeholder="Nome" value="<%=ps.getName() %>" required>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="col-md-12 mb-3">
                                    <label class="form-control-label" for="validationDescription">Descrição</label>
                                    <input type="text" class="form-control" id="validationDescription" name="description" placeholder="Descrição" value="<%=ps.getDescription() %>" required>
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
                        <h6 class="modal-title" id="modal-title-default">Adcionar Perfil:</h6>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form name="create_profile" action="./create_profile_school.do" method="post" class="needs-validation" novalidate>
                            <input type="hidden" name="id_profile" value="<%=u.getProfile().getId() %>">
                            <input type="hidden" name="id_school" value="<%=s.getId() %>">
                            <div class="form-row">
                                <div class="col-md-12 mb-3">
                                    <label class="form-control-label" for="validationName">Nome</label>
                                    <input type="text" class="form-control" id="validationName" name="name" placeholder="Nome do perfil" required>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="col-md-12 mb-3">
                                    <label class="form-control-label" for="validationDescription">Descrição</label>
                                    <input type="text" class="form-control" id="validationDecription" name="description" placeholder="Descrição" required>
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
