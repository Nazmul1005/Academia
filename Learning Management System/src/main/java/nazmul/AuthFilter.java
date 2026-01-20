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
  * Global authentication filter.
  *
  * <p>Applied to all routes via {@code @WebFilter("/*")}. If the current request
  * is not considered a public page and there is no logged-in user in the session
  * attribute {@code "user"}, the filter redirects the client to {@code home.jsp}.
  *
  * <p>Public pages include:
  * <ul>
  *   <li>Landing page and home route</li>
  *   <li>Login and registration pages and their servlet endpoints</li>
  *   <li>Static resources under {@code /resources/}</li>
  * </ul>
  */
@WebFilter("/*")
public class AuthFilter implements Filter {
    
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) 
	        throws IOException, ServletException {
	    
	    HttpServletRequest req = (HttpServletRequest) request;
	    HttpServletResponse res = (HttpServletResponse) response;
	    HttpSession session = req.getSession(false);
	    
	    String requestURI = req.getRequestURI();
	    String contextPath = req.getContextPath();
	    
	    // Public pages that don't require authentication
	    boolean isPublicPage = requestURI.equals(contextPath + "/") ||
	                          requestURI.equals(contextPath + "/home.jsp") ||
	                          requestURI.equals(contextPath + "/home") ||
	                          requestURI.equals(contextPath + "/login.jsp") ||
	                          requestURI.equals(contextPath + "/login") ||
	                          requestURI.equals(contextPath + "/register.jsp") ||
	                          requestURI.equals(contextPath + "/register") ||
	                          requestURI.equals(contextPath + "/test.jsp") ||
	                          requestURI.startsWith(contextPath + "/resources/");
	    
	    boolean loggedIn = session != null && session.getAttribute("user") != null;
	    
	    if (loggedIn || isPublicPage) {
	        chain.doFilter(request, response);
	    } else {
	        res.sendRedirect(contextPath + "/home.jsp");
	    }
	}
    
    public void init(FilterConfig fConfig) throws ServletException {}
    public void destroy() {}
}