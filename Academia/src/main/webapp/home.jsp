<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%--
 Page: Landing / Home
 Access: Public (no login required)

 Primary links:
 - login.jsp (login UI) -> POST /login (LoginServlet)
 - register.jsp (registration UI) -> POST /register (RegistrationServlet)
--%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Academia | Learning Management System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #8b25ea;        /* Blue primary */
            --secondary: #3a0ca3;       /* Blue secondary */
            --accent: #7209b7;         /* Purple accent */
            --success: #4cc9f0;      /* Success green */
            --warning: #f72585;      /* Amber warning */
            --danger: #dc3545;       /* Red danger */
            --light: #f8f9fa;        /* Light background */
            --dark: #212529;         /* Dark text */
            --gradient-start: #a329ea;
            --gradient-end: #3a0ca3;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
        }

        body {
            color: var(--dark);
            background: linear-gradient(135deg, #c6b2d7 0%, #c6b2e5 100%);
            min-height: 100vh;
            overflow-x: hidden;
        }

        /* Navbar with glass effect */
        .navbar {
            background: rgba(255, 255, 255, 0.565);
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            border-bottom: 1px solid rgba(125, 40, 167, 0.2);
            padding: 1rem 0;
            transition: all 0.3s ease;
        }

        .navbar-brand {
            font-weight: 700;
            font-size: 1.8rem;
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .nav-link {
            color: var(--dark);
            font-weight: 500;
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
            background: linear-gradient(90deg, var(--primary), var(--secondary));
            transition: width 0.3s ease;
        }

        .nav-link:hover:after {
            width: 100%;
        }

        /* Hero section with animated Academia text */
        .hero {
            min-height: 100vh;
            display: flex;
            align-items: center;
            position: relative;
            padding: 6rem 0;
            overflow: hidden;
        }


        .hero::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: url('Academia.png') no-repeat center center/cover;
            opacity: 0.07;
            z-index: -1;
        }

        .hero-content {
            text-align: center;
            max-width: 900px;
            margin: 0 auto;
            position: relative;
            z-index: 2;
        }

        /* Apple-style stroke 'hello' animation container */
        .new__bg {
            width: 100%;
            display: flex;
            justify-content: center;
            margin-bottom: 1rem;
            pointer-events: none;
        }
        .hello__div {
            display: flex;
            justify-content: center;
            flex-direction: column;
            margin: 0 auto;
            text-align: center;
            width: 100%;
            max-width: 860px;
        }
        .hello__svg {
            fill: none;
            stroke-dasharray: 5800;
            stroke-dashoffset: 5800;
            animation: anim__hello linear 5s forwards;
            width: 100%;
            max-width: 920px;
            display: block;
            margin: 0 auto 12px;
            filter: drop-shadow(0 14px 30px rgba(67,97,238,0.16));
        }

        @keyframes anim__hello {
            0% { stroke-dashoffset: 5800; opacity: 0; }
            20% { stroke-dashoffset: 5800; opacity: 0; }
            100% { stroke-dashoffset: 0; opacity: 1; }
        }

        /* Academia typed/gradient text revealed after the SVG draws */
        .academia-text {
            font-size: 4.5rem;
            font-weight: 700;
            background: linear-gradient(135deg, var(--primary), var(--secondary), var(--accent));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: 1.25rem;
            opacity: 0;
            transform: translateY(12px);
            transition: opacity 400ms ease, transform 400ms ease;
            display: inline-block;
            position: relative;
        }

        .academia-text.revealed { opacity: 1; transform: translateY(0); }

        .academia-text::after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 50%;
            transform: translateX(-50%) scaleX(0);
            width: 60%;
            height: 6px;
            background: linear-gradient(90deg, var(--primary), var(--secondary), var(--accent));
            border-radius: 8px;
            transition: transform 500ms cubic-bezier(.2,.9,.3,1) 0.05s;
        }

        .academia-text.revealed::after { transform: translateX(-50%) scaleX(1); }

        .hero-subtitle {
            font-size: 1.25rem;
            margin-bottom: 2rem;
            color: var(--dark);
            opacity: 0;
            transform: translateY(8px);
            transition: opacity 400ms ease 150ms, transform 400ms ease 150ms;
        }

        .hero-subtitle.revealed { opacity: 1; transform: translateY(0); }

        /* CTA buttons */
        .cta-button {
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            border: none;
            color: white;
            padding: 12px 30px;
            border-radius: 50px;
            font-weight: 600;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(127, 40, 167, 0.3);
        }

        .cta-button:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(135, 40, 167, 0.4);
            color: white;
        }

        /* Glass cards */
        .glass-card {
            background: rgba(255, 255, 255, 0.7);
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            border-radius: 16px;
            border: 1px solid rgba(255, 255, 255, 0.5);
            padding: 2rem;
            transition: all 0.3s ease;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
            height: 100%;
        }

        .glass-card:hover { 
            transform: translateY(-10px); 
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.15); 
            border-color: rgba(118, 40, 167, 0.3); 
        }

        .feature-icon { 
            font-size: 3rem; 
            margin-bottom: 1.5rem; 
            background: linear-gradient(135deg, var(--primary), var(--secondary)); 
            -webkit-background-clip: text; 
            -webkit-text-fill-color: transparent; 
        }

        /* Stats section */
        .stats-section {
            background: linear-gradient(135deg, rgba(118, 40, 167, 0.1), rgba(162, 32, 201, 0.1));
            border: 1px solid rgba(127, 40, 167, 0.2);
        }

        .stat-number {
            font-size: 2.5rem;
            font-weight: 700;
            color: var(--primary);
            margin-bottom: 0.5rem;
        }
        .st{
            font-size: 2.5 rem;
            font-weight: 700;
            color: var(--accent);
        }

        /* Testimonial cards */
        .testimonial-card {
            transition: all 0.3s ease;
        }

        .testimonial-card:hover {
            transform: translateY(-5px);
        }

        /* Section spacing */
        .section-spacing {
            padding: 80px 0;
        }

        /* Footer */
        footer {
            background: rgba(120, 40, 167, 0.05);
            padding: 40px 0;
            border-top: 1px solid rgba(40, 167, 69, 0.1);
        }

        /* small responsive adjustments */
        @media (max-width: 768px) {
            .academia-text { font-size: 2.8rem; }
            .hero-subtitle { font-size: 1rem; }
        }

        /* Respect reduced-motion preference */
        @media (prefers-reduced-motion: reduce) {
        .hello__svg { animation: none; stroke-dashoffset: 0; }
        .academia-text, .hero-subtitle { transition: none; opacity: 1; transform: none; }
        }

    </style>
