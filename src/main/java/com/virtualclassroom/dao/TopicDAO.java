package com.virtualclassroom.dao;

import com.virtualclassroom.bean.Topic;
import com.virtualclassroom.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.query.Query;

import java.util.List;

public class TopicDAO {

    // Method to get topics for a specific course
	public List<Topic> getTopicsByCourseId(Long courseId) {
	    try (Session session = HibernateUtil.getSessionFactory().openSession()) {
	        System.out.println("Fetching topics for courseId: " + courseId);  // Debug log
	        String hql = "FROM Topic t WHERE t.course.id = :courseId";
	        Query<Topic> query = session.createQuery(hql, Topic.class);
	        query.setParameter("courseId", courseId);
	        List<Topic> result = query.getResultList();
	        System.out.println("Fetched " + result.size() + " topics.");  // Debug log
	        return result;
	    } catch (Exception e) {
	        e.printStackTrace();
	        return null;
	    }
	}
	
	public void addTopic(Topic topic) {
	    try (Session session = HibernateUtil.getSessionFactory().openSession()) {
	        session.beginTransaction();
	        session.save(topic);  // Hibernate will insert based on the entity
	        session.getTransaction().commit();
	        System.out.println("Topic added successfully.");
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	}

	
	public void deleteTopicById(int i) {
	    try (Session session = HibernateUtil.getSessionFactory().openSession()) {
	        session.beginTransaction();
	        Topic topic = session.get(Topic.class, i);
	        if (topic != null) {
	            session.delete(topic);
	            System.out.println("Topic deleted successfully.");
	        }
	        session.getTransaction().commit();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	}


}
