package com.bank.util;

import org.mindrot.jbcrypt.BCrypt;

public class PasswordUtil{
	
	public static String hashPassword(String plainTextPass) {
		
		return BCrypt.hashpw(plainTextPass, BCrypt.gensalt());
		
	}
	
	public static boolean checkPassword(String plainTextPass , String hashedPass) {
		
		return BCrypt.checkpw(plainTextPass, hashedPass);
		
	}
}