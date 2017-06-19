<%-- 
    Document   : approver1_dashboard
    Created on : May 26, 2017, 5:27:24 AM
    Author     : Ashwin Gairola
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="dbFunctions" uri="/WEB-INF/tlds/dbFunctions" %>
<%@page contentType="text/html" pageEncoding="UTF-8" import="model.*, java.util.*" %>
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
        <title>${sessionScope.name}: ONGC DRMS</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" type="text/css" href="/ongc_drms/styles/dashboard_styles.css">
        <style>
            section ul {
                list-style-type: none;
                padding: 0;
            }

            .request {
                background-color: yellowgreen;
                padding: 10px;
                border-radius: 10px;
                margin: 10px auto;
                max-width: 500px;
                box-shadow: 2px 2px 5px;
            }

            .request button {
                display: inline;
                padding: 10px;
                border: 0px;
                border-radius: 5px;
            }

            .approve {
                background-color: skyblue;
            }

            .reject {
                background-color: red;
            }
            
            button {
                cursor: pointer;
                box-shadow: 1px 1px 5px;
            }
    </style>
    </head>
    <body>
        <c:choose>
            <c:when test="${user.role eq 'approver1' or user.role eq 'approver3'}">
                <jsp:include page="../WEB-INF/jspf/approver_header.jsp">
                    <jsp:param name="name" value="${sessionScope.name}"/>
                    <jsp:param name="userId" value="${user.userId}"/>
                </jsp:include>
            </c:when>
            
            <c:when test="${user.role eq 'approver2'}">
                <jsp:include page="../WEB-INF/jspf/approver2_header.jsp">
                    <jsp:param name="name" value="${sessionScope.name}"/>
                    <jsp:param name="userId" value="${user.userId}"/>
                </jsp:include>
            </c:when>
        </c:choose>
        <section class="content">
            <ul>
                <c:set var="surveyRequests" value="${dbFunctions:getSurveyRequests(user.location, user.role)}"/>
                <c:forEach var="surveyRequest" items="${surveyRequests}">
                    <li class="request">
                        <section>
                            <form action="/ongc_drms/HandleSurveyRequestServlet" method="POST">
                                <b>Request ID: </b><label>${surveyRequest.requestId}</label><br>
                                <b>User ID: </b><label>${surveyRequest.userId}</label><br>
                                <b>Request for: </b><label>${surveyRequest.requestList}</label><br>
                                <b>Location of Generation: </b><label>${surveyRequest.location}</label><br>
                                <b>Date Issued: </b><label>${surveyRequest.dateIssued}</label><br>
                                <input type="hidden" name="request_id" value="${surveyRequest.requestId}">
                                <input type="hidden" name="role" value="${user.role}">
                                <input type="hidden" name="approver_id" value="${user.userId}">
                                <button type="submit" name="approve" value="approve" class="approve">Approve</button>
                                <button type="submit" name="reject" value="reject" class="reject">Reject</button>
                            </form>
                        </section>
                    </li>
                </c:forEach>
            </ul>
        </section>
    </body>
</html>
