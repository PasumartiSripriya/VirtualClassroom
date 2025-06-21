package com.virtualclassroom.servlet;



import com.virtualclassroom.dao.CourseDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/instructor/DeleteCourseServlet")
public class DeleteCourseServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Long courseId = Long.parseLong(request.getParameter("courseId"));
        
        CourseDAO dao = new CourseDAO();
        dao.deleteCourse(courseId);
        
        // After deletion, reload the dashboard
        response.sendRedirect("dashboard");
    }
}

