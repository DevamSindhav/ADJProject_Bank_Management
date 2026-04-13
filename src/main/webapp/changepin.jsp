<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Transaction PIN | United Bank</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-navy: #1a237e;
            --accent-gold: #ffd700;
            --text-dark: #1e293b;
            --bg-light: #f8fafc;
            --white: #ffffff;
            --error-red: #c62828; /* Synced with our standard red */
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
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 20px 40px rgba(0,0,0,0.1);
        }

        /* Left Side Panel */
        .info-panel {
            background: linear-gradient(135deg, #0d47a1 0%, var(--primary-navy) 100%);
            color: var(--white);
            padding: 40px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .info-panel h2 { margin-bottom: 20px; font-weight: 700; }
        .info-panel p { opacity: 0.9; line-height: 1.8; }
        .pin-hint {
            background: rgba(255, 255, 255, 0.1);
            padding: 15px;
            border-radius: 8px;
            margin-top: 20px;
            border-left: 4px solid var(--accent-gold);
        }

        /* Right Side Form */
        .form-panel { padding: 40px; }
        .form-header { margin-bottom: 30px; }
        .form-header h1 { font-size: 1.5rem; color: var(--primary-navy); margin-bottom: 8px; }

        .form-group { margin-bottom: 20px; }
        .form-group label { display: block; margin-bottom: 8px; font-weight: 600; font-size: 0.9rem; }

        .form-group input {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            font-size: 1rem;
            box-sizing: border-box;
            transition: all 0.3s ease;
        }

        .form-group input:focus {
            outline: none;
            border-color: var(--primary-navy);
            box-shadow: 0 0 0 3px rgba(26, 35, 126, 0.1);
        }

        .btn-update {
            background: var(--primary-navy);
            color: var(--white);
            width: 100%;
            padding: 14px;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            font-size: 1rem;
            cursor: pointer;
            transition: all 0.3s;
            margin-top: 10px;
        }

        .btn-update:hover {
            background: #283593;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(26, 35, 126, 0.2);
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
        <div style="font-size: 0.85rem; color: #64748b; font-weight: 600;">
            <i class="fas fa-user-lock"></i> ACCOUNT SETTINGS
        </div>
    </nav>

    <div class="container">
        <div class="form-wrapper">
            <div class="info-panel">
                <h2>Transaction PIN</h2>
                <p>Your PIN is required for every withdrawal and transfer. Keeping it updated prevents unauthorized access to your funds.</p>

                <div class="pin-hint">
                    <strong>💡 Security Tip:</strong>
                    <p style="font-size: 0.85rem; margin-top: 10px; margin-bottom: 0;">
                        Avoid simple sequences like '1234' or your birth year. Change your PIN every 90 days for maximum security.
                    </p>
                </div>
            </div>

            <div class="form-panel">
                <div class="form-header">
                    <h1>Update PIN</h1>
                    <p style="color: #64748b; font-size: 0.9rem;">Verify your password to set a new PIN.</p>
                </div>

                <% 
                    String errorParam = request.getParameter("error");
                    if (errorParam != null) { 
                        String displayMsg = "An unexpected error occurred.";
                        
                        if(errorParam.equals("invalid_password")) {
                            displayMsg = "The login password you entered is incorrect.";
                        } 
                        else if(errorParam.equals("server_error")) {
                            displayMsg = "PIN update failed due to a server error. Please try again.";
                        } 
                        else {
                            displayMsg = "Error: " + errorParam.replace("_", " ");
                        }
                %>
                    <div class="alert-box alert-error"><span>⚠️</span> <%= displayMsg %></div>
                <%  } %>

                <form action="UpdatePinServlet" method="post" id="pinForm">
                    <div class="form-group">
                        <label for="password">Login Password</label>
                        <input type="password" id="password" name="password" placeholder="Enter current password" required>
                    </div>

                    <div class="form-group">
                        <label for="newPin">New 4-Digit PIN</label>
                        <input type="password" id="newPin" name="newPin"
                               pattern="\d{4}" maxlength="4" inputmode="numeric"
                               placeholder="••••" required>
                    </div>

                    <div class="form-group">
                        <label for="confirmPin">Confirm New PIN</label>
                        <input type="password" id="confirmPin"
                               pattern="\d{4}" maxlength="4" inputmode="numeric"
                               placeholder="••••" required>
                    </div>

                    <button type="submit" class="btn-update">Change PIN Now</button>

                    <div style="text-align: center; margin-top: 20px;">
                        <a href="DashBoardServlet" style="color: #64748b; text-decoration: none; font-size: 0.85rem; font-weight: 500;">
                            &larr; Return to Dashboard
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <footer style="text-align: center; padding: 25px; color: #94a3b8; font-size: 0.8rem; background: var(--white); border-top: 1px solid #e2e8f0;">
        &copy; 2026 United Bank. Protected by 256-bit SSL Encryption.
    </footer>

    <script>
        document.getElementById('pinForm').onsubmit = function(e) {
            const pin = document.getElementById('newPin').value;
            const confirm = document.getElementById('confirmPin').value;
            const password = document.getElementById('password').value;

            if (pin !== confirm) {
                alert("The new PINs do not match. Please try again.");
                return false;
            }

            if (!/^\d{4}$/.test(pin)) {
                alert("PIN must be exactly 4 digits.");
                return false;
            }

            return true;
        };
    </script>
</body>
</html>