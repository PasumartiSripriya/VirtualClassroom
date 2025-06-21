package com.virtualclassroom.servlet;

import com.virtualclassroom.bean.User;
import com.virtualclassroom.dao.UserDAO;
import com.virtualclassroom.util.PasswordUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String inputPassword = request.getParameter("password");

        UserDAO userDAO = new UserDAO();
        User user = userDAO.getUserByUsername(username);

        if (user != null) {
            String storedHashedPassword = user.getPassword();

            if (PasswordUtil.checkPassword(inputPassword, storedHashedPassword)) {
                HttpSession session = request.getSession();
                session.setAttribute("user", user); // ✅ Standardized here
                session.setAttribute("role", user.getRole().toLowerCase());

                System.out.println("Login success for: " + user.getEmail());
                System.out.println("Role: " + user.getRole());

                if ("student".equalsIgnoreCase(user.getRole())) {
                    response.sendRedirect("studentdashboard");
                } else if ("instructor".equalsIgnoreCase(user.getRole())) {
                    response.sendRedirect("instructor/dashboard");
                } else {
                    response.sendRedirect("login.jsp?error=Unknown+role");
                }
                return;
            }
        }

        request.setAttribute("error", "Invalid credentials!");
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }
}
