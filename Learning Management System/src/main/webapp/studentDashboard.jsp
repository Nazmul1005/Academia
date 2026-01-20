<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="nazmul.User, nazmul.CourseDAO, nazmul.Course, java.util.List" %>
        <%-- Page: Student Dashboard Role requirement: session attribute "user" must exist and have role "student" Data
            loaded (via CourseDAO): - getCoursesByStudentId(user.id) - getAvailableCourses(user.id) -
            getUserById(user.id) (profile display) Action routing: - POST action="enrollCourse" -> /enrollCourse
            (EnrollCourseServlet)
            - POST action="UpdateProfileServlet" -> /UpdateProfileServlet (UpdateProfileServlet)
            - logout.jsp (invalidates session)
            --%>
            <% User user=(User) session.getAttribute("user"); if (user==null || !"student".equals(user.getRole())) {
                response.sendRedirect("login.jsp"); return; } CourseDAO courseDAO=new CourseDAO(); List<Course>
                enrolledCourses = courseDAO.getCoursesByStudentId(user.getId());
                List<Course> availableCourses = courseDAO.getAvailableCourses(user.getId());
                    User student = courseDAO.getUserById(user.getId());
                    // Calculate progress for CSS conic-gradient
                    int progressDegrees = (enrolledCourses.size() * 360 / Math.max(enrolledCourses.size() +
                    availableCourses.size(), 1));
                    %>
                    <!DOCTYPE html>
                    <html lang="en">

                    <head>
                        <meta charset="UTF-8">
                        <meta name="viewport" content="width=device-width, initial-scale=1.0">
                        <title>Student Dashboard - Academia</title>
                        <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css"
                            rel="stylesheet">
                        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
                            rel="stylesheet">
                        <style>
                            /* Professional color scheme for students */
                            :root {
                                --primary: #2563eb;
                                /* Blue primary */
                                --secondary: #3f0596;
                                /* Emerald secondary */
                                --accent: #7c3aed;
                                /* Purple accent */
                                --success: #1391e0;
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
                                --student-primary: #3b82f6;
                                /* Student theme blue */
                                --student-secondary: #8b5cf6;
                                /* Student theme purple */
                                --student-accent: #410596;
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

                            /* Animated background particles */
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

                            /* Welcome section with student focus */
                            .welcome-section {
                                background: linear-gradient(135deg, var(--student-primary), var(--info) 100%);
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

                            .progress-ring {
                                width: 120px;
                                height: 120px;
                                position: relative;
                            }

                            .progress-circle {
                                width: 100%;
                                height: 100%;
                                border-radius: 50%;
                                background: conic-gradient(#ffffff 0deg, #ffffff <%=(enrolledCourses.size() * 360 / Math.max(enrolledCourses.size() + availableCourses.size(), 1)) %>deg, rgba(255, 255, 255, 0.2) 0deg);
                                display: flex;
                                align-items: center;
                                justify-content: center;
                                position: relative;
                            }

                            .progress-circle::before {
                                content: '';
                                width: 80px;
                                height: 80px;
                                background: var(--student-primary);
                                border-radius: 50%;
                                position: absolute;
                            }

                            .progress-text {
                                position: absolute;
                                color: white;
                                font-weight: 700;
                                z-index: 1;
                            }

                            /* Enhanced glass cards */
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

                            /* Course cards with enhanced styling */
                            .course-card {
                                border-radius: 16px;
                                overflow: hidden;
                                transition: all 0.3s;
                                border: 2px transparent;
                                background: linear-gradient(135deg, var(--student-primary), var(--info));
                                100%);
                                position: relative;
                                height: 100%;
                            }

                            .course-card::before {
                                content: '';
                                position: absolute;
                                top: 0;
                                left: 0;
                                right: 0;
                                height: 4px;
                                background: linear-gradient(90deg, var(--student-primary), var(--info));
                                transform: scaleX(0);
                                transition: transform 0.3s;
                            }

                            .course-card:hover::before {
                                transform: scaleX(1);
                            }

                            .course-card:hover {
                                transform: translateY(-5px);
                                box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
                                border-color: var(--teacher-primary);
                            }

                            .course-header {
                                background: linear-gradient(135deg, var(--student-primary), var(--info));
                                color: white;
                                padding: 2rem;
                                position: relative;
                            }


                            .course-code {
                                background: rgba(255, 255, 255, 0.2);
                                padding: 0.25rem 0.75rem;
                                border-radius: 20px;
                                font-size: 0.875rem;
                                font-weight: 600;
                                display: inline-block;
                                margin-bottom: 0.5rem;
                            }

                            .course-title {
                                font-size: 1.25rem;
                                font-weight: 700;
                                margin-bottom: 0.5rem;
                            }

                            .course-teacher {
                                opacity: 0.9;
                                font-size: 0.95rem;
                            }

                            /* Enhanced buttons */
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
                                background: linear-gradient(135deg, var(--student-primary), var(--student-secondary));
                                color: white;
                                box-shadow: 0 4px 15px rgba(59, 130, 246, 0.3);
                            }

                            .btn-primary:hover {
                                transform: translateY(-2px);
                                box-shadow: 0 8px 25px rgba(59, 130, 246, 0.4);
                            }

                            .btn-enroll {
                                background: linear-gradient(135deg, var(--student-accent), var(--info));
                                color: white;
                                border-radius: 25px;
                                padding: 0.75rem 1.5rem;
                                font-size: 0.875rem;
                                font-weight: 600;
                                text-decoration: none;
                                display: inline-flex;
                                align-items: center;
                                gap: 0.5rem;
                            }

                            .btn-enroll:hover {
                                transform: scale(1.05);
                                box-shadow: 0 6px 20px rgba(237, 113, 250, 0.822);
                                color: white;
                            }

                            .btn-gradient-primary {
                                background: linear-gradient(135deg, #667eea, #764ba2);
                                border: none;
                                color: white;
                                transition: all 0.3s ease;
                            }

                            .btn-gradient-primary:hover {
                                transform: translateY(-2px);
                                box-shadow: 0 8px 20px rgba(118, 75, 162, 0.4);
                            }

                            /* Statistics section */
                            .stats-section {
                                display: grid;
                                grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
                                gap: 1.5rem;
                                margin-bottom: 2rem;
                            }

                            .stat-item {
                                background: var(--surface);
                                padding: 1.5rem;
                                border-radius: 16px;
                                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
                                text-align: center;
                                transition: all 0.3s;
                            }

                            .stat-item:hover {
                                transform: translateY(-5px);
                                box-shadow: 0 12px 30px rgba(0, 0, 0, 0.12);
                            }

                            .stat-icon {
                                width: 64px;
                                height: 64px;
                                margin: 0 auto 1rem;
                                border-radius: 16px;
                                display: flex;
                                align-items: center;
                                justify-content: center;
                                font-size: 1.5rem;
                                color: white;
                            }

                            .stat-icon.enrolled {
                                background: linear-gradient(135deg, var(--student-primary), var(--info));
                            }

                            .stat-icon.available {
                                background: linear-gradient(135deg, var(--student-primary), var(--info));
                            }

                            .stat-number {
                                font-size: 2rem;
                                font-weight: 800;
                                color: var(--dark);
                                margin-bottom: 0.5rem;
                            }

                            .stat-label {
                                color: var(--muted);
                                font-weight: 500;
                            }

                            /* Empty state styling */
                            .empty-state {
                                text-align: center;
                                padding: 3rem 1rem;
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

                            /* Professional alerts */
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


                            /* Section headers */
                            .section-header {
                                display: flex;
                                align-items: center;
                                gap: 1rem;
                                margin-bottom: 2rem;
                            }

                            .section-icon {
                                width: 48px;
                                height: 48px;
                                border-radius: 12px;
                                display: flex;
                                align-items: center;
                                justify-content: center;
                                color: white;
                                font-size: 1.25rem;
                            }

                            .section-icon.available {
                                background: linear-gradient(135deg, var(--student-primary), var(--info));
                            }

                            .section-icon.enrolled {
                                background: linear-gradient(135deg, var(--student-primary), var(--info));
                            }

                            .text-muted {
                                color: var(--light) !important;
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
                        <!-- Animated background -->
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
                                        <h1 class="display-5 fw-bold mb-2">Student Dashboard</h1>
                                        <p class="lead mb-4">Welcome back, <%= user.getFullName() %>! Continue your
                                                learning journey and explore new opportunities.</p>
                                        <div class="d-flex gap-3">
                                            <span class="badge bg-light text-dark px-3 py-2 fs-6">
                                                <i class="fas fa-book-open me-1"></i>Enrolled: <%=
                                                    enrolledCourses.size() %>
                                            </span>
                                            <span class="badge bg-light text-dark px-3 py-2 fs-6">
                                                <i class="fas fa-plus-circle me-1"></i>Available: <%=
                                                    availableCourses.size() %>
                                            </span>
                                        </div>
                                    </div>
                                    <div class="col-md-4 text-center">
                                        <div class="progress-ring">
                                            <div class="progress-circle">
                                                <div class="progress-text">
                                                    <div class="fs-4 fw-bold">
                                                        <%= enrolledCourses.size() %>
                                                    </div>
                                                    <div class="small">Enrolled</div>
                                                </div>
                                            </div>
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

                                            <!-- Statistics Section -->
                                            <div class="stats-section fade-in">
                                                <div class="stat-item">
                                                    <div class="stat-icon enrolled">
                                                        <i class="fas fa-book-reader"></i>
                                                    </div>
                                                    <div class="stat-number">
                                                        <%= enrolledCourses.size() %>
                                                    </div>
                                                    <div class="stat-label">Enrolled Courses</div>
                                                </div>
                                                <div class="stat-item">
                                                    <div class="stat-icon available">
                                                        <i class="fas fa-plus-circle"></i>
                                                    </div>
                                                    <div class="stat-number">
                                                        <%= availableCourses.size() %>
                                                    </div>
                                                    <div class="stat-label">Available to Enroll</div>
                                                </div>
                                            </div>

                                            <!-- ================= Student Profile Section ================= -->
                                            <div class="fade-in">
                                                <div class="section-header">
                                                    <div class="section-icon available">
                                                        <i class="fas fa-user"></i>
                                                    </div>
                                                    <div>
                                                        <h3 class="mb-1 text-white">My Profile</h3>
                                                        <p class="text-light mb-0">Manage your Profile</p>
                                                    </div>
                                                </div>

                                                <div class="container mb-4">
                                                    <div
                                                        class="card glass-card shadow-lg border-0 p-4 profile-card position-relative overflow-hidden">

                                                        <div class="row text-dark mb-3 fs-5">
                                                            <!-- fs-5 makes all text bigger -->
                                                            <div class="col-md-6 mb-3">
                                                                <p class="mb-2">
                                                                    <i class="fas fa-pen me-2 text-primary fs-4"></i>
                                                                    <strong>Username:</strong> <span class="text-dark">
                                                                        <%= user.getUsername() %>
                                                                    </span>
                                                                </p>
                                                            </div>
                                                            <div class="col-md-6 mb-3">
                                                                <p class="mb-2">
                                                                    <i class="fas fa-pen me-2 text-primary fs-4"></i>
                                                                    <strong>Fullname:</strong> <span class="text-dark">
                                                                        <%= user.getFullName() %>
                                                                    </span>
                                                                </p>
                                                            </div>
                                                            <div class="col-md-6 mb-3">
                                                                <p class="mb-2">
                                                                    <i
                                                                        class="fas fa-envelope me-2 text-primary fs-4"></i>
                                                                    <strong>Email:</strong> <span class="text-dark">
                                                                        <%= student.getEmail() %>
                                                                    </span>
                                                                </p>
                                                            </div>
                                                            <div class="col-md-6 mb-3">
                                                                <p class="mb-2">
                                                                    <i
                                                                        class="fas fa-user-tag me-2 text-primary fs-4"></i>
                                                                    <strong>Role:</strong> <span class=" text-dark">
                                                                        <%= user.getRole() %>
                                                                    </span>
                                                                </p>
                                                            </div>
                                                        </div>


                                                        <div class="text-end">
                                                            <button
                                                                class="btn btn-gradient-primary rounded-pill shadow-sm"
                                                                data-bs-toggle="modal" data-bs-target="#profileModal">
                                                                <i class="fas fa-edit me-1"></i> Edit Profile
                                                            </button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>




                                            <!-- ================= Profile Edit Modal ================= -->
                                            <div class="modal fade" id="profileModal" tabindex="-1" aria-hidden="true">
                                                <div class="modal-dialog modal-lg modal-dialog-centered">
                                                    <div class="modal-content glass-card p-4">
                                                        <div class="modal-header border-0">
                                                            <h5 class="modal-title"><i
                                                                    class="fas fa-user-edit me-2"></i>Edit Profile</h5>
                                                            <button type="button" class="btn-close"
                                                                data-bs-dismiss="modal"></button>
                                                        </div>
                                                        <div class="modal-body">
                                                            <form action="UpdateProfileServlet" method="post">
                                                                <input type="hidden" name="id"
                                                                    value="<%= user.getId() %>">

                                                                <div class="row g-3">
                                                                    <div class="col-md-6">
                                                                        <label class="form-label fw-bold">Full
                                                                            Name</label>
                                                                        <input type="text" class="form-control"
                                                                            name="fullName"
                                                                            value="<%= user.getFullName() %>" required>
                                                                    </div>
                                                                    <div class="col-md-6">
                                                                        <label
                                                                            class="form-label fw-bold">Username</label>
                                                                        <input type="text" class="form-control"
                                                                            name="username"
                                                                            value="<%= user.getUsername() %>" required>
                                                                    </div>
                                                                    <div class="col-md-6">
                                                                        <label class="form-label fw-bold">Email</label>
                                                                        <input type="email" class="form-control"
                                                                            name="email"
                                                                            value="<%= student.getEmail() %>" required>
                                                                    </div>
                                                                    <div class="col-md-6">
                                                                        <label
                                                                            class="form-label fw-bold">Password</label>
                                                                        <input type="text" class="form-control"
                                                                            name="password"
                                                                            value="<%= user.getPassword() %>" required>
                                                                    </div>
                                                                </div>

                                                                <div class="mt-4 text-end">
                                                                    <button type="button" class="btn btn-secondary me-2"
                                                                        data-bs-dismiss="modal">Cancel</button>
                                                                    <button type="submit"
                                                                        class="btn btn-gradient-primary rounded-pill">
                                                                        <i class="fas fa-save me-1"></i> Save Changes
                                                                    </button>
                                                                </div>
                                                            </form>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>



                                            <!-- Available Courses Section -->
                                            <div class="fade-in">
                                                <div class="section-header">
                                                    <div class="section-icon available">
                                                        <i class="fas fa-store"></i>
                                                    </div>
                                                    <div>
                                                        <h3 class="mb-1 text-white">Course Marketplace</h3>
                                                        <p class="text-light mb-0">Discover and enroll in exciting new
                                                            courses</p>
                                                    </div>
                                                </div>

                                                <div class="glass-card mb-4">
                                                    <div class="card-body p-4">
                                                        <% if (availableCourses.isEmpty()) { %>
                                                            <div class="empty-state">
                                                                <div class="empty-state-icon">
                                                                    <i class="fas fa-search"></i>
                                                                </div>
                                                                <h5>No Available Courses</h5>
                                                                <p class="mb-3">All available courses have been enrolled
                                                                    or there are no courses available at this time.</p>
                                                                <button class="btn btn-primary"
                                                                    onclick="window.location.reload()">
                                                                    <i class="fas fa-refresh me-2"></i>Refresh
                                                                </button>
                                                            </div>
                                                            <% } else { %>
                                                                <div class="row">
                                                                    <% for (Course course : availableCourses) { %>
                                                                        <div class="col-md-6 col-lg-4 mb-4">
                                                                            <div class="course-card h-100">
                                                                                <div class="course-header">
                                                                                    <div class="course-code">
                                                                                        <%= course.getCourseCode() %>
                                                                                    </div>
                                                                                    <div class="course-title">
                                                                                        <%= course.getCourseName() %>
                                                                                    </div>
                                                                                    <div class="course-teacher">
                                                                                        <i
                                                                                            class="fas fa-chalkboard-teacher me-1"></i>
                                                                                        <%= course.getTeacherName()
                                                                                            !=null ?
                                                                                            course.getTeacherName()
                                                                                            : "Not Assigned" %>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="card-body p-3 text-center">
                                                                                    <form action="enrollCourse"
                                                                                        method="post">
                                                                                        <input type="hidden"
                                                                                            name="courseId"
                                                                                            value="<%= course.getId() %>">
                                                                                        <button type="submit"
                                                                                            class="btn btn-enroll">
                                                                                            <i
                                                                                                class="fas fa-plus-circle me-1"></i>Enroll
                                                                                            Now
                                                                                        </button>
                                                                                    </form>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <% } %>
                                                                </div>
                                                                <% } %>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- Enrolled Courses Section -->
                                            <div class="fade-in">
                                                <div class="section-header">
                                                    <div class="section-icon enrolled">
                                                        <i class="fas fa-graduation-cap"></i>
                                                    </div>
                                                    <div>
                                                        <h3 class="mb-1 text-white">My Learning Journey</h3>
                                                        <p class="text-light mb-0">Track your progress in enrolled
                                                            courses</p>
                                                    </div>
                                                </div>

                                                <div class="glass-card">
                                                    <div class="card-body p-4">
                                                        <% if (enrolledCourses.isEmpty()) { %>
                                                            <div class="empty-state">
                                                                <div class="empty-state-icon">
                                                                    <i class="fas fa-book-open"></i>
                                                                </div>
                                                                <h5>Start Your Learning Journey</h5>
                                                                <p class="mb-3">You haven't enrolled in any courses yet.
                                                                    Explore the available courses above and begin your
                                                                    educational adventure!</p>
                                                                <button class="btn btn-primary"
                                                                    onclick="document.querySelector('.course-marketplace').scrollIntoView({behavior: 'smooth'})">
                                                                    <i class="fas fa-search me-2"></i>Browse Courses
                                                                </button>
                                                            </div>
                                                            <% } else { %>
                                                                <div class="row">
                                                                    <% for (Course course : enrolledCourses) { %>
                                                                        <div class="col-md-6 col-lg-4 mb-4">
                                                                            <div class="course-card h-100">
                                                                                <div class="course-header">
                                                                                    <div class="course-code">
                                                                                        <%= course.getCourseCode() %>
                                                                                    </div>
                                                                                    <div class="course-title">
                                                                                        <%= course.getCourseName() %>
                                                                                    </div>
                                                                                    <div class="course-teacher">
                                                                                        <i
                                                                                            class="fas fa-chalkboard-teacher me-1"></i>
                                                                                        <%= course.getTeacherName()
                                                                                            !=null ?
                                                                                            course.getTeacherName()
                                                                                            : "Not Assigned" %>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="card-body p-3 text-center">
                                                                                    <div class="progress mb-3"
                                                                                        style="height: 8px;">
                                                                                        <div class="progress-bar bg-#410596"
                                                                                            style="width: <%= Math.random() * 80 + 20 %>%">
                                                                                        </div>
                                                                                    </div>
                                                                                    <small
                                                                                        class="text-muted col-white">Progress:
                                                                                        In Progress</small>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <% } %>
                                                                </div>
                                                                <% } %>
                                                    </div>
                                                </div>
                                            </div>
                        </div>

                        <script
                            src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
                        <script>

                            // Smooth scrolling for internal links
                            document.querySelectorAll('a[href^="#"]').forEach(anchor => {
                                anchor.addEventListener('click', function (e) {
                                    e.preventDefault();
                                    document.querySelector(this.getAttribute('href')).scrollIntoView({
                                        behavior: 'smooth'
                                    });
                                });
                            });
                        </script>
                    </body>

                    </html>