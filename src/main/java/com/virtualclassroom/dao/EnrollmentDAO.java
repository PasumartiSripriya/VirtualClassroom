package com.virtualclassroom.dao;

import com.virtualclassroom.bean.Enrollment;
import com.virtualclassroom.util.HibernateUtil;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

public class EnrollmentDAO {

    // Save new enrollment
    public void enrollStudent(Enrollment enrollment) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction tx = null;

        try {
            tx = session.beginTransaction();
            session.save(enrollment);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
        } finally {
            session.close();
        }
    }

    // Check if the student is already enrolled in the course
    public boolean isStudentEnrolledInCourse(Long studentId, Long courseId) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        boolean enrolled = false;

        try {
            Enrollment enrollment = session.createQuery(
                    "FROM Enrollment e WHERE e.student.id = :studentId AND e.course.id = :courseId", Enrollment.class)
                .setParameter("studentId", studentId)
                .setParameter("courseId", courseId)
                .uniqueResult();

            enrolled = (enrollment != null);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }

        return enrolled;
    }
    
    public List<Long> getEnrolledCourseIdsByStudentId(Long studentId) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        List<Long> courseIds = null;

        try {
            courseIds = session.createQuery(
                    "SELECT e.course.id FROM Enrollment e WHERE e.student.id = :studentId", Long.class)
                    .setParameter("studentId", studentId)
                    .getResultList();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }

        return courseIds;
    }

}

