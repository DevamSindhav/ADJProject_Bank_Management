package com.bank.dao;

import com.bank.util.DBConnection;
import com.bank.model.Customer;
import com.bank.model.Transaction;

import java.sql.SQLException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import java.math.BigDecimal;

public class CustomerDAO{
	
	public boolean registerUser(Customer customer) {
		boolean isSuccess = false;
		
		String sql = "INSERT INTO customerData "
				+ "(full_name, email, password_hash, mobile_number, address, postal_code, pin , balance, account_type, dob ) "
				+ "VALUES(? , ? , ? , ? , ? , ? , ? ,? , ? , ? )";
		
		try(Connection con = DBConnection.getConnection();
			PreparedStatement pStmt = con.prepareStatement(sql);){
			
			pStmt.setString(1, customer.getFullName());
			pStmt.setString(2, customer.getEmail());
			pStmt.setString(3, customer.getPassword());
			pStmt.setString(4, customer.getMobileNumber());
			pStmt.setString(5, customer.getAddress());
			pStmt.setString(6, customer.getPostalCode());
			pStmt.setString(7, customer.getPin());
			pStmt.setBigDecimal(8, customer.getBalance());
			pStmt.setString(9, customer.getAccountType());
			pStmt.setDate(10, customer.getDOB());
			
			
			
			int rawsAffected = pStmt.executeUpdate();
			
			
			if(rawsAffected > 0){
				
				int accNo = getAccountNumber(customer.getEmail());
				
				if(accNo != -1) {
					
					TransactionDAO tDao = new TransactionDAO();
						
					Transaction transaction = new Transaction(accNo , "DEPOSIT" , customer.getBalance());
						
					boolean transactionDone = tDao.addNewTransaction(transaction);
						
					if(transactionDone) {
						
						isSuccess = true;
						
					}
				}
			}
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
	return isSuccess;
	}
	
//	public Customer loginCheck(String email , String passHash) {
//		Customer customer = null;
//		String sql = "SELECT * FROM customerData WHERE email = ? AND password_hash = ? ";
//		
//		try(Connection con = DBConnection.getConnection();
//			PreparedStatement pStmt = con.prepareStatement(sql);){
//			
//			pStmt.setString(1, email);
//			pStmt.setString(2, passHash);
//			
//			try(ResultSet rs = pStmt.executeQuery();){
//				
//				if(rs.next()) {
//					
//					customer = new Customer();
//					
//					customer.setAccountNumber(rs.getInt("account_number"));
//					customer.setFullName(rs.getString("full_name"));
//					customer.setEmail(email);
//					customer.setPassword(passHash);
//					customer.setBalance(rs.getBigDecimal("balance"));
//					customer.setAccountType(rs.getString("account_type"));
//					customer.setMobileNumber(rs.getString("mobile_number"));
//					customer.setPin(rs.getString("pin"));
//					customer.setAddress(rs.getString("address"));
//					customer.setDOB(rs.getDate("dob"));
//					customer.setPostalCode(rs.getString("postal_code"));
//				}
//			}
//			
//		}catch(SQLException e) {
//			e.printStackTrace();
//		}
//		return customer;
//	}
	
	public Customer getCustomerbyEmail(String email) {
		
		Customer customer = null;
		String sql = "SELECT * FROM customerData WHERE email = ?";
		
		try(Connection con = DBConnection.getConnection();
			PreparedStatement pStmt = con.prepareStatement(sql);){
			
			pStmt.setString(1, email);
			
			try(ResultSet rs = pStmt.executeQuery();){
				
				if(rs.next()) {
					
					customer = new Customer();
					
					customer.setAccountNumber(rs.getInt("account_number"));
					customer.setFullName(rs.getString("full_name"));
					customer.setEmail(rs.getString("email"));
					customer.setPassword(rs.getString("password_hash"));
					customer.setBalance(rs.getBigDecimal("balance"));
					customer.setAccountType(rs.getString("account_type"));
					customer.setMobileNumber(rs.getString("mobile_number"));
					customer.setPin(rs.getString("pin"));
					customer.setAddress(rs.getString("address"));
					customer.setDOB(rs.getDate("dob"));
					customer.setPostalCode(rs.getString("postal_code"));
				}
			}
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return customer;
	}
	
	public Customer getCustomerbyAccountNumber(int accNo) {
		
		Customer customer = null;
		String sql = "SELECT * FROM customerData WHERE account_number = ?";
		
		try(Connection con = DBConnection.getConnection();
			PreparedStatement pStmt = con.prepareStatement(sql);){
			
			pStmt.setInt(1, accNo);
			
			try(ResultSet rs = pStmt.executeQuery();){
				
				if(rs.next()) {
					
					customer = new Customer();
					
					customer.setAccountNumber(rs.getInt("account_number"));
					customer.setFullName(rs.getString("full_name"));
					customer.setEmail(rs.getString("email"));
					customer.setPassword(rs.getString("password_hash"));
					customer.setBalance(rs.getBigDecimal("balance"));
					customer.setAccountType(rs.getString("account_type"));
					customer.setMobileNumber(rs.getString("mobile_number"));
					customer.setPin(rs.getString("pin"));
					customer.setAddress(rs.getString("address"));
					customer.setDOB(rs.getDate("dob"));
					customer.setPostalCode(rs.getString("postal_code"));
				}
			}
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return customer;
	}
	
	public BigDecimal getCurrentBalance(int accNo) {
		
		String sql = "SELECT balance FROM customerData WHERE account_number = ?";
		
		BigDecimal balance = new BigDecimal("-1.00");//-1 for error handling
		
		try(Connection con = DBConnection.getConnection();
			PreparedStatement pStmt = con.prepareStatement(sql);){
			
			pStmt.setInt(1, accNo);
			
			try(ResultSet rs = pStmt.executeQuery();){
				
				if(rs.next()) {
					
					balance = rs.getBigDecimal("balance");
				}
			}
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
		
		return balance;
	}
	
	public boolean updateBalance(int accNo , BigDecimal newBalance) {
		
		boolean isSuccess = false;
		
		String sql = "UPDATE customerData SET balance = ? WHERE account_number = ?";
		
		try(Connection con = DBConnection.getConnection();
			PreparedStatement pStmt = con.prepareStatement(sql);){
			
			pStmt.setBigDecimal(1, newBalance);
			pStmt.setInt(2 , accNo);
			
			int rowsAffected = pStmt.executeUpdate();
			
			if(rowsAffected > 0)
				isSuccess = true;
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return isSuccess;
	}
	
	public boolean updateTransactionPin(int accNo , String newPin) {
		
		
		boolean isSuccess = false;
		String sql = "UPDATE customerData SET pin = ? WHERE account_number = ?";
		
		try(Connection con = DBConnection.getConnection();
			PreparedStatement pStmt = con.prepareStatement(sql);){
			
			
			pStmt.setString(1, newPin);
			pStmt.setInt(2, accNo);
			
			int rowsAffected = pStmt.executeUpdate();
			
			if(rowsAffected > 0) {
				isSuccess = true;
			}
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
		
		return isSuccess;
	}
	
	
	//need to change this //
	public boolean deleteAccountbyAccountNumber(int accNo , String passHash ) {
		boolean isSuccess = false;
		
		String sql = "DELETE FROM customerData WHERE account_number = ? and password_hash = ?";
		
		try(Connection con = DBConnection.getConnection();
			PreparedStatement pStmt = con.prepareStatement(sql);){
			
			pStmt.setInt(1,accNo);
			pStmt.setString(2, passHash);
			
			int rowsAffected = pStmt.executeUpdate();
			
			if(rowsAffected > 0) {
				isSuccess = true;
			}
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
		
		return isSuccess;
	}
	
	public String getTransactionPin(int accNo) {
		
		String pin = null;
		
		String sql = "SELECT pin FROM customerData WHERE account_number = ?";
		
		try(Connection con = DBConnection.getConnection();
			PreparedStatement pStmt = con.prepareStatement(sql);){
			
			pStmt.setInt(1, accNo);
			
			try(ResultSet rs = pStmt.executeQuery()){
				
				if(rs.next()) {
					
					pin = rs.getString("pin");
					
				}
				
			}
			
		}catch(Exception e) {
			
			e.printStackTrace();
			
		}
		
		return pin;
	}
	
	public String getPassword(int accNo) {
		
		String passHash = null;
		
		String sql = "SELECT password_hash FROM customerData WHERE account_number = ?";
		
		try(Connection con = DBConnection.getConnection();
			PreparedStatement pStmt = con.prepareStatement(sql);){
			
			pStmt.setInt(1, accNo);
			
			try(ResultSet rs = pStmt.executeQuery()){
				
				if(rs.next()) {
					
					passHash = rs.getString("password_hash");
					
				}
				
			}
			
		}catch(Exception e) {
			
			e.printStackTrace();
			
		}
		
		return passHash;
		
	}
	
	public boolean updatePassword(int accNo , String newPass) {
		
		
		boolean isSuccess = false;
		String sql = "UPDATE customerData SET password_hash = ? WHERE account_number = ?";
		
		try(Connection con = DBConnection.getConnection();
			PreparedStatement pStmt = con.prepareStatement(sql);){
			
			
			pStmt.setString(1, newPass);
			pStmt.setInt(2, accNo);
			
			int rowsAffected = pStmt.executeUpdate();
			
			if(rowsAffected > 0) {
				isSuccess = true;
			}
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
		
		return isSuccess;
	}
	
	public int getAccountNumber(String email) {
		
		int accNo = -1;
		
		String sql = "SELECT account_number FROM customerData WHERE email = ?";
		
		try(Connection con = DBConnection.getConnection();
				PreparedStatement pStmt = con.prepareStatement(sql);){
			
			
			pStmt.setString(1, email);
			
			try(ResultSet rs = pStmt.executeQuery();){
			
				if(rs.next()) {
					
					accNo = rs.getInt("account_number");
					
				}
			}
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
		
		return accNo;
	}
}




/*  Documentation of this class
 * 
 * main purpose is to access the database table customerData using class methods
 * 
 * this DAO is specifically for the customer data table
 * 
 */