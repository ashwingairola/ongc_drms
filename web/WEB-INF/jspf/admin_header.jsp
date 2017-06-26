<%-- 
    Document   : admin_header
    Created on : Jun 14, 2017, 12:11:25 AM
    Author     : Ashwin Gairola
--%>

<header>
    <img src="/ongc_drms/img/logo.jpg" alt="ONGC DRMS" id="logo">
    <h3>ONGC Data Requisition Management System</h3>
    <h1>${param.name} (ID: ${param.userId})</h1>
    <ul>
        <li><a href="/ongc_drms/admin/admin_dashboard.jsp">Add Users</a></li>
        <li><a href="/ongc_drms/admin/update_user.jsp">Update Users</a></li>
        <li><a href="/ongc_drms/admin/delete_user.jsp">Delete Users</a></li>
        <li><a href="#">View Profile</a></li>
        <li><a href="/ongc_drms/LogoutServlet">Logout</a></li>
    </ul>
</header>
