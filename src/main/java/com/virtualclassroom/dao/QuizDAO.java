package com.virtualclassroom.dao;

import com.virtualclassroom.bean.Quiz;
import com.virtualclassroom.util.JPAUtil;

import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import java.util.List;

public class QuizDAO {

    // Get quizzes by course ID
   // public static List<Quiz> getQuizzesByCourseId(Long courseId) {
        //EntityManager em = JPAUtil.getEntityManagerFactory().createEntityManager();
       // try {
        	//return em.createQuery("SELECT q FROM Quiz q WHERE q.topic.id = :topicId ORDER BY q.id", Quiz.class)
        	         //.setParameter("topicId", topicId)
        	       //  .getResultList();

       // } finally {
            //em.close();
      //  }
    //}

    // Get quizzes by topic ID (new method)
    public static List<Quiz> getQuizzesByTopicId(Long topicId) {
        EntityManager em = JPAUtil.getEntityManagerFactory().createEntityManager();
        try {
            return em.createQuery("SELECT q FROM Quiz q WHERE q.topic.id = :topicId ORDER BY q.id", Quiz.class)
                     .setParameter("topicId", topicId)
                     .getResultList();
        } finally {
            em.close();
        }
    }

    // Get a single quiz by ID
    public static Quiz getQuizById(Long quizId) {
        EntityManager em = JPAUtil.getEntityManagerFactory().createEntityManager();
        try {
            return em.find(Quiz.class, quizId);
        } finally {
            em.close();
        }
    }

    // Save a new quiz
    public static void saveQuiz(Quiz quiz) {
        EntityManager em = JPAUtil.getEntityManagerFactory().createEntityManager();
        EntityTransaction transaction = em.getTransaction();
        try {
            transaction.begin();
            em.persist(quiz);
            transaction.commit();
        } catch (Exception e) {
            transaction.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    // Update an existing quiz
    public static void updateQuiz(Quiz quiz) {
        EntityManager em = JPAUtil.getEntityManagerFactory().createEntityManager();
        EntityTransaction transaction = em.getTransaction();
        try {
            transaction.begin();
            em.merge(quiz);
            transaction.commit();
        } catch (Exception e) {
            transaction.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    // Delete a quiz by ID
    public static void deleteQuiz(Long quizId) {
        EntityManager em = JPAUtil.getEntityManagerFactory().createEntityManager();
        EntityTransaction transaction = em.getTransaction();
        try {
            transaction.begin();
            Quiz quiz = em.find(Quiz.class, quizId);
            if (quiz != null) {
                em.remove(quiz);
            }
            transaction.commit();
        } catch (Exception e) {
            transaction.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }
}
