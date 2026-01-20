package nazmul;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import javax.servlet.annotation.WebServlet;

 /**
  * Handles profile updates for student and teacher users.
  *
  * <p><strong>Route:</strong> {@code POST /UpdateProfileServlet}
  *
  * <p><strong>Called from:</strong> {@code studentDashboard.jsp} and {@code teacherDashboard.jsp}
  *
  * <p><strong>Request parameters:</strong>
  * <ul>
  *   <li>{@code id} (user id)</li>
  *   <li>{@code fullName}</li>
  *   <li>{@code username}</li>
  *   <li>{@code email}</li>
  *   <li>{@code password} (optional; only applied if non-blank)</li>
  * </ul>
  *
  * <p><strong>Workflow:</strong> fetches the user via {@link CourseDAO#getUserById(int)},
  * applies updates, persists via {@link CourseDAO#updateUser(User)}, refreshes the
  * session {@code "user"}, and redirects back to the appropriate dashboard.
  */
@WebServlet("/UpdateProfileServlet")
public class UpdateProfileServlet extends HttpServlet {
    private CourseDAO courseDAO = new CourseDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	int id = Integer.parseInt(request.getParameter("id"));
    	User user = courseDAO.getUserById(id); 
        try {
            
            String fullName = request.getParameter("fullName");
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            

            if (user != null) {
                user.setFullName(fullName);
                user.setUsername(username);
                user.setEmail(email);

                if (password != null && !password.isBlank()) {
                    user.setPassword(password);
                }

                courseDAO.updateUser(user);
                request.getSession().setAttribute("user", user);

                if ("student".equalsIgnoreCase(user.getRole())) {
                    response.sendRedirect("studentDashboard.jsp?success=1");
                } else {
                    response.sendRedirect("teacherDashboard.jsp?success=1");
                }
                return;
            }

            response.sendRedirect("login.jsp?error=notfound");

        } catch (Exception e) {
            e.printStackTrace();
            if ("student".equalsIgnoreCase(user.getRole())) {
                response.sendRedirect("studentDashboard.jsp?error=1");
            } else {
                response.sendRedirect("teacherDashboard.jsp?error=1");
            }
        }
    }
}
