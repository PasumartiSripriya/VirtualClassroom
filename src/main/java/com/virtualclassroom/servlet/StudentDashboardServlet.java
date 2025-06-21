package com.virtualclassroom.servlet;

import com.virtualclassroom.bean.Course;
import com.virtualclassroom.bean.User;
import com.virtualclassroom.dao.CourseDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;
import java.util.Set;

@WebServlet("/studentdashboard")
public class StudentDashboardServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        User user = (User) session.getAttribute("user"); // ✅ correct key name


        // Redirect if not logged in or not a student
        if (user == null || !"student".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect("login.jsp");
            return;
        }

        CourseDAO courseDAO = new CourseDAO();

        // Fetch all available courses
        List<Course> courses = courseDAO.getAllCourses();

        // Fetch course IDs the student is enrolled in
        Set<Long> enrolledCourseIds = courseDAO.getEnrolledCourseIdsByStudentId(user.getId());

        // Check for enrollment success flag (if redirected back after enrollment)
        String enrollmentSuccess = request.getParameter("enrolled");
        String enrolledCourseIdParam = request.getParameter("courseId");

        if (enrollmentSuccess != null && "true".equals(enrollmentSuccess) && enrolledCourseIdParam != null) {
            try {
                Long enrolledCourseId = Long.parseLong(enrolledCourseIdParam);
                request.setAttribute("enrollmentSuccess", true);
                request.setAttribute("enrolledCourseId", enrolledCourseId);
            } catch (NumberFormatException e) {
                // Ignore invalid courseId
            }
        }

        // Set attributes for JSP
        request.setAttribute("courses", courses);
        request.setAttribute("enrolledCourseIds", enrolledCourseIds);

        // Forward to JSP
        request.getRequestDispatcher("student-dashboard.jsp").forward(request, response);
    }
}
