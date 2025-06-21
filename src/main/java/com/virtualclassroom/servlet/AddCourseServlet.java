package com.virtualclassroom.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.virtualclassroom.bean.Course;
import com.virtualclassroom.bean.User;
import com.virtualclassroom.dao.CourseDAO;

@WebServlet("/instructor/AddCourseServlet")
public class AddCourseServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String title = request.getParameter("title");
        String description = request.getParameter("description");

        HttpSession session = request.getSession();
        User instructor = (User) session.getAttribute("user");

        Course course = new Course();
        course.setTitle(title);
        course.setDescription(description);
        course.setCategory("Programming"); // optional: set default or get from form
        course.setInstructor(instructor);

        CourseDAO dao = new CourseDAO();
        dao.addCourse(course);

        response.sendRedirect("dashboard"); // reload dashboard with new course
    }
}

