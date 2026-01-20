<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="nazmul.User, nazmul.CourseDAO, java.util.List" %>
        <%-- Page: View Students in a Course Role requirement: session attribute "user" must exist and have
            role "teacher" Routing: - This page is typically reached via: GET /viewCourseStudents?courseId=...
            (ViewCourseStudentsServlet) which forwards to viewStudents.jsp with request attributes: - "students"
            (List<User>)
            - "courseId" (Integer)

            Navigation links:
            - teacherDashboard.jsp
            - logout.jsp
            --%>
            <% User user=(User ) session.getAttribute("user"); if (user==null || !"teacher".equals(user.getRole())) {
                response.sendRedirect("login.jsp"); return; } List<User> students = (List<User>)
                    request.getAttribute("students");
                    int courseId = (Integer) request.getAttribute("courseId");
                    %>
                    <!DOCTYPE html>
                    <html lang="en">

                    <head>
                        <meta charset="UTF-8" />
                        <meta name="viewport" content="width=device-width, initial-scale=1" />
                        <title>Course Students - EduManage</title>
                        <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css"
                            rel="stylesheet" />
                        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
                            rel="stylesheet" />
                        <style>
                            /* Reuse studentDashboard color scheme */
                            :root {
                                --primary: #2563eb;
                                /* Blue primary */
                                --secondary: #8b5cf6;
                                /* Purple secondary */
                                --accent: #7c3aed;
                                /* Purple accent */
                                --success: #10b981;
                                /* Green success */
                                --warning: #f59e0b;
                                /* Amber warning */
                                --danger: #ef4444;
                                /* Red danger */
                                --info: #06b6d4;
                                /* Cyan info */
                                --light: #f1f5f9;
                                /* Light gray */
                                --dark: #1e293b;
                                /* Dark slate */
                                --surface: #ffffff;
                                /* White surface */
                                --muted: #64748b;
                                /* Slate gray */
                                --student-primary: #3b82f6;
                                /* Student theme blue */
                                --student-secondary: #8b5cf6;
                                /* Student theme purple */
                            }

                            /* Base styles */
                            * {
                                font-family: 'Inter', 'Segoe UI', -apple-system, BlinkMacSystemFont, sans-serif;
                            }

                            body {
                                background: linear-gradient(135deg, #0f172a 0%, #1e293b 25%, #334155 50%, #475569 75%, #64748b 100%);
                                min-height: 100vh;
                                color: var(--light);
                                margin: 0;
                                padding: 0;
                                line-height: 1.6;
                            }

                            /* Navbar with glass effect */
                            .navbar {
                                background: rgba(15, 23, 42, 0.95);
                                backdrop-filter: blur(10px);
                                -webkit-backdrop-filter: blur(10px);
                                border-bottom: 1px solid rgba(172, 30, 197, 0.2);
                                padding: 1rem 0;
                                transition: all 0.3s ease;
                            }

                            .navbar-brand {
                                font-weight: 700;
                                font-size: 1.8rem;
                                background: linear-gradient(135deg, #3b82f6, #8b5cf6);
                                -webkit-background-clip: text;
                                -webkit-text-fill-color: transparent;
                                background-clip: text;
                            }

                            .nav-link {
                                font-weight: 800;
                                font-size: 1.2rem;
                                background: linear-gradient(135deg, #3b82f6, #8b5cf6);
                                -webkit-background-clip: text;
                                -webkit-text-fill-color: transparent;
                                background-clip: text;
                                transition: all 0.3s ease;
                                position: relative;
                            }

                            .nav-link:after {
                                content: '';
                                position: absolute;
                                width: 0;
                                height: 2px;
                                bottom: 0;
                                left: 0;
                                background: linear-gradient(90deg, var(--student-primary), var(--info));
                                transition: width 0.3s ease;
                            }

                            .nav-link:hover:after {
                                width: 100%;
                            }

                            .navbar-toggler {
                                border-color: #8b5cf6;
                                /* white border */
                            }

                            .navbar-toggler-icon {
                                background-image: url("data:image/svg+xml;charset=utf8,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 30 30'%3E%3Cpath stroke='rgba(255,255,255,1)' stroke-width='2' d='M4 7h22M4 15h22M4 23h22'/%3E%3C/svg%3E");
                            }

                            .btn-outline-light {
                                border-radius: 12px;
                                font-weight: 600;
                                padding: 0.5rem 1.25rem;
                                border: 2px solid var(--light);
                                color: var(--light);
                                transition: all 0.3s ease;
                            }

                            .btn-outline-light:hover {
                                background: var(--student-primary);
                                border-color: var(--student-primary);
                                color: white;
                                box-shadow: 0 8px 20px rgba(59, 130, 246, 0.4);
                                transform: translateY(-2px);
                            }

                            /* Content area */
                            .container.content-area {
                                margin-top: 3rem;
                                margin-bottom: 4rem;
                            }

                            /* Header and badge */
                            .header-row {
                                display: flex;
                                justify-content: space-between;
                                align-items: center;
                                margin-bottom: 2rem;
                            }

                            .header-row h2 {
                                font-weight: 700;
                                color: var(--light);
                                font-size: 2rem;
                            }

                            .stat-badge {
                                background: linear-gradient(135deg, var(--student-primary), var(--student-secondary));
                                padding: 0.5rem 1.25rem;
                                border-radius: 30px;
                                font-weight: 700;
                                color: white;
                                box-shadow: 0 6px 15px rgba(59, 130, 246, 0.4);
                                user-select: none;
                            }

                            /* Glass card */
                            .glass-card {
                                background: rgba(255, 255, 255, 0.1);
                                backdrop-filter: blur(25px);
                                border-radius: 20px;
                                border: 1px solid rgba(255, 255, 255, 0.15);
                                box-shadow: 0 12px 40px rgba(0, 0, 0, 0.15);
                                overflow: hidden;
                                transition: transform 0.3s cubic-bezier(0.4, 0, 0.2, 1), box-shadow 0.3s cubic-bezier(0.4, 0, 0.2, 1);
                                color: var(--light);
                            }

                            .glass-card:hover {
                                transform: translateY(-8px);
                                box-shadow: 0 20px 60px rgba(59, 130, 246, 0.5);
                            }

                            .card-header {
                                background: linear-gradient(135deg, var(--student-primary), var(--student-secondary));
                                padding: 1rem 1.5rem;
                                color: white;
                                font-weight: 700;
                                font-size: 1.25rem;
                                display: flex;
                                align-items: center;
                                gap: 0.75rem;
                                border-bottom: none;
                            }

                            /* Table styles */
                            .table-responsive {
                                padding: 1rem 1.5rem 2rem 1.5rem;
                            }

                            table.table {
                                width: 100%;
                                border-collapse: separate;
                                border-spacing: 0 0.75rem;
                                color: var(--dark);
                                background: transparent;
                            }

                            table.table thead tr th {
                                background: linear-gradient(135deg, var(--student-primary), var(--student-secondary));
                                color: white;
                                font-weight: 700;
                                padding: 0.75rem 1rem;
                                border-radius: 12px;
                                border: none;
                                text-align: left;
                                user-select: none;
                            }

                            table.table tbody tr {
                                background: rgba(255, 255, 255, 0.15);
                                border-radius: 12px;
                                transition: background-color 0.3s ease;
                            }

                            table.table tbody tr:hover {
                                background: rgba(59, 130, 246, 0.15);
                            }

                            table.table tbody tr td {
                                padding: 0.75rem 1rem;
                                border: none;
                                color: #000000;
                                vertical-align: middle;
                            }

                            /* Empty state */
                            .empty-state {
                                text-align: center;
                                padding: 4rem 1rem;
                                color: var(--muted);
                            }

                            .empty-state i {
                                font-size: 5rem;
                                margin-bottom: 1rem;
                                color: var(--student-secondary);
                                opacity: 0.6;
                            }

                            .empty-state p {
                                font-size: 1.25rem;
                                font-weight: 600;
                            }

                            /* Floating action button */
                            .floating-btn {
                                position: fixed;
                                bottom: 2rem;
                                right: 2rem;
                                width: 60px;
                                height: 60px;
                                border-radius: 50%;
                                background: linear-gradient(135deg, var(--student-primary), var(--student-secondary));
                                color: white;
                                display: flex;
                                align-items: center;
                                justify-content: center;
                                box-shadow: 0 8px 25px rgba(59, 130, 246, 0.4);
                                transition: all 0.3s ease;
                                cursor: pointer;
                                z-index: 1000;
                            }

                            .floating-btn:hover {
                                transform: translateY(-5px) scale(1.1) rotate(10deg);
                                box-shadow: 0 12px 35px rgba(59, 130, 246, 0.6);
                            }

                            .floating-btn i {
                                font-size: 1.5rem;
                            }

                            /* Responsive */
                            @media (max-width: 768px) {
                                .header-row {
                                    flex-direction: column;
                                    align-items: flex-start;
                                    gap: 0.5rem;
                                }

                                .stat-badge {
                                    font-size: 0.9rem;
                                    padding: 0.4rem 1rem;
                                }

                                .card-header {
                                    font-size: 1.1rem;
                                }

                                table.table thead tr th,
                                table.table tbody tr td {
                                    padding: 0.5rem 0.75rem;
                                }
                            }
                        </style>
                    </head>

                    <body>
                        <!-- Navigation Bar -->
                        <nav class="navbar navbar-expand-lg navbar-light">
                            <div class="container">
                                <a class="navbar-brand" href="home.jsp"><i
                                        class="fas fa-graduation-cap me-2"></i>Academia</a>
                                <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                                    data-bs-target="#navbarNav">
                                    <span class="navbar-toggler-icon"></span>
                                </button>

                                <div class="collapse navbar-collapse" id="navbarNav">
                                    <ul class="navbar-nav ms-auto">
                                        <li class="nav-item">
                                            <a class="nav-link" href="teacherDashboard.jsp">Dashboard</a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link" href="logout.jsp">Logout</a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </nav>

                        <div class="container content-area">
                            <div class="header-row">
                                <h2>Students Enrolled in Course</h2>
                                <span class="stat-badge">
                                    <%= students.size() %> students
                                </span>
                            </div>

                            <div class="glass-card">
                                <div class="card-header">
                                    <i class="fas fa-users"></i> Student List
                                </div>
                                <div class="card-body p-0">
                                    <% if (students==null || students.isEmpty()) { %>
                                        <div class="empty-state">
                                            <i class="fas fa-user-graduate"></i>
                                            <p>No students enrolled in this course yet.</p>
                                        </div>
                                        <% } else { %>
                                            <div class="table-responsive">
                                                <table class="table">
                                                    <thead>
                                                        <tr>
                                                            <th>Student ID</th>
                                                            <th>Full Name</th>
                                                            <th>Username</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <% for (User student : students) { %>
                                                            <tr>
                                                                <td>
                                                                    <%= student.getId() %>
                                                                </td>
                                                                <td>
                                                                    <%= student.getFullName() %>
                                                                </td>
                                                                <td>
                                                                    <%= student.getUsername() %>
                                                                </td>
                                                            </tr>
                                                            <% } %>
                                                    </tbody>
                                                </table>
                                            </div>
                                            <% } %>
                                </div>
                            </div>
                        </div>

                        <!-- Floating action button -->
                        <a href="teacherDashboard.jsp" class="floating-btn" title="Back to Dashboard">
                            <i class="fas fa-arrow-left"></i>
                        </a>

                        <script
                            src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
                    </body>

                    </html>