<%-- 
    Document   : dashboard
    Created on : May 22, 2017, 10:56:54 PM
    Author     : Ashwin Gairola
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="com.ongcdrms.model.*"%>
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
        <title>${sessionScope.name}: ONGC DRMS</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" type="text/css" href="/ongc_drms/styles/dashboard_styles.css">
        <link rel="stylesheet" type="text/css" href="/ongc_drms/styles/employee_styles.css">
    </head>
    
    <body>
        <jsp:include page="../WEB-INF/jspf/header.jsp">
            <jsp:param name="name" value="${sessionScope.name}"/>
            <jsp:param name="userId" value="${user.userId}"/>
        </jsp:include>
        
        <section class="content">
            <h2>You may request for survey data here.</h2>
            <div class="surveyform">
                <form id="form" action="/ongc_drms/SendRequestServlet" method="POST" onsubmit="return validate()">
                    <label>Survey Name</label>
                    <input type="text" name="surveyname" id="survey"><br>

                    <button type="button" onclick="addSurvey()">Add Survey</button><br>

                    <label style="margin-top: 30px;">Your desired surveys will appear here:</label>
                    <select multiple="multiple" id="listbox"></select><br>
                    <button type="button" onclick="deleteSurvey()">Delete Survey</button>

                    <input type="hidden" name="userid" value="${user.userId}">
                    <input type="hidden" name="location" value="${user.location}">
                    <input type="hidden" name="requestList" id="requestList" value="">
                    
                    <button type="submit">Submit Request</button>
                </form>
            </div>
        </section>

        <script>
            var list = new Array();
            var requestList = document.getElementById("requestList");
            
            function addSurvey()
            {
                var survey = document.getElementById('survey').value;
                if(survey.length !== 0)
                {
                    list.push(survey);                                  // Add the survey name to the array.
                    var listbox = document.getElementById('listbox');   // Add the survey name to the select box.
                    var option = document.createElement('option');
                    option.text = survey;
                    listbox.add(option);
                    requestList.setAttribute('value', list.join(', '));
                }
            }

            function deleteSurvey()
            {
                var listbox = document.getElementById('listbox');
                for(var i=0; i<listbox.options.length; ++i)
                {
                    if(listbox.options[i].selected)
                    {
                        listbox.remove(i);
                        list.splice(i,1);
                        requestList.setAttribute('value', list.join(', '));
                        break;
                    }
                }
            }
            
            function validate()
            {
                if(list.length === 0)
                {
                    window.alert('Please enter at least one survey.');
                    return false;
                }
                
                return true;
            }
        </script>
    </body>
</html>
