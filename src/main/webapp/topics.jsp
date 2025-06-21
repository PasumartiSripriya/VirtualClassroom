<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.virtualclassroom.bean.Course" %>
<%@ page import="com.virtualclassroom.bean.Topic" %>
<%@ page import="java.util.List" %>

<%
    Course course = (Course) request.getAttribute("course");
    List<Topic> topics = (List<Topic>) request.getAttribute("topics");
%>

<!DOCTYPE html>
<html>
<head>
    <title><%= course.getTitle() %> - Topics</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        html, body {
            margin: 0;
            padding: 0;
            height: 100%;
            font-family: 'Segoe UI', sans-serif;
            background-color: #f5f5f5;
            color: #333;
        }

        .top-bar {
            background-color: #e0f0ff; /* Light blue background */
            text-align: center;
            padding: 0.5rem;
            font-weight: 500;
            color: #007bff; /* Blue text */
            font-size: 0.95rem; /* Reduced size */
        }

        .navbar {
            background-color: #343a40;
            padding: 1rem 2rem;
        }

        .navbar-brand {
            font-size: 1.5rem;
            font-weight: bold;
            color: white;
            text-decoration: none;
        }

        .header-section {
            display: flex;
            flex-wrap: wrap;
            align-items: center;
            padding: 2rem;
            background-color: #ffffff;
            color: #333;
            border-bottom: 1px solid #ddd;
        }

        .course-info {
            flex: 1 1 300px;
            padding-right: 1rem;
        }

        .course-info h2 {
            font-size: 2.2rem;
            font-weight: 700; /* Bold */
            color: #212529;
        }

        .header-image {
            flex: 1 1 500px;
            background: url('https://media.istockphoto.com/id/939787416/photo/two-female-programmers-working-on-new-project-they-working-late-at-night-at-the-office.jpg?s=612x612&w=0&k=20&c=QfNngcOWfyX2ZFWk6XP4wXzlMSF0xDEA34Vyc9fuWms=') no-repeat center center;
            background-size: cover;
            height: 300px;
            border-radius: 10px;
        }

        .card {
            border: none;
            background-color: #eaf4ff; /* Light blue-gray for contrast */
            color: #333;
            transition: transform 0.3s;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            border-radius: 10px;
        }

        .card:hover {
            transform: scale(1.03);
        }

        .card-title {
            color: #0d6efd; /* Deep blue for topic titles */
            font-size: 1.4rem;
            font-weight: 600;
        }

        .btn-watch-quiz {
            background-color: #0d6efd; /* Same blue for both buttons */
            border: none;
            color: white;
        }

        .btn-watch-quiz:hover {
            background-color: #0b5ed7;
        }

        footer {
            background-color: #343a40;
            padding: 1rem;
            color: #ccc;
            text-align: center;
            margin-top: 2rem;
        }

        footer hr {
            border-color: #666;
        }
    </style>
</head>
<body>
    <!-- Top Bar Message -->
    <div class="top-bar">
        Ready to boost your skills? Join the best courses now!
    </div>

    <!-- Simplified Navbar -->
    <nav class="navbar">
        <a class="navbar-brand" href="#">VirtualClassroom</a>
    </nav>

    <!-- Header Section with Title and Image -->
    <div class="header-section">
        <div class="course-info">
            <h2><%= course.getTitle() %> - Topics</h2>
            <p><%= course.getDescription() %></p>
        </div>
        <div class="header-image"></div>
    </div>

    <!-- Topic Cards Section -->
    <div class="container my-4">
        <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4">
            <%
                if (topics != null && !topics.isEmpty()) {
                    for (Topic topic : topics) {
            %>
                <div class="col">
                    <div class="card h-100">
                        <div class="card-body d-flex flex-column">
                            <h5 class="card-title"><%= topic.getTitle() %></h5>
                            <p class="card-text flex-grow-1"><%= topic.getDescription() %></p>
                            <div class="d-flex gap-2 mt-3">
                                <a href="<%= topic.getVideoUrl() %>" target="_blank" class="btn btn-watch-quiz w-50">🎥 Watch</a>
                                <form action="QuizServlet" method="get" class="w-50">
                                    <input type="hidden" name="topicId" value="<%= topic.getId() %>">
                                    <button type="submit" class="btn btn-watch-quiz w-100">📝 Quiz</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            <%
                    }
                } else {
            %>
                <p class="text-dark">No topics available for this course yet.</p>
            <%
                }
            %>
        </div>
    </div>

    <!-- Footer -->
    <footer>
        <hr>
        <p><em>"Code is like humor. When you have to explain it, it’s bad." – Cory House</em></p>
        <p>Happy Learning! 💻📚</p>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
