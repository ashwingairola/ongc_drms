<%-- 
    Document   : profile
    Created on : Jun 2, 2017, 1:19:22 AM
    Author     : Ashwin Gairola
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="com.ongcdrms.model.*"%>
<!DOCTYPE html>
<%
    response.setHeader("Cache-Control", "no-cache"); //forces caches to obtain a new copy of the page from the origin server
    response.setHeader("Cache-Control", "no-store"); //directs caches not to store the page under any circumstance
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0 backward compatibility
    response.setDateHeader("Expires", 0); //causes the proxy cache to see the page as "stale"
%>
<jsp:useBean id="user" class="com.ongcdrms.model.User" scope="session"/>
<html>
    <head>
        <title>User-ONGC DRMS</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" type="text/css" href="/ongc_drms/styles/dashboard_styles.css">
        <link rel="stylesheet" type="text/css" href="/ongc_drms/styles/employee_styles.css">
        <style>
            #details
            {
                background-color: #c2c2d6;
                padding: 20px;
                border-radius: 5px;
                text-align: justify;
            }
            
            #details label
            {
                padding:10px;
                display: block;
            }
        </style>
    </head>
    
    <body>
        <jsp:include page="../WEB-INF/jspf/header.jsp">
            <jsp:param name="name" value="${sessionScope.name}"/>
            <jsp:param name="userId" value="${user.userId}"/>
        </jsp:include>
        
        <section class="content">
            <h2>Your Profile</h2>
            
            <div id="details">
                <label>CPF Number: ${user.userId}</label>
                <label>Name: ${sessionScope.name}</label>
                <label>Designation: ${user.designation}</label>
                <label>Location: ${user.location}</label>
                <label>Phone No.: ${user.phno}</label>
                <label>Role: ${user.role}</label>
            </div>
        </section>
    </body>
</html>