<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Secure Login | United Bank</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-navy: #1a237e;
            --accent-blue: #3949ab;
            --bg-gray: #f0f2f5;
            --text-dark: #1e293b;
            --white: #ffffff;
            --error-red: #d32f2f;
            --success-green: #2e7d32;
        }

        body {
            margin: 0;
            padding: 0;
            font-family: 'Inter', sans-serif;
            background-color: var(--bg-gray);
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .login-card {
            background: var(--white);
            padding: 40px;
            border-radius: 16px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
            text-align: center;
        }

        .bank-logo {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--primary-navy);
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }

        h2 {
            font-size: 1.25rem;
            color: var(--text-dark);
            margin-bottom: 25px;
            font-weight: 600;
        }

        .input-group {
            margin-bottom: 20px;
            text-align: left;
        }

        label {
            display: block;
            font-size: 0.85rem;
            font-weight: 600;
            color: #64748b;
            margin-bottom: 6px;
        }

        input[type="email"],
        input[type="password"] {
            width: 100%;
            padding: 12px 16px;
            border: 1px solid #e2e8f0;
            border-radius: 8px;
            box-sizing: border-box;
            font-size: 1rem;
            transition: border-color 0.2s, box-shadow 0.2s;
        }

        input:focus {
            outline: none;
            border-color: var(--accent-blue);
            box-shadow: 0 0 0 3px rgba(57, 73, 171, 0.1);
        }

        button {
            width: 100%;
            padding: 12px;
            background-color: var(--primary-navy);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: background-color 0.2s;
            margin-top: 10px;
        }

        button:hover {
            background-color: var(--accent-blue);
        }

        .footer-links {
            margin-top: 25px;
            font-size: 0.9rem;
            color: #64748b;
        }

        .footer-links a {
            color: var(--accent-blue);
            text-decoration: none;
            font-weight: 600;
        }

        .footer-links a:hover {
            text-decoration: underline;
        }

        /* Alert Messages */
        .status-msg {
            padding: 12px;
            border-radius: 8px;
            font-size: 0.9rem;
            margin-bottom: 20px;
            font-weight: 500;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }

        .msg-error {
            background: #ffebee;
            color: var(--error-red);
            border: 1px solid #ffcdd2;
        }

        .msg-success {
            background: #e8f5e9;
            color: var(--success-green);
            border: 1px solid #c8e6c9;
        }
    </style>
</head>
<body>

    <div class="login-card">
        <div class="bank-logo">
            <span>🏦</span> UNITED BANK
        </div>
        <h2>Sign in to Online Banking</h2>

        <% 
            String status = request.getParameter("status");
            String error = request.getParameter("error");
            
            if (status != null) { 
                if(status.equals("password_updated")) {
        %>
            <div class="status-msg msg-success"><span>✅</span> Password changed successfully. Please log in again.</div>
        <%      } 
            } else if (error != null) { 
                String displayMsg = "";
                if(error.equals("invalid_password")) displayMsg = "Invalid email or password. Please try again.";
                else if(error.equals("user_not_registered")) displayMsg = "User not registered. Please open an account.";
                else if(error.equals("unauthorized")) displayMsg = "Your session has expired. Please log in to continue.";
                else if(error.equals("server_error")) displayMsg = "A server error occurred. Please try again later.";
                
                if(!displayMsg.isEmpty()) {
        %>
            <div class="status-msg msg-error"><span>⚠️</span> <%= displayMsg %></div>
        <%      }
            } 
        %>

        <form action="LoginServlet" method="post">
            <div class="input-group">
                <label>Email</label>
                <input type="email" name="email" placeholder="Enter your email" required>
            </div>

            <div class="input-group">
                <label>Password</label>
                <input type="password" name="password" placeholder="••••••••" required>
            </div>

            <button type="submit">Secure Login</button>
        </form>

        <div class="footer-links">
            <p>New user? <a href="register.jsp">Open an account here</a></p>
        </div>
    </div>

</body>
</html>