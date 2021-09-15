<%-- 
    Document   : alter_school
    Created on : 05/04/2021, 16:49:35
    Author     : Gabriel Moraes
--%>

<%@page import="model.ProfileDAO"%>
<%@page import="model.TelephoneDAO"%>
<%@page import="model.AddressDAO"%>
<%@page import="model.SchoolDAO"%>
<%@page import="model.Telephone"%>
<%@page import="model.Address"%>
<%@page import="model.School"%>
<%@page import="model.Menu"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="validate_login.jsp" %>
<%
    String url = request.getRequestURI();
    School s = new School();
    try{
        int id = Integer.parseInt(request.getParameter("id"));
        SchoolDAO sDAO = new SchoolDAO();
        
        s = sDAO.uploadById(id);
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
        <title>OnGes - Editar Escola</title>
        <link rel="icon" href="../assets/icon/favicon.png" type="image/png">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700">
        <link rel="stylesheet" href="../assets/vendor/nucleo/css/nucleo.css" type="text/css">
        <link rel="stylesheet" href="../assets/vendor/@fortawesome/fontawesome-free/css/all.min.css" type="text/css">
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
                                <h6 class="h2 text-white d-inline-block mb-0">Editar Escola</h6>
                                <nav aria-label="breadcrumb" class="d-none d-md-inline-block ml-md-4">
                                    <ol class="breadcrumb breadcrumb-links breadcrumb-dark">
                                        <li class="breadcrumb-item"><a href='../dashboard.jsp'><i class="fas fa-home"></i></a></li>
                                        <li class="breadcrumb-item"><a href='../admin/school.jsp' >Escola</a></li>
                                        <li class="breadcrumb-item active" aria-current="page">Editar Escola</li>
                                    </ol>
                                </nav>
                            </div>
                            <div class="col-lg-6 col-5 text-right">
                                <a class="btn btn-sm btn-neutral" href="../admin/School">
                                    Voltar
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="container-fluid mt--6">
                <div class="row">
                    <div class="col">
                        <div class="card-wrapper">
                            <div class="card">
                                <div class="card-header">
                                    <div class="row align-items-center">
                                        <div class="col-8">
                                            <h3 class="mb-0">Editar Escola</h3>
                                        </div>
                                        <div class="col-4 text-right">
                                        <%
                                            if(s.getAddress().getId() == 0){
                                        %>
                                            <span data-toggle="modal" data-target="#modal-create-address">
                                                <a data-toggle="tooltip" data-original-title="Adicionar Endereço">
                                                    <i class="fas fa-map-marked"></i>
                                                </a>
                                            </span>&nbsp;
                                        <%
                                            }
                                            
                                            if(s.getTelephone().getId() == 0){
                                        %>
                                            <span data-toggle="modal" data-target="#modal-create-telephone">
                                                <a data-toggle="tooltip" data-original-title="Adicionar Telephone">
                                                    <i class="fas fa-phone"></i>
                                                </a>
                                            </span>&nbsp;
                                        <%
                                            }

                                            if(s.getResponsibleSchool().getId() == 0){
                                        %>
                                            <a data-toggle="tooltip" data-original-title="Adicionar Responsável" href="./add_responsible_school.jsp?id_school=<%=s.getId() %>">
                                                <i class="fas fa-user-plus"></i>
                                            </a>
                                        <%
                                            } else {
                                        %>
                                            <a data-toggle="tooltip" data-original-title="Editar Responsável" href="./alter_responsible_school.jsp?id=<%=s.getResponsibleSchool().getId() %>">
                                                <i class="fas fa-id-card"></i>
                                            </a>
                                        <%
                                            }
                                        %>
                                        </div>
                                    </div>
                                </div>
                                <div class="card-body">
                                    <form name="alter_school" action="../alter_school.do" method="post" class="needs-validation" novalidate>
                                        <input type="hidden" name="id" value="<%=s.getId() %>">
                                        <input type="hidden" name="name" value="<%=s.getName() %>">
                                        <div class="form-row">
                                            <div class="col-md-6 mb-3">
                                                <label class="form-control-label" for="companyName">Razão Social</label>
                                                <input type="text" name="company_name" class="form-control" id="companyName" placeholder="Razão Social" value='<%=s.getCompanyName() %>' required>
                                            </div>
                                            <div class="col-md-3 mb-3">
                                                <label class="form-control-label" for="cnpj">CNPJ</label>
                                                <input type="text" name="cnpj" class="form-control" id="cnpj" placeholder="CNPJ" value="<%=s.getCnpj() %>" onkeydown="javascript: fMasc( this, mCNPJ );" maxlength="18" required>
                                            </div>
                                        </div>
                                        <div class="form-row">
                                            <div class="col-md-3 mb-3">
                                                <label class="form-control-label" for="email">Email</label>
                                                <input type="text" class="form-control" name="email" id="email" placeholder="Email" value="<%=s.getEmail() %>" required>
                                            </div>
                                            <div class="col-md-3 mb-3">
                                                <label class="form-control-label" for="status">Status</label>
                                                <input type="text" class="form-control" name="status" id="naturalness" placeholder="status" value="<%=s.getStatus() %>" >
                                            </div>
                                        </div>
                                        <button class="btn btn-primary" type="submit">Salvar</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <%if(s.getAddress().getId() != 0 || s.getTelephone().getId() != 0) {%>
                <div class="row">
                    <%if(s.getAddress().getId() != 0) {%>
                    <div class="col-xl-8">
                        <div class="card-wrapper">
                            <div class="card">
                                <div class="card-header">
                                    <h3 class="mb-0">Editar Endereço</h3>
                                </div>
                                <div class="card-body">
                                    <form name="alter_address" action="../alter_address.do" method="post" class="needs-validation" novalidate>
                                        <input type="hidden" name="id" value="<%=s.getAddress().getId() %>">
                                        <input type="hidden" name="type_user" value="school">
                                        <input type="hidden" name="id_custom" value="<%=s.getId() %>">
                                        <div class="form-row">
                                            <div class="col-md-6 mb-3">
                                                <label class="form-control-label" for="postal_code">CEP</label>
                                                <input type="text" name="postal_code" class="form-control" id="postal_code" placeholder="CEP" onkeydown="javascript: fMasc( this, mCEP );" maxlength="10" value="<%=s.getAddress().getPostalCode() %>" required>
                                            </div>
                                        </div>
                                        <div class="form-row">
                                            <div class="col-md-9 mb-3">
                                                <label class="form-control-label" for="street">Rua</label>
                                                <input type="text" name="street" class="form-control" id="street" placeholder="Rua" value="<%=s.getAddress().getStreet() %>" required>
                                            </div>
                                            <div class="col-md-3 mb-3">
                                                <label class="form-control-label" for="number">Número</label>
                                                <input type="text" name="number" class="form-control" id="number" placeholder="Numero" value="<%=s.getAddress().getNumber() %>" required>
                                            </div>
                                        </div>
                                        <div class="form-row">
                                            <div class="col-md-3 mb-3">
                                                <label class="form-control-label" for="district">Bairro</label>
                                                <input type="text" class="form-control" name="district" id="district" placeholder="Bairro" value="<%=s.getAddress().getDistrict() %>" required>
                                            </div>
                                            <div class="col-md-3 mb-3">
                                                <label class="form-control-label" for="city">Cidade</label>
                                                <input type="text" class="form-control" name="city" id="city" placeholder="Cidade" value="<%=s.getAddress().getCity() %>" >
                                            </div>
                                            <div class="col-md-3 mb-3">
                                                <label class="form-control-label" for="state">Estado</label>
                                                <input type="text" class="form-control" name="state" id="state" placeholder="Estado" value="<%=s.getAddress().getState() %>" >
                                            </div>
                                            <div class="col-md-3 mb-3">
                                                <label class="form-control-label" for="country">País</label>
                                                <input type="text" class="form-control" name="country" id="country" placeholder="País" value="<%=s.getAddress().getCountry() %>" >
                                            </div>
                                        </div>
                                        <div class="form-row">
                                            <div class="col-md-12 mb-3">
                                                <label class="form-control-label" for="complement">Complemento</label>
                                                <input type="text" class="form-control" name="complement" id="complement" placeholder="Complemento" value="<%=s.getAddress().getComplement() %>">
                                            </div>
                                        </div>
                                        <button class="btn btn-primary" type="submit">Salvar</button>
                                    </form>
                              </div>
                            </div>
                        </div>
                    </div>
                    <% } if(s.getTelephone().getId() != 0) { %>
                    <div class="col-xl-4">
                        <div class="card-wrapper">
                            <div class="card">
                                <div class="card-header">
                                    <div class="row align-items-center">
                                        <div class="col-8">
                                            <h3 class="mb-0">Editar Telefone</h3>
                                        </div>
                                        <div class="col-4 text-right">
                                            <span data-toggle="modal" data-target="#modal-delete">
                                                <a class="table-action" data-toggle="tooltip" data-original-title="Excluir">
                                                    <i class="fas fa-trash"></i>
                                                </a>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                                <div class="card-body">
                                    <form name="alter_telephone" action="../alter_telephone.do" method="post" class="needs-validation" novalidate>
                                        <input type="hidden" name="id" value="<%=s.getTelephone().getId() %>">
                                        <input type="hidden" name="type_user" value="school">
                                        <input type="hidden" name="id_custom" value="<%=s.getId() %>">
                                        <div class="form-row">
                                            <div class="col-md-12 mb-3">
                                                <label class="form-control-label" for="number">Numero</label>
                                                <input type="text" name="number" class="form-control" id="number" placeholder="Numero" onkeydown="javascript: fMasc( this, mTel );" maxlength="15" value="<%=s.getTelephone().getNumber() %>" required>
                                            </div>
                                        </div>
                                        <div class="form-row">
                                            <div class="col-md-12 mb-3">
                                                <label class="form-control-label" for="type">Tipo</label>
                                                <select class="form-control" name="type" id="type">
                                                    <%
                                                        if(s.getTelephone().getType().equals("Fixo")){
                                                    %>
                                                    <option selected>Fixo</option>
                                                    <option>Celular</option>
                                                    <%
                                                        } else {
                                                    %>
                                                    <option>Fixo</option>
                                                    <option selected>Celular</option>
                                                    <%
                                                        }
                                                    %>
                                                </select>
                                            </div>
                                        </div>
                                        <button class="btn btn-primary" type="submit">Salvar</button>
                                    </form>
                              </div>
                            </div>
                        </div>
                    </div>
                    <% } %>
                </div>
                <% }%>
                <div class="modal fade" id="modal-create-address" tabindex="-1" role="dialog" aria-labelledby="modal-default" aria-hidden="true">
                    <div class="modal-dialog modal- modal-dialog-centered modal-" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h6 class="modal-title" id="modal-title-default">Adicionar Endereço:</h6>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">×</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <form name="create_address" action="../create_address.do" method="post" class="needs-validation" novalidate>
                                    <input type="hidden" name="type_user" value="school">
                                    <input type="hidden" name="id_custom" value="<%=s.getId() %>">
                                    <div class="form-row">
                                        <div class="col-md-9 mb-3">
                                            <label class="form-control-label" for="validationPostalCode">CEP</label>
                                            <input type="text" class="form-control" id="validationPostalCode" name="postal_code" placeholder="CEP" onkeydown="javascript: fMasc( this, mCEP );" maxlength="10" required>
                                        </div>
                                        <div class="col-md-3 mb-3">
                                            
                                        </div>
                                    </div>
                                    <div class="form-row">
                                        <div class="col-md-9 mb-3">
                                            <label class="form-control-label" for="validationStreet">Rua</label>
                                            <input type="text" class="form-control" id="validationNewPassword" name="street" placeholder="Rua">
                                        </div>
                                        <div class="col-md-3 mb-3">
                                            <label class="form-control-label" for="validationNumber">Número</label>
                                            <input type="text" class="form-control" id="validationNumber" name="number" placeholder="Número">
                                        </div>
                                    </div>
                                    <div class="form-row">
                                        <div class="col-md-6 mb-3">
                                            <label class="form-control-label" for="validationDistrict">Bairro</label>
                                            <input type="text" class="form-control" id="validationDistrict" name="district" placeholder="Bairro">
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label class="form-control-label" for="validationCity">Cidade</label>
                                            <input type="text" class="form-control" id="validationCity" name="city" placeholder="Cidade">
                                        </div>
                                    </div>
                                    <div class="form-row">
                                        <div class="col-md-6 mb-3">
                                            <label class="form-control-label" for="validationState">Estado</label>
                                            <input type="text" class="form-control" id="validationState" name="state" placeholder="Estado">
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label class="form-control-label" for="validationCountry">País</label>
                                            <input type="text" class="form-control" id="validationCountry" name="country" placeholder="País">
                                        </div>
                                    </div>
                                    <div class="form-row">
                                        <div class="col-md-12 mb-3">
                                            <label class="form-control-label" for="validationComplement">Complemento</label>
                                            <input type="text" class="form-control" id="validationComplement" name="complement" placeholder="Complemento">
                                        </div>
                                    </div>
                                    <button type="submit" class="btn btn-primary">Salvar</button>
                                    <button type="button" class="btn btn-link  ml-auto" data-dismiss="modal">Fechar</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal fade" id="modal-create-telephone" tabindex="-1" role="dialog" aria-labelledby="modal-default" aria-hidden="true">
                    <div class="modal-dialog modal- modal-dialog-centered modal-" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h6 class="modal-title" id="modal-title-default">Adicionar Telefone:</h6>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">×</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <form name="create_telephone" action="../create_telephone.do" method="post" class="needs-validation" novalidate>
                                    <input type="hidden" name="type_user" value="school">
                                    <input type="hidden" name="id_custom" value="<%=s.getId() %>">
                                    <div class="form-row">
                                        <div class="col-md-12 mb-3">
                                            <label class="form-control-label" for="validationNumber">Número</label>
                                            <input type="text" class="form-control" id="validationNumber" name="number" placeholder="Número" onkeydown="javascript: fMasc( this, mTel ); " maxlength="15">
                                        </div>
                                    </div>
                                    <div class="form-row">
                                        <div class="col-md-12 mb-3">
                                            <label class="form-control-label" for="validationType">Tipo</label>
                                            <select class="form-control" name="type" id="validationType">
                                                <option selected>Fixo</option>
                                                <option>Celular</option>
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
                <div class="modal fade" id="modal-delete" tabindex="-1" role="dialog" aria-labelledby="modal-default" aria-hidden="true">
                    <div class="modal-dialog modal- modal-dialog modal-lg" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h6 class="modal-title" id="modal-title-default">Excluir Telefone</h6>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">×</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <p>Tem certeza que deseja excluir o telefone?</p>
                                <form name="delete_telephone" action="../delete_telephone.do" method="post">
                                    <input type="hidden" name="id" value="<%=s.getTelephone().getId() %>">
                                    <input type="hidden" name="type_user" value="school">
                                    <input type="hidden" name="id_custom" value="<%=s.getId() %>">
                                    <button type="submit" class="btn btn-primary">Salvar</button>
                                    <button type="button" class="btn btn-link  ml-auto" data-dismiss="modal">Fechar</button>
                                </form>
                            </div>
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
        <script>
            (function() {
              'use strict';
              window.addEventListener('load', function() {
                var forms = document.getElementsByClassName('needs-validation');
                var validation = Array.prototype.filter.call(forms, function(form) {
                  form.addEventListener('submit', function(event) {
                    if (form.checkValidity() === false) {
                      event.preventDefault();
                      event.stopPropagation();
                    }
                    form.classList.add('was-validated');
                  }, false);
                });
              }, false);
            })();
        </script>
        <script src="../assets/js/argon.js?v=1.1.0"></script>
        <script src="../assets/js/demo.min.js"></script>
    </body>
</html>
