<%@ page import="com.virtualclassroom.bean.User" %>
<%@ page import="com.virtualclassroom.bean.Course" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.*" %>
<%@ page import="java.util.Set" %>

<%
    User user = (User) session.getAttribute("user");
  
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<Course> courses = (List<Course>) request.getAttribute("courses");
    Set<Long> enrolledCourseIds = (Set<Long>) request.getAttribute("enrolledCourseIds");

    Long enrolledCourseId = (Long) request.getAttribute("enrolledCourseId");
    Boolean enrollmentSuccess = (Boolean) request.getAttribute("enrollmentSuccess");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Student Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        header {
            background-color: #343a40;
            color: white;
            padding: 1rem;
            text-align: center;
        }

        .welcome {
            text-align: center;
            margin-top: 1rem;
            font-size: 1.2rem;
        }

        .container {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
            padding: 2rem;
        }

        .card {
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            overflow: hidden;
            transition: transform 0.2s;
        }

        .card:hover {
            transform: scale(1.02);
        }

        .card img {
            width: 100%;
            height: 150px;
            object-fit: cover;
            background-color: #ddd;
        }

        .card-body {
            padding: 1rem;
        }

        .card-title {
            font-weight: bold;
            font-size: 1.1rem;
            margin-bottom: 0.5rem;
        }

        .card-text {
            font-size: 0.9rem;
            color: #555;
            margin-bottom: 0.5rem;
        }

        .btn-group {
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
        }

        .btn {
            padding: 0.5rem 1rem;
            border: none;
            border-radius: 5px;
            font-weight: bold;
            cursor: pointer;
            text-align: center;
        }

        .btn-enroll {
            background-color: #28a745;
            color: white;
        }

        .btn-watch {
            background-color: #007bff;
            color: white;
        }

        .no-courses {
            text-align: center;
            margin-top: 2rem;
            color: #888;
        }

        .enrollment-success {
            color: green;
            font-weight: bold;
        }
    </style>
</head>
<body>

<header>
    <h1>Student Dashboard</h1>
</header>

<div class="welcome">
    Welcome, <%= user.getUsername() %> (Student)
</div>

<div class="container">
    <%
        if (courses != null && !courses.isEmpty()) {
            for (Course course : courses) {
                boolean isEnrolled = enrolledCourseIds != null && enrolledCourseIds.contains(course.getId());
                boolean justEnrolled = enrollmentSuccess != null && enrollmentSuccess &&
                                       enrolledCourseId != null && enrolledCourseId.equals(course.getId());
    %>
    <div class="card">
        <img src="https://upload.wikimedia.org/wikipedia/en/3/30/Java_programming_language_logo.svg" alt="Course Image" />
        <div class="card-body">
            <div class="card-title"><%= course.getTitle() %></div>
            <div class="card-text"><%= course.getDescription() %></div>
            <div class="card-text"><strong>Category:</strong> <%= course.getCategory() %></div>
            <div class="btn-group">
                <% if (isEnrolled) { %>
                    <% if (justEnrolled) { %>
                        <p class="enrollment-success">Enrolled Successfully!</p>
                    <% } %>
                    <form action="courseDetails" method="get">
                        <input type="hidden" name="courseId" value="<%= course.getId() %>" />
                        <button type="submit" class="btn btn-watch">Go to Course</button>
                    </form>
                <% } else { %>
                    <button type="button" class="btn btn-enroll" data-bs-toggle="modal"
                            data-bs-target="#enrollModal" onclick="setCourseId(<%= course.getId() %>)">
                        Enroll
                    </button>
                <% } %>
            </div>
        </div>
    </div>
    <%
            }
        } else {
    %>
    <div class="no-courses">No courses available.</div>
    <%
        }
    %>
</div>

<!-- Modal for Enrollment -->
<div class="modal fade" id="enrollModal" tabindex="-1" aria-labelledby="enrollModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <form action="enroll" method="post" class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="enrollModalLabel">Enroll in Course</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <input type="hidden" name="courseId" id="modalCourseId">
                <div class="mb-3">
                    <label for="studentName" class="form-label">Student Name</label>
                    <input type="text" class="form-control" id="studentName" name="studentName"
                           value="<%= user.getUsername() %>" readonly>
                </div>
                <div class="mb-3">
                    <label for="startDate" class="form-label">Course Start Date</label>
                    <input type="date" class="form-control" name="startDate" required>
                </div>
            </div>
            <div class="modal-footer d-flex flex-column align-items-start">
                <button type="submit" class="btn btn-enroll mb-2">Submit</button>
            </div>
        </form>
    </div>
</div>

<script>
    function setCourseId(courseId) {
        document.getElementById("modalCourseId").value = courseId;
    }
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>

