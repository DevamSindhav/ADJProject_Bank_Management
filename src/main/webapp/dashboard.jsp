<%@ page import="com.bank.model.Customer, com.bank.model.Transaction, java.util.List, java.math.BigDecimal" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // We grab the data package prepared by DashBoardServlet
    Customer customer = (Customer) request.getAttribute("customer");
    List<Transaction> miniStatement = (List<Transaction>) request.getAttribute("miniStatement");

    // If the customer object is missing
    if (customer == null) {
        response.sendRedirect("DashBoardServlet");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard | United Bank</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-navy: #1a237e;
            --accent-blue: #3949ab;
            --success-green: #2e7d32;
            --withdraw-red: #c62828;
            --bg-light: #f4f7fa;
            --white: #ffffff;
            --text-dark: #1e293b;
            --shadow: 0 4px 20px rgba(0,0,0,0.08);
        }

        body { font-family: 'Inter', sans-serif; background-color: var(--bg-light); margin: 0; color: #2c3e50; }

        header {
            background: var(--primary-navy);
            color: white;
            padding: 1rem 5%;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: var(--shadow);
        }

        /* PROFILE DROPDOWN MENU */
        .dropdown { position: relative; display: inline-block; }

        .profile-btn {
            background: rgba(255, 255, 255, 0.1);
            color: white;
            padding: 8px 16px;
            border-radius: 20px;
            cursor: pointer;
            font-weight: 600;
            font-size: 0.9rem;
            border: 1px solid rgba(255, 255, 255, 0.2);
            transition: background 0.3s;
        }

        .profile-btn:hover { background: rgba(255, 255, 255, 0.2); }

        .dropdown-content {
            display: none;
            position: absolute;
            right: 0;
            margin-top: 10px;
            background-color: var(--white);
            min-width: 180px;
            box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.1);
            border-radius: 8px;
            overflow: hidden;
            z-index: 10;
        }

        .dropdown-content a {
            color: var(--text-dark);
            padding: 12px 16px;
            text-decoration: none;
            display: block;
            font-size: 0.85rem;
            font-weight: 500;
            border-bottom: 1px solid #f0f2f5;
        }

        .dropdown-content a:hover { background-color: #f8fafc; }
        
        /* The JS will toggle this class instead of using hover */
        .dropdown-content.show { display: block; }

        .container { max-width: 1100px; margin: 30px auto; padding: 0 20px; }

        /* --- UNIVERSAL ALERT COMPONENT --- */
        .alert-box {
            padding: 14px 20px;
            border-radius: 8px;
            margin-bottom: 25px;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 12px;
            font-size: 0.95rem;
            animation: fadeInDown 0.4s ease-out;
        }
        
        .alert-success {
            background-color: #e8f5e9;
            color: var(--success-green);
            border: 1px solid #a5d6a7;
        }
        
        .alert-error {
            background-color: #ffebee;
            color: var(--withdraw-red);
            border: 1px solid #ef9a9a;
        }

        @keyframes fadeInDown {
            from { opacity: 0; transform: translateY(-10px); }
            to { opacity: 1; transform: translateY(0); }
        }
        /* --------------------------------- */

        /* BALANCE SECTION */
        .balance-card {
            background: linear-gradient(135deg, var(--primary-navy) 0%, var(--accent-blue) 100%);
            color: white;
            padding: 35px;
            border-radius: 16px;
            box-shadow: 0 10px 30px rgba(26, 35, 126, 0.2);
            margin-bottom: 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        /* GRID FOR NAVIGATION CARDS */
        .action-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .card {
            background: var(--white);
            padding: 30px 25px;
            border-radius: 12px;
            box-shadow: var(--shadow);
            display: flex;
            flex-direction: column;
            align-items: center;
            text-align: center;
            transition: transform 0.2s, box-shadow 0.2s;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.12);
        }

        .card-icon { font-size: 3rem; margin-bottom: 15px; }
        .card h3 { margin: 0 0 20px 0; font-size: 1.2rem; color: var(--primary-navy); }

        .btn-action {
            width: 100%;
            padding: 12px;
            border-radius: 8px;
            color: white;
            font-weight: 600;
            text-decoration: none;
            display: inline-block;
            box-sizing: border-box;
            transition: opacity 0.2s;
        }
        
        .btn-action:hover { opacity: 0.9; }

        /* RECENT TRANSACTIONS TABLE */
        .statement-box { background: var(--white); padding: 25px; border-radius: 12px; box-shadow: var(--shadow); }
        table { width: 100%; border-collapse: collapse; margin-top: 15px; }
        th { text-align: left; padding: 12px; background: #f8f9fa; color: var(--primary-navy); font-size: 0.85rem; }
        td { padding: 12px; border-bottom: 1px solid #eee; font-size: 0.9rem; }

        .btn-link {
            text-decoration: none;
            padding: 12px 20px;
            border-radius: 8px;
            background: var(--primary-navy);
            color: white;
            font-weight: 600;
            display: inline-block;
            margin-top: 20px;
        }
    </style>
</head>
<body>

<header>
    <div style="font-weight: 700; font-size: 1.4rem;">🏦 UNITED BANK</div>
    
    <div style="display: flex; align-items: center; gap: 20px;">
        <div style="font-size: 0.9rem;">
            Welcome, <strong><%= customer.getFullName() %></strong>
        </div>
        
        <div class="dropdown">
            <div class="profile-btn" onclick="toggleDropdown()">⚙️ Profile ▼</div>
            <div id="profileMenu" class="dropdown-content">
                <a href="changepassword.jsp">🔑 Change Password</a>
                <a href="changepin.jsp">🔢 Change PIN</a>
                <a href="LogoutServlet">🚪 Logout</a>
                <a href="deleteaccount.jsp" style="color: var(--withdraw-red); border-top: 1px solid #f0f2f5;">⚠️ Delete Account</a>
            </div>
        </div>
    </div>
</header>

<div class="container">

    <% 
        String status = request.getParameter("status");
        String error = request.getParameter("error");
        
        if (status != null) { 
            String displayMsg = "Transaction Successful! Your account has been updated.";
            if(status.equals("pin_updated")) displayMsg = "Your security PIN has been updated successfully.";
    %>
        <div class="alert-box alert-success"><span>✅</span> <%= displayMsg %></div>
        
    <%  } 
        else if (error != null) { 
            String displayMsg = "An error occurred: " + error.replace("_", " ");
            if(error.equals("server_error")) displayMsg = "A server error occurred. Please try again later.";
    %>
        <div class="alert-box alert-error"><span>⚠️</span> <%= displayMsg %></div>
    <%  } %>

    <div class="balance-card">
        <div>
            <h3 style="margin:0; opacity:0.8; font-weight:400;">Current Balance</h3>
            <div style="font-size: 2.8rem; font-weight: 700; margin: 5px 0;">₹ <%= String.format("%.2f", customer.getBalance()) %></div>
            <div style="font-family: monospace; opacity: 1;">Account: <%= customer.getAccountNumber() %></div>
        </div>
        <div style="font-size: 4rem; opacity: 0.2;">💰</div>
    </div>

    <div class="action-grid">
        
        <div class="card">
            <div class="card-icon">💵</div>
            <h3>Deposit Funds</h3>
            <a href="deposit.jsp" class="btn-action" style="background: var(--success-green);">Make a Deposit</a>
        </div>

        <div class="card">
            <div class="card-icon">🏧</div>
            <h3>Withdraw Cash</h3>
            <a href="withdraw.jsp" class="btn-action" style="background: var(--withdraw-red);">Make a Withdrawal</a>
        </div>

        <div class="card">
            <div class="card-icon">💸</div>
            <h3>Transfer Money</h3>
            <a href="transfermoney.jsp" class="btn-action" style="background: var(--accent-blue);">Send Money</a>
        </div>

    </div>

    <div class="statement-box">
        <h3 style="color: var(--primary-navy);">Recent Activity</h3>
        <table>
            <thead>
                <tr>
                    <th>Description</th>
                    <th style="text-align: right;">Amount</th>
                </tr>
            </thead>
            <tbody>
                <%
                    if (miniStatement == null || miniStatement.isEmpty()) {
                %>
                        <tr><td colspan="2" style="text-align:center; padding: 20px; color: #999;">No transactions found.</td></tr>
                <%
                    } else {
                        for (Transaction t : miniStatement) {
                            boolean isCredit = "DEPOSIT".equalsIgnoreCase(t.getTransactionType()) || "RECEIVED".equalsIgnoreCase(t.getTransactionType()) || "TRANSFER IN".equalsIgnoreCase(t.getTransactionType());
                %>
                        <tr>
                            <td style="font-weight: 600; font-size: 0.85rem;"><%= t.getTransactionType() %></td>
                            <td style="text-align: right; font-weight: 700; color: <%= isCredit ? "var(--success-green)" : "var(--withdraw-red)" %>;">
                                <%= isCredit ? "+" : "-" %> ₹<%= String.format("%.2f", t.getAmount()) %>
                            </td>
                        </tr>
                <%
                        }
                    }
                %>
            </tbody>
        </table>
        <div style="text-align: right;">
            <a href="FullStatementServlet" class="btn-link">View Full Statement</a>
        </div>
    </div>

</div>

<footer style="text-align: center; padding: 30px; color: #999; font-size: 0.75rem;">
    &copy; 2026 United Bank Digital Banking. All transactions are encrypted.
</footer>

<script>
    function toggleDropdown() {
        document.getElementById("profileMenu").classList.toggle("show");
    }

    // Close the dropdown if the user clicks anywhere else on the screen
    window.onclick = function(event) {
        if (!event.target.matches('.profile-btn')) {
            var dropdowns = document.getElementsByClassName("dropdown-content");
            for (var i = 0; i < dropdowns.length; i++) {
                var openDropdown = dropdowns[i];
                if (openDropdown.classList.contains('show')) {
                    openDropdown.classList.remove('show');
                }
            }
        }
    }
</script>

</body>
</html>