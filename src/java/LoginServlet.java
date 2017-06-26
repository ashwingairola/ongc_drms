import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.*;

/**
 *
 * @author Ashwin Gairola
 */
@WebServlet(urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet
{
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException
    {
        String userid = request.getParameter("userid");
        String password = request.getParameter("password");
        User user = DBManager.getUser(userid);
        
        if(user!=null)
        {
            if(password.equals(user.getPassword()))
            {
                String destination = "index.jsp";
                String role = user.getRole();
                switch(role)
                {
                    case "sender":
                        destination = "sender/dashboard.jsp";
                        break;

                    case "approver1":
                    case "approver2":
                    case "approver3":
                        destination = "approver/approver_dashboard.jsp";
                        break;

                    case "admin":
                        destination = "admin/admin_dashboard.jsp";
                        break;
                }
                
                user = DBManager.getUserDetails(userid);
                String firstName = user.getFirstName();
                String middleName = user.getMiddleName();
                String lastName = user.getLastName();
                String name = firstName + ((middleName!=null) ? " "+middleName : "") + ((lastName!=null) ? " "+lastName : "");
                request.setAttribute("user", user);
                request.setAttribute("name", name);
                request.setAttribute("destination", destination);
                
                RequestDispatcher view = request.getRequestDispatcher("LoginRedirectServlet");
                view.forward(request, response);
            }
        }
        else
            response.sendRedirect("index.jsp");
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
