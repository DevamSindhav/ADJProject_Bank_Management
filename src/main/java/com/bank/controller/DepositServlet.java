package com.bank.controller;

import com.bank.model.Transaction;
import com.bank.dao.CustomerDAO;
import com.bank.dao.TransactionDAO;

import javax.servlet.http.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;

import java.io.IOException;
import java.math.BigDecimal;
import java.lang.NumberFormatException;


@WebServlet("/DepositServlet")
public class DepositServlet extends HttpServlet{
	
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
				BigDecimal amount = new BigDecimal(req.getParameter("amount"));
				
				CustomerDAO cDao = new CustomerDAO();
				TransactionDAO tDao = new TransactionDAO();
				
				BigDecimal zero = new BigDecimal("0");
				
				if(amount.compareTo(zero) > 0) {
					
					// I think not necessary validation we can do this on page too i think!!
					// But just to be safe!!!
					//No this is necessary don't trust webPage
					
					BigDecimal oldBalance = cDao.getCurrentBalance(accNo);
						
					BigDecimal newBalance = oldBalance.add(amount);
						
					boolean isSuccess = cDao.updateBalance(accNo, newBalance);
						
					if(isSuccess) {
							
						Transaction transaction = new Transaction(accNo , "DEPOSIT" , amount);
						boolean transactionAdded = tDao.addNewTransaction(transaction);
							
						if(!transactionAdded)
						{
							//sendRedirect with server error message
								
							//@roll_back to previous state
							cDao.updateBalance(accNo, oldBalance);
						}
						
					}
					
					//******not Checking for the customer object null or not
					//Because existence of session indirectly implies the
					//Existence og the customer i think!!!*****
					
				}
				else {
					
					//send Redirect with message: Invalid amount
					
				}
				
				
			}
			else {
				
				//sendRedirect to the Login page
				
			}
			
		}catch(NumberFormatException e) {
			
			e.printStackTrace();
			//sendRedirect with the error message of illegal argument
			
		}catch(Exception e) {
			
			e.printStackTrace();
			//sendRedirect  with error message
			
		}
		
	}
	
}