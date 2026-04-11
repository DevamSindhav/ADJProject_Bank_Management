package com.bank.controller;

import com.bank.model.Customer;
import com.bank.model.Transaction;
import com.bank.dao.CustomerDAO;
import com.bank.dao.TransactionDAO;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.servlet.ServletException;

import java.io.IOException;
import java.util.List;

@WebServlet("/DashBoardServlet")
public class DashBoardServlet extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	public void doGet(HttpServletRequest req , HttpServletResponse resp) 
				throws ServletException , IOException
	{
		try {
			
			HttpSession session = req.getSession(false);
			
			if(session != null && session.getAttribute("accNo") != null) {
				
				int accNo =(int) session.getAttribute("accNo");
				
				CustomerDAO cDao = new CustomerDAO();
				TransactionDAO tDao = new TransactionDAO();
				
				Customer customer = cDao.getCustomerbyAccountNumber(accNo);
				
				if(customer != null) {
					
					List<Transaction> transactions = tDao.getMiniStatement(accNo);
					
					req.setAttribute("customer", customer);
					req.setAttribute("miniStatement", transactions);
					
					//now Dispatch the req to dashboard.jsp using forward
					//req.RequestDispatcher("dashboard.jsp").forward(req,resp);
					
				}
				else {
					
					//SendRedirect to login with message Server Error pls login again
					
				}
				
			}
			else {
				
				//sendRedirect to the LoginPage
				
			}
		}catch(Exception e) {
			
			e.printStackTrace();
			//sendRedirect with Server Error message
			
		}
	}
}