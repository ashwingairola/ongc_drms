<%@page contentType="text/html" pageEncoding="UTF-8" session="false"%>
<!DOCTYPE html>
<html>
    <head>
        <title>ONGC DRMS</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" type="text/css" href="styles/login_styles.css">
    </head>
    <body>
        <header>
            <img src="img/logo.jpg" alt="ONGC DRMS">
            <h1>ONGC DRMS</h1>
        </header>
        
        <section>
            <h1 id="maintitle">Welcome to ONGC Data Requisition Management System</h1>
        </section>
        
        <div id="loginform">
            <form action="LoginServlet" method="POST" >
                <div class="container">
                    <label><b>CPF Number</b></label>
                    <input type="text" placeholder="Enter CPF Number" name="userid">
                    <label><b>Password</b></label>
                    <input type="password" placeholder="Enter Password" name="password">
                    <button type="submit">Login</button>
                </div>
            </form>
        </div>
    </body>
</html>
