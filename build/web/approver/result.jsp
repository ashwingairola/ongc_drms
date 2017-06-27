<%-- 
    Document   : result
    Created on : Jun 26, 2017, 2:03:34 AM
    Author     : Ashwin Gairola
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    response.setHeader("Cache-Control", "no-cache"); //forces caches to obtain a new copy of the page from the origin server
    response.setHeader("Cache-Control", "no-store"); //directs caches not to store the page under any circumstance
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0 backward compatibility
    response.setDateHeader("Expires", 0); //causes the proxy cache to see the page as "stale"
%>
<jsp:useBean id="user" class="com.ongcdrms.model.User" scope="session" />
<html>
    <head>
        <title>${sessionScope.name}: ONGC DRMS</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" type="text/css" href="/ongc_drms/styles/dashboard_styles.css">
        <link rel="stylesheet" type="text/css" href="/ongc_drms/styles/employee_styles.css">
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
        
        <c:choose>
            <c:when test="${sessionScope.flag}">
                <c:set var="result" value="SUCCESS!" />
                <c:set var="message" value="You have successfully handled the request." />
            </c:when>
            <c:otherwise>
                <c:set var="result" value="FAILED!" />
                <c:set var="message" value="The request could not be handled due to some error. Sorry about that." />
            </c:otherwise>
        </c:choose>
        
        <section class="content">
            <h1>${result}</h1>
            <p>${message}</p>
            <a href="/ongc_drms/approver/approver_dashboard.jsp">Go Back</a>
        </section>
    </body>
</html>
