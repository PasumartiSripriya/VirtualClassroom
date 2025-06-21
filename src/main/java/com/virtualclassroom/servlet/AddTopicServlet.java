package com.virtualclassroom.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.virtualclassroom.bean.Topic;
import com.virtualclassroom.dao.TopicDAO;

@WebServlet("/instructor/AddTopicServlet")
public class AddTopicServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Long courseId = Long.parseLong(request.getParameter("courseId"));
        String title = request.getParameter("title");
        String desc = request.getParameter("description");
        String video = request.getParameter("videoUrl");

        // Fetch the Course object by ID
        com.virtualclassroom.dao.CourseDAO courseDAO = new com.virtualclassroom.dao.CourseDAO();
        com.virtualclassroom.bean.Course course = courseDAO.getCourseById(courseId);

        Topic topic = new Topic();
        topic.setCourse(course); // ✅ Correct way
        topic.setTitle(title);
        topic.setDescription(desc);
        topic.setVideoUrl(video);

        TopicDAO dao = new TopicDAO();
        dao.addTopic(topic);

        // Redirect back to course details
        response.sendRedirect("CourseDetailsServlet?courseId=" + courseId);
    }
}

