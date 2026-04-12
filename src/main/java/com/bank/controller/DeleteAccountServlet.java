package com.bank.controller;

import com.bank.dao.CustomerDAO;
import com.bank.util.PasswordUtil;

import javax.servlet.http.*;
import javax.servlet.ServletException;
import java.io.IOException;
import javax.servlet.annotation.WebServlet;

@WebServlet("/DeleteAccountServlet")
public class DeleteAccountServlet extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	public void doPost(HttpServletRequest req , HttpServletResponse resp)
				throws ServletException , IOException
	{
		try {
			
			HttpSession session = req.getSession(false);
			
			if(session != null && session.getAttribute("accNo") != null ) {
				
				int accNo = (int) session.getAttribute("accNo");
				String plainPassword = req.getParameter("password");
				
				CustomerDAO cDao = new CustomerDAO();
				
				if(PasswordUtil.checkPassword(plainPassword, cDao.getPassword(accNo))){
					boolean accDeleted = cDao.deleteAccountbyAccountNumber(accNo, PasswordUtil.hashPassword(plainPassword));
					
					if(accDeleted) {
						session.invalidate();
						resp.sendRedirect("index.jsp?status=account_deleted");
						return;
					}
					else {
						resp.sendRedirect("deleteaccount.jsp?error=server_error");
						return;
					}
				}
				else {
					resp.sendRedirect("deleteaccount.jsp?error=invalid_password");
					return;
				}
				
			}
			else {
				resp.sendRedirect("login.jsp?error=unauthorized");
				return;
			}
			
		}catch(Exception e) {
			e.printStackTrace();
			resp.sendRedirect("deleteaccount.jsp?error=server_error");
			return;
		}
	}
	
}