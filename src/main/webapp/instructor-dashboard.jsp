<%@ page import="java.util.*, com.virtualclassroom.bean.User, com.virtualclassroom.bean.Course" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"instructor".equalsIgnoreCase(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Instructor Dashboard</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f1f1f1;
            margin: 0;
            padding: 0;
        }

        header {
            background-color: #2c3e50;
            color: white;
            padding: 20px;
            text-align: center;
        }

        h1 {
            margin: 0;
        }

        .welcome {
            text-align: center;
            margin: 20px 0;
            font-size: 18px;
        }

        .dashboard-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            padding: 20px;
        }

        .course-card {
            background-color: white;
            border-radius: 10px;
            width: 300px;
            margin: 15px;
            padding: 20px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            text-align: center;
        }

        .course-card h3 {
            margin-top: 0;
        }

        .course-card p {
            color: #333;
            font-size: 14px;
        }

        .btn {
            display: inline-block;
            padding: 10px 15px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            text-decoration: none;
            margin-top: 10px;
        }

        .btn:hover {
            background-color: #0056b3;
        }

        .add-course-form {
            max-width: 500px;
            background: white;
            margin: 30px auto;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }

        .add-course-form input,
        .add-course-form textarea {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }

        .add-course-form button {
            padding: 10px 20px;
            background-color: #28a745;
            color: white;
            border: none;
            border-radius: 5px;
        }

        .add-course-form button:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>

<header>
    <h1>Instructor Dashboard</h1>
</header>

<div class="welcome">
    Welcome, ${user.username} (Instructor)
</div>

<!-- Add Course Form -->
<div class="add-course-form">
    <h3>Add New Course</h3>
    <form action="AddCourseServlet" method="post">
        <input type="text" name="title" placeholder="Course Title" required />
        <textarea name="description" placeholder="Course Description" required></textarea>
        <button type="submit">Add Course</button>
    </form>
</div>

<!-- Display Courses -->
<div class="dashboard-container">
    <c:forEach var="course" items="${courses}">
        <div class="course-card">
            <h3>${course.title}</h3>
            <p>${course.description}</p>
            <p><strong>Enrollments:</strong> ${course.enrollmentCount}</p>

            <form action="CourseDetailsServlet" method="get">
                <input type="hidden" name="courseId" value="${course.id}" />
                <button class="btn" type="submit">View Details</button>
            </form>

            <c:if test="${user.id == course.instructor.id}">
                <form action="DeleteCourseServlet" method="post" style="margin-top: 10px;">
                    <input type="hidden" name="courseId" value="${course.id}" />
                    <button class="btn" style="background-color: #dc3545;" type="submit" onclick="return confirm('Delete this course?')">Delete</button>
                </form>
            </c:if>
        </div>
    </c:forEach>
</div>

</body>
</html>
