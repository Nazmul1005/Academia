package nazmul;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import javax.servlet.annotation.WebServlet;

 /**
  * Admin action servlet for editing an existing course.
  *
  * <p><strong>Route:</strong> {@code POST /EditCouraseServlet1}
  *
  * <p><strong>Called from:</strong> {@code adminDashboard.jsp} (edit modal form)
  *
  * <p><strong>Request parameters:</strong>
  * <ul>
  *   <li>{@code id} (course id)</li>
  *   <li>{@code courseCode}</li>
  *   <li>{@code courseName}</li>
  *   <li>{@code teacherId}</li>
  * </ul>
  *
  * <p><strong>Workflow:</strong> updates the course via {@link CourseDAO#updateCourse(Course)}
  * and redirects back to {@code adminDashboard.jsp} with a status message.
  */
@WebServlet("/EditCouraseServlet1")
public class EditCouraseServlet1 extends HttpServlet {
    private CourseDAO courseDAO = new CourseDAO();

    /**
     * Updates a course based on submitted form fields.
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String code = request.getParameter("courseCode");
        String name = request.getParameter("courseName");
        int teacherId = Integer.parseInt(request.getParameter("teacherId"));

        Course course = new Course();
        course.setId(id);
        course.setCourseCode(code);
        course.setCourseName(name);
        course.setTeacherId(teacherId);

        boolean updated = courseDAO.updateCourse(course);
        if (updated) {
            response.sendRedirect("adminDashboard.jsp?message=Course updated successfully");
        } else {
            response.sendRedirect("adminDashboard.jsp?error=Failed to update course");
        }
    }
}
