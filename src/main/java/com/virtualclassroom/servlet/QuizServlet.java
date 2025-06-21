package com.virtualclassroom.servlet;

import com.virtualclassroom.bean.Quiz;
import com.virtualclassroom.dao.QuizDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.*;

@WebServlet("/QuizServlet")
public class QuizServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Long topicId = Long.parseLong(request.getParameter("topicId"));
        String courseId = request.getParameter("courseId");
        HttpSession session = request.getSession();

        List<Quiz> quizList = QuizDAO.getQuizzesByTopicId(topicId);
        if (quizList == null || quizList.isEmpty()) {
            request.setAttribute("message", "No quiz found.");
            request.getRequestDispatcher("quiz.jsp").forward(request, response);
            return;
        }

        Boolean quizStarted = (Boolean) session.getAttribute("quizStarted");
        Integer currentIndex = (Integer) session.getAttribute("currentIndex");
        Map<Long, String> answers = (Map<Long, String>) session.getAttribute("answers");
        Integer timeLeft = (Integer) session.getAttribute("timeLeft");

        if (quizStarted == null || !quizStarted) {
            request.setAttribute("quizStarted", false);
        } else {
            if (currentIndex == null) currentIndex = 0;
            if (answers == null) answers = new HashMap<>();
            if (timeLeft == null) timeLeft = 600;

            request.setAttribute("quizStarted", true);
            request.setAttribute("currentQuestion", quizList.get(currentIndex));
            request.setAttribute("currentIndex", currentIndex);
            request.setAttribute("answers", answers);
            request.setAttribute("timeLeft", timeLeft);
        }

        request.setAttribute("quizList", quizList);
        request.setAttribute("topicId", topicId);
        request.setAttribute("courseId", courseId);

        request.getRequestDispatcher("quiz.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Long topicId = Long.parseLong(request.getParameter("topicId"));
        String courseId = request.getParameter("courseId");

        List<Quiz> quizList = QuizDAO.getQuizzesByTopicId(topicId);
        if (quizList == null) quizList = new ArrayList<>();

        if (request.getParameter("startQuiz") != null) {
            session.setAttribute("quizStarted", true);
            session.setAttribute("answers", new HashMap<Long, String>());
            session.setAttribute("currentIndex", 0);
            session.setAttribute("timeLeft", 600);
            response.sendRedirect("QuizServlet?topicId=" + topicId + "&courseId=" + courseId);
            return;
        }

        Integer timeLeft = Integer.parseInt(request.getParameter("timeLeft"));
        session.setAttribute("timeLeft", timeLeft);

        Map<Long, String> answers = (Map<Long, String>) session.getAttribute("answers");
        if (answers == null) answers = new HashMap<>();

        String questionIdStr = request.getParameter("questionId");
        String selectedAnswer = request.getParameter("answer");
        Integer currentIndex = Integer.parseInt(request.getParameter("currentIndex"));

        if (questionIdStr != null && selectedAnswer != null) {
            answers.put(Long.parseLong(questionIdStr), selectedAnswer);
        }

        session.setAttribute("answers", answers);

        if (request.getParameter("submit") != null) {
            int score = 0;
            for (Quiz q : quizList) {
                String userAnswer = answers.get(q.getId());
                if (userAnswer != null && userAnswer.equalsIgnoreCase(q.getCorrectAnswer())) {
                    score++;
                }
            }

            session.removeAttribute("quizStarted");
            session.removeAttribute("answers");
            session.removeAttribute("currentIndex");
            session.removeAttribute("timeLeft");

            request.setAttribute("score", score);
            request.setAttribute("total", quizList.size());
            request.setAttribute("topicId", topicId);
            request.setAttribute("courseId", courseId);
            request.getRequestDispatcher("quiz.jsp").forward(request, response);
            return;
        }

        if (request.getParameter("navigateTo") != null) {
            session.setAttribute("currentIndex", Integer.parseInt(request.getParameter("navigateTo")));
        } else {
            session.setAttribute("currentIndex", currentIndex + 1);
        }

        response.sendRedirect("QuizServlet?topicId=" + topicId + "&courseId=" + courseId);
    }
}
