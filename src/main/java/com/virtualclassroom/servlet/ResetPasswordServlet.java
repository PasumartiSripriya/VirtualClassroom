package com.virtualclassroom.servlet;

import com.virtualclassroom.dao.UserDAO;
import com.virtualclassroom.util.PasswordUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/ResetPasswordServlet")
public class ResetPasswordServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String token = request.getParameter("token");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        if (token == null || token.trim().isEmpty()) {
            request.setAttribute("error", "Invalid token.");
            request.getRequestDispatcher("reset-password.jsp").forward(request, response);
            return;
        }

        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match.");
            request.setAttribute("token", token); // keep token in the form
            request.getRequestDispatcher("reset-password.jsp").forward(request, response);
            return;
        }

        if (newPassword.length() < 6) {
            request.setAttribute("error", "Password must be at least 6 characters long.");
            request.setAttribute("token", token);
            request.getRequestDispatcher("reset-password.jsp").forward(request, response);
            return;
        }

        // Get email by token from DB
        UserDAO userDAO = new UserDAO();
        String email = userDAO.getEmailByToken(token);
        if (email == null) {
            request.setAttribute("error", "Token is expired or invalid.");
            request.getRequestDispatcher("reset-password.jsp").forward(request, response);
            return;
        }

        // Hash the password
        String hashedPassword = PasswordUtil.hashPassword(newPassword);

        // Update password in DB
        boolean success = userDAO.updatePassword(email, hashedPassword);
        if (success) {
            userDAO.deleteResetToken(token); // invalidate the token after use
            request.setAttribute("message", "Password reset successful! Please login.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Something went wrong. Please try again.");
            request.setAttribute("token", token);
            request.getRequestDispatcher("reset-password.jsp").forward(request, response);
        }
    }
}
