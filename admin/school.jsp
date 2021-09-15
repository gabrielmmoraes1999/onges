<%-- 
    Document   : school
    Created on : 05/04/2021, 12:58:49
    Author     : Gabriel Moraes
--%>

<%@page import="model.Menu"%>
<%@page import="model.SchoolDAO"%>
<%@page import="model.School"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="validate_login.jsp" %>
<%
    String url = request.getRequestURI();
    ArrayList<School> list = new ArrayList<School>();
    try{
        SchoolDAO sDAO = new SchoolDAO();
        list = sDAO.read();
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
        <title>OnGes - Escola</title>
        <link rel="icon" href="../assets/icon/favicon.png" type="image/png">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700">
        <link rel="stylesheet" href="../assets/vendor/nucleo/css/nucleo.css" type="text/css">
        <link rel="stylesheet" href="../assets/vendor/@fortawesome/fontawesome-free/css/all.min.css" type="text/css">
        <link rel="stylesheet" href="../assets/vendor/datatables.net-bs4/css/dataTables.bootstrap4.min.css">
        <link rel="stylesheet" href="../assets/vendor/datatables.net-buttons-bs4/css/buttons.bootstrap4.min.css">
        <link rel="stylesheet" href="../assets/vendor/datatables.net-select-bs4/css/select.bootstrap4.min.css">
        <link rel="stylesheet" href="../assets/css/argon.css?v=1.1.0" type="text/css">
        <script type="text/javascript">
            function fMasc(objeto,mascara) {
                obj=objeto;
                masc=mascara;
                setTimeout("fMascEx()",1);
            }
            function fMascEx() {
                obj.value=masc(obj.value);
            }
            function mTel(tel) {
                tel=tel.replace(/\D/g,"");
                tel=tel.replace(/^(\d)/,"($1");
                tel=tel.replace(/(.{3})(\d)/,"$1) $2");
                if(tel.length == 9) {
                    tel=tel.replace(/(.{1})$/,"-$1");
                } else if (tel.length == 10) {
                    tel=tel.replace(/(.{2})$/,"-$1");
                } else if (tel.length == 11) {
                    tel=tel.replace(/(.{3})$/,"-$1");
                } else if (tel.length == 12) {
                    tel=tel.replace(/(.{4})$/,"-$1");
                } else if (tel.length > 12) {
                    tel=tel.replace(/(.{4})$/,"-$1");
                }
                return tel;
            }
            function mCNPJ(cnpj){
                cnpj=cnpj.replace(/\D/g,"");
                cnpj=cnpj.replace(/^(\d{2})(\d)/,"$1.$2");
                cnpj=cnpj.replace(/^(\d{2})\.(\d{3})(\d)/,"$1.$2.$3");
                cnpj=cnpj.replace(/\.(\d{3})(\d)/,".$1/$2");
                cnpj=cnpj.replace(/(\d{4})(\d)/,"$1-$2");
                return cnpj;
            }
            function mCPF(cpf){
                cpf=cpf.replace(/\D/g,"");
                cpf=cpf.replace(/(\d{3})(\d)/,"$1.$2");
                cpf=cpf.replace(/(\d{3})(\d)/,"$1.$2");
                cpf=cpf.replace(/(\d{3})(\d{1,2})$/,"$1-$2");
                return cpf;
            }
            function mCEP(cep){
                cep=cep.replace(/\D/g,"");
                cep=cep.replace(/^(\d{2})(\d)/,"$1.$2");
                cep=cep.replace(/\.(\d{3})(\d)/,".$1-$2");
                return cep;
            }
            function mNum(num){
                num=num.replace(/\D/g,"");
                return num;
            }
        </script>
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
                                <h6 class="h2 text-white d-inline-block mb-0">Escola</h6>
                                <nav aria-label="breadcrumb" class="d-none d-md-inline-block ml-md-4">
                                    <ol class="breadcrumb breadcrumb-links breadcrumb-dark">
                                        <li class="breadcrumb-item"><a><i class="fas fa-home"></i></a></li>
                                        <li class="breadcrumb-item active" aria-current="page">Gerenciar</li>
                                    </ol>
                                </nav>
                            </div>
                            <div class="col-lg-6 col-5 text-right">
                                <button class="btn btn-sm btn-neutral" data-toggle="modal" data-target="#modal-create">
                                    Nova Escola
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
                            <h3 class="mb-0">Escola</h3>
                        </div>
                        <div class="table-responsive">
                            <table class="table align-items-center table-flush">
                                <thead class="thead-light">
                                    <tr>
                                        <th scope="col">#</th>
                                        <th scope="col">Razão Social</th>
                                        <th scope="col">Nome</th>
                                        <th scope="col">Email</th>
                                        <th scope="col">Ações</th>
                                    </tr>
                                </thead>
                                <tbody class="list">
                                    <%
                                        for(School s:list){
                                    %>
                                    <tr>
                                        <th scope="row">
                                            <%=s.getId() %>
                                        </th>
                                        <td>
                                            <%=s.getCompanyName() %>
                                        </td>
                                        <td>
                                            <%=s.getName() %>
                                        </td>
                                        <td>
                                            <%=s.getEmail() %>
                                        </td>
                                        <td>
                                            <a class="table-action" data-toggle="tooltip" data-original-title="Editar" href="alter_school.jsp?id=<%=s.getId() %>">
                                                <i class="fas fa-user-edit"></i>
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
        <div class="modal fade" id="modal-create" tabindex="-1" role="dialog" aria-labelledby="modal-default" aria-hidden="true">
            <div class="modal-dialog modal- modal-dialog-centered modal-" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h6 class="modal-title" id="modal-title-default">Cadastrar Nova Escola:</h6>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form name="create_school" action="../create_school.do" method="post" class="needs-validation" novalidate>
                            <div class="form-row">
                                <div class="col-md-12 mb-3">
                                    <label class="form-control-label" for="validationCompanyName">Razão Social</label>
                                    <input type="text" class="form-control" id="validationCompanyName" name="company_name" placeholder="Razão Social" required>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="col-md-12 mb-3">
                                    <label class="form-control-label" for="validationName">Nome</label>
                                    <input type="text" class="form-control" id="validationName" name="name" placeholder="Nome" required>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="col-md-12 mb-3">
                                    <label class="form-control-label" for="validationCnpj">CNPJ</label>
                                    <input type="text" class="form-control" id="validationCnpj" name="cnpj" placeholder="CNPJ" onkeydown="javascript: fMasc( this, mCNPJ );" maxlength="18" required>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="col-md-12 mb-3">
                                    <label class="form-control-label" for="validationEmail">Email</label>
                                    <input type="text" class="form-control" id="validationCnpj" name="email" placeholder="Email" required>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="col-md-12 mb-3">
                                    <label class="form-control-label" for="validationStatus">Status</label>
                                    <input type="text" class="form-control" id="validationStatus" name="status" placeholder="Status" required>
                                </div>
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
