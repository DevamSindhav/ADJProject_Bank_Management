package com.bank.util;

import java.sql.SQLException;
import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection{
	public static final String URL = "jdbc:mysql://localhost:3306/bank";
	public static final String USER = "root";
	public static final String PASS = "root123";
	
	public static Connection getConnection() {
		Connection connection = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			connection = DriverManager.getConnection(URL , USER , PASS);
		}catch(SQLException e) {
			System.out.println("Failed to connect to database. Check Credentials or URL");
			e.printStackTrace();
		}catch(ClassNotFoundException e) {
			System.out.println("Class not found. issue with driver!");
			e.printStackTrace();
		}
		return connection;
	}
}