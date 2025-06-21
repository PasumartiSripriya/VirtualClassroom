package com.virtualclassroom.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.virtualclassroom.dao.TopicDAO;

@WebServlet("/instructor/DeleteTopicsServlet")
public class DeleteTopicsServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String[] topicIds = request.getParameterValues("topicIds");
        int courseId = Integer.parseInt(request.getParameter("courseId"));

        if (topicIds != null) {
            TopicDAO dao = new TopicDAO();
            for (String id : topicIds) {
                dao.deleteTopicById(Integer.parseInt(id));
            }
        }
        response.sendRedirect("CourseDetailsServlet?courseId=" + courseId);
    }
}

