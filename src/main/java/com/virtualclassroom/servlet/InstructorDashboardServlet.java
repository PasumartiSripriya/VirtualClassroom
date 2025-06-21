package com.virtualclassroom.servlet;

import com.virtualclassroom.bean.Course;
import com.virtualclassroom.bean.User;
import com.virtualclassroom.dao.CourseDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/instructor/dashboard")
public class InstructorDashboardServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");
        String role = (String) session.getAttribute("role");

        System.out.println("Session role: " + role);
        System.out.println("User object: " + user);

        if (user == null || role == null || !"instructor".equalsIgnoreCase(role)) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        CourseDAO dao = new CourseDAO();
        List<Course> courses = dao.getAllCourses();

        request.setAttribute("courses", courses);
        request.getRequestDispatcher("/instructor-dashboard.jsp").forward(request, response);
    }
}

