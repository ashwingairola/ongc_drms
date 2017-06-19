<%-- 
    Document   : test
    Created on : May 24, 2017, 8:42:23 AM
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String userId = request.getParameter("userid");
    String location = request.getParameter("location");
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
        <p>
            <%= userId+" "+location %>
        </p>
    </body>
</html>
