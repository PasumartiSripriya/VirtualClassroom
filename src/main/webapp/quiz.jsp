<%@ page import="java.util.*, com.virtualclassroom.bean.Quiz" %>
<%
    Boolean quizStarted = (Boolean) request.getAttribute("quizStarted");
    List<Quiz> quizList = (List<Quiz>) request.getAttribute("quizList");
    Quiz currentQuestion = (Quiz) request.getAttribute("currentQuestion");
    Integer currentIndex = (Integer) request.getAttribute("currentIndex");
    Map<Long, String> answers = (Map<Long, String>) request.getAttribute("answers");
    Integer score = (Integer) request.getAttribute("score");
    Integer total = (Integer) request.getAttribute("total");
    Long topicId = (Long) request.getAttribute("topicId");
    String courseId = (String) request.getAttribute("courseId");
    Integer timeLeft = (Integer) request.getAttribute("timeLeft");
    if (timeLeft == null) timeLeft = 600;
%>
<!DOCTYPE html>
<html>
<head>
    <title>Quiz Page</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #eef2f7;
        }
        .container {
            display: flex;
            height: 100vh;
        }
        .left-panel {
            width: 70%;
            padding: 20px;
            box-sizing: border-box;
            border-right: 1px solid #ccc;
            background-color: #ffffff;
            overflow-y: auto;
        }
        .right-panel {
            width: 30%;
            padding: 20px;
            box-sizing: border-box;
            background-color: #f3f3f3;
            overflow-y: auto;
        }
        .question-number {
            margin: 5px;
            padding: 10px;
            background-color: #eee;
            border: none;
            cursor: pointer;
            border-radius: 5px;
        }
        .active {
            background-color: #4CAF50 !important;
            color: white;
        }
        #timer {
            font-size: 20px;
            font-weight: bold;
            margin: 15px;
            text-align: center;
            color: red;
        }
        button {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 8px;
            margin-top: 10px;
            cursor: pointer;
            font-weight: bold;
        }
        button:hover {
            background-color: #45a049;
        }
        .question-container {
            background-color: #f9f9f9;
            padding: 15px;
            border-radius: 10px;
            margin-bottom: 10px;
        }
        label {
            display: block;
            margin-bottom: 8px;
        }
    </style>
    <script>
        let totalTime = <%= timeLeft %>;
        let timerInterval;

        function startTimer() {
            timerInterval = setInterval(function () {
                let minutes = Math.floor(totalTime / 60);
                let seconds = totalTime % 60;
                document.getElementById("timer").innerText =
                    minutes.toString().padStart(2, '0') + ":" + seconds.toString().padStart(2, '0');
                totalTime--;
                if (totalTime < 0) {
                    clearInterval(timerInterval);
                    document.getElementById("quizForm").submit();
                }
            }, 1000);
        }

        function launchConfetti() {
            const script = document.createElement("script");
            script.src = "https://cdn.jsdelivr.net/npm/canvas-confetti@1.5.1/dist/confetti.browser.min.js";
            script.onload = function () {
                const canvas = document.createElement("canvas");
                canvas.style.position = "fixed";
                canvas.style.top = 0;
                canvas.style.left = 0;
                canvas.style.width = "100%";
                canvas.style.height = "100%";
                canvas.style.pointerEvents = "none";
                canvas.style.zIndex = 9999;
                document.body.appendChild(canvas);

                const myConfetti = confetti.create(canvas, { resize: true });
                myConfetti({ particleCount: 200, spread: 70, origin: { y: 0.6 } });

                setTimeout(() => canvas.remove(), 3000);
            };
            document.body.appendChild(script);
        }

        document.addEventListener("DOMContentLoaded", function () {
            const form = document.getElementById("quizForm");
            if (form) {
                form.addEventListener("submit", function () {
                    document.getElementById("timeLeftInput").value = totalTime;
                });
            }
        });
    </script>
</head>

<body onload="<% if (quizStarted != null && quizStarted && score == null && currentQuestion != null) { %>startTimer();<% } else if (score != null && score == total) { %>launchConfetti();<% } %>">
<h2 style="text-align: center;">Online Quiz</h2>

<% if (score != null) { %>
    <h3 style="text-align:center;">Your Score: <%= score %> / <%= total %></h3>
    <div style="text-align:center;">
        <form action="TopicsServlet" method="get">
            <input type="hidden" name="courseId" value="<%= courseId %>"/>
            <button type="submit">Back to Topics</button>
        </form>
    </div>

<% } else if (quizStarted == null || !quizStarted) { %>
    <div class="container">
        <div class="left-panel">
            <h3>Instructions</h3>
            <ul>
                <li>You have 10 minutes to complete the quiz.</li>
                <li>Each question carries 1 mark.</li>
                <li>Questions can be navigated using the panel on the right.</li>
            </ul>
            <form method="post" action="QuizServlet">
                <input type="hidden" name="startQuiz" value="true"/>
                <input type="hidden" name="topicId" value="<%= topicId %>"/>
                <input type="hidden" name="courseId" value="<%= courseId %>"/>
                <button type="submit">Start Quiz</button>
            </form>
        </div>
    </div>

<% } else if (currentQuestion != null) { %>
    <div id="timer">10:00</div>
    <div class="container">
        <div class="left-panel">
            <form method="post" action="QuizServlet" id="quizForm">
                <input type="hidden" name="topicId" value="<%= topicId %>"/>
                <input type="hidden" name="courseId" value="<%= courseId %>"/>
                <input type="hidden" name="questionId" value="<%= currentQuestion.getId() %>"/>
                <input type="hidden" name="currentIndex" value="<%= currentIndex %>"/>
                <input type="hidden" name="timeLeft" id="timeLeftInput"/>

                <div class="question-container">
                    <h4>Q<%= (currentIndex + 1) %>: <%= currentQuestion.getQuestion() %></h4>
                    <% String[] options = {
                            currentQuestion.getOptionA(),
                            currentQuestion.getOptionB(),
                            currentQuestion.getOptionC(),
                            currentQuestion.getOptionD()
                        };
                        for (int i = 0; i < options.length; i++) {
                            String opt = options[i];
                            String value = opt.substring(0, 1);
                            boolean checked = answers != null && value.equalsIgnoreCase(answers.get(currentQuestion.getId()));
                    %>
                        <label>
                            <input type="radio" name="answer" value="<%= value %>" <%= (checked ? "checked" : "") %>/> <%= opt %>
                        </label>
                    <% } %>
                </div>

                <% if (currentIndex == quizList.size() - 1) { %>
                    <button type="submit" name="submit">Submit Quiz</button>
                <% } else { %>
                    <button type="submit">Next</button>
                <% } %>
            </form>
        </div>

        <div class="right-panel">
            <form method="post" action="QuizServlet">
                <input type="hidden" name="topicId" value="<%= topicId %>"/>
                <input type="hidden" name="courseId" value="<%= courseId %>"/>
                <h4>Questions</h4>
                <% for (int i = 0; i < quizList.size(); i++) { %>
                    <button type="submit" name="navigateTo" value="<%= i %>" class="question-number <%= (i == currentIndex ? "active" : "") %>">
                        <%= (i + 1) %>
                    </button>
                <% } %>
            </form>
        </div>
    </div>
<% } %>

</body>
</html>
