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
  * Teacher action servlet for viewing enrolled students of a course.
  *
  * <p><strong>Route:</strong> {@code GET /viewCourseStudents?courseId=...}
  *
  * <p><strong>Called from:</strong> {@code teacherDashboard.jsp}
  *
  * <p><strong>Role requirement:</strong> session {@code user} must have role {@code teacher}.
  *
  * <p><strong>Workflow:</strong> loads students via {@link CourseDAO#getStudentsByCourseId(int)}
  * and forwards to {@code viewStudents.jsp} with request attributes:
  * <ul>
  *   <li>{@code students}</li>
  *   <li>{@code courseId}</li>
  * </ul>
  */
@WebServlet("/viewCourseStudents")
public class ViewCourseStudentsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    /**
     * Loads students for a given course and forwards to {@code viewStudents.jsp}.
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null || !"teacher".equals(user.getRole())) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        int courseId = Integer.parseInt(request.getParameter("courseId"));
        
        CourseDAO courseDAO = new CourseDAO();
        request.setAttribute("students", courseDAO.getStudentsByCourseId(courseId));
        request.setAttribute("courseId", courseId);
        
        request.getRequestDispatcher("viewStudents.jsp").forward(request, response);
    }
}