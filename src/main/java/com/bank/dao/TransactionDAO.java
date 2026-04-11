package com.bank.dao;

import com.bank.model.Transaction;
import com.bank.util.DBConnection;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.List;
import java.util.ArrayList;



public class TransactionDAO{
	
	public boolean addNewTransaction(Transaction transaction) {
		boolean isSuccess = false;
		
		String sql = "INSERT INTO transaction_history (account_number , transaction_type , amount) "
				+ "VALUES(? , ? , ?)";
		
		try(Connection con = DBConnection.getConnection();
			PreparedStatement pStmt = con.prepareStatement(sql);){
			
			pStmt.setInt(1, transaction.getAccountNumber());
			pStmt.setString(2, transaction.getTransactionType());
			pStmt.setBigDecimal(3, transaction.getAmount());
			
			int rowsAffected = pStmt.executeUpdate();
			
			if(rowsAffected > 0) {
				isSuccess = true;
			}
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
		
		return isSuccess;
	}
	
	public List<Transaction> getMiniStatement(int accNo){
		
		List<Transaction> transactions = new ArrayList<>();
		
		String sql = "SELECT * FROM transaction_history WHERE account_number = ? "
				+ "ORDER BY transaction_time DESC LIMIT 10";
		
		try(Connection con = DBConnection.getConnection();
			PreparedStatement pStmt = con.prepareStatement(sql);){
			
			pStmt.setInt(1, accNo);
			
			try(ResultSet rs = pStmt.executeQuery();){
			
				while(rs.next()) {
					transactions.add(new Transaction(rs.getInt("transaction_id"),
													accNo,
													rs.getString("transaction_type"),
													rs.getBigDecimal("amount"),
													rs.getTimestamp("transaction_time")));
				}
			}
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
		
		return transactions;
	}
	
	public List<Transaction> getAllTransactions(int accNo){
		
		List<Transaction> transactions = new ArrayList<>();
		
		String sql = "SELECT * FROM transaction_history WHERE account_number = ? "
				+ "ORDER BY transaction_time DESC";
		
		try(Connection con = DBConnection.getConnection();
			PreparedStatement pStmt = con.prepareStatement(sql);){
			
			pStmt.setInt(1, accNo);
			
			try(ResultSet rs = pStmt.executeQuery();){
			
				while(rs.next()) {
					transactions.add(new Transaction(rs.getInt("transaction_id"),
													accNo,
													rs.getString("transaction_type"),
													rs.getBigDecimal("amount"),
													rs.getTimestamp("transaction_time")));
				}
			}
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
		
		return transactions;
	}
	
}