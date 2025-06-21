# VirtualClassroom
A full-featured Virtual Classroom Web Application built using Java, JSP/Servlets, and Hibernate (JPA). This platform facilitates online learning, enabling students to enroll in courses, track progress, and attempt quizzes, while instructors can manage course content and monitor engagement. 
## 🚀 Features

### 👩‍🎓 Student Features
- Browse and enroll in available courses
- Watch topic-wise video lectures
- Take quizzes with a live 10-minute countdown timer
- View scores and progress
- Password reset via email

### 👨‍🏫 Instructor Features
- Add, view, and delete courses
- Add/edit/delete topics (video + description)
- View enrollments for each course
- Instructor-only dashboard with course performance

### ✨ Quiz Engine
- One-question-at-a-time quiz flow
- Sidebar with clickable question numbers
- Timer with auto-submit on expiry
- Confetti animation on perfect score
## 🛠️ Tech Stack

- **Frontend**: JSP, HTML, CSS, JavaScript, Bootstrap
- **Backend**: Java 17+, Spring Boot, Servlets, Spring Security (JWT)
- **Database**: MySQL / PostgreSQL
- **ORM**: Hibernate / JPA
- **Library Management**: Manual JAR imports in `WEB-INF/lib`
- **Server**: Apache Tomcat 9
-**Email Integration**: JavaMail API (for password reset)

## 🧩 Modules

- `Student Dashboard` – Course discovery, enrollment, and access
- `Course Details` – Watch topics, start quizzes
- `Instructor Dashboard` – Manage own courses and topics
- `Quiz Module` – Dynamic, timer-based assessment engine
- `Security` – JWT-based authentication with role-level access

##📦 Required JARs
spring-core, spring-context, spring-web, spring-security-core, spring-security-web
hibernate-core, javax.persistence, mysql-connector-java
javax.mail, activation.jar, and any others used in your WEB-INF/lib
