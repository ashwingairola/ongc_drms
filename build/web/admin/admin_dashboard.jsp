<%-- 
    Document   : admindashboard
    Created on : May 25, 2017, 11:02:25 PM
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="model.*" %>
<!DOCTYPE html>
<%
    response.setHeader("Cache-Control", "no-cache"); //forces caches to obtain a new copy of the page from the origin server
    response.setHeader("Cache-Control", "no-store"); //directs caches not to store the page under any circumstance
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0 backward compatibility
    response.setDateHeader("Expires", 0); //causes the proxy cache to see the page as "stale"
%>
<jsp:useBean id="user" class="model.User" scope="session"/>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="/ongc_drms/styles/dashboard_styles.css">
        <title>Admin</title>
    </head>
    <body>
        <jsp:include page="../WEB-INF/jspf/admin_header.jsp">
            <jsp:param name="name" value="${sessionScope.name}"/>
            <jsp:param name="userId" value="${user.userId}"/>
        </jsp:include>
        
        <section class="content">
            <h2>You may request for survey data here.</h2>
            <div class="surveyform">
                <form id="form" action="AdminServlet" method="POST">
                    <label>CPF Number: </label><input type="number" name="userid">
                    <label>Password: </label><input type="password" name="password">
                    <label>First Name: </label><input name="firstname">
                    <label>Middle Name: </label><input name="midname">
                    <label>Last Name: </label><input name="lastname">
                    <label>Designation: </label><input name="designation">
                    <label>Location: </label><input name="location">
                    <label>Role: </label><input name="role">
                    <button type="submit">Add User</button>
                </form>
            </div>
        </section>
        
    </body>
</html>
