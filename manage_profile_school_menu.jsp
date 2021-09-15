<%-- 
    Document   : manager_profile_school_menu
    Created on : 12/05/2021, 14:18:52
    Author     : Gabriel Moraes
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="model.ProfileSchoolDAO"%>
<%@page import="model.ProfileSchool"%>
<%@page import="model.Menu"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="validate_login.jsp" %>
<%
    ArrayList<Menu> list = new ArrayList<Menu>();
    ArrayList<Menu> listUnlink = new ArrayList<Menu>();
    ProfileSchoolDAO psDAO = new ProfileSchoolDAO();
    String url = request.getRequestURI();
    ProfileSchool ps = new ProfileSchool();
    try{
        int id = Integer.parseInt(request.getParameter("id"));
        ps = psDAO.uploadById(id);
        list = psDAO.unlinkedMenus(u.getProfile().getId(),ps.getId());
        listUnlink = ps.getMenus();
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
        <title>OnGes - Gerenciar Perfil Menu</title>
        <link rel="icon" href="./assets/icon/favicon.png" type="image/png">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700">
        <link rel="stylesheet" href="./assets/vendor/nucleo/css/nucleo.css" type="text/css">
        <link rel="stylesheet" href="./assets/vendor/@fortawesome/fontawesome-free/css/all.min.css" type="text/css">
        <link rel="stylesheet" href="./assets/vendor/datatables.net-bs4/css/dataTables.bootstrap4.min.css">
        <link rel="stylesheet" href="./assets/vendor/datatables.net-buttons-bs4/css/buttons.bootstrap4.min.css">
        <link rel="stylesheet" href="./assets/vendor/datatables.net-select-bs4/css/select.bootstrap4.min.css">
        <link rel="stylesheet" href="./assets/css/argon.min.css?v=1.2.0" type="text/css">
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
                                <h6 class="h2 text-white d-inline-block mb-0">Gerenciar Perfil</h6>
                                <nav aria-label="breadcrumb" class="d-none d-md-inline-block ml-md-4">
                                    <ol class="breadcrumb breadcrumb-links breadcrumb-dark">
                                        <li class="breadcrumb-item"><a><i class="fas fa-home"></i></a></li>
                                        <li class="breadcrumb-item"><a>Perfil</a></li>
                                        <li class="breadcrumb-item active" aria-current="page">Gerenciar Perfil: <%=ps.getName() %></li>
                                    </ol>
                                </nav>
                            </div>
                            <div class="col-lg-6 col-5 text-right">
                                <a class="btn btn-sm btn-neutral" href="../profile_school.jsp">
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
                        <div class="card-header">
                            <h3 class="mb-0">Menus Não Vinculados</h3>
                        </div>
                        <div class="table-responsive">
                            <table class="table align-items-center table-flush">
                                <thead class="thead-light">
                                    <tr>
                                        <th scope="col">#</th>
                                        <th scope="col">Título</th>
                                        <th scope="col">Adicionar</th>
                                    </tr>
                                </thead>
                                <tbody class="list">
                                    <%
                                        for(Menu m:list){
                                    %>
                                    <tr>
                                        <th scope="row">
                                            <%=list.indexOf(m)+1 %>
                                        </th>
                                        <td>
                                            <%=m.getTitle() %>
                                        </td>
                                        <td>
                                            <a class="table-action" data-toggle="tooltip" data-original-title="Adicionar" href="./manage_profile_school_menu.do?id_menu=<%=m.getId() %>&id_profile_school=<%=ps.getId() %>&op=vincular">
                                                <i class="fas fa-plus"></i>
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
                    <div class="card">
                        <div class="card-header">
                            <h3 class="mb-0">Menus Vinculados</h3>
                        </div>
                        <div class="table-responsive">
                            <table class="table align-items-center table-flush">
                                <thead class="thead-light">
                                    <tr>
                                        <th scope="col">#</th>
                                        <th scope="col">Título</th>
                                        <th scope="col">Remover</th>
                                    </tr>
                                </thead>
                                <tbody class="list">
                                    <%
                                        for(Menu m:listUnlink){
                                    %>
                                    <tr>
                                        <th scope="row">
                                            <%=listUnlink.indexOf(m)+1 %>
                                        </th>
                                        <td>
                                            <%=m.getTitle() %>
                                        </td>
                                        <td>
                                            <a class="table-action table-action-delete" data-toggle="tooltip" data-original-title="Excluir" href="./manage_profile_school_menu.do?id_menu=<%=m.getId() %>&id_profile_school=<%=ps.getId() %>&op=remover">
                                                <i class="fas fa-trash"></i>
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
        <script src="../assets/vendor/jquery/dist/jquery.min.js"></script>
        <script src="../assets/vendor/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
        <script src="../assets/vendor/js-cookie/js.cookie.js"></script>
        <script src="../assets/vendor/jquery.scrollbar/jquery.scrollbar.min.js"></script>
        <script src="../assets/vendor/jquery-scroll-lock/dist/jquery-scrollLock.min.js"></script>
        <script src="../assets/js/argon.js?v=1.1.0"></script>
        <script src="../assets/js/demo.min.js"></script>
    </body>
</html>
