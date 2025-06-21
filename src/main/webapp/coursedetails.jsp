<%@ page import="java.util.*, com.virtualclassroom.bean.Course, com.virtualclassroom.bean.Topic, com.virtualclassroom.bean.User" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    Course course = (Course) request.getAttribute("course");
    List<Topic> topics = (List<Topic>) request.getAttribute("topics");
    User user = (User) session.getAttribute("user");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Course Details - ${course.title}</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 20px;
        }

        h2 {
            text-align: center;
            font-size: 32px;
            margin-bottom: 10px;
        }

        .course-info {
            background: white;
            padding: 20px;
            border-radius: 10px;
            margin: 20px auto;
            max-width: 1000px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .add-topic-form {
            background: #ffffff;
            padding: 20px;
            border-radius: 10px;
            max-width: 1000px;
            margin: 20px auto;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .add-topic-form input[type="text"],
        .add-topic-form textarea {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 14px;
        }

        .add-topic-form button {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 8px;
            cursor: pointer;
            font-weight: bold;
        }

        .add-topic-form button:hover {
            background-color: #0056b3;
        }

        .topic-list {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 20px;
            max-width: 1000px;
            margin: 0 auto 30px;
        }

        .topic-card {
            background: #e9f2ff;
            border-radius: 12px;
            padding: 20px;
            width: 300px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
            position: relative;
        }

        .topic-card strong {
            font-size: 18px;
            color: #004085;
        }

        .topic-card p {
            font-size: 14px;
            color: #333;
            margin-top: 10px;
        }

        .video-link {
            display: inline-block;
            margin-top: 10px;
            color: white;
            background-color: #007bff;
            padding: 8px 12px;
            text-decoration: none;
            border-radius: 6px;
        }

        .video-link:hover {
            background-color: #0056b3;
        }

        .delete-button {
            background-color: #dc3545;
            border: none;
            color: white;
            padding: 8px 16px;
            border-radius: 6px;
            margin: 20px auto;
            display: block;
            font-weight: bold;
            cursor: pointer;
        }

        .delete-button:hover {
            background-color: #c82333;
        }

        .checkbox-container {
            position: absolute;
            top: 15px;
            right: 15px;
        }
    </style>
</head>
<body>

<h2>${course.title} - Topics</h2>

<div class="course-info">
    <p><strong>Description:</strong> ${course.description}</p>
    <p><strong>Category:</strong> ${course.category}</p>
    <p><strong>Total Enrollments:</strong> ${course.enrollmentCount}</p>
</div>

<!-- ✅ Show Add Topic Form only if the logged-in instructor is the creator -->
<c:if test="${course.instructor.id == user.id}">
    <div class="add-topic-form">
        <h3>Add New Topic</h3>
        <form action="AddTopicServlet" method="post">
            <input type="hidden" name="courseId" value="${course.id}" />
            <input type="text" name="title" placeholder="Topic Title" required />
            <textarea name="description" placeholder="Topic Description" required></textarea>
            <input type="text" name="videoUrl" placeholder="YouTube Video URL" required />
            <button type="submit">Add Topic</button>
        </form>
    </div>
</c:if>

<!-- ✅ If the instructor is the course creator, show checkboxes and delete -->
<c:if test="${course.instructor.id == user.id}">
    <form action="DeleteTopicsServlet" method="post">
        <input type="hidden" name="courseId" value="${course.id}" />
        <div class="topic-list">
            <c:forEach var="topic" items="${topics}">
                <div class="topic-card">
                    <div class="checkbox-container">
                        <input type="checkbox" name="topicIds" value="${topic.id}" />
                    </div>
                    <strong>${topic.title}</strong>
                    <p>${topic.description}</p>
                    <a class="video-link" href="${topic.videoUrl}" target="_blank">Watch</a>
                </div>
            </c:forEach>
        </div>
        <button class="delete-button" type="submit" onclick="return confirm('Delete selected topics?')">Delete Selected Topics</button>
    </form>
</c:if>

<!-- ❌ For other instructors: show topic list without any checkboxes or delete buttons -->
<c:if test="${course.instructor.id != user.id}">
    <div class="topic-list">
        <c:forEach var="topic" items="${topics}">
            <div class="topic-card">
                <strong>${topic.title}</strong>
                <p>${topic.description}</p>
                <a class="video-link" href="${topic.videoUrl}" target="_blank">Watch</a>
            </div>
        </c:forEach>
    </div>
</c:if>

</body>
</html>
