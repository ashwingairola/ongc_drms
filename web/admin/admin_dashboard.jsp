<%-- 
    Document   : admindashboard
    Created on : May 25, 2017, 11:02:25 PM
    Author     : Ashwin Gairola
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
        <link rel="stylesheet" type="text/css" href="/ongc_drms/styles/employee_styles.css">
        <title>Admin: ${sessionScope.name}</title>
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
                    <table>
                        <tr>
                            <td><label>CPF Number: </label></td>
                            <td><input type="number" name="userid"></td>
                        </tr>
                        <tr>
                            <td><label>Password: </label></td>
                            <td><input type="password" name="password"></td>
                        </tr>
                        <tr>
                            <td><label>First Name: </label></td>
                            <td><input name="firstname"></td>
                        </tr>
                        <tr>
                            <td><label>Middle Name: </label></td>
                            <td><input name="midname"></td>
                        </tr>
                        <tr>
                            <td><label>Last Name: </label></td>
                            <td><input name="lastname"></td>
                        </tr>
                        <tr>
                            <td><label>Phone Number: </label></td>
                            <td><input name="phone" maxlength="10"></td>
                        </tr>
                        <tr>
                            <td><label>Designation: </label></td>
                            <td><input name="designation"></td>
                        </tr>
                        <tr>
                            <td><label>Location: </label></td>
                            <td><input name="location"></td>
                        </tr>
                        <tr>
                            <td><label>Role: </label></td>
                            <td><input name="role"></td>
                        </tr>
                    </table>
                    <input type="hidden" name="action" value="adduser">
                    <button type="submit">Add User</button>
                </form>
            </div>
        </section>
    </body>
</html>
