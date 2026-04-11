package com.bank.model;

import java.sql.Date;
import java.math.BigDecimal;

public class Customer{
	private int accNo;
	private String fullName;
	private String email;
	private String passHash;
	private BigDecimal balance;
	private String accType;
	private String mobileNo;
	private String address;
	private String pin;
	private String postalCode;
	private Date dob;
	
	public Customer() {}
	
	public Customer(String fullName , String email , String passHash , String mobileNo , String address ) {
		this.fullName = fullName;
		this.email = email;
		this.passHash = passHash;
		this.mobileNo = mobileNo;
		this.address = address;
	}
	
	public Customer(String fullName , String email , String passHash , String mobileNo , String address ,
					String postalCode ,String pin , BigDecimal balance , String accType ,Date dob ) {
		
		this.fullName = fullName;
		this.email = email;
		this.passHash = passHash;
		this.mobileNo = mobileNo;
		this.address = address;
		this.accType = accType;
		this.pin = pin;
		this.balance = balance;
		this.postalCode = postalCode;
		this.dob = dob;
		
	}
	
	public String getFullName() {return fullName;}
	public void setFullName(String fullName) {this.fullName = fullName;}
	
	public int getAccountNumber() {return accNo;}
	public void setAccountNumber(int accNo) {this.accNo = accNo;}
	
	public String getEmail() {return email;}
	public void setEmail(String email) {this.email = email;}
	
	public String getPassword() {return passHash;}
	public void setPassword(String passHash) {this.passHash = passHash;}
	
	public BigDecimal getBalance() {return balance;}
	public void setBalance(BigDecimal balance) {this.balance = balance;}
	
	public String getAccountType() {return accType;}
	public void setAccountType(String accType) {this.accType = accType;}
	
	public String getMobileNumber() {return mobileNo;}
	public void setMobileNumber(String mobileNo) {this.mobileNo = mobileNo;}
	
	public String getAddress() {return address;}
	public void setAddress(String address) {this.address = address;}
	
	public String getPin() {return pin;}
	public void setPin(String pin) {this.pin = pin;}
	
	public Date getDOB() {return dob;}
	public void setDOB(Date dob) {this.dob = dob;}
	
	public String getPostalCode() {return postalCode;}
	public void setPostalCode(String postalCode) {this.postalCode = postalCode;}
}