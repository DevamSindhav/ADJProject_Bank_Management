<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Transfer Funds | United Bank</title>
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
            --success-green: #10b981;
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

        /* Left Side Panel */
        .info-panel {
            background: linear-gradient(135deg, var(--primary-navy) 0%, var(--accent-blue) 100%);
            color: var(--white);
            padding: 45px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .info-panel h2 { font-size: 1.8rem; margin-bottom: 25px; }
        .secure-item {
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

        .form-group input:focus {
            outline: none;
            border-color: var(--accent-blue);
            box-shadow: 0 0 0 4px rgba(57, 73, 171, 0.1);
        }

        .btn-transfer {
            background: var(--accent-blue);
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

        .btn-transfer:hover {
            background: var(--primary-navy);
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
            SECURE PEER-TO-PEER NETWORK
        </div>
    </nav>

    <div class="container">
        <div class="form-wrapper">
            <div class="info-panel">
                <h2>Instant Transfer</h2>
                <div class="secure-item">
                    <span style="font-size: 1.5rem;">💸</span>
                    <div>
                        <strong style="display:block;">Lightning Fast</strong>
                        <small style="opacity:0.9;">Send money instantly 24/7.</small>
                    </div>
                </div>
                <div class="secure-item">
                    <span style="font-size: 1.5rem;">🔄</span>
                    <div>
                        <strong style="display:block;">Zero Fees</strong>
                        <small style="opacity:0.9;">Internal transfers are completely free.</small>
                    </div>
                </div>
                <p style="margin-top: 20px; font-size: 0.9rem; opacity: 0.8; line-height: 1.6;">
                    Ensure the recipient's account number is correct. Transfers are processed immediately and cannot be undone.
                </p>
            </div>

            <div class="form-panel">
                <div class="form-header">
                    <h1>Send Money</h1>
                    <p style="color: #64748b; font-size: 0.95rem;">Transfer funds to another United Bank account.</p>
                </div>

                <% 
                    String errorParam = request.getParameter("error");
                    if (errorParam != null) { 
                        String displayMsg = "An unexpected error occurred.";
                        
                        if(errorParam.equals("not_enough_balance")) {
                            displayMsg = "Insufficient funds. Please check your balance and try again.";
                        } 
                        else if(errorParam.equals("invalid_pin")) {
                            displayMsg = "The transaction PIN you entered is incorrect.";
                        } 
                        else if(errorParam.equals("invalid_amount") || errorParam.equals("invalid_input")) {
                            displayMsg = "Invalid amount entered. Please use valid numbers.";
                        } 
                        else if(errorParam.equals("server_error")) {
                            displayMsg = "Transaction failed. Please check the recipient's account number or try again later.";
                        } 
                        else {
                            displayMsg = "Error: " + errorParam.replace("_", " ");
                        }
                %>
                    <div class="alert-box alert-error"><span>⚠️</span> <%= displayMsg %></div>
                <%  } %>

                <form action="TransferServlet" method="post" id="transferForm">
                    <div class="form-group">
                        <label for="targetAcc">Recipient Account Number</label>
                        <input type="number" id="targetAcc" name="targetAcc" placeholder="Enter account number" required>
                    </div>

                    <div class="form-group">
                        <label for="amount">Transfer Amount</label>
                        <div class="input-wrapper">
                            <span class="currency-symbol">₹</span>
                            <input type="number" step="0.01" id="amount" name="amount" class="amount-input" placeholder="0.00" required>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="pin">Transaction PIN</label>
                        <input type="password" id="pin" name="pin" maxlength="4" pattern="\d{4}" inputmode="numeric" placeholder="••••" required>
                    </div>

                    <button type="submit" class="btn-transfer">Verify and Transfer</button>

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
        &copy; 2026 United Bank Limited. Regulated by the Reserve Bank of India (RBI).
    </footer>

    <script>
        document.getElementById('transferForm').onsubmit = function() {
            const targetAcc = document.getElementById('targetAcc').value;
            const amount = document.getElementById('amount').value;
            const pin = document.getElementById('pin').value;

            if (parseFloat(amount) <= 0) {
                alert("Please enter an amount greater than zero.");
                return false;
            }
            if (!/^\d{4}$/.test(pin)) {
                alert("Transaction PIN must be a 4-digit number.");
                return false;
            }
            if (targetAcc.trim() === "") {
                alert("Please enter a valid recipient account number.");
                return false;
            }
            return confirm("Confirm transfer of ₹" + amount + " to Account No. " + targetAcc + "?");
        };
    </script>
</body>
</html>