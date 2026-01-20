package nazmul;


import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import nazmul.Course;
import nazmul.CourseDAO;

 /**
  * Admin action servlet for creating a new course.
  *
  * <p><strong>Route:</strong> {@code POST /addCourse}
  *
  * <p><strong>Called from:</strong> {@code adminDashboard.jsp}
  *
  * <p><strong>Request parameters:</strong>
  * <ul>
  *   <li>{@code courseCode}</li>
  *   <li>{@code courseName}</li>
  *   <li>{@code teacherId}</li>
  * </ul>
  *
  * <p><strong>Workflow:</strong> inserts a new record via {@link CourseDAO#addCourse(Course)}
  * and redirects back to {@code adminDashboard.jsp} with a status message.
  */
@WebServlet("/addCourse")
public class AddCourseServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    /**
     * Creates a course based on submitted form fields.
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String courseCode = request.getParameter("courseCode");
        String courseName = request.getParameter("courseName");
        int teacherId = Integer.parseInt(request.getParameter("teacherId"));
        
        Course course = new Course();
        course.setCourseCode(courseCode);
        course.setCourseName(courseName);
        course.setTeacherId(teacherId);
        
        CourseDAO courseDAO = new CourseDAO();
        boolean success = courseDAO.addCourse(course);
        
        if (success) {
            response.sendRedirect("adminDashboard.jsp?message=Course added successfully");
        } else {
            response.sendRedirect("adminDashboard.jsp?error=Failed to add course");
        }
    }
}
