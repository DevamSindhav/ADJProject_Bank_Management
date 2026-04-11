package com.bank.controller;

import com.bank.dao.CustomerDAO;
import com.bank.util.PasswordUtil;

import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.ServletException;

import java.io.IOException;

@WebServlet("/UpdatePinServlet")
public class UpdatePinServlet extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	public void doPost(HttpServletRequest req , HttpServletResponse resp)
				throws ServletException , IOException
	{
		
		try {
			
			HttpSession session = req.getSession(false);
			
			if(session != null && session.getAttribute("accNo") != null) {
				
				int accNo = (int) session.getAttribute("accNo");
				String plainPass = (String) req.getParameter("password");
				String newPin = (String) req.getParameter("newPin");
				
				
				CustomerDAO cDao = new CustomerDAO();
				
				if(PasswordUtil.checkPassword(plainPass, cDao.getPassword(accNo) )) {
					
					String hasedNewPin = PasswordUtil.hashPassword(newPin);
					boolean isSuccess = cDao.updateTransactionPin(accNo, hasedNewPin);
					
					if(isSuccess) {
						
						//SendRedirect to Dash board with message saying changed pin successfully
						
					}
					else {
						
						//SendRedirect saying pin server error
						
					}
					
				}
				else {
					
					//sendReditect Change pin page with error message password incorrect
					
				}
				
			}
			else {
				
				//session not created redirect to LoginPage
				
			}
			
		}catch(Exception e) {
			
			e.printStackTrace();
			//sendRedirect to error Page or error message
			
		}
		
	}
	
	
}