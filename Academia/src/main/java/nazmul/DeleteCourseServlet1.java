package nazmul;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import javax.servlet.annotation.WebServlet;

 /**
  * Admin action servlet for deleting a course.
  *
  * <p><strong>Route:</strong> {@code GET /DeleteCourseServlet1?id=...}
  *
  * <p><strong>Called from:</strong> {@code adminDashboard.jsp} (delete link)
  *
  * <p><strong>Request parameters:</strong>
  * <ul>
  *   <li>{@code id} (course id)</li>
  * </ul>
  *
  * <p><strong>Workflow:</strong> deletes via {@link CourseDAO#deleteCourse(int)}
  * and redirects back to {@code adminDashboard.jsp} with a status message.
  */
@WebServlet("/DeleteCourseServlet1")
public class DeleteCourseServlet1 extends HttpServlet {
    private CourseDAO courseDAO = new CourseDAO();

    /**
     * Deletes the course referenced by the {@code id} query parameter.
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        boolean deleted = courseDAO.deleteCourse(id);
        
        if (deleted) {
            response.sendRedirect("adminDashboard.jsp?message=Course deleted successfully");
        } else {
            response.sendRedirect("adminDashboard.jsp?error=Failed to delete course");
        }
    }
}
