package com.virtualclassroom.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.virtualclassroom.bean.Course;
import com.virtualclassroom.bean.Topic;
import com.virtualclassroom.dao.CourseDAO;

@WebServlet("/instructor/CourseDetailsServlet")
	public class InstructorCourseDetailsServlet extends HttpServlet {
	    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    	Long courseId = Long.parseLong(request.getParameter("courseId"));


	        CourseDAO courseDAO = new CourseDAO();
	        Course course = courseDAO.getCourseById(courseId); // includes instructor info
	        List<Topic> topics = courseDAO.getTopicsByCourseId(courseId); // custom method

	        request.setAttribute("course", course);
	        request.setAttribute("topics", topics);
	        request.getRequestDispatcher("/coursedetails.jsp").forward(request, response);

	    }
	}



