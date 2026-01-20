<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%--
 Page: Logout
 Workflow:
 - Invalidates the current HTTP session
 - Redirects to login.jsp
--%>
<%
    session.invalidate();
    response.sendRedirect("login.jsp");
%>