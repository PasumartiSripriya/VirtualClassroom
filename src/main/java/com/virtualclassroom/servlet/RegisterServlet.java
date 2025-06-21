package com.virtualclassroom.servlet;

import com.virtualclassroom.bean.User;
import com.virtualclassroom.util.JPAUtil;
import com.virtualclassroom.util.PasswordUtil;

import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {

        String email = request.getParameter("email");
        String username = request.getParameter("username");
        String plainPassword = request.getParameter("password");
        String role = request.getParameter("role");

        String hashedPassword = PasswordUtil.hashPassword(plainPassword);

        User user = new User();
        user.setEmail(email);
        user.setUsername(username);
        user.setPassword(hashedPassword);
        user.setRole(role.toUpperCase());

        EntityManager em = JPAUtil.getEntityManagerFactory().createEntityManager();
        EntityTransaction transaction = em.getTransaction();

        try {
            transaction.begin();
            em.persist(user);
            transaction.commit();

            request.setAttribute("successMessage", "Registered Successfully!!");
            request.getRequestDispatcher("register.jsp").forward(request, response);

        } catch (Exception e) {
            transaction.rollback();
            request.setAttribute("error", "Registration failed: " + e.getMessage());
            request.getRequestDispatcher("register.jsp").forward(request, response);
        } finally {
            em.close();
        }
    }
}
