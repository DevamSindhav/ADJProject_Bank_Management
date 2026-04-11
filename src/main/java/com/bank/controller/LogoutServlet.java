package com.bank.controller;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.servlet.ServletException;

import java.io.IOException;


@WebServlet("/LogoutServlet")
public class LogoutServlet extends HttpServlet{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest req , HttpServletResponse resp) 
				throws ServletException , IOException
	{
		
		try {
			
			HttpSession session = req.getSession(false);
			if(session != null) {
				session.invalidate();
			}
			
			//redirecting to logout page
			
		}catch(Exception e) {
			
			e.printStackTrace();
			//
			
		}
		
	}
	
}
