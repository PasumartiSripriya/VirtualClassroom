<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Forgot Password - VirtualClassroom</title>
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(to right, #6a11cb, #2575fc);
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
            color: #333;
        }

        .form-container {
            background-color: #fff;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.2);
            width: 400px;
        }

        h2 {
            text-align: center;
            margin-bottom: 25px;
        }

        label {
            font-weight: 500;
        }

        input[type="email"],
        input[type="submit"] {
            width: 100%;
            padding: 12px;
            margin-top: 10px;
            margin-bottom: 15px;
            border-radius: 8px;
            border: 1px solid #ccc;
            box-sizing: border-box;
        }

        input[type="submit"] {
            background-color: #2575fc;
            color: white;
            font-weight: bold;
            cursor: pointer;
            transition: background 0.3s ease;
        }

        input[type="submit"]:hover {
            background-color: #1a5fdc;
        }

        .message {
            color: green;
            font-weight: bold;
            text-align: center;
            margin-bottom: 15px;
        }

        .debug-link {
            margin-top: 10px;
            font-size: 14px;
            word-break: break-all;
            text-align: center;
        }

        .debug-link a {
            color: #2575fc;
            text-decoration: none;
        }

        .debug-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<div class="form-container">
    <h2>Forgot Password</h2>

    <!-- Success message display -->
    <%
        String message = request.getParameter("message");
        if (message != null) {
    %>
        <div class="message"><%= message %></div>
    <%
        }
    %>

    <form action="ForgotPasswordServlet" method="post">
        <label>Enter your registered email:</label>
        <input type="email" name="email" required>
        <input type="submit" value="Send Reset Link">
    </form>

    <!-- Optional: Debug Link for Testing -->
    <%
        String debugLink = (String) session.getAttribute("resetDebugLink");
        if (debugLink != null) {
    %>
        <div class="debug-link">
            <strong>Debug Reset Link:</strong><br>
            <a href="<%= debugLink %>"><%= debugLink %></a>
        </div>
    <%
            session.removeAttribute("resetDebugLink");
        }
    %>
</div>

</body>
</html>
