package com.virtualclassroom.test;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

public class JPATest {
    public static void main(String[] args) {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("virtualClassroomPU");
        EntityManager em = emf.createEntityManager();

        System.out.println("✅ JPA is connected successfully!");

        em.close();
        emf.close();
    }
}
