package com.bank.controller;

import com.bank.dao.TransactionDAO;
import com.bank.model.Transaction;

import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.ServletException;

import java.io.IOException;
import java.util.List;


@WebServlet("/FullStatementServlet")
public class FullStatementServlet extends HttpServlet{

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
				
				int accNo = (int) session.getAttribute("accNo");
				
				TransactionDAO tDao = new TransactionDAO();
				
				List<Transaction> transactions = tDao.getAllTransactions(accNo);
				
				req.setAttribute("allTransactions", transactions);
				
				//RequestDispatcher reqDip = req.getRequestDispatcher( path to redirect )
				//reqDip.forward(req , resp )
				//forward this to the statement.jsp
				
			}
			else {
				
				//sendRedirect to loginPage
				
			}
			
		}catch(Exception e) {
			e.printStackTrace();
			//sendredirect error message
		}
		
	}
	
}