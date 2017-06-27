<%-- 
    Document   : approved_requests
    Created on : Jun 2, 2017, 1:58:41 AM
    Author     : Ashwin Gairola
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="dbFunctions" uri="/WEB-INF/tlds/dbFunctions"%>
<%@page contentType="text/html" pageEncoding="UTF-8" import="com.ongcdrms.model.*, java.util.*"%>
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
            section ul {
                list-style-type: none;
                padding: 0;
            }
            
            label {
                display: block;
            }
            
            .request {
                background-color: yellowgreen;
                padding: 10px;
                border-radius: 10px;
                margin: 10px auto;
                max-width: 500px;
                box-shadow: 2px 2px 5px;
            }
        </style>
    </head>
    
    <body>
        <jsp:include page="../WEB-INF/jspf/header.jsp">
            <jsp:param name="name" value="${sessionScope.name}"/>
            <jsp:param name="userId" value="${user.userId}"/>
        </jsp:include>
        
        <section class="content">
            <h2>Your Approved Requests</h2>
            <ul>
                <c:set var="userId" value="${user.userId}"/>
                <c:set var="history" value="${dbFunctions:getApprovedRequests(userId)}"/>
                <c:forEach var="surveyRequest" items="${history}">
                    <li class="request">
                        <section>
                            <label>Request ID: ${surveyRequest.requestId}</label>
                            <label>User ID: ${surveyRequest.userId}</label>
                            <label>Request for: ${surveyRequest.requestList}</label>
                            <label>Location of Generation: ${surveyRequest.location}</label>
                            <label>Date Issued: ${surveyRequest.dateIssued}</label>
                            <label>Status: ${surveyRequest.status}</label>
                        </section>
                    </li>
                </c:forEach>
            </ul>
        </section>
    </body>
</html>