package com.virtualclassroom.util;

import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import org.hibernate.service.ServiceRegistry;

import com.virtualclassroom.bean.Course;
import com.virtualclassroom.bean.Quiz;
import com.virtualclassroom.bean.User;
import com.virtualclassroom.bean.Enrollment;
import com.virtualclassroom.bean.Topic;

public class HibernateUtil {

    private static SessionFactory sessionFactory;

    static {
        try {
            // Load configuration from hibernate.cfg.xml
            Configuration configuration = new Configuration().configure("hibernate.cfg.xml");

            // Register annotated entity classes
            configuration.addAnnotatedClass(User.class);
            configuration.addAnnotatedClass(Course.class);
            configuration.addAnnotatedClass(Quiz.class);
            configuration.addAnnotatedClass(Enrollment.class);
            configuration.addAnnotatedClass(Topic.class);

            // Build the service registry
            ServiceRegistry serviceRegistry = new StandardServiceRegistryBuilder()
                    .applySettings(configuration.getProperties()).build();

            // Build the session factory
            sessionFactory = configuration.buildSessionFactory(serviceRegistry);

        } catch (Throwable ex) {
            System.err.println("Initial SessionFactory creation failed: " + ex);
            throw new ExceptionInInitializerError(ex);
        }
    }

    // Return SessionFactory
    public static SessionFactory getSessionFactory() {
        return sessionFactory;
    }

    // Call this on application shutdown to clean up
    public static void shutdown() {
        if (sessionFactory != null && !sessionFactory.isClosed()) {
            sessionFactory.close();
        }
    }
}
