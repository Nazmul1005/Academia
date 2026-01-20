package nazmul;


import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nazmul.CourseDAO;
import nazmul.User;

 /**
  * Student action servlet for enrolling into a course.
  *
  * <p><strong>Route:</strong> {@code POST /enrollCourse}
  *
  * <p><strong>Called from:</strong> {@code studentDashboard.jsp}
  *
  * <p><strong>Request parameters:</strong>
  * <ul>
  *   <li>{@code courseId}</li>
  * </ul>
  *
  * <p><strong>Role requirement:</strong> session {@code user} must have role {@code student}.
  */
@WebServlet("/enrollCourse")
public class EnrollCourseServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    /**
     * Enrolls the current session user into the selected course.
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null || !"student".equals(user.getRole())) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        int courseId = Integer.parseInt(request.getParameter("courseId"));
        int studentId = user.getId();
        
        CourseDAO courseDAO = new CourseDAO();
        boolean success = courseDAO.enrollCourse(studentId, courseId);
        
        if (success) {
            response.sendRedirect("studentDashboard.jsp?message=Course enrolled successfully");
        } else {
            response.sendRedirect("studentDashboard.jsp?error=Failed to enroll course");
        }
    }
}