</head>
<body>
    <!-- Navigation Bar -->
    <nav class="navbar navbar-expand-lg navbar-light">
        <div class="container">
            <a class="navbar-brand" href="home.jsp"><i class="fas fa-graduation-cap me-2"></i>Academia</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link active" href="home.jsp">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#features">Features</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#testimonials">Testimonials</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="login.jsp">Login</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="register.jsp">Register</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <section class="hero" aria-hidden="false">
        <div class="container">
            <div class="hero-content">

                <!-- Apple-like hello SVG animation -->
                <div class="new__bg" aria-hidden="true">
                  <div class="hello__div" id="helloWrapper">
                    <svg class="hello__svg" id="helloSvg" viewBox="0 0 1230.94 414.57" preserveAspectRatio="xMidYMid meet" aria-hidden="true">
                      <defs>
                        <linearGradient id="academiaGrad" x1="0%" y1="0%" x2="100%" y2="0%">
                          <stop offset="0%" stop-color="#4361ee" />
                          <stop offset="60%" stop-color="#3a0ca3" />
                          <stop offset="100%" stop-color="#f72585" />
                        </linearGradient>
                      </defs>
                      <path d="M-293.58-104.62S-103.61-205.49-60-366.25c9.13-32.45,9-58.31,0-74-10.72-18.82-49.69-33.21-75.55,31.94-27.82,70.11-52.22,377.24-44.11,322.48s34-176.24,99.89-183.19c37.66-4,49.55,23.58,52.83,47.92a117.06,117.06,0,0,1-3,45.32c-7.17,27.28-20.47,97.67,33.51,96.86,66.93-1,131.91-53.89,159.55-84.49,31.1-36.17,31.1-70.64,19.27-90.25-16.74-29.92-69.47-33-92.79,16.73C62.78-179.86,98.7-93.8,159-81.63S302.7-99.55,393.3-269.92c29.86-58.16,52.85-114.71,46.14-150.08-7.44-39.21-59.74-54.50-92.87-8.70-47,65-61.78,266.62-34.74,308.53S416.62-58,481.52-130.31s133.20-188.56,146.54-256.23c14-71.15-56.94-94.64-88.40-47.32C500.53-375,467.58-229.49,503.30-127a73.73,73.73,0,0,0,23.43,33.67c25.49,20.23,55.10,16,77.46,6.32a111.25,111.25,0,0,0,30.44-19.87c37.73-34.23,29-36.71,64.58-127.53C724-284.30,785-298.63,821-259.13a71,71,0,0,1,13.69,22.56c17.68,46,6.81,80-6.81,107.89-12,24.62-34.56,42.72-61.45,47.91-23.06,4.45-48.37-.35-66.48-24.27a78.88,78.88,0,0,1-12.66-25.80c-14.75-51,4.14-88.76,11-101.41,6.18-11.39,37.26-69.61,103.42-42.24,55.71,23.05,100.66-23.31,100.66-23.31" transform="translate(311.08 476.02)" stroke="url(#academiaGrad)" stroke-linecap="round" stroke-miterlimit="10" stroke-width="35" fill="none" />
                    </svg>
                  </div>
                </div>

                <!-- Main title revealed after SVG animation finishes -->
                <h1 class="academia-text" id="academiaTitle">It's Academia</h1>
                <p class="hero-subtitle" id="heroSub">Transforming education through innovative technology and engaging learning experiences</p>
                <div class="d-flex gap-3 justify-content-center flex-wrap mt-4">
                    <a href="register.jsp" class="btn cta-button btn-lg">Get Started</a>
                    <a href="#features" class="btn cta-button btn-lg">Explore Features</a>
                </div>

            </div>
        </div>
    </section>

    <!-- Stats Section -->
    <section class="section-spacing">
        <div class="container">
            <div class="stats-section p-5 glass-card">
                <div class="row text-center">
                    <div class="col-md-3 col-6 mb-4">
                        <div class="stat-number">500+</div>
                        <p class="st">Active Courses</p>
                    </div>
                    <div class="col-md-3 col-6 mb-4">
                        <div class="stat-number">10K+</div>
                        <p  class="st">Happy Students</p>
                    </div>
                    <div class="col-md-3 col-6 mb-4">
                        <div class="stat-number">200+</div>
                        <p class="st">Expert Teachers</p>
                    </div>
                    <div class="col-md-3 col-6 mb-4">
                        <div class="stat-number">98%</div>
                        <p class="st">Satisfaction Rate</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Features Section -->
    <section id="features" class="section-spacing">
        <div class="container">
            <div class="text-center mb-5">
                <h2 class="fw-bold">Powerful Learning Features</h2>
                <p class="lead">Everything you need for an exceptional educational experience</p>
            </div>

            <div class="row g-4">
                <div class="col-md-4">
                    <div class="glass-card text-center p-4">
                        <div class="feature-icon">
                            <i class="fas fa-graduation-cap"></i>
                        </div>
                        <h4 class="mb-3">Interactive Courses</h4>
                        <p>Engage with multimedia content, quizzes, and interactive assignments that make learning enjoyable.</p>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="glass-card text-center p-4">
                        <div class="feature-icon">
                            <i class="fas fa-chalkboard-teacher"></i>
                        </div>
                        <h4 class="mb-3">Expert Instructors</h4>
                        <p>Learn from industry professionals and academic experts passionate about sharing their knowledge.</p>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="glass-card text-center p-4">
                        <div class="feature-icon">
                            <i class="fas fa-certificate"></i>
                        </div>
                        <h4 class="mb-3">Certification</h4>
                        <p>Earn recognized certificates upon completion to showcase your skills and knowledge.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Testimonials Section -->
    <section id="testimonials" class="section-spacing">
        <div class="container">
            <div class="text-center mb-5">
                <h2 class="fw-bold">What Our Students Say</h2>
                <p class="lead">Hear from our community of learners</p>
            </div>

            <div class="row">
                <div class="col-md-4 mb-4">
                    <div class="testimonial-card glass-card p-4">
                        <div class="d-flex mb-3">
                            <i class="fas fa-star text-warning"></i>
                            <i class="fas fa-star text-warning"></i>
                            <i class="fas fa-star text-warning"></i>
                            <i class="fas fa-star text-warning"></i>
                            <i class="fas fa-star text-warning"></i>
                        </div>
                        <p class="card-text">"Academia transformed my learning experience. The courses are engaging and the platform is intuitive."</p>
                        <div class="d-flex align-items-center mt-3">
                            <img src="https://randomuser.me/api/portraits/men/65.jpg" 
                                alt="User" class="rounded-circle me-3" width="50" height="50">
                            <div>
                                <h6 class="mb-0">Nazmul Islam</h6>
                                <small class="text-muted">Computer Science Student</small>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-md-4 mb-4">
                    <div class="testimonial-card glass-card p-4">
                        <div class="d-flex mb-3">
                            <i class="fas fa-star text-warning"></i>
                            <i class="fas fa-star text-warning"></i>
                            <i class="fas fa-star text-warning"></i>
                            <i class="fas fa-star text-warning"></i>
                            <i class="fas fa-star text-warning"></i>
                        </div>
                        <p class="card-text">"As a teacher, I find Academia's platform incredibly effective for delivering content and tracking student progress."</p>
                        <div class="d-flex align-items-center mt-3">
                            <img src="https://randomuser.me/api/portraits/men/7.jpg" 
                                alt="User" class="rounded-circle me-3" width="50" height="50">
                            <div>
                                <h6 class="mb-0">Mashukur Rahman</h6>
                                <small class="text-muted">Instructor</small>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-md-4 mb-4">
                    <div class="testimonial-card glass-card p-4">
                        <div class="d-flex mb-3">
                            <i class="fas fa-star text-warning"></i>
                            <i class="fas fa-star text-warning"></i>
                            <i class="fas fa-star text-warning"></i>
                            <i class="fas fa-star text-warning"></i>
                            <i class="fas fa-star text-warning"></i>
                        </div>
                        <p class="card-text">"The certification I earned through Academia helped me land my dream job. The courses are practical and relevant."</p>
                        <div class="d-flex align-items-center mt-3">
                            <img src="https://randomuser.me/api/portraits/men/22.jpg" 
                                alt="User" class="rounded-circle me-3" width="50" height="50">
                            <div>
                                <h6 class="mb-0">Rahul Hasan Ratul</h6>
                                <small class="text-muted">Business Analyst</small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- CTA Section -->
    <section class="section-spacing">
        <div class="container">
            <div class="glass-card p-5 text-center">
                <h2 class="fw-bold mb-4">Ready to Begin Your Learning Journey?</h2>
                <p class="lead mb-4">Join thousands of students expanding their knowledge with Academia</p>
                <a href="register.jsp" class="btn cta-button btn-lg">
                    <i class="fas fa-rocket me-2"></i>Start Learning Now
                </a>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer>
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <h3 class="fw-bold">Academia</h3>
                    <p>Transforming education through technology</p>
                </div>
                <div class="col-md-6 text-md-end">
                    <p>&copy; 2025 Academia. All rights reserved to Karypto Inc.</p>
                </div>
            </div>
        </div>
    </footer>

    <!-- Bootstrap & JavaScript -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Navbar background change on scroll
        window.addEventListener('scroll', function() {
            const navbar = document.querySelector('.navbar');
            if (window.scrollY > 50) {
                navbar.style.background = 'rgba(255, 255, 255, 0.95)';
                navbar.style.boxShadow = '0 4px 20px rgba(0, 0, 0, 0.1)';
            } else {
                navbar.style.background = 'rgba(255, 255, 255, 0.9)';
                navbar.style.boxShadow = 'none';
            }
        });

        // Smooth scrolling for anchor links
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                const target = document.querySelector(this.getAttribute('href'));
                if (target) {
                    target.scrollIntoView({
                        behavior: 'smooth',
                        block: 'start'
                    });
                }
            });
        });

        // Hello SVG control: reveal Academia title after svg anim completes, and replay periodically
        (function(){
            let svg = document.getElementById('helloSvg'); // reassignable now
            const title = document.getElementById('academiaTitle');
            const subtitle = document.getElementById('heroSub');
            const wrapper = document.getElementById('helloWrapper');

            // When the SVG animation ends, reveal the text
            svg.addEventListener('animationend', function(){
                title.classList.add('revealed');
                subtitle.classList.add('revealed');
            });

            // Function to restart the SVG animation cleanly
            function restartHello(){
                // hide title while replaying
                title.classList.remove('revealed');
                subtitle.classList.remove('revealed');

                // clone and replace the svg
                const clone = svg.cloneNode(true);
                svg.parentNode.replaceChild(clone, svg);

                // update svg reference
                svg = clone;

                // reattach listener to the new clone
                svg.addEventListener('animationend', function(){
                    title.classList.add('revealed');
                    subtitle.classList.add('revealed');
                });
            }

            // replay every 18 seconds
            let helloInterval = setInterval(restartHello, 18000);

            // replay on click/tap for users who want to see it again
            wrapper.addEventListener('click', function(){ restartHello(); });

            // Respect reduced motion preference
            if(window.matchMedia && window.matchMedia('(prefers-reduced-motion: reduce)').matches){
                // cancel animation and show text immediately
                clearInterval(helloInterval);
                const current = document.getElementById('helloSvg');
                if(current) current.style.animation = 'none';
                title.classList.add('revealed');
                subtitle.classList.add('revealed');
            }
        })();


    </script>
</body>
</html>