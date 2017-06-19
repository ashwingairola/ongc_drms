import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.*;

@WebServlet(urlPatterns = {"/HandleSurveyRequestServlet"})
public class HandleSurveyRequestServlet extends HttpServlet
{
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException
    {
        String requestId = request.getParameter("request_id");
        String role = request.getParameter("role");
        String approverId = request.getParameter("approver_id");
        boolean approved = (request.getParameter("approve")!=null) ? true : false;
        boolean rejected = (request.getParameter("reject")!=null) ? true : false;
        
        boolean flag = DBManager.handleRequest(requestId, approved, rejected, role, approverId);
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
