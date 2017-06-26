<%-- 
    Document   : update
    Created on : Jun 26, 2017, 1:57:52 PM
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
<jsp:useBean id="update_user" class="model.User" scope="request" />
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
            <h2>You can update users here.</h2>
            <div class="surveyform">
                <form id="form" action="AdminServlet" method="POST" onsubmit="return validate()">
                    <table>
                        <input type="hidden" name="userid" value="${update_user.userId}">
                        <tr>
                            <td><label>CPF Number: </label></td>
                            <td><label>${update_user.userId}</label></td>
                        </tr>
                        <tr>
                            <td><label>First Name: </label></td>
                            <td><input id="firstname" name="firstname" value="${update_user.firstName}"></td>
                        </tr>
                        <tr>
                            <td><label>Middle Name: </label></td>
                            <td><input name="midname" value="${update_user.middleName}"></td>
                        </tr>
                        <tr>
                            <td><label>Last Name: </label></td>
                            <td><input name="lastname" value="${update_user.lastName}"></td>
                        </tr>
                        <tr>
                            <td><label>Phone Number: </label></td>
                            <td><input id="phone" name="phone" value="${update_user.phno}" maxlength="10"></td>
                        </tr>
                        <tr>
                            <td><label>Designation: </label></td>
                            <td><input id="designation" name="designation" value="${update_user.designation}"></td>
                        </tr>
                        <tr>
                            <td><label>Location: </label></td>
                            <td><input id="location" name="location" value="${update_user.location}"></td>
                        </tr>
                        <tr>
                            <td><label>Role: </label></td>
                            <td><input id="role" name="role" value="${update_user.role}"></td>
                        </tr>
                    </table>
                    <input type="hidden" name="action" value="updateuser">
                    <button type="submit">Update User</button>
                </form>
            </div>
        </section>
        
        <script>
            function validate()
            {
                var errors = "";
                
                if(document.getElementById('firstname').value.length === 0)
                    errors += "Please enter a first name.\n";
                if(document.getElementById('phone').value.length === 0)
                    errors += "Please enter a valid phone number.\n";
                if(document.getElementById('location').value.length === 0)
                    errors += "Please enter a valid location.\n";
                if(document.getElementById('designation').value.length === 0)
                    errors += "Please enter a designation.\n";
                if(document.getElementById('role').value.length === 0)
                    errors += "A user MUST have a role.\n";
                
                if(errors.length !== 0)
                {
                    window.alert(errors);
                    return false;
                }
                
                return true;
            }
        </script>
    </body>
</html>
