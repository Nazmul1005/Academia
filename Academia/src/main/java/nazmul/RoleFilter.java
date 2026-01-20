package nazmul;


import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nazmul.User;

 /**
  * Role-based authorization filter intended for admin-only paths.
  *
  * <p>This filter is mapped to {@code /admin/*}. It allows the request through
  * only when a session exists and the session attribute {@code "user"} is a
  * {@link User} with role {@code "admin"}.
  *
  * <p>Otherwise it redirects to:
  * <ul>
  *   <li>{@code /login.jsp} if there is no session</li>
  *   <li>{@code /accessDenied.jsp} if the user is not an admin</li>
  * </ul>
  */
@WebFilter("/admin/*")
public class RoleFilter implements Filter {
    
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) 
            throws IOException, ServletException {
        
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);
        
        if (session != null) {
            User user = (User) session.getAttribute("user");
            if (user != null && "admin".equals(user.getRole())) {
                chain.doFilter(request, response);
            } else {
                res.sendRedirect(req.getContextPath() + "/accessDenied.jsp");
            }
        } else {
            res.sendRedirect(req.getContextPath() + "/login.jsp");
        }
    }
    
    public void init(FilterConfig fConfig) throws ServletException {}
    public void destroy() {}
}