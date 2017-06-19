<%-- 
    Document   : approver_history
    Created on : Jun 5, 2017, 11:28:19 AM
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
<c:set var="levelApproved" value=""/>
<c:choose>
    <c:when test="${user.role eq 'approver1'}">
        <c:set var="levelApproved" value="is_level1_approved"/>
    </c:when>
    
    <c:when test="${user.role eq 'approver2'}">
        <c:set var="levelApproved" value="is_level2_approved"/>
    </c:when>
    
    <c:when test="${user.role eq 'approver3'}">
        <c:set var="levelApproved" value="is_level3_approved"/>
    </c:when>
</c:choose>

<html>
    <head>
        <title>${sessionScope.name}: ONGC DRMS</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" type="text/css" href="/ongc_drms/styles/dashboard_styles.css">
        <style>
            button {
                font-family: helvetica;
                border-radius: 5px;
                box-shadow: 1px 1px 5px black;
            }
            
            body {
                font-family: helvetica;
                margin: 0;
            }

            header {
                text-align: center;
                color: white;
                padding-top: 10px;
                background-color: #ff4d4d;
                background-size: cover;
                background-position: center;
            }

            #logo {
                height: 75px;
                border-radius: 10px;
            }

            header ul {
                list-style-type: none;
                padding: 10px;
                background: rgba(0,0,0,0.7);
            }

            header li {
                padding: 10px;
                display: inline;
            }

            a {
                color: white;
                text-decoration: none;
            }

            .content {
                max-width: 500px;
                margin: auto;
                text-align: center;
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
            <jsp:include page="../WEB-INF/jspf/filter.jsp"/>
            <ul>
                <c:set var="i" value="0"/>
                <c:set var="history" value="${dbFunctions:getApproverHistory(user.location, user.role, user.userId)}"/>
                <c:forEach var="surveyRequest" items="${history}">
                    <c:choose>
                        <c:when test="${user.role eq 'approver1'}">
                            <c:set var="dateApproved" value="${surveyRequest.dateApproved1}"/>
                        </c:when>
                        
                        <c:when test="${user.role eq 'approver2'}">
                            <c:set var="dateApproved" value="${surveyRequest.dateApproved2}"/>
                        </c:when>
                        
                        <c:when test="${user.role eq 'approver3'}">
                            <c:set var="dateApproved" value="${surveyRequest.dateApproved3}"/>
                        </c:when>
                    </c:choose>
                    
                    <%-- Possibly redundant code --%>
                    <c:choose>
                        <c:when test="${dateApproved eq null}">
                            <c:set var="dateApproved" value="Yet to be approved"/>
                        </c:when>
                    </c:choose>
                    <%-- Redundant code ends here --%>
                    <%--
                    <c:set var="status" value=""/>
                    <c:choose>
                        <c:when test="${surveyRequest.level3Approved}">
                            <c:set var="status" value="APPROVED"/>
                        </c:when>
                        
                        <c:when test="${surveyRequest.level2Approved}">
                            <c:set var="status" value="PENDING (To be approved by HOI, GEOPIC, Dehradun)"/>
                        </c:when>
                        
                        <c:when test="${surveyRequest.level1Approved}">
                            <c:set var="status" value="PENDING (To be approved by GMS)"/>
                        </c:when>
                        
                        <c:when test="${surveyRequest.rejected}">
                            <c:set var="status" value="REJECTED"/>
                        </c:when>
                        
                        <c:otherwise>
                            <c:set var="status" value="PENDING (To be approved at your branch)"/>
                        </c:otherwise>
                    </c:choose>
                    --%>
                    <li class="request" id="request${i}">
                        <section>
                            <b>Request ID:</b> <label id="requestId${i}">${surveyRequest.requestId}</label><br>
                            <b>User ID:</b> <label id="userId${i}">${surveyRequest.userId}</label><br>
                            <b>Request for:</b> <label id="requestList${i}">${surveyRequest.requestList}</label><br>
                            <b>Location of Generation:</b> <label id="location${i}">${surveyRequest.location}</label><br>
                            <b>Date Issued:</b> <label id="dateIssued${i}">${surveyRequest.dateIssued}</label><br>
                            <b>Date Approved:</b> <label>${dateApproved}</label><br>
                            <b>Status:</b> <label id="status${i}">${surveyRequest.status}</label>
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
