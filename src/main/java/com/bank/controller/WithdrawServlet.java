package com.bank.controller;

import com.bank.model.Transaction;
import com.bank.util.PasswordUtil;
import com.bank.dao.TransactionDAO;
import com.bank.dao.CustomerDAO;

import javax.servlet.http.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;

import java.io.IOException;
import java.math.BigDecimal;

@WebServlet("/WithdrawServlet")
public class WithdrawServlet extends HttpServlet{
	
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
				String pin = (String) req.getParameter("pin");
				
				CustomerDAO cDao = new CustomerDAO();
				TransactionDAO tDao = new TransactionDAO();
				
				String dbPin = cDao.getTransactionPin(accNo);
				
					
				BigDecimal zero = new BigDecimal("0");
					
				if(amount.compareTo(zero) > 0) {
						
					// I think not necessary validation we can do this on page too i think!!
					// But just to be safe!!!
					//No this is necessary don't trust webPage
						
					BigDecimal oldBalance = cDao.getCurrentBalance(accNo);
					if(PasswordUtil.checkPassword(pin, dbPin)){		
						if(amount.compareTo(oldBalance) <= 0) {
								
							BigDecimal newBalance = oldBalance.subtract(amount);
								
							boolean isSuccess = cDao.updateBalance(accNo, newBalance);
								
							if(isSuccess) {
									
								Transaction transaction = new Transaction(accNo , "WITHDRAW" , amount);
									
								boolean transactionAdded = tDao.addNewTransaction(transaction);
									
								if(!transactionAdded) {
									//sendRedirect and message passed for error
										
									//@rollback to previous state not safe rollback
									//for safe roll back we have to impliment rollback at DB level
									//but just for a understanding
										
									cDao.updateBalance(accNo, oldBalance);
								}
									
							}
							else {
									
								//sendRedirect stating Server Error right now!
									
							}
								
						}
						else {
								
								//Send redirect stating not enough balance in account
								
						}
					}
					else {
						//SendRedirect Stating InvalidPin
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