package com.bank.controller;

import com.bank.model.Customer;
import com.bank.dao.CustomerDAO;
import com.bank.util.PasswordUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

import java.math.BigDecimal;
import java.sql.Date;


@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void doPost(HttpServletRequest req , HttpServletResponse resp )
			throws ServletException , IOException
	{
		
		try {
		
			String fullName = req.getParameter("fullName");
			String email = req.getParameter("email");
			String mobileNo = req.getParameter("mobileNo");
			String address = req.getParameter("address");
			String postalCode = req.getParameter("postalCode");
			String pin = req.getParameter("pin");
			BigDecimal balance = new BigDecimal(req.getParameter("balance"));
			String accType = req.getParameter("accType");
			Date dob = Date.valueOf(req.getParameter("dob"));
			
			//hashing the password 
			String password = req.getParameter("password");
			
			String passHash = PasswordUtil.hashPassword(password);
			
			CustomerDAO cDao = new CustomerDAO(); 
			
			Customer customer = cDao.getCustomerbyEmail(email);
			
			if(customer == null) {
				
				String hashedPin = PasswordUtil.hashPassword(pin);
				
				customer = new Customer(fullName , email , passHash , mobileNo , address ,
										postalCode , hashedPin , balance , accType , dob);
				
				
				
				boolean isSuccess = cDao.registerUser(customer);
				
				if(isSuccess) {
					
					//sendRedirect to login page with success message
					
				}
				else {
					
					//sendRedirect to either error page or to register the page with error massage
					
				}
					
				
			}
			
			else {
				
				//sendRedirect to the Register page with msg stating email already in use.
			}
			
		}catch(Exception e) {
			
			e.printStackTrace();
			
			//here needs to be redirected to the page with the error msg
		}
		
	}
		
	
}

