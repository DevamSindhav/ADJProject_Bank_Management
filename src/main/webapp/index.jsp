<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>United Bank | Your Trusted Financial Partner</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-navy: #1a237e;
            --accent-gold: #ffd700;
            --text-dark: #1e293b;
            --bg-light: #f8fafc;
            --white: #ffffff;
            --withdraw-red: #c62828;
            --success-green: #2e7d32;
        }

        body {
            margin: 0;
            font-family: 'Inter', sans-serif;
            background-color: var(--bg-light);
            color: var(--text-dark);
            line-height: 1.6;
        }

        /* Navigation Bar */
        nav {
            background: var(--white);
            padding: 1.5rem 10%;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        .logo {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--primary-navy);
            letter-spacing: -0.5px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        /* --- UNIVERSAL ALERT COMPONENT --- */
        .alert-container {
            position: absolute;
            top: 90px; /* Just below the nav */
            left: 50%;
            transform: translateX(-50%);
            width: 90%;
            max-width: 600px;
            z-index: 999;
        }

        .alert-box {
            padding: 14px 20px;
            border-radius: 8px;
            font-weight: 500;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 12px;
            font-size: 0.95rem;
            box-shadow: 0 10px 25px rgba(0,0,0,0.15);
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
            from { opacity: 0; transform: translate(-50%, -20px); }
            to { opacity: 1; transform: translate(-50%, 0); }
        }
        /* --------------------------------- */

        /* Hero Section */
        .hero {
            background: linear-gradient(135deg, #1a237e 0%, #3949ab 100%);
            color: var(--white);
            padding: 120px 10% 100px; /* Increased top padding to clear alerts */
            text-align: center;
            clip-path: ellipse(150% 100% at 50% 0%); 
            position: relative;
        }

        .hero h1 {
            font-size: 3.5rem;
            margin-bottom: 1.5rem;
            font-weight: 800;
            letter-spacing: -1px;
        }

        .hero p {
            font-size: 1.25rem;
            opacity: 0.9;
            max-width: 700px;
            margin: 0 auto 2.5rem;
        }

        /* Call to Action Buttons */
        .cta-container {
            display: flex;
            gap: 20px;
            justify-content: center;
        }

        .btn {
            padding: 16px 32px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 600;
            font-size: 1rem;
            transition: all 0.3s ease;
            display: inline-block;
        }

        .btn-register {
            background: var(--white);
            color: var(--primary-navy);
        }

        .btn-register:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.2);
        }

        .btn-login {
            background: transparent;
            color: var(--white);
            border: 2px solid var(--white);
        }

        .btn-login:hover {
            background: rgba(255, 255, 255, 0.1);
        }

        /* Features Section */
        .features {
            padding: 80px 10%;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 40px;
            margin-top: -50px; 
        }

        .feature-card {
            background: var(--white);
            padding: 40px;
            border-radius: 16px;
            text-align: center;
            box-shadow: 0 10px 30px rgba(0,0,0,0.05);
            transition: 0.3s;
        }

        .feature-card:hover {
            transform: translateY(-10px);
        }

        .icon {
            font-size: 2.5rem;
            margin-bottom: 20px;
            display: block;
        }

        .feature-card h3 {
            margin-bottom: 15px;
            color: var(--primary-navy);
        }

        footer {
            text-align: center;
            padding: 50px;
            color: #64748b;
            font-size: 0.9rem;
        }
    </style>
</head>
<body>

    <nav>
        <div class="logo">
            <span>🏦</span> UNITED BANK
        </div>
        <div style="display: flex; gap: 30px;">
            <a href="login.jsp" style="text-decoration:none; color: var(--text-dark); font-weight:600;">Support</a>
            <a href="login.jsp" style="text-decoration:none; color: var(--text-dark); font-weight:600;">Security</a>
        </div>
    </nav>

    <% 
        String status = request.getParameter("status");
        String error = request.getParameter("error");
        
        if (status != null || error != null) {
    %>
        <div class="alert-container">
            <% if (status != null) { 
                String displayMsg = "Operation successful.";
                if(status.equals("logged_out")) displayMsg = "You have been successfully securely logged out.";
                else if(status.equals("account_deleted")) displayMsg = "Account deleted succesfuly!";
            %>
                <div class="alert-box alert-success"><span>✅</span> <%= displayMsg %></div>
            
            <% } else if (error != null) { 
                String displayMsg = "An unexpected error occurred.";
                if(error.equals("unauthorized")) displayMsg = "Please log in to access your account.";
            %>
                <div class="alert-box alert-error"><span>⚠️</span> <%= displayMsg %></div>
            <% } %>
        </div>
    <% } %>

    <section class="hero">
        <h1>Welcome to the Future of Banking</h1>
        <p>Experience seamless, secure, and smart financial management with United Bank. Your journey to financial freedom starts here.</p>
        
        <div class="cta-container">
            <a href="register.jsp" class="btn btn-register">Open New Account</a>
            <a href="login.jsp" class="btn btn-login">Customer/Admin Login</a>
        </div>
    </section>

    <section class="features">
        <div class="feature-card">
            <span class="icon">🔒</span>
            <h3>Secure Transfers</h3>
            <p>Advanced encryption to keep your money and data safe 24/7.</p>
        </div>
        <div class="feature-card">
            <span class="icon">⚡</span>
            <h3>Instant Deposits</h3>
            <p>Experience real-time credit to your account with zero waiting time.</p>
        </div>
        <div class="feature-card">
            <span class="icon">📉</span>
            <h3>e-Statements</h3>
            <p>Detailed digital transaction history at the click of a button.</p>
        </div>
    </section>

    <footer>
        <p>&copy; 2026 United Bank Limited. Member FDIC. Licensed by the Reserve Bank.</p>
    </footer>

</body>
</html>