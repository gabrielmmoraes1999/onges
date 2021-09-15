<%-- 
    Document   : menu
    Created on : 23/03/2021, 12:16:45
    Author     : Gabriel Moraes
--%>

<%@page import="model.MenuDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Menu"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="validate_login.jsp" %>
<%
    ArrayList<Menu> list = new ArrayList<Menu>();
    String url = request.getRequestURI();
    try{
        MenuDAO mDAO = new MenuDAO();
        list = mDAO.read();
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
        <title>OnGes - Menu</title>
        <link rel="icon" href="../assets/icon/favicon.png" type="image/png">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700">
        <link rel="stylesheet" href="../assets/vendor/nucleo/css/nucleo.css" type="text/css">
        <link rel="stylesheet" href="../assets/vendor/@fortawesome/fontawesome-free/css/all.min.css" type="text/css">
        <link rel="stylesheet" href="../assets/vendor/datatables.net-bs4/css/dataTables.bootstrap4.min.css">
        <link rel="stylesheet" href="../assets/vendor/datatables.net-buttons-bs4/css/buttons.bootstrap4.min.css">
        <link rel="stylesheet" href="../assets/vendor/datatables.net-select-bs4/css/select.bootstrap4.min.css">
        <link rel="stylesheet" href="../assets/css/argon.min.css?v=1.1.0" type="text/css">
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
                                <h6 class="h2 text-white d-inline-block mb-0">Menu</h6>
                                <nav aria-label="breadcrumb" class="d-none d-md-inline-block ml-md-4">
                                    <ol class="breadcrumb breadcrumb-links breadcrumb-dark">
                                        <li class="breadcrumb-item"><a><i class="fas fa-home"></i></a></li>
                                        <li class="breadcrumb-item"><a>Gerenciar</a></li>
                                    </ol>
                                </nav>
                            </div>
                            <div class="col-lg-6 col-5 text-right">
                                <button class="btn btn-sm btn-neutral" data-toggle="modal" data-target="#modal-create">
                                    Adicionar Menu
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
                            <h3 class="mb-0">Menu</h3>
                        </div>
                        <div class="table-responsive">
                            <table class="table align-items-center table-flush">
                                <thead class="thead-light">
                                    <tr>
                                        <th scope="col">#</th>
                                        <th scope="col">Icone</th>
                                        <th scope="col">Título</th>
                                        <th scope="col">Link</th>
                                        <th scope="col">Status</th>
                                        <th scope="col">Ações</th>
                                    </tr>
                                </thead>
                                <tbody class="list">
                                    <%
                                        for(Menu m:list){
                                    %>
                                    <tr>
                                        <th scope="row">
                                            <%=m.getId() %>
                                        </th>
                                        <td>
                                            <span class="badge badge-dot mr-4">
                                                <i class='<%=m.getIcon()+" "+m.getColor() %>'></i>
                                            </span>
                                        </td>
                                        <td>
                                            <%=m.getTitle() %>
                                        </td>
                                        <td>
                                            <%=m.getLink() %>
                                        </td>
                                        <%
                                            if(m.isStatus()){
                                        %>
                                        <td>
                                            <span class="badge badge-dot mr-4">
                                                <i class="bg-success"></i>
                                                <span class="status">Ativo</span>
                                            </span>
                                        </td>
                                        <%
                                            } else {
                                        %>
                                        <td>
                                            <span class="badge badge-dot mr-4">
                                                <i class="bg-warning"></i>
                                                <span class="status">Inativo</span>
                                            </span>
                                        </td>
                                        <%
                                            }
                                        %>
                                        <td>
                                            <span data-toggle="modal" data-target="#modal-alter<%=m.getId() %>">
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
            for(Menu m:list){
        %>
        <div class="modal fade" id="modal-alter<%=m.getId() %>" tabindex="-1" role="dialog" aria-labelledby="modal-default" aria-hidden="true">
            <div class="modal-dialog modal- modal-dialog-centered modal-" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h6 class="modal-title" id="modal-title-default">Editar Menu:</h6>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form name="alter_menu" action="../alter_menu.do" method="POST" class="needs-validation" novalidate>
                            <input type="hidden" name="id" value="<%=m.getId() %>">
                            <div class="form-row">
                                <div class="col-md-12 mb-3">
                                    <label class="form-control-label" for="validationTitle">Título</label>
                                    <input type="text" class="form-control" id="validationTitle" name="title" placeholder="Título" value="<%=m.getTitle() %>" required>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="col-md-12 mb-3">
                                    <label class="form-control-label" for="validationLink">Link</label>
                                    <input type="text" class="form-control" id="validationLink" name="link" placeholder="Link" value="<%=m.getLink() %>" required>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-control-label" for="validationIcon">Icone</label>
                                    <input type="text" class="form-control" id="validationIcon" name="icon" placeholder="Icone" value="<%=m.getIcon() %>" required>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-control-label" for="validationColor">Cor</label>
                                    <input type="text" class="form-control" id="validationColor" name="color" placeholder="Cor" value="<%=m.getColor() %>" required>
                                </div>
                            </div>
                            <div class="form-row">
                                <label class="form-control-label">Status</label>
                            </div>
                            <div class="form-group">
                                <label class="custom-toggle custom-toggle-success">
                                    <input type="checkbox" name="status" <%if(m.isStatus()) {%>checked<%}%>>
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
        <div class="modal fade" id="modal-create" tabindex="-1" role="dialog" aria-labelledby="modal-default" aria-hidden="true">
            <div class="modal-dialog modal- modal-dialog-centered modal-" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h6 class="modal-title" id="modal-title-default">Adicionar Menu:</h6>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form name="create_menu" action="../create_menu.do" method="post" class="needs-validation" novalidate>
                            <div class="form-row">
                                <div class="col-md-12 mb-3">
                                    <label class="form-control-label" for="validationTitle">Título</label>
                                    <input type="text" class="form-control" id="validationTitle" name="title" placeholder="Título" required>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="col-md-12 mb-3">
                                    <label class="form-control-label" for="validationLink">Link</label>
                                    <input type="text" class="form-control" id="validationLink" name="link" placeholder="Link" required>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-control-label" for="validationIcon">Icone</label>
                                    <input type="text" class="form-control" id="validationIcon" name="icon" placeholder="Icone" required>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-control-label" for="validationColor">Cor</label>
                                    <input type="text" class="form-control" id="validationColor" name="color" placeholder="Cor" required>
                                </div>
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
        <script src="../assets/vendor/jquery/dist/jquery.min.js"></script>
        <script src="../assets/vendor/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
        <script src="../assets/vendor/js-cookie/js.cookie.js"></script>
        <script src="../assets/vendor/jquery.scrollbar/jquery.scrollbar.min.js"></script>
        <script src="../assets/vendor/jquery-scroll-lock/dist/jquery-scrollLock.min.js"></script>
        <script src="../assets/js/argon.js?v=1.1.0"></script>
        <script src="../assets/js/demo.min.js"></script>
    </body>
</html>
