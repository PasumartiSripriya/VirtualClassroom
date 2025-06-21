<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Register - VirtualClassroom</title>
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(to right, #6a11cb, #2575fc);
            color: white;
        }

        .header {
            padding: 20px 40px;
            font-size: 28px;
            font-weight: bold;
            background-color: white;
            color: #333;
        }

        .container {
            position: relative;
            height: calc(100vh - 70px);
            display: flex;
            align-items: center;
            padding: 0 50px;
        }

        .welcome-text {
            flex: 1;
            max-width: 600px;
        }

        .welcome-text h1 {
            font-size: 42px;
            margin-bottom: 10px;
        }

        .welcome-text p {
            font-size: 18px;
            max-width: 500px;
        }

       .form-dialog {
    position: absolute;
    right: 40px;
    top: 50%; /* Optional: center vertically */
    transform: translateY(-50%); /* Optional: center vertically */
    background-color: white;
    color: #333;
    padding: 15px; /* Reduced from 30px */
    border-radius: 12px;
    width: 100%;
    max-width: 400px; /* Also slightly reduced width */
    box-shadow: 0 10px 20px rgba(0, 0, 0, 0.15);
    font-size: 14px;
}

/* Additional tweaks to inputs and buttons inside */
.form-dialog input,
.form-dialog button {
    padding: 8px 10px; /* Reduced input/button height */
    font-size: 14px;
    margin-bottom: 10px;
}
       
        

        .form-dialog h2 {
            text-align: center;
            margin-bottom: 20px;
        }

        label {
            font-weight: bold;
            display: block;
            margin-top: 12px;
        }

        input, select {
    width: 350px;
    padding: 12px;
    margin: 6px auto 16px auto;
    border: 1px solid #ccc;
    border-radius: 6px;
    display: block;
}
        
        button {
            width: 100%;
            background-color: #007bff;
            color: white;
            border: none;
            padding: 12px;
            font-size: 16px;
            border-radius: 6px;
            cursor: pointer;
        }

        button:hover {
            background-color: #0056b3;
        }

        .form-footer {
            text-align: center;
            margin-top: 20px;
            font-size: 14px;
        }

        .form-footer a {
            color: #007bff;
            text-decoration: none;
        }

        .form-footer a:hover {
            text-decoration: underline;
        }

        .success-message, .error-message {
            padding: 12px;
            text-align: center;
            border-radius: 6px;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .success-message {
            color: #155724;
            background-color: #d4edda;
            border: 1px solid #c3e6cb;
        }

        .error-message {
            color: #721c24;
            background-color: #f8d7da;
            border: 1px solid #f5c6cb;
        }
    </style>
</head>
<body>

<div class="header">
    VirtualClassroom
</div>

<div class="container">
    <div class="welcome-text">
        <h1>Welcome to VirtualClassroom</h1>
        <p>Empower your learning with interactive and engaging online courses. Register to start your journey!</p>
    </div>

    <div class="form-dialog">
        <h2>Register</h2>
        <form action="RegisterServlet" method="post">
            <label>Email</label>
            <input type="email" name="email" required>

            <label>Username</label>
            <input type="text" name="username" required>

            <label>Password</label>
            <input type="password" name="password" required>

            <label>Role</label>
            <select name="role">
                <option value="STUDENT">Student</option>
                <option value="INSTRUCTOR">Instructor</option>
            </select>

            <button type="submit">Register</button>
        </form>

        <c:if test="${not empty successMessage}">
            <div class="success-message">
                ${successMessage}
                <a href="login.jsp">Click here to login</a>
            </div>
        </c:if>

        <c:if test="${not empty error}">
            <div class="error-message">
                ${error}
            </div>
        </c:if>

        <div class="form-footer">
            Already have an account? <a href="login.jsp">Login here</a>
        </div>
    </div>
</div>

</body>
</html>
