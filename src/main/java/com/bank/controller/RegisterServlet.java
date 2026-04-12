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

import java.time.LocalDate;
import java.time.Period;
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
			String password = req.getParameter("password");
			String mobileNo = req.getParameter("mobileNo");
			String address = req.getParameter("address");
			String postalCode = req.getParameter("postalCode");
			Date dob = Date.valueOf(req.getParameter("dob"));
			String pin = req.getParameter("pin");
			BigDecimal balance = new BigDecimal(req.getParameter("balance"));
			String accType = req.getParameter("accType");
			
			LocalDate birthDate = dob.toLocalDate();
			LocalDate currentDate = LocalDate.now();
			int age = Period.between(birthDate, currentDate).getYears();

			if (age < 18) {
			    resp.sendRedirect("register.jsp?error=underage");
			    return; 
			}
			
			if(password == null || password.length() < 8 || password.length() > 16){
				resp.sendRedirect("register.jsp?error=invalid_password");
				return;
			}
			
			if (pin == null || !pin.matches("\\d{4}")) {
				
				resp.sendRedirect("register.jsp?error=invalid_pin");
				return;
			}
			
			//hashing the password 
			
			String passHash = PasswordUtil.hashPassword(password);
			
			CustomerDAO cDao = new CustomerDAO(); 
			
			Customer customer = cDao.getCustomerbyEmail(email);
			
			if(customer == null) {
				
				String hashedPin = PasswordUtil.hashPassword(pin);
				
				customer = new Customer(fullName , email , passHash , mobileNo , address ,
										postalCode , hashedPin , balance , accType , dob);
				
				boolean isSuccess = cDao.registerUser(customer);
				
				if(isSuccess) {
					resp.sendRedirect("login.jsp");
					return;
				}
				else {
					resp.sendRedirect("register.jsp?error=server_error");
					return;
				}
			}
			else {	
				resp.sendRedirect("register.jsp?error=email_taken");
				return;
			}
		}catch(Exception e) {
			
			e.printStackTrace();
			
			resp.sendRedirect("register.jsp?error=server_error");
			return;
		}
	}	
}

