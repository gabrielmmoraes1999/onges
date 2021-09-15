<%-- 
    Document   : alter_student
    Created on : 06/07/2021, 15:36:33
    Author     : Gabriel Moraes
--%>

<%@page import="model.FuncionaryDAO"%>
<%@page import="model.SchoolDAO"%>
<%@page import="model.StudentDAO"%>
<%@page import="model.Student"%>
<%@page import="model.Menu"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="validate_login.jsp" %>
<%
    String url = request.getRequestURI();
    FuncionaryDAO fDAO = new FuncionaryDAO();
    Student s = new Student();
    StudentDAO sDAO = new StudentDAO();
    SchoolDAO scDAO = new SchoolDAO();
    int idSchool = 0;
    String email = null;
    
    try{
        if(u.getProfile().getId() == 50){
            idSchool = scDAO.uploadByIdResponsibleSchoolUser(u.getId());
        }else if(u.getProfile().getId() == 0 && u.getProfileSchool().getId() > 0){
            idSchool = fDAO.uploadByIdUser(u.getId()).getSchool().getId();
        }
        
        int id = Integer.parseInt(request.getParameter("id"));
        s = sDAO.uploadById(id);
        email = lDAO.uploadByUser(uDAO.uploadById(s.getUser().getId()).getId()).getEmail();
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
        <title>OnGes - Editar Aluno</title>
        <link rel="icon" href="./assets/icon/favicon.png" type="image/png">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700">
        <link rel="stylesheet" href="./assets/vendor/nucleo/css/nucleo.css" type="text/css">
        <link rel="stylesheet" href="./assets/vendor/@fortawesome/fontawesome-free/css/all.min.css" type="text/css">
        <link rel="stylesheet" href="./assets/css/argon.css?v=1.1.0" type="text/css">
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
                                <h6 class="h2 text-white d-inline-block mb-0">Editar Aluno</h6>
                                <nav aria-label="breadcrumb" class="d-none d-md-inline-block ml-md-4">
                                    <ol class="breadcrumb breadcrumb-links breadcrumb-dark">
                                        <li class="breadcrumb-item"><a><i class="fas fa-home"></i></a></li>
                                        <li class="breadcrumb-item"><a>Aluno</a></li>
                                        <li class="breadcrumb-item active" aria-current="page">Editar Aluno</li>
                                    </ol>
                                </nav>
                            </div>
                            <div class="col-lg-6 col-5 text-right">
                                <a class="btn btn-sm btn-neutral" href="student.jsp">
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
                            <div class="row align-items-center">
                                <div class="col-8">
                                    <h3 class="mb-0">Editar Aluno</h3>
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
                                %>
                                </div>
                            </div>
                        </div>
                        <div class="card-body">
                            <form name="alter_funcionary" action="./alter_student.do" method="post" class="needs-validation" novalidate>
                                <input type="hidden" name="id" value="<%=s.getId() %>">
                                <div class="form-row">
                                    <div class="col-md-6 mb-3">
                                        <label class="form-control-label" for="fullName">Nome Completo</label>
                                        <input type="text" name="full_name" class="form-control" id="fullName" placeholder="Nome Completo" value="<%=s.getFullName() %>" required>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <label class="form-control-label" for="cpf">CPF</label>
                                        <input type="text" name="cpf" class="form-control" id="cpf" placeholder="CPF" onkeydown="javascript: fMasc( this, mCPF );" maxlength="14" value="<%=s.getCpf() %>" required>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <label class="form-control-label" for="gender">Gênero</label>
                                        <select class="form-control" name="gender" id="gender">
                                            <option<%if(s.getGender().equals("Feminino")){%> selected<%}%>>Feminino</option>
                                            <option<%if(s.getGender().equals("Masculino")){%> selected<%}%>>Masculino</option>
                                            <option<%if(s.getGender().equals("Outros")){%> selected<%}%>>Outros</option>
                                            <option<%if(s.getGender().equals("Prefiro não dizer")){%> selected<%}%>>Prefiro não dizer</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="col-md-2 mb-3">
                                        <label for="birthDate" class="form-control-label">Data de Nascimento</label>
                                        <div>
                                            <input class="form-control" name="birth_date" type="date" id="birthDate" value="<%=s.getBirthDate() %>" required>
                                        </div>
                                    </div>
                                    <div class="col-md-5 mb-3">
                                        <label class="form-control-label" for="nationality">Nacionalidade</label>
                                        <input type="text" class="form-control" name="nationality" id="nationality" placeholder="Nacionalidade" value="<%=s.getNationality() %>" required>
                                    </div>
                                    <div class="col-md-5 mb-3">
                                        <label class="form-control-label" for="naturalness">Naturalidade</label>
                                        <input type="text" class="form-control" name="naturalness" id="naturalness" placeholder="Naturalidade" <%if(s.getNaturalness() != null) {%>value="<%=s.getNaturalness() %>"<% } %> >
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="col-md-3 mb-3">
                                        <label class="form-control-label" for="rg">Registro Geral</label>
                                        <input type="text" class="form-control" name="rg" id="rg" placeholder="Registro Geral" value="<%=s.getRg() %>" required>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <label class="form-control-label" for="issuingAgencyRg">Orgão Emissor</label>
                                        <input type="text" class="form-control" name="issuing_agency_rg" id="issuingAgencyRg" placeholder="Orgão Emissor" value="<%=s.getIssuingAgencyRg() %>" required>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <label class="form-control-label" for="stateRg">Estado do RG</label>
                                        <select class="form-control" name="state_rg" id="stateRg">
                                            <option<%if(s.getStateRg().equals(null)){%> selected<%}%>>Escolhe...</option>
                                            <option<%if(s.getStateRg().equals("AC")){%> selected<%}%>>AC</option>
                                            <option<%if(s.getStateRg().equals("AL")){%> selected<%}%>>AL</option>
                                            <option<%if(s.getStateRg().equals("AP")){%> selected<%}%>>AP</option>
                                            <option<%if(s.getStateRg().equals("AM")){%> selected<%}%>>AM</option>
                                            <option<%if(s.getStateRg().equals("BA")){%> selected<%}%>>BA</option>
                                            <option<%if(s.getStateRg().equals("CE")){%> selected<%}%>>CE</option>
                                            <option<%if(s.getStateRg().equals("DF")){%> selected<%}%>>DF</option>
                                            <option<%if(s.getStateRg().equals("ES")){%> selected<%}%>>ES</option>
                                            <option<%if(s.getStateRg().equals("GO")){%> selected<%}%>>GO</option>
                                            <option<%if(s.getStateRg().equals("MA")){%> selected<%}%>>MA</option>
                                            <option<%if(s.getStateRg().equals("MT")){%> selected<%}%>>MT</option>
                                            <option<%if(s.getStateRg().equals("MS")){%> selected<%}%>>MS</option>
                                            <option<%if(s.getStateRg().equals("MG")){%> selected<%}%>>MG</option>
                                            <option<%if(s.getStateRg().equals("PA")){%> selected<%}%>>PA</option>
                                            <option<%if(s.getStateRg().equals("PB")){%> selected<%}%>>PB</option>
                                            <option<%if(s.getStateRg().equals("PR")){%> selected<%}%>>PR</option>
                                            <option<%if(s.getStateRg().equals("PE")){%> selected<%}%>>PE</option>
                                            <option<%if(s.getStateRg().equals("RJ")){%> selected<%}%>>RJ</option>
                                            <option<%if(s.getStateRg().equals("RN")){%> selected<%}%>>RN</option>
                                            <option<%if(s.getStateRg().equals("RS")){%> selected<%}%>>RS</option>
                                            <option<%if(s.getStateRg().equals("RO")){%> selected<%}%>>RO</option>
                                            <option<%if(s.getStateRg().equals("RR")){%> selected<%}%>>RR</option>
                                            <option<%if(s.getStateRg().equals("SC")){%> selected<%}%>>SC</option>
                                            <option<%if(s.getStateRg().equals("SP")){%> selected<%}%>>SP</option>
                                            <option<%if(s.getStateRg().equals("SE")){%> selected<%}%>>SE</option>
                                            <option<%if(s.getStateRg().equals("TO")){%> selected<%}%>>TO</option>
                                        </select>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <label for="example-date-input" class="form-control-label" for="dateRg">Data do RG</label>
                                        <div>
                                            <input class="form-control" name="date_rg" type="date" id="dateRg" value="<%=s.getDateRg() %>" required>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="col-md-6 mb-3">
                                        <label class="form-control-label" for="mothersName">Nome da Mãe</label>
                                        <input type="text" class="form-control" name="mothers_name" id="mothersName" placeholder="Nome da Mãe" value="<%=s.getMothersName() %>" required>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label class="form-control-label" for="fathersName">Nome do Pai</label>
                                        <input type="text" class="form-control" name="fathers_name" id="fathersName" placeholder="Nome do Pai" value="<%=s.getFathersName() %>" required>
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="col-md-6 mb-3">
                                        <label class="form-control-label" for="email">Endereço de Email (OnGes ID):</label>
                                        <input type="text" name="email" class="form-control" id="email" placeholder="Email" value="<%=email %>" disabled>
                                    </div>
                                </div>
                                <button class="btn btn-primary" type="submit">Salvar</button>
                            </form>
                        </div>
                    </div>
                </div>
                <%
                    if(s.getAddress().getId() != 0 || s.getTelephone().getId() != 0) {
                %>
                <div class="row">
                    <%
                        if(s.getAddress().getId() != 0) {
                    %>
                    <div class="col-xl-8">
                        <div class="card-wrapper">
                            <div class="card">
                                <div class="card-header">
                                    <h3 class="mb-0">Editar Endereço</h3>
                                </div>
                                <div class="card-body">
                                    <form name="alter_address" action="./alter_address.do" method="post" class="needs-validation" novalidate>
                                        <input type="hidden" name="id" value="<%=s.getAddress().getId() %>">
                                        <input type="hidden" name="type_user" value="student">
                                        <input type="hidden" name="id_custom" value="<%=s.getId() %>">
                                        <div class="form-row">
                                            <div class="col-md-6 mb-3">
                                                <label class="form-control-label" for="postal_code">CEP</label>
                                                <input type="text" name="postal_code" class="form-control" id="postal_code" placeholder="CEP" maxlength="10" onkeydown="javascript: fMasc( this, mCEP );" value="<%=s.getAddress().getPostalCode() %>" required>
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
                    <%
                        }

                        if(s.getTelephone().getId() != 0) {
                    %>
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
                                    <form name="alter_telephone" action="./alter_telephone.do" method="post" class="needs-validation" novalidate>
                                        <input type="hidden" name="id" value="<%=s.getTelephone().getId() %>">
                                        <input type="hidden" name="type_user" value="student">
                                        <input type="hidden" name="id_custom" value="<%=s.getId() %>">
                                        <div class="form-row">
                                            <div class="col-md-12 mb-3">
                                                <label class="form-control-label" for="number">Numero</label>
                                                <input type="text" name="number" class="form-control" id="number" placeholder="Numero" maxlength="15" onkeydown="javascript: fMasc( this, mTel );" value="<%=s.getTelephone().getNumber() %>"  required>
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
                    <%
                        }
                    %>
                </div>
                <%
                    }
                %>
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
                        <form name="create_address" action="./create_address.do" method="post" class="needs-validation" novalidate>
                            <input type="hidden" name="type_user" value="student">
                            <input type="hidden" name="id_custom" value="<%=s.getId() %>">
                            <div class="form-row">
                                <div class="col-md-9 mb-3">
                                    <label class="form-control-label" for="validationPostalCode">CEP</label>
                                    <input type="text" class="form-control" id="validationPostalCode" name="postal_code" maxlength="10" onkeydown="javascript: fMasc( this, mCEP );" placeholder="CEP" required>
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
                        <form name="create_telephone" action="./create_telephone.do" method="post" class="needs-validation" novalidate>
                            <input type="hidden" name="type_user" value="student">
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
                        <p>Tem certeza que deseja excluir o telefone do aluno <b><%=s.getFullName() %></b>?</p>
                        <form name="delete_telephone" action="../delete_telephone.do" method="post">
                            <input type="hidden" name="type_user" value="student">
                            <input type="hidden" name="id" value="<%=s.getTelephone().getId() %>">
                            <input type="hidden" name="id_custom" value="<%=s.getId() %>">
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
        <script src="./assets/js/argon.js?v=1.1.0"></script>
        <script src="./assets/js/demo.min.js"></script>
    </body>
</html>
