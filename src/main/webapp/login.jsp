<!DOCTYPE html>
<html>
<head>
    <title>Virtual Classroom Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', Arial, sans-serif;
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            height: 100vh;
            display: flex;
            flex-direction: column;
        }

        .navbar-custom {
            background-color: #ffffff;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            padding: 1rem 2rem;
            display: flex;
            align-items: center;
        }

        .navbar-brand {
            font-size: 1.8rem;
            font-weight: bold;
            color: #4a4a4a;
            text-decoration: none;
        }

        .main-content {
            flex: 1;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 2rem;
        }

        .welcome-text {
            max-width: 50%;
        }

        .welcome-text h1 {
            font-size: 3rem;
            font-weight: bold;
        }

        .login-box {
            background-color: white;
            padding: 50px;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
            width: 400px;
            color: #333;
        }

        .login-box h2 {
            text-align: center;
            margin-bottom: 24px;
            color: #333;
        }

        .login-box label {
            font-weight: bold;
            display: block;
            margin-bottom: 6px;
            color: #555;
        }

        .login-box input[type="text"],
        .login-box input[type="password"] {
            width: 100%;
            padding: 12px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 6px;
        }

        .login-box button {
            width: 100%;
            padding: 12px;
            background-color: #2575fc;
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 18px;
            cursor: pointer;
        }

        .login-box button:hover {
            background-color: #1a5fd2;
        }

        .register-link {
            margin-top: 15px;
            text-align: center;
        }

        .register-link a {
            color: #2575fc;
            text-decoration: none;
        }

        .register-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

    <!-- Header -->
    <header class="navbar-custom">
        <a href="#" class="navbar-brand">VirtualClassroom</a>
    </header>

    <!-- Main Content -->
    <div class="main-content">
        <div class="welcome-text">
            <h1>Welcome to VirtualClassroom</h1>
            <p>Empower your learning with interactive and engaging online courses. Login to continue your journey!</p>
        </div>

        <div class="login-box">
            <h2>Login</h2>
            <form action="login" method="post">
                <label>Username:</label>
                <input type="text" name="username" required>

                <label>Password:</label>
                <input type="password" name="password" required>
                <div style="text-align: right; margin-top: -15px; margin-bottom: 15px;">
        <a href="forgot-password.jsp" style="color: #2575fc; font-size: 14px;">Forgot Password?</a>
    </div>

                <button type="submit">Login</button>

                <div class="register-link">
                    <p>Don't have an account? <a href="register.jsp">Register here</a></p>
                </div>
            </form>
        </div>
    </div>
    
    

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
