<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="nazmul.User, nazmul.CourseDAO, nazmul.Course, java.util.List" %>
        <%-- Page: Admin Dashboard Role requirement: session attribute "user" must exist and have role "admin" Data
            loaded (via CourseDAO): - getAllCourses() - getAllTeachers() - getAllStudents() Action routing: - POST
            action="addCourse" -> /addCourse (AddCourseServlet)
            - POST action="${pageContext.request.contextPath}/EditCouraseServlet1" -> /EditCouraseServlet1
            (EditCouraseServlet1)
            - GET href="${pageContext.request.contextPath}/DeleteCourseServlet1?id=..." -> /DeleteCourseServlet1
            (DeleteCourseServlet1)
            - logout.jsp (invalidates session)
            --%>
            <% User user=(User) session.getAttribute("user"); if (user==null || !"admin".equals(user.getRole())) {
                response.sendRedirect("login.jsp"); return; } CourseDAO courseDAO=new CourseDAO(); List<Course> courses
                = courseDAO.getAllCourses();
                List<User> teachers = courseDAO.getAllTeachers();
                    List<User> students = courseDAO.getAllStudents() ;

                        %>
                        <!DOCTYPE html>
                        <html lang="en">

                        <head>
                            <meta charset="UTF-8">
                            <meta name="viewport" content="width=device-width, initial-scale=1.0">
                            <title>Admin Dashboard - Academia</title>
                            <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css"
                                rel="stylesheet">
                            <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
                                rel="stylesheet">
                            <style>
                                /* Professional color scheme matching student dashboard */
                                :root {
                                    --primary: #2563eb;
                                    /* Blue primary */
                                    --secondary: #3f0596;
                                    /* Emerald secondary */
                                    --accent: #7c3aed;
                                    /* Purple accent */
                                    --success: #10b981;
                                    /* Green success */
                                    --warning: #f59e0b;
                                    /* Amber warning */
                                    --danger: #ef4444;
                                    /* Red danger */
                                    --info: #6306d4;
                                    /* Cyan info */
                                    --light: #f1f5f9;
                                    /* Light gray */
                                    --dark: #1e293b;
                                    /* Dark slate */
                                    --surface: #ffffff;
                                    /* White surface */
                                    --muted: #64748b;
                                    /* Slate gray */
                                    --admin-primary: #3b82f6;
                                    /*  theme blue */
                                    --admin-secondary: #8b5cf6;
                                    /*  theme purple */
                                    --admin-accent: #410596;
                                }

                                /* Modern typography and base styles */
                                * {
                                    font-family: 'Inter', 'Segoe UI', -apple-system, BlinkMacSystemFont, sans-serif;
                                }

                                body {
                                    background: linear-gradient(135deg, #0f172a 0%, #1e293b 25%, #334155 50%, #475569 75%, #64748b 100%);
                                    background-attachment: fixed;
                                    min-height: 100vh;
                                    color: var(--dark);
                                    line-height: 1.6;
                                }

                                /* Animated background particles matching student dashboard */
                                .background-animation {
                                    position: fixed;
                                    top: 0;
                                    left: 0;
                                    width: 100%;
                                    height: 100%;
                                    z-index: -1;
                                    overflow: hidden;
                                }

                                .floating-shape {
                                    position: absolute;
                                    border-radius: 50%;
                                    background: linear-gradient(135deg, rgba(59, 130, 246, 0.1), rgba(139, 92, 246, 0.1));
                                    animation: floatShape 20s infinite linear;
                                }

                                @keyframes floatShape {
                                    0% {
                                        transform: translateY(100vh) rotate(0deg);
                                        opacity: 0;
                                    }

                                    10% {
                                        opacity: 1;
                                    }

                                    90% {
                                        opacity: 0.8;
                                    }

                                    100% {
                                        transform: translateY(-100px) rotate(360deg);
                                        opacity: 0;
                                    }
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
                                    background: linear-gradient(90deg, var(--admin-primary), var(--info));
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


                                /* Welcome section with admin focus */
                                .welcome-section {
                                    background: linear-gradient(135deg, var(--admin-primary) 0%, var(--info) 100%);
                                    color: white;
                                    padding: 3rem 0;
                                    margin-bottom: 2rem;
                                    border-radius: 0 0 2rem 2rem;
                                    position: relative;
                                    overflow: hidden;
                                }

                                .welcome-section::before {
                                    content: '';
                                    position: absolute;
                                    top: 0;
                                    right: -20%;
                                    width: 40%;
                                    height: 100%;
                                    background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="20" cy="20" r="2" fill="white" fill-opacity="0.1"/><circle cx="80" cy="40" r="3" fill="white" fill-opacity="0.1"/><circle cx="40" cy="80" r="1.5" fill="white" fill-opacity="0.1"/></svg>');
                                    opacity: 0.3;
                                }

                                /* Enhanced statistics cards matching student dashboard */
                                .stats-grid {
                                    display: grid;
                                    grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
                                    gap: 1.5rem;
                                    margin-bottom: 2rem;
                                }

                                .stat-card {
                                    background: var(--surface);
                                    border-radius: 20px;
                                    padding: 2rem;
                                    box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
                                    border: 1px solid rgba(255, 255, 255, 0.2);
                                    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
                                    position: relative;
                                    overflow: hidden;
                                }

                                .stat-card::before {
                                    content: '';
                                    position: absolute;
                                    top: 0;
                                    left: 0;
                                    width: 100%;
                                    height: 4px;
                                    background: linear-gradient(90deg, var(--admin-primary), var(--admin-secondary));
                                    transform: scaleX(0);
                                    transition: transform 0.3s;
                                }

                                .stat-card:hover {
                                    transform: translateY(-8px);
                                    box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15);
                                }

                                .stat-card:hover::before {
                                    transform: scaleX(1);
                                }

                                .stat-icon {
                                    width: 64px;
                                    height: 64px;
                                    border-radius: 16px;
                                    display: flex;
                                    align-items: center;
                                    justify-content: center;
                                    font-size: 1.5rem;
                                    margin-bottom: 1rem;
                                    color: white;
                                }

                                .stat-icon.courses {
                                    background: linear-gradient(135deg, var(--admin-primary), var(--info));
                                }

                                .stat-icon.teachers {
                                    background: linear-gradient(135deg, var(--admin-primary), var(--info));
                                }

                                .stat-icon.students {
                                    background: linear-gradient(135deg, var(--admin-primary), var(--info));
                                }

                                .stat-number {
                                    font-size: 2.5rem;
                                    font-weight: 800;
                                    color: var(--dark);
                                    margin-bottom: 0.5rem;
                                }

                                .stat-label {
                                    color: var(--muted);
                                    font-weight: 500;
                                    margin-bottom: 1rem;
                                }

                                .stat-change {
                                    display: flex;
                                    align-items: center;
                                    gap: 0.5rem;
                                    font-size: 0.875rem;
                                    font-weight: 600;
                                    color: var(--success);
                                }

                                /* Enhanced glass cards matching student dashboard */
                                .glass-card {
                                    background: rgba(255, 255, 255, 0.95);
                                    backdrop-filter: blur(20px);
                                    border-radius: 20px;
                                    border: 1px solid rgba(255, 255, 255, 0.2);
                                    box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
                                    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
                                    overflow: hidden;
                                    position: relative;
                                }

                                .glass-card::before {
                                    content: '';
                                    position: absolute;
                                    top: 0;
                                    left: -100%;
                                    width: 100%;
                                    height: 100%;
                                    background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
                                    transition: left 0.5s;
                                }

                                .glass-card:hover::before {
                                    left: 100%;
                                }

                                .glass-card:hover {
                                    transform: translateY(-8px);
                                    box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15);
                                }

                                /* Form sections */
                                .form-section {
                                    background: var(--surface);
                                    border-radius: 16px;
                                    padding: 2rem;
                                    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
                                    margin-bottom: 2rem;
                                }

                                .form-section-header {
                                    display: flex;
                                    align-items: center;
                                    gap: 1rem;
                                    margin-bottom: 2rem;
                                    padding-bottom: 1rem;
                                    border-bottom: 1px solid rgba(0, 0, 0, 0.05);
                                }

                                .form-section-icon {
                                    width: 48px;
                                    height: 48px;
                                    border-radius: 12px;
                                    background: linear-gradient(135deg, var(--admin-primary), var(--admin-secondary));
                                    display: flex;
                                    align-items: center;
                                    justify-content: center;
                                    color: white;
                                }

                                /* Enhanced form controls */
                                .form-control {
                                    border: 2px solid rgba(0, 0, 0, 0.08);
                                    border-radius: 12px;
                                    padding: 0.875rem 1rem;
                                    font-size: 0.95rem;
                                    transition: all 0.3s;
                                    background: var(--surface);
                                }

                                .form-control:focus {
                                    border-color: var(--admin-primary);
                                    box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
                                    background: var(--surface);
                                }

                                .form-label {
                                    font-weight: 600;
                                    color: var(--dark);
                                    margin-bottom: 0.5rem;
                                }

                                /* Professional buttons */
                                .btn {
                                    border-radius: 12px;
                                    font-weight: 600;
                                    padding: 0.75rem 1.5rem;
                                    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
                                    border: none;
                                    position: relative;
                                    overflow: hidden;
                                }

                                .btn::before {
                                    content: '';
                                    position: absolute;
                                    top: 0;
                                    left: -100%;
                                    width: 100%;
                                    height: 100%;
                                    background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
                                    transition: left 0.5s;
                                }

                                .btn:hover::before {
                                    left: 100%;
                                }

                                .btn-primary {
                                    background: linear-gradient(135deg, var(--admin-primary), var(--admin-secondary));
                                    color: white;
                                    box-shadow: 0 4px 15px rgba(59, 130, 246, 0.3);
                                }

                                .btn-primary:hover {
                                    transform: translateY(-2px);
                                    box-shadow: 0 8px 25px rgba(59, 130, 246, 0.4);
                                }

                                .btn-outline-primary {
                                    border: 2px solid var(--admin-primary);
                                    color: var(--admin-primary);
                                    background: transparent;
                                }

                                .btn-outline-primary:hover {
                                    background: var(--admin-primary);
                                    color: white;
                                    transform: translateY(-1px);
                                }

                                /* Professional tables */
                                .data-table-container {
                                    background: var(--surface);
                                    border-radius: 16px;
                                    overflow: hidden;
                                    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
                                }

                                .data-table-header {
                                    background: linear-gradient(135deg, var(--admin-primary), var(--info));
                                    color: white;
                                    padding: 1.5rem 2rem;
                                    display: flex;
                                    align-items: center;
                                    justify-content: between;
                                    gap: 1rem;
                                }

                                .table {
                                    margin-bottom: 0;
                                    font-size: 0.925rem;
                                }

                                .table thead th {
                                    background: var(--light);
                                    border: none;
                                    padding: 1rem;
                                    font-weight: 700;
                                    color: var(--dark);
                                    text-transform: uppercase;
                                    font-size: 0.8rem;
                                    letter-spacing: 0.5px;
                                }

                                .table tbody td {
                                    padding: 1rem;
                                    border-top: 1px solid rgba(0, 0, 0, 0.05);
                                    vertical-align: middle;
                                }

                                .table tbody tr:hover {
                                    background: rgba(59, 130, 246, 0.02);
                                }

                                /* Action buttons */
                                .action-btn {
                                    padding: 0.5rem 1rem;
                                    border-radius: 8px;
                                    font-size: 0.875rem;
                                    margin: 0 0.25rem;
                                }

                                /* Empty states */
                                .empty-state {
                                    text-align: center;
                                    padding: 4rem 2rem;
                                    color: var(--muted);
                                }

                                .empty-state-icon {
                                    width: 100px;
                                    height: 100px;
                                    margin: 0 auto 1.5rem;
                                    border-radius: 50%;
                                    background: linear-gradient(135deg, var(--light), #e2e8f0);
                                    display: flex;
                                    align-items: center;
                                    justify-content: center;
                                    font-size: 2.5rem;
                                    color: var(--muted);
                                }

                                /* Alerts */
                                .alert {
                                    border-radius: 12px;
                                    border: none;
                                    padding: 1rem 1.5rem;
                                    margin-bottom: 1.5rem;
                                    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
                                }

                                .alert-success {
                                    background: linear-gradient(135deg, rgba(16, 185, 129, 0.1), rgba(5, 150, 105, 0.05));
                                    border-left: 4px solid var(--success);
                                    color: var(--success);
                                }

                                .alert-danger {
                                    background: linear-gradient(135deg, rgba(239, 68, 68, 0.1), rgba(220, 38, 38, 0.05));
                                    border-left: 4px solid var(--danger);
                                    color: var(--danger);
                                }

                                /* Responsive design */
                                @media (max-width: 768px) {
                                    .welcome-section {
                                        padding: 2rem 0;
                                    }

                                    .stats-section {
                                        grid-template-columns: 1fr;
                                    }

                                    .progress-ring {
                                        width: 80px;
                                        height: 80px;
                                    }

                                }

                                /* Loading animations */
                                .fade-in {
                                    animation: fadeIn 0.6s ease-out forwards;
                                }

                                @keyframes fadeIn {
                                    from {
                                        opacity: 0;
                                        transform: translateY(20px);
                                    }

                                    to {
                                        opacity: 1;
                                        transform: translateY(0);
                                    }
                                }
                            </style>
                        </head>

                        <body>
                            <!-- Animated background matching -->
                            <div class="background-animation" id="backgroundAnimation"></div>

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
                                                <a class="nav-link" href="home.jsp">Home</a>
                                            </li>
                                            <li class="nav-item">
                                                <a class="nav-link" href="logout.jsp">Logout</a>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </nav>

                            <!-- Welcome Section -->
                            <div class="welcome-section">
                                <div class="container">
                                    <div class="row align-items-center">
                                        <div class="col-md-8">
                                            <h1 class="display-5 fw-bold mb-2">Admin Control Center</h1>
                                            <p class="lead mb-4">Welcome back, <%= user.getFullName() %>! Manage your
                                                    educational platform with comprehensive administrative tools.</p>
                                            <div class="d-flex gap-3">
                                                <span class="badge bg-light text-dark px-3 py-2 fs-6">
                                                    <i class="fas fa-book me-1"></i>Courses: <%= courses.size() %>
                                                </span>
                                                <span class="badge bg-light text-dark px-3 py-2 fs-6">
                                                    <i class="fas fa-chalkboard-teacher me-1"></i>Teachers: <%=
                                                        teachers.size() %>
                                                </span>
                                                <span class="badge bg-light text-dark px-3 py-2 fs-6">
                                                    <i class="fas fa-user-graduate me-1"></i>Students: <%=
                                                        students.size() %>
                                                </span>
                                            </div>
                                        </div>
                                        <div class="col-md-4 text-center">
                                            <div class="display-3 fw-bold">
                                                <i class="fas fa-cogs text-white opacity-50"></i>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="container pb-5">
                                <!-- Alert Messages -->
                                <% if (request.getParameter("message") !=null) { %>
                                    <div class="alert alert-success alert-dismissible fade show fade-in" role="alert">
                                        <i class="fas fa-check-circle me-2"></i>
                                        <%= request.getParameter("message") %>
                                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                    </div>
                                    <% } %>

                                        <% if (request.getParameter("error") !=null) { %>
                                            <div class="alert alert-danger alert-dismissible fade show fade-in"
                                                role="alert">
                                                <i class="fas fa-exclamation-triangle me-2"></i>
                                                <%= request.getParameter("error") %>
                                                    <button type="button" class="btn-close"
                                                        data-bs-dismiss="alert"></button>
                                            </div>
                                            <% } %>

                                                <!-- Tab Content -->
                                                <div id="tabContent">
                                                    <!-- Dashboard Overview Tab -->
                                                    <div class="tab-content-item active" id="dashboard-content">
                                                        <!-- Statistics Cards -->
                                                        <div class="stats-grid fade-in">
                                                            <div class="stat-card">
                                                                <div class="stat-icon courses">
                                                                    <i class="fas fa-book"></i>
                                                                </div>
                                                                <div class="stat-number">
                                                                    <%= courses.size() %>
                                                                </div>
                                                                <div class="stat-label">Total Courses</div>
                                                                <div class="stat-change">
                                                                    <i class="fas fa-arrow-up"></i>
                                                                    <span>Active courses in system</span>
                                                                </div>
                                                            </div>

                                                            <div class="stat-card">
                                                                <div class="stat-icon teachers">
                                                                    <i class="fas fa-chalkboard-teacher"></i>
                                                                </div>
                                                                <div class="stat-number">
                                                                    <%= teachers.size() %>
                                                                </div>
                                                                <div class="stat-label">Total Teachers</div>
                                                                <div class="stat-change">
                                                                    <i class="fas fa-arrow-up"></i>
                                                                    <span>Registered educators</span>
                                                                </div>
                                                            </div>

                                                            <div class="stat-card">
                                                                <div class="stat-icon students">
                                                                    <i class="fas fa-user-graduate"></i>
                                                                </div>
                                                                <div class="stat-number">
                                                                    <%= students.size() %>
                                                                </div>
                                                                <div class="stat-label">Total Students</div>
                                                                <div class="stat-change">
                                                                    <i class="fas fa-arrow-up"></i>
                                                                    <span>Active learners</span>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <!-- Add Course Tab -->
                                                        <div class="tab-content-item" id="add-course-content">
                                                            <div class="glass-card fade-in">
                                                                <div class="card-body p-4">
                                                                    <div class="form-section-header">
                                                                        <div class="form-section-icon">
                                                                            <i class="fas fa-plus-circle"></i>
                                                                        </div>
                                                                        <div>
                                                                            <h4 class="mb-1">Add New Course</h4>
                                                                            <p class="text-muted mb-0">Create a new
                                                                                course and assign it to a teacher</p>
                                                                        </div>
                                                                    </div>
                                                                    <form action="addCourse" method="post"
                                                                        class="needs-validation" novalidate>
                                                                        <div class="row">
                                                                            <div class="col-md-6 mb-3">
                                                                                <label for="courseCode"
                                                                                    class="form-label">Course
                                                                                    Code</label>
                                                                                <input type="text" class="form-control"
                                                                                    id="courseCode" name="courseCode"
                                                                                    required placeholder="e.g., CS101">
                                                                                <div class="invalid-feedback">Please
                                                                                    provide a valid course code.</div>
                                                                            </div>
                                                                            <div class="col-md-6 mb-3">
                                                                                <label for="courseName"
                                                                                    class="form-label">Course
                                                                                    Name</label>
                                                                                <input type="text" class="form-control"
                                                                                    id="courseName" name="courseName"
                                                                                    required
                                                                                    placeholder="e.g., Introduction to Computer Science">
                                                                                <div class="invalid-feedback">Please
                                                                                    provide a course name.</div>
                                                                            </div>
                                                                        </div>
                                                                        <div class="mb-4">
                                                                            <label for="teacherId"
                                                                                class="form-label">Assign
                                                                                Teacher</label>
                                                                            <select class="form-control" id="teacherId"
                                                                                name="teacherId" required>
                                                                                <option value="">Select a teacher for
                                                                                    this course</option>
                                                                                <% for (User teacher : teachers) { %>
                                                                                    <option
                                                                                        value="<%= teacher.getId() %>">
                                                                                        <%= teacher.getFullName() %> (
                                                                                            <%= teacher.getEmail() %>)
                                                                                    </option>
                                                                                    <% } %>
                                                                            </select>
                                                                            <div class="invalid-feedback">Please select
                                                                                a teacher.</div>
                                                                        </div>
                                                                        <button type="submit" class="btn btn-primary">
                                                                            <i class="fas fa-plus me-2"></i>Create
                                                                            Course
                                                                        </button>
                                                                    </form>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <!-- All Courses Tab -->
                                                        <div class="tab-content-item" id="courses-content">
                                                            <div class="data-table-container fade-in">
                                                                <div class="data-table-header">
                                                                    <div>
                                                                        <h5 class="mb-1"><i
                                                                                class="fas fa-book me-2"></i>Course
                                                                            Management</h5>
                                                                        <p class="mb-0 opacity-75">Manage all courses in
                                                                            the system</p>
                                                                    </div>
                                                                </div>
                                                                <div class="table-responsive">
                                                                    <% if (courses.isEmpty()) { %>
                                                                        <div class="empty-state">
                                                                            <div class="empty-state-icon">
                                                                                <i class="fas fa-book"></i>
                                                                            </div>
                                                                            <h5>No courses available</h5>
                                                                            <p>Start by creating your first course using
                                                                                the Add Course section.</p>
                                                                            <button class="btn btn-primary"
                                                                                onclick="switchTab('add-course')">
                                                                                <i class="fas fa-plus me-2"></i>Add
                                                                                First Course
                                                                            </button>
                                                                        </div>
                                                                        <% } else { %>
                                                                            <table class="table">
                                                                                <thead>
                                                                                    <tr>
                                                                                        <th>Course Code</th>
                                                                                        <th>Course Name</th>
                                                                                        <th>Assigned Teacher</th>
                                                                                        <th>Status</th>
                                                                                        <th>Actions</th>
                                                                                    </tr>
                                                                                </thead>
                                                                                <tbody>
                                                                                    <% for (Course course : courses) {
                                                                                        %>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <strong
                                                                                                    class="text-primary">
                                                                                                    <%= course.getCourseCode()
                                                                                                        %>
                                                                                                </strong>
                                                                                            </td>
                                                                                            <td>
                                                                                                <%= course.getCourseName()
                                                                                                    %>
                                                                                            </td>
                                                                                            <td>
                                                                                                <% if
                                                                                                    (course.getTeacherName()
                                                                                                    !=null) { %>
                                                                                                    <div
                                                                                                        class="d-flex align-items-center">
                                                                                                        <i
                                                                                                            class="fas fa-user-circle text-success me-2"></i>
                                                                                                        <%= course.getTeacherName()
                                                                                                            %>
                                                                                                    </div>
                                                                                                    <% } else { %>
                                                                                                        <span
                                                                                                            class="badge bg-warning">
                                                                                                            <i
                                                                                                                class="fas fa-exclamation-triangle me-1"></i>Not
                                                                                                            Assigned
                                                                                                        </span>
                                                                                                        <% } %>
                                                                                            </td>
                                                                                            <td>
                                                                                                <span
                                                                                                    class="badge bg-success">Active</span>
                                                                                            </td>
                                                                                            <td>
                                                                                                <!-- Edit Button with data-* attributes -->
                                                                                                <button
                                                                                                    class="btn btn-sm btn-primary editBtn"
                                                                                                    data-id="<%= course.getId() %>"
                                                                                                    data-code="<%= course.getCourseCode() %>"
                                                                                                    data-name="<%= course.getCourseName() %>"
                                                                                                    data-teacherid="<%= course.getTeacherId() %>"
                                                                                                    data-bs-toggle="modal"
                                                                                                    data-bs-target="#editCourseModal">
                                                                                                    Edit
                                                                                                </button>

                                                                                                <!-- Delete Button -->
                                                                                                <a href="${pageContext.request.contextPath}/DeleteCourseServlet1?id=<%= course.getId() %>"
                                                                                                    class="btn btn-sm btn-danger"
                                                                                                    onclick="return confirm('Are you sure you want to delete this course?');">
                                                                                                    Delete
                                                                                                </a>
                                                                                            </td>
                                                                                        </tr>
                                                                                        <% } %>
                                                                                </tbody>
                                                                            </table>
                                                                            <% } %>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <!-- All Teachers Tab -->
                                                        <div class="tab-content-item" id="teachers-content">
                                                            <div class="data-table-container fade-in">
                                                                <div class="data-table-header">
                                                                    <div>
                                                                        <h5 class="mb-1"><i
                                                                                class="fas fa-chalkboard-teacher me-2"></i>Teacher
                                                                            Management</h5>
                                                                        <p class="mb-0 opacity-75">View and manage all
                                                                            registered teachers</p>
                                                                    </div>
                                                                </div>
                                                                <div class="table-responsive">
                                                                    <% if (teachers.isEmpty()) { %>
                                                                        <div class="empty-state">
                                                                            <div class="empty-state-icon">
                                                                                <i
                                                                                    class="fas fa-chalkboard-teacher"></i>
                                                                            </div>
                                                                            <h5>No teachers registered</h5>
                                                                            <p>Teachers will appear here once they
                                                                                register for accounts.</p>
                                                                        </div>
                                                                        <% } else { %>
                                                                            <table class="table">
                                                                                <thead>
                                                                                    <tr>
                                                                                        <th>ID</th>
                                                                                        <th>Teacher Details</th>
                                                                                        <th>Contact Information</th>
                                                                                        <th>Status</th>
                                                                                    </tr>
                                                                                </thead>
                                                                                <tbody>
                                                                                    <% for (User teacher : teachers) {
                                                                                        %>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <span
                                                                                                    class="badge bg-primary">#
                                                                                                    <%= teacher.getId()
                                                                                                        %></span>
                                                                                            </td>
                                                                                            <td>
                                                                                                <div
                                                                                                    class="d-flex align-items-center">
                                                                                                    <div class="me-3">
                                                                                                        <div class="bg-success text-white rounded-circle d-flex align-items-center justify-content-center"
                                                                                                            style="width: 40px; height: 40px;">
                                                                                                            <i
                                                                                                                class="fas fa-user"></i>
                                                                                                        </div>
                                                                                                    </div>
                                                                                                    <div>
                                                                                                        <h6
                                                                                                            class="mb-0">
                                                                                                            <%= teacher.getFullName()
                                                                                                                %>
                                                                                                        </h6>
                                                                                                        <small
                                                                                                            class="text-muted">@
                                                                                                            <%= teacher.getUsername()
                                                                                                                %>
                                                                                                                </small>
                                                                                                    </div>
                                                                                                </div>
                                                                                            </td>
                                                                                            <td>
                                                                                                <div>
                                                                                                    <i
                                                                                                        class="fas fa-envelope text-muted me-2"></i>
                                                                                                    <%= teacher.getEmail()
                                                                                                        %>
                                                                                                </div>
                                                                                            </td>
                                                                                            <td>
                                                                                                <span
                                                                                                    class="badge bg-success">
                                                                                                    <i
                                                                                                        class="fas fa-check-circle me-1"></i>Active
                                                                                                </span>
                                                                                            </td>
                                                                                        </tr>
                                                                                        <% } %>
                                                                                </tbody>
                                                                            </table>
                                                                            <% } %>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <!-- All Students Tab -->
                                                        <div class="tab-content-item" id="students-content">
                                                            <div class="data-table-container fade-in">
                                                                <div class="data-table-header">
                                                                    <div>
                                                                        <h5 class="mb-1"><i
                                                                                class="fas fa-user-graduate me-2"></i>Student
                                                                            Management</h5>
                                                                        <p class="mb-0 opacity-75">View and manage all
                                                                            registered students</p>
                                                                    </div>
                                                                </div>
                                                                <div class="table-responsive">
                                                                    <% if (students.isEmpty()) { %>
                                                                        <div class="empty-state">
                                                                            <div class="empty-state-icon">
                                                                                <i class="fas fa-user-graduate"></i>
                                                                            </div>
                                                                            <h5>No students registered</h5>
                                                                            <p>Students will appear here once they
                                                                                register for accounts.</p>
                                                                        </div>
                                                                        <% } else { %>
                                                                            <table class="table">
                                                                                <thead>
                                                                                    <tr>
                                                                                        <th>ID</th>
                                                                                        <th>Student Details</th>
                                                                                        <th>Contact Information</th>
                                                                                        <th>Status</th>
                                                                                    </tr>
                                                                                </thead>
                                                                                <tbody>
                                                                                    <% for (User student : students) {
                                                                                        %>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <span
                                                                                                    class="badge bg-warning">#
                                                                                                    <%= student.getId()
                                                                                                        %></span>
                                                                                            </td>
                                                                                            <td>
                                                                                                <div
                                                                                                    class="d-flex align-items-center">
                                                                                                    <div class="me-3">
                                                                                                        <div class="bg-warning text-dark rounded-circle d-flex align-items-center justify-content-center"
                                                                                                            style="width: 40px; height: 40px;">
                                                                                                            <i
                                                                                                                class="fas fa-user"></i>
                                                                                                        </div>
                                                                                                    </div>
                                                                                                    <div>
                                                                                                        <h6
                                                                                                            class="mb-0">
                                                                                                            <%= student.getFullName()
                                                                                                                %>
                                                                                                        </h6>
                                                                                                        <small
                                                                                                            class="text-muted">@
                                                                                                            <%= student.getUsername()
                                                                                                                %>
                                                                                                                </small>
                                                                                                    </div>
                                                                                                </div>
                                                                                            </td>
                                                                                            <td>
                                                                                                <div>
                                                                                                    <i
                                                                                                        class="fas fa-envelope text-muted me-2"></i>
                                                                                                    <%= student.getEmail()
                                                                                                        %>
                                                                                                </div>
                                                                                            </td>
                                                                                            <td>
                                                                                                <span
                                                                                                    class="badge bg-success">
                                                                                                    <i
                                                                                                        class="fas fa-check-circle me-1"></i>Active
                                                                                                </span>
                                                                                            </td>
                                                                                        </tr>
                                                                                        <% } %>
                                                                                </tbody>
                                                                            </table>
                                                                            <% } %>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                            </div>
                            <!-- ✅ Single Reusable Edit Modal -->
                            <div class="modal fade" id="editCourseModal" tabindex="-1" aria-hidden="true">
                                <div class="modal-dialog modal-dialog-centered">
                                    <div class="modal-content">
                                        <form action="${pageContext.request.contextPath}/EditCouraseServlet1"
                                            method="post">
                                            <div class="modal-header">
                                                <h5 class="modal-title">Edit Course</h5>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                    aria-label="Close"></button>
                                            </div>

                                            <div class="modal-body">
                                                <input type="hidden" name="id" id="editCourseId">

                                                <div class="mb-3">
                                                    <label class="form-label">Course Code</label>
                                                    <input type="text" name="courseCode" id="editCourseCode"
                                                        class="form-control" required>
                                                </div>

                                                <div class="mb-3">
                                                    <label class="form-label">Course Name</label>
                                                    <input type="text" name="courseName" id="editCourseName"
                                                        class="form-control" required>
                                                </div>

                                                <div class="mb-3">
                                                    <label class="form-label">Teacher</label>
                                                    <select name="teacherId" id="editTeacherId" class="form-select"
                                                        required>
                                                        <% for (User teacher : teachers) { %>
                                                            <option value="<%= teacher.getId() %>">
                                                                <%= teacher.getFullName() %>
                                                            </option>
                                                            <% } %>
                                                    </select>
                                                </div>
                                            </div>

                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary"
                                                    data-bs-dismiss="modal">Cancel</button>
                                                <button type="submit" class="btn btn-success">Save Changes</button>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>

                            <script
                                src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
                            <script>
                                // Create animated background shapes matching student dashboard
                                document.addEventListener('DOMContentLoaded', function () {
                                    const backgroundAnimation = document.getElementById('backgroundAnimation');

                                    function createFloatingShape() {
                                        const shape = document.createElement('div');
                                        shape.classList.add('floating-shape');

                                        const size = Math.random() * 60 + 20;
                                        shape.style.width = `${size}px`;
                                        shape.style.height = `${size}px`;
                                        shape.style.left = `${Math.random() * 100}vw`;
                                        shape.style.bottom = '-100px';

                                        const duration = Math.random() * 15 + 20;
                                        shape.style.animationDuration = `${duration}s`;

                                        backgroundAnimation.appendChild(shape);

                                        setTimeout(() => {
                                            if (shape.parentNode) {
                                                shape.parentNode.removeChild(shape);
                                            }
                                        }, duration * 1000);
                                    }

                                    // Create initial shapes
                                    for (let i = 0; i < 8; i++) {
                                        setTimeout(() => createFloatingShape(), i * 1000);
                                    }

                                    // Continue creating shapes
                                    setInterval(createFloatingShape, 3000);

                                    // Auto-dismiss alerts after 5 seconds
                                    setTimeout(() => {
                                        document.querySelectorAll('.alert').forEach(alert => {
                                            const bsAlert = new bootstrap.Alert(alert);
                                            bsAlert.close();
                                        });
                                    }, 5000);
                                });

                                // Tab switching functionality
                                function switchTab(tabName) {
                                    // Hide all tab contents
                                    document.querySelectorAll('.tab-content-item').forEach(item => {
                                        item.classList.remove('active');
                                    });

                                    // Show selected tab content
                                    const targetContent = document.getElementById(tabName + '-content');
                                    if (targetContent) {
                                        targetContent.classList.add('active');
                                    }

                                    // Update URL hash
                                    window.location.hash = tabName;
                                }


                                // Initialize page
                                document.addEventListener('DOMContentLoaded', function () {

                                    // Load tab from URL hash
                                    const hash = window.location.hash.substr(1);
                                    if (hash && document.getElementById(hash + '-content')) {
                                        switchTab(hash);
                                    }

                                    // Form validation
                                    const forms = document.querySelectorAll('.needs-validation');
                                    forms.forEach(form => {
                                        form.addEventListener('submit', function (event) {
                                            if (!form.checkValidity()) {
                                                event.preventDefault();
                                                event.stopPropagation();
                                            }
                                            form.classList.add('was-validated');
                                        });
                                    });

                                });

                                // Handle window resize
                                window.addEventListener('resize', function () {
                                    const sidebar = document.getElementById('sidebar');
                                    const mainContent = document.getElementById('mainContent');

                                    if (window.innerWidth >= 768) {
                                        sidebar.classList.remove('show');
                                        mainContent.classList.add('sidebar-open');
                                    } else {
                                        mainContent.classList.remove('sidebar-open');
                                    }
                                });

                                // Add some visual feedback for admin actions
                                document.querySelectorAll('.action-btn').forEach(btn => {
                                    btn.addEventListener('click', function () {
                                        this.style.transform = 'scale(0.95)';
                                        setTimeout(() => {
                                            this.style.transform = '';
                                        }, 150);
                                    });
                                });

                                document.addEventListener("DOMContentLoaded", function () {
                                    const editButtons = document.querySelectorAll(".editBtn");

                                    editButtons.forEach(button => {
                                        button.addEventListener("click", function () {
                                            // Get values from button data-attributes
                                            const id = this.getAttribute("data-id");
                                            const code = this.getAttribute("data-code");
                                            const name = this.getAttribute("data-name");
                                            const teacherId = this.getAttribute("data-teacherid");

                                            // Fill modal form fields
                                            document.getElementById("editCourseId").value = id;
                                            document.getElementById("editCourseCode").value = code;
                                            document.getElementById("editCourseName").value = name;

                                            // Select correct teacher
                                            const teacherSelect = document.getElementById("editTeacherId");
                                            for (let option of teacherSelect.options) {
                                                option.selected = (option.value === teacherId);
                                            }
                                        });
                                    });
                                });

                            </script>
                        </body>

                        </html>