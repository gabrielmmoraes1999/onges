<%@page import="model.Login"%>
<%@page import="model.User"%>
<%@page import="model.LoginDAO"%>
<%@page import="model.UserDAO"%>
<%
    UserDAO uDAO = new UserDAO();
    LoginDAO lDAO = new LoginDAO();
    String link = null;
    User u = new User();
    try{
    String emailLogin = (String) session.getAttribute("email");
    String passwordLogin = (String) session.getAttribute("password");
    Login l = lDAO.login(emailLogin, passwordLogin);
    link = "/login";
    u = uDAO.uploadById(l.getUser().getId());
    }catch(Exception e){
        out.print("Erro:"+e);
    }
%>