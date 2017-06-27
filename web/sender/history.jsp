<%-- 
    Document   : history
    Created on : May 22, 2017, 10:56:54 PM
    Author     : Ashwin Gairola
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="dbFunctions" uri="/WEB-INF/tlds/dbFunctions" %>
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
            button {
                font-family: helvetica;
                border-radius: 5px;
                box-shadow: 1px 1px 5px black;
            }
            
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
            
            #monthselector, #yearselector {
                display: none;
                top: 0;
                left: 0;
                background-color: rgba(0,0,0,0.4);
                height: 100%;
                width: 100%;
                z-index: 1;
                position: fixed;
                padding-top: 60px;
            }
            
            .selectorcontent {
                background-color: #fefefe;
                width: 40%;
                margin: 200px auto;
                padding: 20px;
                -webkit-animation: animatezoom 0.6s;
                animation: animatezoom 0.6s;
            }
            
            @-webkit-keyframes animatezoom {
                from{-webkit-transform: scale(0)}
                to{-webkit-transform: scale(1)}
            }
            
            @keyframes animatezoom {
                from {transform: scale(0)} 
                to {transform: scale(1)}
            }
            
            .closecalendar {
                float: right;
                font-size: 20px;
                color: #000000;
                font-weight: bold;
            }
            
            .closecalendar:hover {
                color: red;
                cursor: pointer;
            }
            
            #selectfilter {
                border-radius: 10px;
                background: #c2c2d6;
                padding: 5px;
            }
            
            #filter {
                border-radius: 5px;
                font-size: 16px;
                height: 40px;
            }
        </style>
    </head>
    
    <body>
        <jsp:include page="../WEB-INF/jspf/header.jsp">
            <jsp:param name="name" value="${sessionScope.name}"/>
            <jsp:param name="userId" value="${user.userId}"/>
        </jsp:include>
        
        <section class="content">
            <h2>Your Request History</h2>
            <jsp:include page="../WEB-INF/jspf/filter.jsp"/>
            <ul>
                <c:set var="i" value="0"/>
                <c:set var="history" value="${dbFunctions:getHistory(user.userId)}"/>
                <c:forEach var="surveyRequest" items="${history}">
                    <li>
                        <section class="request" id="request${i}">
                            <b>Request ID: </b><label id="requestId${i}">${surveyRequest.requestId}</label><br>
                            <b>User ID: </b><label id="userId${i}">${surveyRequest.userId}</label><br>
                            <b>Request for: </b><label id="requestList${i}">${surveyRequest.requestList}</label><br>
                            <b>Location of Generation: </b><label id="location${i}">${surveyRequest.location}</label><br>
                            <b>Date Issued: </b><label id="dateIssued${i}">${surveyRequest.dateIssued}</label><br>
                            <b>Status: </b><label id="status${i}">${surveyRequest.status}</label>
                        </section>
                    </li>
                    <c:set var="i" value="${i+1}"/>
                </c:forEach>
            </ul>
        </section>
        <input type="hidden" id="numOfRequests" value="${i}">
        <script src="../js/filter.js"></script>
    </body>
</html>