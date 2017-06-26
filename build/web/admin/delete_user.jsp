<%-- 
    Document   : delete_user
    Created on : Jun 19, 2017, 1:23:12 AM
    Author     : Ashwin Gairola
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    response.setHeader("Cache-Control", "no-cache"); //forces caches to obtain a new copy of the page from the origin server
    response.setHeader("Cache-Control", "no-store"); //directs caches not to store the page under any circumstance
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0 backward compatibility
    response.setDateHeader("Expires", 0); //causes the proxy cache to see the page as "stale"
%>
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
                <form id="form" action="/ongc_drms/AdminServlet" method="POST">
                    <table>
                        <tr>
                            <td><label>CPF Number: </label></td>
                            <td><input type="number" name="userid"></td>
                        </tr>
                    </table>
                    <input type="hidden" name="action" value="deleteuser">
                    <button type="submit">Delete User</button>
                </form>
            </div>
        </section>
    </body>
</html>
