<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Password | United Bank</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-navy: #1a237e;
            --accent-gold: #ffd700;
            --text-dark: #1e293b;
            --bg-light: #f8fafc;
            --white: #ffffff;
            --error-red: #c62828; /* Synced with our standard red */
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
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 20px 40px rgba(0,0,0,0.1);
        }

        /* Left side - Information */
        .info-panel {
            background: linear-gradient(135deg, var(--primary-navy) 0%, #3949ab 100%);
            color: var(--white);
            padding: 40px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .info-panel h2 { margin-bottom: 20px; font-weight: 700; }
        .info-panel ul { padding-left: 20px; opacity: 0.9; }
        .info-panel li { margin-bottom: 12px; }

        /* Right side - The Form */
        .form-panel { padding: 40px; }

        .form-header { margin-bottom: 30px; }
        .form-header h1 { font-size: 1.5rem; color: var(--primary-navy); margin-bottom: 5px; }

        .form-group { margin-bottom: 20px; }
        .form-group label { display: block; margin-bottom: 8px; font-weight: 600; font-size: 0.9rem; }

        .form-group input {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            font-size: 1rem;
            box-sizing: border-box;
            transition: border-color 0.3s;
        }

        .form-group input:focus {
            outline: none;
            border-color: var(--primary-navy);
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
            transition: transform 0.2s, background 0.3s;
        }

        .btn-update:hover {
            background: #283593;
            transform: translateY(-2px);
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
        <div style="font-size: 0.9rem; color: #64748b; font-weight: 600;">
            Secure Session Active
        </div>
    </nav>

    <div class="container">
        <div class="form-wrapper">
            <div class="info-panel">
                <h2>Security Shield</h2>
                <p>Keeping your account safe is our top priority. When updating your password, ensure it follows these rules:</p>
                <ul>
                    <li>Minimum 8 characters long</li>
                    <li>Include at least one uppercase letter</li>
                    <li>Include one number and one symbol</li>
                    <li>Do not use your date of birth or name</li>
                </ul>
            </div>

            <div class="form-panel">
                <div class="form-header">
                    <h1>Change Password</h1>
                    <p style="color: #64748b; font-size: 0.9rem;">Please enter your current and new credentials.</p>
                </div>

                <% 
                    String errorParam = request.getParameter("error");
                    if (errorParam != null) { 
                        String displayMsg = "An unexpected error occurred.";
                        
                        if(errorParam.equals("invalid_password") || errorParam.equals("invalid_credentials")) {
                            displayMsg = "The current password you entered is incorrect.";
                        } 
                        else if(errorParam.equals("server_error")) {
                            displayMsg = "System update failed due to a server error. Please try again.";
                        } 
                        else {
                            displayMsg = "Error: " + errorParam.replace("_", " ");
                        }
                %>
                    <div class="alert-box alert-error"><span>⚠️</span> <%= displayMsg %></div>
                <%  } %>

                <form action="UpdatePasswordServlet" method="post">
                    <div class="form-group">
                        <label for="oldPassword">Current Password</label>
                        <input type="password" id="oldPassword" name="oldPassword" placeholder="••••••••" required>
                    </div>

                    <div class="form-group">
                        <label for="newPassword">New Password</label>
                        <input type="password" id="newPassword" name="newPassword" placeholder="••••••••" required>
                    </div>

                    <div class="form-group">
                        <label for="confirmPassword">Confirm New Password</label>
                        <input type="password" id="confirmPassword" placeholder="••••••••" required>
                    </div>

                    <button type="submit" class="btn-update">Update Securely</button>

                    <div style="text-align: center; margin-top: 20px;">
                        <a href="DashBoardServlet" style="color: #64748b; text-decoration: none; font-size: 0.85rem; font-weight: 600;">&larr; Cancel and Return</a>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <footer style="text-align: center; padding: 20px; color: #94a3b8; font-size: 0.8rem;">
        &copy; 2026 United Bank Security Protocol. Verified by RSA-256.
    </footer>

    <script>
        // Simple front-end validation to check if passwords match before sending to servlet
        const form = document.querySelector('form');
        const newPass = document.getElementById('newPassword');
        const confirmPass = document.getElementById('confirmPassword');

        form.onsubmit = function(e) {
            if (newPass.value !== confirmPass.value) {
                alert("New password and confirmation do not match!");
                return false;
            }
            return true;
        };
    </script>
</body>
</html>