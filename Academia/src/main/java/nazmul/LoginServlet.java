package nazmul;


import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nazmul.User;
import nazmul.UserDAO;

 /**
  * Handles user login.
  *
  * <p><strong>Route:</strong> {@code POST /login}
  *
  * <p><strong>Workflow:</strong>
  * <ul>
  *   <li>Reads form parameters {@code username} and {@code password}</li>
  *   <li>Authenticates via {@link UserDAO#authenticateUser(String, String)}</li>
  *   <li>On success: stores the {@link User} in session attribute {@code "user"}</li>
  *   <li>Redirects to a role-specific dashboard JSP</li>
  * </ul>
  */
@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    /**
     * Processes the login form submission.
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        UserDAO userDAO = new UserDAO();
        User user = userDAO.authenticateUser(username, password);
        
        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            
            switch(user.getRole()) {
                case "admin":
                    response.sendRedirect("adminDashboard.jsp");
                    break;
                case "teacher":
                    response.sendRedirect("teacherDashboard.jsp");
                    break;
                case "student":
                    response.sendRedirect("studentDashboard.jsp");
                    break;
                default:
                    response.sendRedirect("login.jsp?error=Invalid role");
            }
        } else {
            response.sendRedirect("login.jsp?error=Invalid credentials");
        }
    }
}
