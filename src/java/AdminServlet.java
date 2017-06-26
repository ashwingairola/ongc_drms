import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.DBManager;
import model.*;

/**
 *
 * @author Ashwin Gairola
 */
public class AdminServlet extends HttpServlet
{
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException
    {
        String action = request.getParameter("action");
        switch(action)
        {
            case "adduser" :
                addUser(request, response);
                break;
            
            case "deleteuser" :
                deleteUser(request);
                break;
            
            case "finduser" :
                findUser(request, response);
                break;
                
            case "updateuser" :
                updateUser(request, response);
                break;
        }
    }
    
    private static void addUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException
    {
        String userId = request.getParameter("userid");
        String password = request.getParameter("password");
        String firstName = request.getParameter("firstname");
        String middleName = request.getParameter("midname");
        String lastName = request.getParameter("lastname");
        String phone = request.getParameter("phone");
        String designation = request.getParameter("designation");
        String location = request.getParameter("location");
        String role = request.getParameter("role");
        
        boolean flag = DBManager.addUser(userId, password, firstName, middleName, lastName, phone, designation, location, role);
        request.setAttribute("flag", flag);
        request.setAttribute("destination", "admin/add_result.jsp");
        request.getRequestDispatcher("RedirectServlet").forward(request, response);
    }
    
    private static void deleteUser(HttpServletRequest request)
    {
        String userId = request.getParameter("userid");
        boolean flag = DBManager.deleteUser(userId);
    }
    
    private static void findUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException
    {
        String userId = request.getParameter("userid");
        User user = DBManager.getUserDetails(userId);
        if(user != null)
        {
            request.setAttribute("update_user", user);
            request.getRequestDispatcher("admin/update.jsp").forward(request, response);
        }
    }
    
    private static void updateUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException
    {
        String userId = request.getParameter("userid");
        String firstName = request.getParameter("firstname");
        String middleName = request.getParameter("midname");
        String lastName = request.getParameter("lastname");
        String phone = request.getParameter("phone");
        String designation = request.getParameter("designation");
        String location = request.getParameter("location");
        String role = request.getParameter("role");
        
        boolean flag = DBManager.updateUser(userId, firstName, middleName, lastName,
                phone, designation, location, role);
        request.setAttribute("flag", flag);
        request.setAttribute("destination", "admin/update_result.jsp");
        RequestDispatcher view = request.getRequestDispatcher("RedirectServlet");
        view.forward(request, response);
    }
    
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
