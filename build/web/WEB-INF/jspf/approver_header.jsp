<%-- 
    Document   : approver_header
    Created on : Jun 11, 2017, 11:12:48 PM
    Author     : Ashwin Gairola
--%>

<header>
    <img src="/ongc_drms/img/logo.jpg" id="logo">
    <h3>ONGC Data Requisition Management System</h3>
    <h1>${param.name} (ID: ${param.userId})</h1>
    <ul>
        <li><a href="/ongc_drms/approver/approver_dashboard.jsp">Pending Requests</a></li>
        <li><a href="/ongc_drms/approver/profile.jsp">View Profile</a></li>
        <li><a href="/ongc_drms/approver/approver_history.jsp">Request History</a></li>
        <li><a href="/ongc_drms/LogoutServlet">Logout</a></li>
    </ul>
</header>