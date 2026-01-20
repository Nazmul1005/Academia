package nazmul;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

 /**
  * Servlet endpoint that serves the landing/home page.
  *
  * <p><strong>Route:</strong> {@code GET /home}
  *
  * <p><strong>Workflow:</strong> forwards to {@code home.jsp}.
  */
@WebServlet("/home")
public class HomeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    /**
     * Forwards the request to {@code home.jsp}.
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("home.jsp").forward(request, response);
    }
}
