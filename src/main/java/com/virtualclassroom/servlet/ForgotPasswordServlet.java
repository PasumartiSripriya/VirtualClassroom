package com.virtualclassroom.servlet;

import com.virtualclassroom.dao.UserDAO;
import com.virtualclassroom.util.EmailUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.UUID;

@WebServlet("/ForgotPasswordServlet")
public class ForgotPasswordServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String email = request.getParameter("email");

        if (UserDAO.emailExists(email)) {
            String token = UUID.randomUUID().toString();
            UserDAO.saveResetToken(email, token);
            
            String resetLink = "http://localhost:9091/VirtualClassroom/reset-password.jsp?token=" + token;
            String subject = "Password Reset Request";
            String message = "Click the link below to reset your password:\n" + resetLink;
            
            EmailUtil.sendEmail(email, subject, message);
        }

        response.sendRedirect("forgot-password.jsp?message=If the email is valid, a link has been sent.");
    }
}
