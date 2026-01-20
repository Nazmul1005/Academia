package nazmul;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

 /**
  * Handles user registration.
  *
  * <p><strong>Routes:</strong>
  * <ul>
  *   <li>{@code GET /register} → forwards to {@code register.jsp}</li>
  *   <li>{@code POST /register} → validates input and inserts user via {@link UserDAO}</li>
  * </ul>
  *
  * <p>Registration is limited to roles {@code student} and {@code teacher}.
  */
@WebServlet("/register")
public class RegistrationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    /**
     * Shows the registration page.
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }
    
    /**
     * Processes registration form submission.
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String role = request.getParameter("role"); // Get the selected role
        
        // Validate input more thoroughly
        if (username == null || username.trim().isEmpty()) {
            response.sendRedirect("register.jsp?error=Username is required");
            return;
        }
        
        if (password == null || password.trim().isEmpty()) {
            response.sendRedirect("register.jsp?error=Password is required");
            return;
        }
        
        if (password.length() < 6) {
            response.sendRedirect("register.jsp?error=Password must be at least 6 characters long");
            return;
        }
        
        if (email == null || email.trim().isEmpty()) {
            response.sendRedirect("register.jsp?error=Email is required");
            return;
        }
        
        if (role == null || (!role.equals("student") && !role.equals("teacher"))) {
            response.sendRedirect("register.jsp?error=Please select a valid role");
            return;
        }
        
        User user = new User();
        user.setUsername(username.trim());
        user.setPassword(password.trim());
        user.setFullName(fullName != null ? fullName.trim() : "");
        user.setEmail(email.trim());
        user.setRole(role); // Set the selected role
        
        UserDAO userDAO = new UserDAO();
        boolean success = userDAO.registerUser(user);
        
        if (success) {
            response.sendRedirect("login.jsp?message=Registration successful. Please login.");
        } else {
            response.sendRedirect("register.jsp?error=Registration failed. Username or email may already exist.");
        }
    }
}