import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.*;

@WebServlet(urlPatterns = {"/SendRequestServlet"})
public class SendRequestServlet extends HttpServlet
{
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException
    {   
        String requestList = request.getParameter("requestList");     //Preparing a requestList string
        System.out.println("Requestlist: "+ request.getParameter("requestList"));
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
        RequestDispatcher view1 = request.getRequestDispatcher("sender/test.jsp");
        RequestDispatcher view2 = request.getRequestDispatcher("sender/fail.html");
        if(flag)
            view1.forward(request, response);
        else
            view2.forward(request, response);
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
