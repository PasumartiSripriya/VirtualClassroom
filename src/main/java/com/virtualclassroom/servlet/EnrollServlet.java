package com.virtualclassroom.servlet;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.virtualclassroom.bean.Course;
import com.virtualclassroom.bean.Enrollment;
import com.virtualclassroom.bean.User;
import com.virtualclassroom.dao.CourseDAO;
import com.virtualclassroom.dao.EnrollmentDAO;

@WebServlet("/enroll")
public class EnrollServlet extends HttpServlet {
    private EnrollmentDAO enrollmentDAO = new EnrollmentDAO();
    private CourseDAO courseDAO = new CourseDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Long courseId = Long.parseLong(request.getParameter("courseId"));
        String startDateStr = request.getParameter("startDate");

        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user"); // ✅ Fixed key

        if (currentUser == null || !"student".equalsIgnoreCase(currentUser.getRole())) {
            response.sendRedirect("login.jsp");
            return;
        }

        boolean alreadyEnrolled = enrollmentDAO.isStudentEnrolledInCourse(currentUser.getId(), courseId);

        if (!alreadyEnrolled) {
            Enrollment enrollment = new Enrollment();
            Course course = new Course();
            course.setId(courseId);

            enrollment.setCourse(course);
            enrollment.setStudent(currentUser);
            enrollment.setCompleted(false);
            enrollment.setProgress(0);

            try {
                LocalDate startDate = LocalDate.parse(startDateStr, DateTimeFormatter.ISO_DATE);
                enrollment.setStartDate(startDate);
            } catch (Exception e) {
                e.printStackTrace();
            }

            enrollmentDAO.enrollStudent(enrollment);
        }

        List<Course> courses = courseDAO.getAllCourses();
        Set<Long> enrolledCourseIds = new HashSet<>(enrollmentDAO.getEnrolledCourseIdsByStudentId(currentUser.getId()));

        request.setAttribute("courses", courses);
        request.setAttribute("enrolledCourseIds", enrolledCourseIds);
        request.setAttribute("enrollmentSuccess", true);
        request.setAttribute("enrolledCourseId", courseId);

        request.getRequestDispatcher("student-dashboard.jsp").forward(request, response);
    }
}
