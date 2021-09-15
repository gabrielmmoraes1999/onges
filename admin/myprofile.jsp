<%-- 
    Document   : myprofile
    Created on : 28/03/2021, 19:26:57
    Author     : Gabriel Moraes
--%>
<%@page import="model.ResponsibleSchoolDAO"%>
<%@page import="model.ResponsibleSchool"%>
<%@page import="model.SchoolDAO"%>
<%@page import="model.School"%>
<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.util.Calendar"%>
<%@page import="model.Funcionary"%>
<%@page import="model.FuncionaryDAO"%>
<%@page import="model.Menu"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="validate_login.jsp" %>
<%
    String url = request.getRequestURI();
    Login l = new Login();
    Funcionary f = new Funcionary();
    FuncionaryDAO fDAO = new FuncionaryDAO();
    
    try{
        f = fDAO.uploadByIdUser(u.getId());
        l = lDAO.uploadByUser(u.getId());
    }catch(Exception e){
        out.print("Erro:"+e);
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="user-scalable=no, initial-scale=1, maximum-scale=1, minimum-scale=1, width=device-width, height=device-height, target-densitydpi=device-dpi" />
        <title>OnGes - Perfil</title>
        <link rel="icon" href="../assets/icon/favicon.png" type="image/png">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700">
        <link rel="stylesheet" href="../assets/vendor/nucleo/css/nucleo.css" type="text/css">
        <link rel="stylesheet" href="../assets/vendor/@fortawesome/fontawesome-free/css/all.min.css" type="text/css">
        <link rel="stylesheet" href="../assets/css/argon.css?v=1.1.0" type="text/css">
    </head>
    <body>
        <%@include file="list_menu.jsp" %>
        <div class="main-content" id="panel">
            <%@include file="info_user.jsp" %>
            <%
                Calendar dateOfBirth = new GregorianCalendar();
                dateOfBirth.setTime(f.getBirthDate());
                Calendar today = Calendar.getInstance();
                int age = today.get(Calendar.YEAR) - dateOfBirth.get(Calendar.YEAR);
                dateOfBirth.add(Calendar.YEAR, age);
                if (today.before(dateOfBirth)) {
                    age--;
                }
            %>
            <div class="header pb-6 d-flex align-items-center" style="min-height: 500px; background-image: url(../assets/img/theme/profile-cover.jpg); background-size: cover; background-position: center top;">
                <span class="mask bg-gradient-default opacity-8"></span>
                <div class="container-fluid d-flex align-items-center">
                    <div class="row">
                        <div class="col-lg-7 col-md-10">
                            <h1 class="display-2 text-white"><%=u.getName()+" "+u.getSurname() %></h1>
                            <p class="text-white mt-0 mb-5">Esta é a sua página de perfil. Você pode ver o progresso que fez com seu trabalho e gerenciar seus projetos ou tarefas atribuídas</p>
                            <!--<a href="#!" class="btn btn-neutral">Editar Perfil</a>-->
                        </div>
                    </div>
                </div>
            </div>
            <div class="container-fluid mt--6">
                <div class="row">
                    <div class="col-xl-4 order-xl-2">
                        <div class="card card-profile">
                            <img src="../assets/img/theme/img-1-1000x600.jpg" alt="Image placeholder" class="card-img-top">
                            <div class="row justify-content-center">
                                <div class="col-lg-3 order-lg-2">
                                    <div class="card-profile-image">
                                        <a data-toggle="modal" data-target="#modal-uploadPhoto">
                                            <img src="../<%=u.getPhoto() %>" class="rounded-circle">
                                        </a>
                                    </div>
                                </div>
                            </div>
                            <div class="card-header text-center border-0 pt-8 pt-md-4 pb-0 pb-md-4">
                                <!--<div class="d-flex justify-content-between">
                                    <a href="#" class="btn btn-sm btn-info mr-4">Compartilhar</a>
                                    <a href="#" class="btn btn-sm btn-default float-right">Messagem</a>
                                </div>-->
                            </div>
                            <div class="card-body pt-0">
                                <div class="row">
                                    <div class="col">
                                        <div class="card-profile-stats d-flex justify-content-center">
                                            <div>
                                                <span class="heading">0</span>
                                                <span class="description">Atividades</span>
                                            </div>
                                            <div>
                                                <span class="heading">0</span>
                                                <span class="description">Ranking</span>
                                            </div>
                                            <div>
                                                <span class="heading">0</span>
                                                <span class="description">Comentarios</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="text-center">
                                    <h5 class="h3">
                                        <%=u.getName()+" "+u.getSurname() %>
                                        <span class="font-weight-light">, <%=age %></span>
                                    </h5>
                                    <div class="h5 font-weight-300">
                                        <i class="ni location_pin mr-2"></i><%=f.getAddress().getCity() %>, <%=f.getAddress().getCountry() %>
                                    </div>
                                    <div class="h5 mt-4">
                                        <i class="ni business_briefcase-24 mr-2"></i><%=u.getProfile().getName() %>
                                    </div>
                                    <div>
                                        <i class="ni education_hat mr-2"></i>OnGes
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- Progress track -->
                        <div class="card">
                            <!-- Card header -->
                            <div class="card-header">
                                <!-- Title -->
                                <h5 class="h3 mb-0">Atividades</h5>
                            </div>
                            <!-- Card body -->
                            <div class="card-body">
                                <!-- List group -->
                                <ul class="list-group list-group-flush list my--3">
                                    <li class="list-group-item px-0">
                                      <div class="row align-items-center">
                                        <div class="col-auto">
                                          <!-- Avatar -->
                                          <a href="#" class="avatar rounded-circle">
                                            <img alt="Image placeholder" src="../assets/img/theme/bootstrap.jpg">
                                          </a>
                                        </div>
                                        <div class="col">
                                          <h5>Argon Design System</h5>
                                          <div class="progress progress-xs mb-0">
                                            <div class="progress-bar bg-orange" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 60%;"></div>
                                          </div>
                                        </div>
                                      </div>
                                    </li>
                                    <li class="list-group-item px-0">
                                      <div class="row align-items-center">
                                        <div class="col-auto">
                                          <!-- Avatar -->
                                          <a href="#" class="avatar rounded-circle">
                                            <img alt="Image placeholder" src="../assets/img/theme/angular.jpg">
                                          </a>
                                        </div>
                                        <div class="col">
                                          <h5>Angular Now UI Kit PRO</h5>
                                          <div class="progress progress-xs mb-0">
                                            <div class="progress-bar bg-green" role="progressbar" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100" style="width: 100%;"></div>
                                          </div>
                                        </div>
                                      </div>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-8 order-xl-1">
                        <!--<div class="row">
                            <div class="col-lg-6">
                                <div class="card bg-gradient-info border-0">
                                  <div class="card-body">
                                    <div class="row">
                                      <div class="col">
                                        <h5 class="card-title text-uppercase text-muted mb-0 text-white">Total traffic</h5>
                                        <span class="h2 font-weight-bold mb-0 text-white">350,897</span>
                                      </div>
                                      <div class="col-auto">
                                        <div class="icon icon-shape bg-white text-dark rounded-circle shadow">
                                          <i class="ni ni-active-40"></i>
                                        </div>
                                      </div>
                                    </div>
                                    <p class="mt-3 mb-0 text-sm">
                                      <span class="text-white mr-2"><i class="fa fa-arrow-up"></i> 3.48%</span>
                                      <span class="text-nowrap text-light">Since last month</span>
                                    </p>
                                  </div>
                                </div>
                            </div>
                            <div class="col-lg-6">
                                <div class="card bg-gradient-danger border-0">
                                  <div class="card-body">
                                    <div class="row">
                                      <div class="col">
                                        <h5 class="card-title text-uppercase text-muted mb-0 text-white">Performance</h5>
                                        <span class="h2 font-weight-bold mb-0 text-white">49,65%</span>
                                      </div>
                                      <div class="col-auto">
                                        <div class="icon icon-shape bg-white text-dark rounded-circle shadow">
                                          <i class="ni ni-spaceship"></i>
                                        </div>
                                      </div>
                                    </div>
                                    <p class="mt-3 mb-0 text-sm">
                                      <span class="text-white mr-2"><i class="fa fa-arrow-up"></i> 3.48%</span>
                                      <span class="text-nowrap text-light">Since last month</span>
                                    </p>
                                  </div>
                                </div>
                            </div>
                        </div>-->
                        <div class="card">
                            <div class="card-header">
                                <div class="row align-items-center">
                                    <div class="col-8">
                                      <h3 class="mb-0">Meu Perfil</h3>
                                    </div>
                                    <div class="col-4 text-right">
                                      <a href="#!" class="btn btn-sm btn-primary">Salvar</a>
                                    </div>
                                </div>
                            </div>
                            <div class="card-body">
                                <h6 class="heading-small text-muted mb-4">Informações de Usuário</h6>
                                <div class="pl-lg-4">
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <div class="form-group">
                                                <label class="form-control-label" for="input-email">Endereço de Email</label>
                                                <input type="email" id="input-email" class="form-control" placeholder="jesse@example.com" value="<%=l.getEmail() %>">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-6">
                                            <div class="form-group">
                                                <label class="form-control-label" for="input-first-name">Nome</label>
                                                <input type="text" id="input-first-name" class="form-control" placeholder="First name" value="<%=u.getName() %>">
                                            </div>
                                        </div>
                                        <div class="col-lg-6">
                                            <div class="form-group">
                                                <label class="form-control-label" for="input-last-name">Sobrenome</label>
                                                <input type="text" id="input-last-name" class="form-control" placeholder="Last name" value="<%=u.getSurname() %>">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <hr class="my-4" />
                                <!-- Address -->
                                <h6 class="heading-small text-muted mb-4">Endereço</h6>
                                <div class="pl-lg-4">
                                    <div class="row">
                                        <div class="col-md-8">
                                            <div class="form-group">
                                                <label class="form-control-label" for="input-address">Endereço</label>
                                                <input id="input-address" class="form-control" placeholder="Endereço" value="<%=f.getAddress().getStreet() %>" type="text">
                                            </div>
                                        </div>
                                        <div class="col-lg-4">
                                            <div class="form-group">
                                                <label class="form-control-label" for="input-number">Número</label>
                                                <input type="text" id="input-city" class="form-control" placeholder="Número" value="<%=f.getAddress().getNumber() %>">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-4">
                                            <div class="form-group">
                                                <label class="form-control-label" for="input-city">Cidade</label>
                                                <input type="text" id="input-city" class="form-control" placeholder="Cidade" value="<%=f.getAddress().getCity() %>">
                                            </div>
                                        </div>
                                        <div class="col-lg-4">
                                            <div class="form-group">
                                                <label class="form-control-label" for="input-country">País</label>
                                                <input type="text" id="input-country" class="form-control" placeholder="País" value="<%=f.getAddress().getCountry() %>">
                                            </div>
                                        </div>
                                        <div class="col-lg-4">
                                            <div class="form-group">
                                                <label class="form-control-label" for="input-country">CEP</label>
                                                <input type="text" id="input-postal-code" class="form-control" placeholder="CEP" value="<%=f.getAddress().getPostalCode() %>">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <div class="form-group">
                                                <label class="form-control-label" for="input-complement">Complemento</label>
                                                <input type="text" id="input-city" class="form-control" placeholder="Complemento" value="<%=f.getAddress().getComplement() %>">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <hr class="my-4" />
                            <div class="pl-lg-4">
                                <div class="form-group">
                                    <label class="form-control-label">About Me</label>
                                    <textarea rows="4" class="form-control" placeholder="A few words about you ...">A beautiful premium dashboard for Bootstrap 4.</textarea>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal fade" id="modal-uploadPhoto" tabindex="-1" role="dialog" aria-labelledby="modal-uploadPhoto" aria-hidden="true">
                <div class="modal-dialog modal- modal-dialog-centered modal-" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h6 class="modal-title" id="modal-title-default">Editar foto de Perfil </h6>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">×</span>
                            </button>
                        </div>
                        <form action="../upload_photo.jsp" method="post" enctype="multipart/form-data">
                            <div class="modal-body">
                                <div class="custom-file">
                                    <input type="hidden" value="<%=u.getId() %>" name="idPhoto"/>
                                    <input class="form-control form-control-lg" id="formFileLg" type="file" name="file[]" accept=".jpg"  />
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="submit" class="btn btn-primary">Enviar</button>
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Voltar</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <!-- Footer -->
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
