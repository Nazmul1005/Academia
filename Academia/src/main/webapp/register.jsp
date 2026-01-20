<%--
 Page: Registration
 Access: Public

 Form routing:
 - POST action="register" -> /register (RegistrationServlet)

 Notes:
 - Allowed roles from UI: student, teacher
 - After success: redirect to login.jsp
--%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - Academia</title>
    <!-- Using CDN links that are more reliable -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        /* Base color theme */
        :root {
            --primary: #2563eb;        /* Blue primary */
            --secondary: #8b5cf6;      /* Purple secondary */
            --accent: #7c3aed;         /* Purple accent */
            --success: #10b981;        /* Green success */
            --warning: #f59e0b;        /* Amber warning */
            --danger: #ef4444;         /* Red danger */
            --info: #06b6d4;           /* Cyan info */
            --light: #f1f5f9;          /* Light gray */
            --dark: #1e293b;           /* Dark slate */
            --surface: #ffffff;        /* White surface */
            --muted: #64748b;          /* Slate gray */
            --student-primary: #3b82f6; /* Student theme blue */
            --student-secondary: #8b5cf6; /* Student theme purple */
        }

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
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        /* FIXED: Particles container - ensuring it covers the entire screen */
        .particles {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: 1; /* Above background, below content */
            pointer-events: none;
            overflow: hidden;
        }
        
        /* FIXED: Individual particle styling with better visibility */
        .particle {
            position: absolute;
            border-radius: 50%;
            /* Making bubbles more visible with white/light green colors */
            background: radial-gradient(circle at 30% 30%, 
                rgba(255, 255, 255, 0.4), 
                rgba(255, 255, 255, 0.1),
                rgba(134, 239, 172, 0.2)); /* Light green tint */
            
            /* Adding a subtle border for better visibility */
            border: 1px solid rgba(255, 255, 255, 0.2);
            
            /* Animation properties */
            animation: bubbleFloat linear infinite;
            
            /* Adding some glow effect */
            box-shadow: 0 0 10px rgba(255, 255, 255, 0.1);
        }
        
        /* FIXED: Keyframe animation that definitely works */
        @keyframes bubbleFloat {
            0% {
                transform: translateY(0px) translateX(0px) rotate(0deg);
                opacity: 0;
            }
            10% {
                opacity: 1;
            }
            90% {
                opacity: 1;
            }
            100% {
                transform: translateY(-100vh) translateX(var(--drift, 0px)) rotate(360deg);
                opacity: 0;
            }
        }
        
        /* Main container ensuring proper z-index */
        .container {
            position: relative;
            z-index: 10; /* Above particles */
        }
        
        /* Modern card with glassmorphism effect */
        .glass-card {
            background: rgba(30, 41, 59, 0.95);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            border-radius: 16px;
            border: 1px solid rgba(255, 255, 255, 0.1);
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.2);
            overflow: hidden;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            position: relative;
            z-index: 15;
            max-width: 500px;
            width: 100%;
            margin: 2rem;
            padding: 2rem;
            color: var(--light);
        }

        .glass-card h2 {
            color: var(--light);
            font-weight: 700;
            font-size: 2rem;
            margin-bottom: 1.5rem;
            text-align: center;
            background: linear-gradient(135deg, var(--student-primary), var(--student-secondary));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }
        .role-card {
            min-height: 200px;
            height: 100%;
        }

        .form-control {
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            color: var(--light);
            border-radius: 12px;
            padding: 0.75rem 1rem;
            margin-bottom: 1rem;
        }

        .form-control:focus {
            background: rgba(255, 255, 255, 0.15);
            border-color: var(--student-primary);
            color: var(--light);
            box-shadow: 0 0 0 2px rgba(59, 130, 246, 0.25);
        }

        .form-control::placeholder {
            color: rgba(255, 255, 255, 0.6);
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--student-primary), var(--student-secondary));
            border: none;
            border-radius: 12px;
            padding: 0.75rem 1.5rem;
            font-weight: 600;
            transition: all 0.3s ease;
            width: 100%;
            margin-top: 1rem;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(59, 130, 246, 0.4);
        }


        .register-link {
            color: var(--light);
            text-align: center;
            display: block;
            margin-top: 1rem;
            text-decoration: none;
            transition: color 0.3s ease;
        }

        .register-link:hover {
            color: var(--student-primary);
        }
        
        /* Role selection cards */
        .role-card {
            transition: all 0.3s;
            cursor: pointer;
            border: 2px solid rgba(255, 255, 255, 0.1);
            background: rgba(255, 255, 255, 0.05);
            border-radius: 12px;
            padding: 1rem;
            margin-bottom: 1rem;
            text-align: center;
        }
        
        .role-card:hover, .role-card.selected {
            border-color: var(--student-primary);
            background: rgba(59, 130, 246, 0.1);
            transform: translateY(-2px);
        }
        
        .role-card.selected {
            background: rgba(59, 130, 246, 0.15);
        }
        
        .role-icon {
            font-size: 2rem;
            margin-bottom: 0.5rem;
            color: var(--student-primary);
        }
        
        /* Floating labels */
        .floating-label {
            position: relative;
            margin-bottom: 1.5rem;
        }
        
        .floating-label label {
            position: absolute;
            top: 12px;
            left: 15px;
            color: rgba(255, 255, 255, 0.7);
            transition: all 0.3s;
            pointer-events: none;
            font-size: 0.9rem;
        }
        
        .floating-label input:focus ~ label,
        .floating-label input:not(:placeholder-shown) ~ label {
            top: -20px;
            left: 10px;
            font-size: 0.8rem;
            background: rgba(30, 41, 59, 0.9);
            padding: 2px 8px;
            color: var(--student-primary);
            border-radius: 4px;
        }
        .logo {
            font-weight: 800;
            font-size: 2.2rem;
            background: linear-gradient(to right, #fff, #9825ef); /* White to light purple */
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            filter: drop-shadow(0 2px 5px rgba(0, 0, 0, 0.3));
        }
        
        /* Responsive design */
        @media (max-width: 576px) {
            .card-body {
                padding-left: 1.5rem;
                padding-right: 1.5rem;
            }
            .logo {
                font-size: 1.8rem;
            }
        }
    </style>
</head>
<body>
    <!-- Particles container -->
    <div class="particles" id="particles"></div>
    
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-11 col-sm-9 col-md-8 col-lg-6">
                <div class="glass-card">
                    <div class="card-header text-center border-0 pt-4">
                        <h1 class="logo"><i class="fas fa-graduation-cap me-2"></i>Academia</h1>
                        <p class="text-white mb-0">Create your account</p>
                    </div>
                    <div class="card-body px-4 py-4">

                        <!-- JSP Error Message Display -->
                        <% if (request.getParameter("error") != null) { %>
                            <div class="alert alert-danger text-center" role="alert">
                                <i class="fas fa-exclamation-circle me-2"></i><%= request.getParameter("error") %>
                            </div>
                        <% } %>

                        <!-- Registration Form -->
                        <form action="register" method="post" id="registrationForm">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="floating-label">
                                        <input type="text" class="form-control" id="username" name="username" placeholder=" " required>
                                        <label for="username"><i class="fas fa-user me-1"></i>Username *</label>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="floating-label">
                                        <input type="email" class="form-control" id="email" name="email" placeholder=" " required>
                                        <label for="email"><i class="fas fa-envelope me-1"></i>Email Address *</label>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="floating-label">
                                        <input type="password" class="form-control" id="password" name="password" placeholder=" " required>
                                        <label for="password"><i class="fas fa-lock me-1"></i>Password *</label>
                                    </div>
                                    <div class="form-text text-white-50">Must be at least 6 characters long</div>
                                </div>
                                <div class="col-md-6">
                                    <div class="floating-label">
                                        <input type="text" class="form-control" id="fullName" name="fullName" placeholder=" ">
                                        <label for="fullName"><i class="fas fa-signature me-1"></i>Full Name</label>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Role Selection -->
                            <div class="mb-3">
                                <label class="form-label text-white">Select Your Role *</label>
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <div class="role-card" id="studentCard" onclick="selectRole('student')">
                                            <div class="role-icon">
                                                <i class="fas fa-user-graduate"></i>
                                            </div>
                                            <h5 class="card-title">Student</h5>
                                            <p class="card-text small">Enroll in courses and track your learning progress efficiently</p>
                                            <input type="radio" class="btn-check" name="role" id="roleStudent" value="student" autocomplete="off" required>
                                            <label class="btn btn-outline-primary btn-sm" for="roleStudent">Select Student</label>
                                        </div>
                                    </div>
                                    <div class="col-md-6 mb-3 ">
                                        <div class="role-card" id="teacherCard" onclick="selectRole('teacher')">
                                            <div class="role-icon">
                                                <i class="fas fa-chalkboard-teacher"></i>
                                            </div>
                                            <h5 class="card-title">Teacher</h5>
                                            <p class="card-text small">Create and manage courses, track student progress</p>
                                            <input type="radio" class="btn-check" name="role" id="roleTeacher" value="teacher" autocomplete="off">
                                            <label class="btn btn-outline-primary btn-sm" for="roleTeacher">Select Teacher</label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="d-grid gap-2">
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-user-plus me-2"></i>Create Account
                                </button>
                            </div>
                        </form>
                    </div>
                    <div class="card-footer text-center bg-transparent border-0 pb-4">
                        <p class="text-white mb-2">Already have an account?</p>
                        <a href="login.jsp" class="btn btn-outline-light btn-sm">
                            <i class="fas fa-sign-in-alt me-1"></i>Login Now
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Using more reliable CDN for Bootstrap JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
    <script>
        // Role selection function
        function selectRole(role) {
            // Update card visuals
            document.querySelectorAll('.role-card').forEach(card => {
                card.classList.remove('selected');
            });
            
            if (role === 'student') {
                document.getElementById('studentCard').classList.add('selected');
                document.getElementById('roleStudent').checked = true;
            } else {
                document.getElementById('teacherCard').classList.add('selected');
                document.getElementById('roleTeacher').checked = true;
            }
        }
        
        // Form validation
        document.getElementById('registrationForm').addEventListener('submit', function(e) {
            const password = document.getElementById('password').value;
            const roleSelected = document.querySelector('input[name="role"]:checked');
            
            if (password.length < 6) {
                e.preventDefault();
                alert('Password must be at least 6 characters long');
                return false;
            }
            
            if (!roleSelected) {
                e.preventDefault();
                alert('Please select your role');
                return false;
            }
        });
        
        // FIXED: Simplified and more reliable particle animation
        document.addEventListener('DOMContentLoaded', function() {
            const particlesContainer = document.getElementById('particles');
            
            function createBubble() {
                const bubble = document.createElement('div');
                bubble.className = 'particle';
                
                const size = Math.random() * 35 + 15;
                bubble.style.width = size + 'px';
                bubble.style.height = size + 'px';
                
                const startX = Math.random() * window.innerWidth;
                bubble.style.left = startX + 'px';
                bubble.style.bottom = '-' + size + 'px';
                
                const drift = (Math.random() - 0.5) * 200;
                bubble.style.setProperty('--drift', drift + 'px');
                
                const duration = Math.random() * 15 + 15;
                bubble.style.animationDuration = duration + 's';
                
                particlesContainer.appendChild(bubble);
                
                setTimeout(() => {
                    if (bubble.parentNode) {
                        bubble.parentNode.removeChild(bubble);
                    }
                }, duration * 1000 + 1000);
            }
            
            // Create initial bubbles
            for (let i = 0; i < 20; i++) {
                setTimeout(() => createBubble(), i * 200);
            }
            
            // Keep creating new bubbles
            setInterval(createBubble, 1500);
        });
    </script>
</body>
</html>