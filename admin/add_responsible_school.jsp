<%-- 
    Document   : add_responsible_school
    Created on : 10/05/2021, 11:34:37
    Author     : Gabriel Moraes
--%>

<%@page import="model.Menu"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="validate_login.jsp" %>
<%
    String url = request.getRequestURI();
    int idSchool = 0;
    try{
        idSchool = Integer.parseInt(request.getParameter("id_school"));
    }catch(Exception e){
        out.print("Erro:"+e);
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="user-scalable=no, initial-scale=1, maximum-scale=1, minimum-scale=1, width=device-width, height=device-height, target-densitydpi=device-dpi" />
        <title>OnGes - Adicionar Responsável</title>
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
                                <h6 class="h2 text-white d-inline-block mb-0">Adicionar Responsável</h6>
                                <nav aria-label="breadcrumb" class="d-none d-md-inline-block ml-md-4">
                                    <ol class="breadcrumb breadcrumb-links breadcrumb-dark">
                                        <li class="breadcrumb-item"><a><i class="fas fa-home"></i></a></li>
                                        <li class="breadcrumb-item"><a>Escola</a></li>
                                        <li class="breadcrumb-item active" aria-current="page">Adicionar Responsável</li>
                                    </ol>
                                </nav>
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
                                    <h3 class="mb-0">Adicionar Responsável</h3>
                                </div>
                                <div class="card-body">
                                    <form name="create_responsible_school" action="../create_responsible_school.do" method="post" class="needs-validation" novalidate>
                                        <div class="form-row">
                                            <div class="col-md-6 mb-3">
                                                <input type="hidden" name="id_school" value="<%=idSchool %>">
                                                <label class="form-control-label" for="fullName">Nome Completo</label>
                                                <input type="text" name="full_name" class="form-control" id="fullName" placeholder="Nome Completo" required>
                                            </div>
                                            <div class="col-md-3 mb-3">
                                                <label class="form-control-label" for="cpf">CPF</label>
                                                <input type="text" name="cpf" class="form-control" id="cpf" placeholder="CPF" onkeydown="javascript: fMasc( this, mCPF );" maxlength="14" required>
                                            </div>
                                            <div class="col-md-3 mb-3">
                                                <label class="form-control-label" for="gender">Gênero</label>
                                                <select class="form-control" name="gender" id="gender">
                                                    <option>Feminino</option>
                                                    <option>Masculino</option>
                                                    <option>Outros</option>
                                                    <option>Prefiro não dizer</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="form-row">
                                            <div class="col-md-2 mb-3">
                                                <label for="birthDate" class="form-control-label">Data de Nascimento</label>
                                                <div>
                                                    <input class="form-control" name="birth_date" type="date" id="birthDate" required>
                                                </div>
                                            </div>
                                            <div class="col-md-3 mb-3">
                                                <label class="form-control-label" for="nationality">Nacionalidade</label>
                                                <input type="text" class="form-control" name="nationality" id="nationality" placeholder="Nacionalidade" required>
                                            </div>
                                            <div class="col-md-3 mb-3">
                                                <label class="form-control-label" for="naturalness">Naturalidade</label>
                                                <input type="text" class="form-control" name="naturalness" id="naturalness" placeholder="Naturalidade">
                                            </div>
                                        </div>
                                        <div class="form-row">
                                            <div class="col-md-2 mb-3">
                                                <label class="form-control-label" for="rg">Registro Geral</label>
                                                <input type="text" class="form-control" name="rg" id="rg" placeholder="Registro Geral" required>
                                            </div>
                                            <div class="col-md-2 mb-3">
                                                <label class="form-control-label" for="issuingAgencyRg">Orgão Emissor</label>
                                                <input type="text" class="form-control" name="issuing_agency_rg" id="issuingAgencyRg" placeholder="Orgão Emissor" required>
                                            </div>
                                            <div class="col-md-2 mb-3">
                                                <label class="form-control-label" for="stateRg">Estado do RG</label>
                                                <select class="form-control" name="state_rg" id="stateRg">
                                                    <option>AC</option>
                                                    <option>AL</option>
                                                    <option>AP</option>
                                                    <option>AM</option>
                                                    <option>BA</option>
                                                    <option>CE</option>
                                                    <option>DF</option>
                                                    <option>ES</option>
                                                    <option>GO</option>
                                                    <option>MA</option>
                                                    <option>MT</option>
                                                    <option>MS</option>
                                                    <option>MG</option>
                                                    <option>PA</option>
                                                    <option>PB</option>
                                                    <option>PR</option>
                                                    <option>PE</option>
                                                    <option>RJ</option>
                                                    <option>RN</option>
                                                    <option>RS</option>
                                                    <option>RO</option>
                                                    <option>RR</option>
                                                    <option>SC</option>
                                                    <option>SP</option>
                                                    <option>SE</option>
                                                    <option>TO</option>
                                                </select>
                                            </div>
                                            <div class="col-md-2 mb-3">
                                                <label for="example-date-input" class="form-control-label" for="dateRg">Data do RG</label>
                                                <div>
                                                    <input class="form-control" name="date_rg" type="date" id="dateRg" required>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-row">
                                            <div class="col-md-6 mb-3">
                                                <label class="form-control-label" for="mothersName">Nome da Mãe</label>
                                                <input type="text" class="form-control" name="mothers_name" id="mothersName" placeholder="Nome da Mãe" required>
                                            </div>
                                            <div class="col-md-6 mb-3">
                                                <label class="form-control-label" for="fathersName">Nome do Pai</label>
                                                <input type="text" class="form-control" name="fathers_name" id="fathersName" placeholder="Nome do Pai" required>
                                            </div>
                                        </div>
                                        <button class="btn btn-primary" type="submit">Salvar</button>
                                    </form>
                              </div>
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
