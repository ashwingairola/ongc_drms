package com.ongcdrms;

import com.ongcdrms.model.SurveyRequest;
import com.ongcdrms.model.DBManager;
import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Ashwin Gairola
 */
@WebServlet(urlPatterns = {"/SendRequestServlet"})
public class SendRequestServlet extends HttpServlet
{
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException
    {   
        String requestList = request.getParameter("requestList");     //Preparing a requestList string
        requestList = requestList.trim();
        
        SurveyRequest surveyRequest = new SurveyRequest();      //Extracting the hidden form data to create a SurveyRequest instance
        surveyRequest.setRequestId((int)(Math.random()*100000));
        surveyRequest.setUserId(request.getParameter("userid"));
        surveyRequest.setRequestList(requestList);
        surveyRequest.setLocation(request.getParameter("location"));
        surveyRequest.setLevel1Approved(false);
        surveyRequest.setLevel2Approved(false);
        surveyRequest.setLevel3Approved(false);
        surveyRequest.setRejected(false);
        surveyRequest.setDateIssued(new java.util.Date());
        surveyRequest.setStatus("PENDING (To be approved at your branch)");
        
        boolean flag = DBManager.addRequest(surveyRequest);       //Add the survey request to the database
        request.setAttribute("flag", flag);
        request.setAttribute("destination", "sender/result.jsp");
        
        RequestDispatcher view = request.getRequestDispatcher("RedirectServlet");
        view.forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException
    {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException
    {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo()
    {
        return "Short description";
    }
}
