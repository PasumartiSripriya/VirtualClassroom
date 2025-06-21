package com.virtualclassroom.util;

import org.mindrot.jbcrypt.BCrypt;

public class PasswordUtil {

    // Hash plain password before storing in DB
    public static String hashPassword(String plainPassword) {
        return BCrypt.hashpw(plainPassword, BCrypt.gensalt(10));
    }

    // Compare entered password with hashed password from DB
    public static boolean checkPassword(String plainPassword, String hashedPassword) {
        return BCrypt.checkpw(plainPassword, hashedPassword);
    }
}
