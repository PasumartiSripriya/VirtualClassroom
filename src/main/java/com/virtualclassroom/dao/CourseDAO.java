package com.virtualclassroom.dao;

import com.virtualclassroom.bean.Course;
import com.virtualclassroom.bean.Topic;
import com.virtualclassroom.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;

import java.util.List;
import java.util.HashSet;
import java.util.Set;

public class CourseDAO {

	public List<Course> getAllCourses() {
	    Session session = HibernateUtil.getSessionFactory().openSession();
	    List<Course> courses = session.createQuery("from Course", Course.class).list();

	    for (Course course : courses) {
	        Long count = session.createQuery(
	            "select count(e.id) from Enrollment e where e.course.id = :courseId", Long.class)
	            .setParameter("courseId", course.getId())
	            .uniqueResult();

	        course.setEnrollmentCount(count != null ? count.intValue() : 0);
	    }

	    session.close();
	    return courses;
	}


    // New method to get enrolled course IDs for a given student
    public Set<Long> getEnrolledCourseIdsByStudentId(Long studentId) {
        Set<Long> enrolledCourseIds = new HashSet<>();

        Session session = HibernateUtil.getSessionFactory().openSession();
        try {
            List<Long> courseIds = session.createQuery(
                "select e.course.id from Enrollment e where e.student.id = :studentId", Long.class)
                .setParameter("studentId", studentId)
                .list();

            enrolledCourseIds.addAll(courseIds);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }

        return enrolledCourseIds;
    }
    
    public Course getCourseById(Long courseId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.get(Course.class, courseId);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public List<Topic> getTopicsByCourseId(Long courseId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery("from Topic t where t.course.id = :courseId", Topic.class)
                          .setParameter("courseId", courseId)
                          .list();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
    
    public void addCourse(Course course) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Transaction tx = session.beginTransaction();
            session.save(course);
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    
    public void deleteCourse(Long courseId) {
        Transaction tx = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            tx = session.beginTransaction();
            
            Course course = session.get(Course.class, courseId);
            if (course != null) {
                session.delete(course);
            }
            
            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
        }
    }
}