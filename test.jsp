<%-- 
    Document   : test
    Created on : 23/07/2021, 17:42:02
    Author     : Gabriel Moraes
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
        <%
        int id = Integer.parseInt(request.getParameter("id_teacher"));
        out.print("Professor "+id);
        out.print("Disicplines: ");
        String[] printRec = request.getParameterValues("discipline");
        if (printRec != null){
            for(String printRe:printRec){
                out.println(Integer.parseInt(printRe));
            }
        }
    %>
    </body>
</html>
