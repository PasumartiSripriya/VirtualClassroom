package com.virtualclassroom.servlet;

import com.virtualclassroom.bean.Topic;
import com.virtualclassroom.bean.Course;
import com.virtualclassroom.dao.TopicDAO;
import com.virtualclassroom.dao.CourseDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/courseDetails")
public class CourseDetailsServlet extends HttpServlet {

    private TopicDAO topicDAO = new TopicDAO();
    private CourseDAO courseDAO = new CourseDAO(); // optional, if you want course details too

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Long courseId = Long.parseLong(request.getParameter("courseId"));

        List<Topic> topics = topicDAO.getTopicsByCourseId(courseId);
        Course course = courseDAO.getCourseById(courseId);

        request.setAttribute("topics", topics);
        request.setAttribute("course", course);

        request.getRequestDispatcher("topics.jsp").forward(request, response);
    }
}

