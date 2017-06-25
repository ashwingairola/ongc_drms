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
        
        HttpSession session = request.getSession();
        User user = DBManager.getUser(userid);
        
        if(user!=null)
        {
            if(password.equals(user.getPassword()))
            {
                RequestDispatcher view = request.getRequestDispatcher("index.jsp");
                String role = user.getRole();
                session.setAttribute("role", role);
                switch(role)
                {
                    case "sender":
                        view = request.getRequestDispatcher("sender/dashboard.jsp");
                        break;

                    case "approver1":
                    case "approver2":
                    case "approver3":
                        view = request.getRequestDispatcher("approver/approver_dashboard.jsp");
                        break;

                    case "admin":
                        view = request.getRequestDispatcher("admin/admin_dashboard.jsp");
                        break;
                }
                
                request.setAttribute("userid", userid);
                user = DBManager.getUserDetails(userid);
                String firstName = user.getFirstName();
                String middleName = user.getMiddleName();
                String lastName = user.getLastName();
                String name = firstName + ((middleName!=null) ? " "+middleName : "") + ((lastName!=null) ? " "+lastName : "");
                session.setAttribute("user", user);
                session.setAttribute("name", name);
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
