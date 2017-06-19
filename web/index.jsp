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
            <h1>ONGC</h1>
            <img src="img/logo.jpg" alt="ONGC DRMS">
            <h1>DRMS</h1>
        </header>
        
        <section>
            <h1 id="maintitle">Welcome to ONGC Data Requisition Management System</h1>
            <div class="mainbuttons">
                <button id="employee" onclick="document.getElementById('emplogin').style.display='block'">Login</button>
            </div>
        </section>
        
        <div id="emplogin" class="modal">
            <form class="modal-content animate" action="LoginServlet" method="POST">
                <div class="container">
                    <div style="margin-bottom: 20px">
                        <span onclick="document.getElementById('emplogin').style.display='none'" class="close">&times;</span>
                    </div>
                    <label><b>CPF Number</b></label>
                    <input type="text" placeholder="Enter CPF Number" name="userid">
                    <label><b>Password</b></label>
                    <input type="password" placeholder="Enter Password" name="password">
                    <button type="submit" id="empbutton">Login</button>
                </div>
            </form>
        </div>
        <script>
            var empmodal = document.getElementById('emplogin');
            var adminmodal = document.getElementById('adminlogin');
            window.onclick = function(event)
            {
                if(event.target == empmodal)
                {
                    empmodal.style.display = 'none';
                }
            };
        </script>
    </body>
</html>
