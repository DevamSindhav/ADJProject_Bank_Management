<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Deposit Funds | United Bank</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-navy: #1a237e;
            --accent-blue: #3949ab;
            --accent-gold: #ffd700;
            --text-dark: #1e293b;
            --bg-light: #f8fafc;
            --white: #ffffff;
            --error-red: #c62828;
        }

        body {
            margin: 0;
            font-family: 'Inter', sans-serif;
            background-color: var(--bg-light);
            color: var(--text-dark);
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        nav {
            background: var(--white);
            padding: 1rem 10%;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }

        .logo {
            font-size: 1.2rem;
            font-weight: 700;
            color: var(--primary-navy);
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .container {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 40px 10%;
        }

        .form-wrapper {
            background: var(--white);
            width: 100%;
            max-width: 900px;
            display: grid;
            grid-template-columns: 1fr 1fr;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.15);
        }

        /* Left Side Panel - Now updated to Navy/Blue gradient */
        .info-panel {
            background: linear-gradient(135deg, var(--primary-navy) 0%, var(--accent-blue) 100%);
            color: var(--white);
            padding: 45px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .info-panel h2 { font-size: 1.8rem; margin-bottom: 25px; font-weight: 700; }
        .feature-item {
            display: flex;
            align-items: center;
            gap: 15px;
            margin-bottom: 20px;
            background: rgba(255, 255, 255, 0.1);
            padding: 15px;
            border-radius: 12px;
        }

        /* Right Side Form */
        .form-panel { padding: 45px; }
        .form-header { margin-bottom: 35px; }
        .form-header h1 { font-size: 1.6rem; color: var(--primary-navy); margin-bottom: 10px; }

        .form-group { margin-bottom: 22px; }
        .form-group label { display: block; margin-bottom: 8px; font-weight: 600; font-size: 0.9rem; color: #475569; }

        .input-wrapper { position: relative; }
        .currency-symbol {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #64748b;
            font-weight: 600;
        }

        .form-group input {
            width: 100%;
            padding: 14px 15px;
            border: 2px solid #e2e8f0;
            border-radius: 10px;
            font-size: 1rem;
            box-sizing: border-box;
            transition: all 0.3s ease;
        }

        .form-group input.amount-input { padding-left: 40px; }

        /* Updated focus state to Navy */
        .form-group input:focus {
            outline: none;
            border-color: var(--primary-navy);
            box-shadow: 0 0 0 4px rgba(26, 35, 126, 0.1);
        }

        /* Updated button to Navy */
        .btn-deposit {
            background: var(--primary-navy);
            color: var(--white);
            width: 100%;
            padding: 16px;
            border: none;
            border-radius: 10px;
            font-weight: 700;
            font-size: 1.05rem;
            cursor: pointer;
            transition: all 0.3s;
            margin-top: 15px;
        }

        .btn-deposit:hover {
            background: #283593;
            transform: translateY(-2px);
            box-shadow: 0 10px 15px rgba(26, 35, 126, 0.2);
        }

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
        
        .alert-error {
            background-color: #ffebee;
            color: var(--error-red);
            border: 1px solid #ef9a9a;
        }

        @keyframes fadeInDown {
            from { opacity: 0; transform: translateY(-10px); }
            to { opacity: 1; transform: translateY(0); }
        }
        /* --------------------------------- */
    </style>
</head>
<body>

    <nav>
        <a href="DashBoardServlet" class="logo">
            <span>🏦</span> UNITED BANK
        </a>
        <div style="font-size: 0.85rem; color: #64748b; font-weight: 600; letter-spacing: 0.5px;">
            VERIFIED SECURE DEPOSIT
        </div>
    </nav>

    <div class="container">
        <div class="form-wrapper">
            <div class="info-panel">
                <h2>Easy Deposit</h2>
                <div class="feature-item">
                    <span style="font-size: 1.5rem;">⚡</span>
                    <div>
                        <strong style="display:block;">Instant Credit</strong>
                        <small style="opacity:0.9;">Funds reflect in your account immediately.</small>
                    </div>
                </div>
                <div class="feature-item">
                    <span style="font-size: 1.5rem;">✅</span>
                    <div>
                        <strong style="display:block;">Zero Charges</strong>
                        <small style="opacity:0.9;">No hidden fees for online deposits.</small>
                    </div>
                </div>
                <p style="margin-top: 20px; font-size: 0.9rem; opacity: 0.8; line-height: 1.6;">
                    Make sure the amount entered is correct. Once authorized, the transaction cannot be reversed automatically.
                </p>
            </div>

            <div class="form-panel">
                <div class="form-header">
                    <h1>Add Money</h1>
                    <p style="color: #64748b; font-size: 0.95rem;">Enter the amount to credit your account.</p>
                </div>

                <% 
                    String errorParam = request.getParameter("error");
                    if (errorParam != null) { 
                        String displayMsg = "An unexpected error occurred.";
                        
                        if(errorParam.equals("invalid_amount") || errorParam.equals("invalid_input")) {
                            displayMsg = "Invalid amount entered. Please use valid numbers.";
                        } 
                        else if(errorParam.equals("server_error")) {
                            displayMsg = "Transaction failed due to a server error. Please try again later.";
                        } 
                        else {
                            displayMsg = "Error: " + errorParam.replace("_", " ");
                        }
                %>
                    <div class="alert-box alert-error"><span>⚠️</span> <%= displayMsg %></div>
                <%  } %>

                <form action="DepositServlet" method="post" id="depositForm">
                    <div class="form-group">
                        <label for="amount">Deposit Amount</label>
                        <div class="input-wrapper">
                            <span class="currency-symbol">₹</span>
                            <input type="number" step="100" id="amount" name="amount" class="amount-input" placeholder="0.00" required>
                        </div>
                    </div>

                    <p style="font-size: 0.8rem; color: #94a3b8; margin-bottom: 20px;">
                        By clicking below, you authorize a credit transaction to your account ending in ${sessionScope.accNo % 10000}.
                    </p>

                    <button type="submit" class="btn-deposit">Confirm & Deposit</button>

                    <div style="text-align: center; margin-top: 25px;">
                        <a href="DashBoardServlet" style="color: #64748b; text-decoration: none; font-size: 0.9rem; font-weight: 600;">
                            &larr; Cancel and Return
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <footer style="text-align: center; padding: 25px; color: #94a3b8; font-size: 0.8rem;">
        &copy; 2026 United Bank Limited. Secure Gateway 2.0.
    </footer>

    <script>
        document.getElementById('depositForm').onsubmit = function() {
            const amount = document.getElementById('amount').value;
            if (parseFloat(amount) <= 0) {
                alert("Please enter a valid deposit amount greater than ₹0.");
                return false;
            }
            return confirm("Confirm deposit of ₹" + amount + " to your account?");
        };
    </script>
</body>
</html>