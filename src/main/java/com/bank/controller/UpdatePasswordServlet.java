package com.bank.controller;

import com.bank.dao.CustomerDAO;
import com.bank.util.PasswordUtil;

import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.ServletException;

import java.io.IOException;

@WebServlet("/UpdatePasswordServlet")
public class UpdatePasswordServlet extends HttpServlet{

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
				String oldPlainPass = req.getParameter("oldPassword");
				String newPlainPass = req.getParameter("newPassword");
				
				
				CustomerDAO cDao = new CustomerDAO();
				
				if(PasswordUtil.checkPassword(oldPlainPass, cDao.getPassword(accNo) )) {
					
					String hasedNewPass = PasswordUtil.hashPassword(newPlainPass);
					boolean isSuccess = cDao.updatePassword(accNo, hasedNewPass);
					
					if(isSuccess) {
						
						//We need to invalidate session after changing password
						session.invalidate();
						
						//sendRedirect to Login Page
						resp.sendRedirect("login.jsp?status=password_updated");
						return;
					}
					else {
						resp.sendRedirect("changepassword.jsp?error=server_error");
						return;
						//SendRedirect saying pin server error
						
					}
					
				}
				else {
					resp.sendRedirect("changepassword.jsp?error=invalid_credentials");
					return;
					//sendReditect Change password page with error message password incorrect
					
				}
				
			}
			else {
				resp.sendRedirect("login.jsp?error=unauthorized");
				return;
				//session not created redirect to LoginPage
				
			}
			
		}catch(Exception e) {
			
			e.printStackTrace();
			//sendRedirect to error Page or error message
			resp.sendRedirect("changepassword.jsp?error=server_error");
			return;
		}
		
	}
	
	
}