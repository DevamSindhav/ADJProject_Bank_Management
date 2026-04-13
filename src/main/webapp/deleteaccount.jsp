<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Delete Account | United Bank</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-navy: #1a237e;
            --accent-gold: #ffd700;
            --text-dark: #1e293b;
            --bg-light: #f8fafc;
            --white: #ffffff;
            --error-red: #c62828; 
            --danger-dark: #7f1d1d;
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
            border: 1px solid #fecaca;
        }

        /* Left Side Panel - DANGER THEME */
        .info-panel {
            background: linear-gradient(135deg, var(--danger-dark) 0%, var(--error-red) 100%);
            color: var(--white);
            padding: 40px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .info-panel h2 { margin-bottom: 20px; font-weight: 700; display: flex; align-items: center; gap: 10px; }
        .info-panel p { opacity: 0.95; line-height: 1.6; margin-bottom: 20px; font-weight: 500;}
        .info-panel ul { padding-left: 20px; opacity: 0.9; }
        .info-panel li { margin-bottom: 12px; }

        /* Right Side Form */
        .form-panel { padding: 40px; }
        .form-header { margin-bottom: 30px; }
        .form-header h1 { font-size: 1.5rem; color: var(--error-red); margin-bottom: 8px; }

        .form-group { margin-bottom: 25px; }
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
            border-color: var(--error-red);
            box-shadow: 0 0 0 3px rgba(198, 40, 40, 0.1);
        }

        .btn-danger {
            background: var(--white);
            color: var(--error-red);
            width: 100%;
            padding: 14px;
            border: 2px solid var(--error-red);
            border-radius: 8px;
            font-weight: 700;
            font-size: 1rem;
            cursor: pointer;
            transition: all 0.3s;
            margin-top: 10px;
        }

        .btn-danger:hover {
            background: var(--error-red);
            color: var(--white);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(198, 40, 40, 0.2);
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
        <div style="font-size: 0.85rem; color: var(--error-red); font-weight: 700; letter-spacing: 0.5px;">
            ⚠️ DANGER ZONE
        </div>
    </nav>

    <div class="container">
        <div class="form-wrapper">
            <div class="info-panel">
                <h2><span>⚠️</span> Warning</h2>
                <p>You are about to permanently delete your United Bank account. Please read the following carefully:</p>
                <ul>
                    <li>All your funds must be withdrawn or transferred prior to deletion.</li>
                    <li>Your entire transaction history will be permanently erased.</li>
                    <li>You will lose access to your online banking dashboard immediately.</li>
                    <li>This action <strong>cannot</strong> be undone.</li>
                </ul>
            </div>

            <div class="form-panel">
                <div class="form-header">
                    <h1>Close Account</h1>
                    <p style="color: #64748b; font-size: 0.9rem;">To confirm your identity, please enter your login password below.</p>
                </div>

                <% 
                    String errorParam = request.getParameter("error");
                    if (errorParam != null) { 
                        String displayMsg = "An unexpected error occurred.";
                        
                        if(errorParam.equals("invalid_password")) {
                            displayMsg = "Authentication failed. The password you entered is incorrect.";
                        } else if(errorParam.equals("server_error")) {
                            displayMsg = "Account deletion failed due to a system error. Please try again or contact support.";
                        } else if(errorParam.equals("unauthorized")) {
                            displayMsg = "Your session expired. Please log in to perform this action.";
                        } else {
                            displayMsg = "Error: " + errorParam.replace("_", " ");
                        }
                %>
                    <div class="alert-box alert-error"><span>⛔</span> <%= displayMsg %></div>
                <%  } %>

                <form action="DeleteAccountServlet" method="post" id="deleteForm">
                    
                    <div class="form-group">
                        <label for="password">Confirm Password</label>
                        <input type="password" id="password" name="password" placeholder="Enter your login password" required>
                    </div>

                    <button type="submit" class="btn-danger">Permanently Delete Account</button>

                    <div style="text-align: center; margin-top: 25px;">
                        <a href="DashBoardServlet" style="color: #64748b; text-decoration: none; font-size: 0.9rem; font-weight: 600;">
                            &larr; Cancel and Return to Safety
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <footer style="text-align: center; padding: 25px; color: #94a3b8; font-size: 0.8rem;">
        &copy; 2026 United Bank Limited.
    </footer>

    <script>
        document.getElementById('deleteForm').onsubmit = function() {
            // Extra layer of friction to prevent accidental deletions
            return confirm("WARNING: This action is irreversible. All data will be wiped.\n\nAre you absolutely sure you want to PERMANENTLY delete your account?");
        };
    </script>
</body>
</html>