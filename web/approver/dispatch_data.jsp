<%-- 
    Document   : dispatch_data
    Created on : Jun 13, 2017, 5:27:22 AM
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
        <link rel="stylesheet" type="text/css" href="/ongc_drms/styles/employee_styles.css">
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
                box-shadow: 1px 1px 5px black;
            }
        </style>
    </head>
    <body>
        <jsp:include page="../WEB-INF/jspf/approver2_header.jsp">
            <jsp:param name="name" value="${sessionScope.name}"/>
            <jsp:param name="userId" value="${user.userId}"/>
        </jsp:include>
        <section class="content">
            <ul>
                <c:set var="i" value="0"/>
                <c:forEach var="surveyRequest" items="${dbFunctions:getDispatchableRequests()}">
                    <li class="request">
                        <section>
                            <form action="/ongc_drms/DispatchRequestServlet" method="POST" onsubmit="return validate(document.getElementById('courierId${i}').value)">
                                <b>Request ID: </b><label name="requestId">${surveyRequest.requestId}</label><br>
                                <b>User ID: </b><label>${surveyRequest.userId}</label><br>
                                <b>Request for: </b><label>${surveyRequest.requestList}</label><br>
                                <b>Location of Generation: </b><label>${surveyRequest.location}</label><br>
                                <b>Date Issued: </b><label>${surveyRequest.dateIssued}</label><br>
                                <b>Courier ID: </b><input type="text" name="courierId" id="courierId${i}"/><br>
                                <input type="hidden" name="requestId" value="${surveyRequest.requestId}">
                                <button type="submit">Dispatch</button>
                            </form>
                        </section>
                    </li>
                    <c:set var="i" value="${i+1}"/>
                </c:forEach>
            </ul>
        </section>
        <script>
            function validate(courierId)
            {
                if(courierId === undefined || courierId === '')
                {
                    window.alert('Please enter a valid courier ID');
                    return false;
                }
                else
                    return true;
            }
        </script>
    </body>