<%--
 Page: Login
 Access: Public

 Form routing:
 - POST action="login" -> /login (LoginServlet)

 Related pages:
 - register.jsp (registration UI)
--%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Academia</title>
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
            max-width: 450px;
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
        
        
        .glass-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 40px rgba(0, 0, 0, 0.15);
        }
        

        
        /* Form input fields */
        .form-control {
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.3);
            color: #fff;
            border-radius: 10px;
            padding: 12px 20px;
            transition: all 0.3s;
        }
        
        .form-control:focus {
            background: rgba(255, 255, 255, 0.2);
            border-color: rgba(255, 255, 255, 0.5);
            box-shadow: 0 0 0 0.2rem rgba(255, 255, 255, 0.25);
            color: #fff;
        }
        
        .form-control::placeholder {
            color: rgba(255, 255, 255, 0.7);
        }
        
        /* GREEN gradient button */
        .btn-primary {
            background: linear-gradient(to right, var(--primary), var(--secondary));
            border: none;
            border-radius: 50px;
            padding: 12px 30px;
            font-weight: 600;
            letter-spacing: 0.5px;
            transition: all 0.3s;
            box-shadow: 0 4px 15px rgba(112, 40, 167, 0.4); /* Green shadow */
        }
        
        .btn-primary:hover {
            background: linear-gradient(to right, var(--secondary), var(--primary));
            transform: translateY(-2px);
            box-shadow: 0 7px 20px rgba(104, 40, 167, 0.6);
        }
        
        /* Floating label effect */
        .floating-label {
            position: relative;
            margin-bottom: 20px;
        }
        
        .floating-label label {
            position: absolute;
            top: 12px;
            left: 20px;
            color: rgba(255, 255, 255, 0.8);
            transition: all 0.3s;
            pointer-events: none;
        }
        
        .floating-label input:focus ~ label,
        .floating-label input:not(:placeholder-shown) ~ label {
            top: -10px;
            left: 15px;
            font-size: 12px;
            background: linear-gradient(135deg, #3a4241 0%, #404d49 100%); /* Green gradient */
            padding: 0 8px;
            color: #fff;
            border-radius: 4px;
        }
        
        /* Alert messages */
        .alert {
            background: rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            color: #fff;
            border-radius: 10px;
        }
        
        /* Academia logo with Purple gradient */
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
                        <p class="text-white mb-0">Smart management for modern education</p>
                    </div>
                    <div class="card-body px-5 py-4">

                        <!-- JSP Error Message Display -->
                        <% if (request.getParameter("error") != null) { %>
                            <div class="alert alert-danger text-center" role="alert">
                                <i class="fas fa-exclamation-circle me-2"></i><%= request.getParameter("error") %>
                            </div>
                        <% } %>

                        <!-- JSP Success Message Display -->
                        <% if (request.getParameter("message") != null) { %>
                            <div class="alert alert-success text-center" role="alert">
                                <i class="fas fa-check-circle me-2"></i><%= request.getParameter("message") %>
                            </div>
                        <% } %>
                        
                        <!-- Login Form -->
                        <form action="login" method="post">
                            <div class="floating-label">
                                <input type="text" class="form-control" id="username" name="username" placeholder=" " required>
                                <label for="username"><i class="fas fa-user me-1"></i>Username</label>
                            </div>
                            
                            <div class="floating-label">
                                <input type="password" class="form-control" id="password" name="password" placeholder=" " required>
                                <label for="password"><i class="fas fa-lock me-1"></i>Password</label>
                            </div>
                            
                            <div class="d-grid gap-2 mt-4">
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-sign-in-alt me-2"></i>Login
                                </button>
                            </div>
                        </form>
                    </div>
                    <div class="card-footer text-center bg-transparent border-0 pb-4">
                        <p class="text-white mb-2">Don't have an account?</p>
                        <a href="register.jsp" class="btn btn-outline-light btn-sm">
                            <i class="fas fa-user-plus me-1"></i>Register Now
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Using more reliable CDN for Bootstrap JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
    <script>
        // FIXED: Simplified and more reliable particle animation
        document.addEventListener('DOMContentLoaded', function() {
            console.log('Starting particle animation...'); // Debug log
            
            const particlesContainer = document.getElementById('particles');
            
            if (!particlesContainer) {
                console.error('Particles container not found!');
                return;
            }
            
            // Function to create a single bubble
            function createBubble() {
                const bubble = document.createElement('div');
                bubble.className = 'particle';
                
                // Random size between 15px and 50px
                const size = Math.random() * 35 + 15;
                bubble.style.width = size + 'px';
                bubble.style.height = size + 'px';
                
                // Position at bottom of screen, random X position
                const startX = Math.random() * window.innerWidth;
                bubble.style.left = startX + 'px';
                bubble.style.bottom = '-' + size + 'px'; // Start below screen
                
                // Random horizontal drift
                const drift = (Math.random() - 0.5) * 200;
                bubble.style.setProperty('--drift', drift + 'px');
                
                // Random animation duration (15-30 seconds)
                const duration = Math.random() * 15 + 15;
                bubble.style.animationDuration = duration + 's';
                
                // Add to container
                particlesContainer.appendChild(bubble);
                
                console.log('Created bubble:', size, startX, duration); // Debug log
                
                // Remove bubble after animation
                setTimeout(() => {
                    if (bubble.parentNode) {
                        bubble.parentNode.removeChild(bubble);
                    }
                }, duration * 1000 + 1000);
            }
            
            // Create initial bubbles immediately
            for (let i = 0; i < 20; i++) {
                setTimeout(() => createBubble(), i * 200);
            }
            
            // Keep creating new bubbles
            setInterval(createBubble, 1500);
            
            console.log('Particle system initialized'); // Debug log
        });
        
        // Test function you can run in console
        window.testBubbles = function() {
            const container = document.getElementById('particles');
            const testBubble = document.createElement('div');
            testBubble.style.position = 'absolute';
            testBubble.style.width = '30px';
            testBubble.style.height = '30px';
            testBubble.style.backgroundColor = 'red';
            testBubble.style.borderRadius = '50%';
            testBubble.style.left = '50px';
            testBubble.style.top = '50px';
            testBubble.style.zIndex = '1000';
            container.appendChild(testBubble);
            console.log('Test bubble added');
        };
    </script>
</body>
</html>