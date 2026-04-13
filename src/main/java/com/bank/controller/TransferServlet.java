package com.bank.controller;


import com.bank.dao.CustomerDAO;
import com.bank.dao.TransactionDAO;
import com.bank.model.Transaction;
import com.bank.util.PasswordUtil;

import java.math.BigDecimal;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet("/TransferServlet")
public class TransferServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
     
	public void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException 
	{
		try {
			
			HttpSession session = request.getSession(false);
			
			if(session != null && session.getAttribute("accNo") != null) {
				
				int senderAccNo = (int) (session.getAttribute("accNo"));
				int receiverAccNo = Integer.parseInt(request.getParameter("targetAcc"));
				BigDecimal amount;
				try{
					amount = new BigDecimal(request.getParameter("amount"));
				}
				catch(NumberFormatException e) {
					response.sendRedirect("transfermoney.jsp?error=invalid_amount");
					return;
				}
				String plainPin = request.getParameter("pin");
				
				CustomerDAO cDao = new CustomerDAO();
				TransactionDAO tDao = new TransactionDAO();
				
				if(PasswordUtil.checkPassword(plainPin, cDao.getTransactionPin(senderAccNo))) {
					
					BigDecimal currentSenderBalance = cDao.getCurrentBalance(senderAccNo);
					BigDecimal currentReceiverBalance = cDao.getCurrentBalance(receiverAccNo);
					
					BigDecimal diff = currentSenderBalance.subtract(amount);
					BigDecimal zero = new BigDecimal("0");
					
					if(diff.compareTo(zero) >= 0) {
						boolean senderUpdate = cDao.updateBalance(senderAccNo, diff);
						boolean receiverUpdate = cDao.updateBalance(receiverAccNo,
												 currentReceiverBalance.add(amount));
						if(senderUpdate && receiverUpdate) {
							Transaction senderTransaction = new Transaction(senderAccNo , "WITHDRAW" , amount);
							Transaction receiverTransaction = new Transaction(receiverAccNo , "DEPOSIT" , amount);
							
							boolean isTransactionSender = tDao.addNewTransaction(senderTransaction);
							boolean isTransactionReceiver = tDao.addNewTransaction(receiverTransaction);
							
							if(isTransactionSender && isTransactionReceiver) {
								response.sendRedirect("DashBoardServlet?status=success");
								return;
							}
							else {
								cDao.updateBalance(senderAccNo, currentSenderBalance);
								cDao.updateBalance(receiverAccNo, currentReceiverBalance);
								response.sendRedirect("transfermoney.jsp?error=server_error");
								return;
							}
						}
						else {
							
							//for roll back
							cDao.updateBalance(senderAccNo, currentSenderBalance);
							cDao.updateBalance(receiverAccNo, currentReceiverBalance);
							response.sendRedirect("transfermoney.jsp?error=server_error");
							return;
						}
					}
					else {
						response.sendRedirect("transfermoney.jsp?error=not_enough_balance");
						return;
					}
					
				}
				else {
					response.sendRedirect("transfermoney.jsp?error=invalid_pin");
					return;
				}
				
			}
			else {
				response.sendRedirect("login.jsp?error=unauthorized");
				return;
			}
			
		}catch(NumberFormatException e) {
			e.printStackTrace();
			response.sendRedirect("transfermoney.jsp?error=invalid_amount");
			return;
		}catch(Exception e) {
			e.printStackTrace();
			response.sendRedirect("transfermoney.jsp?error=server_error");
			return;
		}
	}
		
}
