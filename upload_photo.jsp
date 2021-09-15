<%@page import="model.UserDAO"%>
<%@page import="model.Upload"%>
<%
    Upload up = new Upload();
    up.setFolderUpload("img");
    if(up.formProcess(getServletContext(), request)){
        UserDAO uDAO = new UserDAO();
        String idString = (String) up.getForm().get("idPhoto");
        int id = Integer.parseInt(idString);
        uDAO.uploadPhoto("img/"+up.getFiles().get(0), id);
       } else {
           
       }
    response.sendRedirect("/myprofile.jsp");
%>
