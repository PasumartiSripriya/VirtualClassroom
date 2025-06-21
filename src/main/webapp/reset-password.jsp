<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    String token = request.getParameter("token");
    if (token == null || token.isEmpty()) {
%>
<html><body>
    <p style="color:red; text-align:center; margin-top: 50px;">Invalid or missing token.</p>
</body></html>
<%
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Reset Password - VirtualClassroom</title>
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

        .container {
            background-color: #fff;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.2);
            width: 380px;
        }

        .container h2 {
            text-align: center;
            margin-bottom: 25px;
            color: #333;
        }

        .container input[type="password"],
        .container input[type="submit"] {
            width: 100%;
            padding: 12px;
            margin-top: 12px;
            border: 1px solid #ccc;
            border-radius: 8px;
            box-sizing: border-box;
        }

        .container input[type="submit"] {
            background-color: #2575fc;
            color: white;
            font-weight: bold;
            cursor: pointer;
            transition: background 0.3s ease;
        }

        .container input[type="submit"]:hover {
            background-color: #1a5fdc;
        }

        .container p {
            text-align: center;
            margin: 10px 0;
        }

        .success {
            color: green;
        }

        .error {
            color: red;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Reset Your Password</h2>

    <c:if test="${not empty message}">
        <p class="success">${message}</p>
    </c:if>
    <c:if test="${not empty error}">
        <p class="error">${error}</p>
    </c:if>

    <form action="ResetPasswordServlet" method="post">
        <input type="hidden" name="token" value="<%= token %>" />
        <label>New Password:</label>
        <input type="password" name="newPassword" required />
        <label>Confirm Password:</label>
        <input type="password" name="confirmPassword" required />
        <input type="submit" value="Update Password" />
    </form>
</div>
</body>
</html>
