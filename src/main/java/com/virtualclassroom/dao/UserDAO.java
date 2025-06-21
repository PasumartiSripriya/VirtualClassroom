package com.virtualclassroom.dao;

import com.virtualclassroom.bean.PasswordResetToken;
import com.virtualclassroom.bean.User;
import com.virtualclassroom.util.JPAUtil;

import java.time.LocalDateTime;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.TypedQuery;


public class UserDAO {
    public User validateUser(String username, String password) {
    	EntityManager em = JPAUtil.getEntityManagerFactory().createEntityManager(); 

        try {
            TypedQuery<User> query = em.createQuery(
                "SELECT u FROM User u WHERE u.username = :username AND u.password = :password", User.class);
            query.setParameter("username", username);
            query.setParameter("password", password);

            return query.getSingleResult(); // returns null if not found
        } catch (NoResultException e) {
            return null;
        } finally {
            em.close();
        }
    }
    public User getUserByUsername(String username) {
        EntityManager em = JPAUtil.getEntityManagerFactory().createEntityManager();
        try {
            return em.createQuery("SELECT u FROM User u WHERE u.username = :username", User.class)
                     .setParameter("username", username)
                     .getSingleResult();
        } catch (Exception e) {
            return null;
        } finally {
            em.close();
        }
    }
    public static boolean emailExists(String email) {
        EntityManager em = JPAUtil.getEntityManagerFactory().createEntityManager();
        try {
            Long count = em.createQuery(
                "SELECT COUNT(u) FROM User u WHERE u.email = :email", Long.class)
                .setParameter("email", email)
                .getSingleResult();
            return count > 0;
        } finally {
            em.close();
        }
    }
    public static  void saveResetToken(String email, String token) {
        EntityManager em = JPAUtil.getEntityManagerFactory().createEntityManager();
        try {
            em.getTransaction().begin();

            PasswordResetToken prt = new PasswordResetToken();
            prt.setEmail(email);
            prt.setToken(token);
            prt.setExpiryTime(LocalDateTime.now().plusMinutes(30)); // token expires in 30 mins

            em.persist(prt);
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }
    public String getEmailByToken(String token) {
        EntityManager em = JPAUtil.getEntityManagerFactory().createEntityManager();
        try {
            PasswordResetToken prt = em.find(PasswordResetToken.class, token);
            if (prt != null && prt.getExpiryTime().isAfter(LocalDateTime.now())) {
                return prt.getEmail();
            }
        } finally {
            em.close();
        }
        return null;
    }
    public boolean updatePassword(String email, String hashedPassword) {
        EntityManager em = JPAUtil.getEntityManagerFactory().createEntityManager();
        try {
            em.getTransaction().begin();
            User user = em.createQuery("SELECT u FROM User u WHERE u.email = :email", User.class)
                          .setParameter("email", email)
                          .getSingleResult();

            user.setPassword(hashedPassword); // assuming setter exists
            em.merge(user);
            em.getTransaction().commit();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }
    public boolean deleteResetToken(String token) {
        EntityManager em = JPAUtil.getEntityManagerFactory().createEntityManager();
        try {
            em.getTransaction().begin();
            PasswordResetToken prt = em.find(PasswordResetToken.class, token);
            if (prt != null) {
                em.remove(prt);
            }
            em.getTransaction().commit();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }



}

