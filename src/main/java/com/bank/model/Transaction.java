package com.bank.model;

import java.sql.Timestamp;
import java.math.BigDecimal;

public class Transaction{
	private int transactionId;
	private int accNo;
	private String transactionType;
	private BigDecimal amount;
	private Timestamp timeStamp;
	
	public Transaction(int transactionId , int accNo , String transactionType , 
					   BigDecimal amount , Timestamp timeStamp) {
		this.transactionId = transactionId;
		this.accNo = accNo;
		this.transactionType = transactionType;
		this.amount = amount;
		this.timeStamp = timeStamp;
	}
	
	public Transaction(int accNo , String transactionType , BigDecimal amount ) {
		this.accNo = accNo;
		this.transactionType = transactionType;
		this.amount = amount;
	}
	
	public int getTransactionId() {return transactionId;}
	public Timestamp getTimeStamp() {return timeStamp;}
	
	public int getAccountNumber() {return accNo;}
	public void setAccountNumber(int accNo) {this.accNo = accNo;}
	
	public String getTransactionType() {return transactionType;}
	public void setTransactionType(String transactionType) {this.transactionType = transactionType;}
	
	public BigDecimal getAmount() {return amount;}
	public void setAmount(BigDecimal amount) {this.amount = amount;}
	
}