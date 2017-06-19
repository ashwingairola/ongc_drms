<%-- 
    Document   : header
    Created on : Jun 11, 2017, 4:50:09 AM
    Author     : Ashwin Gairola
--%>

<header>
    <img src="/ongc_drms/img/logo.jpg" alt="ONGC DRMS" id="logo">
    <h3>ONGC Data Requisition Management System</h3>
    <h1>${param.name} (ID: ${param.userId})</h1>
    <ul>
        <li><a href="dashboard.jsp">Request Surveys</a></li>
        <li><a href="/ongc_drms/sender/profile.jsp">View Profile</a></li>
        <li><a href="/ongc_drms/sender/history.jsp">Request History</a></li>
        <li><a href="/ongc_drms/sender/approved_requests.jsp">Approved Requests</a></li>
        <li><a href="/ongc_drms/LogoutServlet">Logout</a></li>
    </ul>
</header>