package com.virtualclassroom.util;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

public class JPAUtil {

    private static final EntityManagerFactory emf = Persistence.createEntityManagerFactory("virtualClassroomPU");

    // Return EntityManagerFactory
    public static EntityManagerFactory getEntityManagerFactory() {
        return emf;
    }

    // Return EntityManager - add this method
    public static EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    // Call this during shutdown to release resources
    public static void shutdown() {
        if (emf != null && emf.isOpen()) {
            emf.close();
        }
    }
}
