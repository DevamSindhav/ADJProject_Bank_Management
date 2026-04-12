package com.bank.controller;

import com.bank.model.Customer;
import com.bank.dao.CustomerDAO;
import com.bank.util.PasswordUtil;

import javax.servlet.http.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;

import java.io.IOException;


@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	public void doPost(HttpServletRequest req , HttpServletResponse resp)
				throws ServletException , IOException
	{
		try {
			
			String email = req.getParameter("email");
			String plainPass = req.getParameter("password");
			
			CustomerDAO cDao = new CustomerDAO();
			
			Customer customer = cDao.getCustomerbyEmail(email);
			
			if(customer != null) {
				
				String passHash = customer.getPassword();
				
				if(PasswordUtil.checkPassword(plainPass, passHash)) {
					
					HttpSession session = req.getSession();
					
					if(session != null) {
						
						session.setAttribute("fullName", customer.getFullName());
						session.setAttribute("accNo", customer.getAccountNumber());
						session.setAttribute("email", email);
						
						//forward to dashBoardServlet
						//the dashboard servlet will help to make give user data and recent statements
						//to display on dashboards
						resp.sendRedirect("DashBoardServlet");
						return;
					}
					else {
						//sendRedirect to page with message of serverError
						resp.sendRedirect("login.jsp?error=server_error");
						return;
					}
					
				}
				else {
					
					//sendRedirect to the login page with message of incorrect password
					resp.sendRedirect("login.jsp?error=invalid_password");
					return;
				}
				
			}
			else {
				
				//SendRedirect to loginPage with error message stating user not Registered
				resp.sendRedirect("login.jsp?error=user_not_registered");
				return;
			}
			
		}catch(Exception e) {
			e.printStackTrace();
			//sendRedirect with the error message or redirect to error page
			resp.sendRedirect("login.jsp?error=server_error");
			return;
		}
	}
	
}
