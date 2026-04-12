<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Account Registration | United Bank</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-navy: #1a237e;
            --accent-gold: #ffd700;
            --text-dark: #1e293b;
            --bg-light: #f8fafc;
            --white: #ffffff;
            --withdraw-red: #c62828;
        }

        body { 
            background-color: var(--bg-light); 
            font-family: 'Inter', sans-serif; 
            color: var(--text-dark);
        }

        .registration-card { 
            max-width: 650px; 
            margin: 50px auto; 
            border: none; 
            border-radius: 16px; 
            box-shadow: 0 10px 30px rgba(0,0,0,0.05); 
        }

        .card-header { 
            background: linear-gradient(135deg, #1a237e 0%, #3949ab 100%); 
            color: var(--white); 
            border-radius: 16px 16px 0 0 !important; 
            padding: 25px; 
            text-align: center; 
        }

        .card-header h3 {
            font-weight: 700;
            letter-spacing: -0.5px;
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
            color: var(--withdraw-red);
            border: 1px solid #ef9a9a;
        }

        @keyframes fadeInDown {
            from { opacity: 0; transform: translateY(-10px); }
            to { opacity: 1; transform: translateY(0); }
        }
        /* --------------------------------- */

        .step-content { display: none; }
        .step-content.active { display: block; }
        
        .btn-next, .btn-submit { 
            background-color: var(--primary-navy); 
            color: var(--white); 
            font-weight: 600;
        }
        
        .btn-next:hover, .btn-submit:hover { 
            background-color: #3949ab; 
            color: var(--white); 
        }

        .form-label { 
            font-weight: 600; 
            color: var(--text-dark); 
        }
        
        .progress { 
            height: 8px; 
            margin-bottom: 30px; 
            background-color: #e2e8f0;
        }

        .progress-bar {
            background-color: var(--primary-navy);
        }

        .text-primary {
            color: var(--primary-navy) !important;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="card registration-card">
        <div class="card-header">
            <h3>🏦 Create Your Account</h3>
            <p class="mb-0">Join United Bank today.</p>
        </div>
        <div class="card-body p-4">
            
            <% 
                String errorParam = request.getParameter("error");
                if(errorParam != null) { 
                    String displayMsg = "An unexpected error occurred. Please try again.";
                    
                    if(errorParam.equals("invalid_password")) {
                        displayMsg = "Your password must be between 8 and 16 characters.";
                    } else if(errorParam.equals("invalid_pin")) {
                        displayMsg = "Your security PIN must be exactly 4 digits.";
                    } else if(errorParam.equals("underage")) {
                        displayMsg = "You must be at least 18 years old to open an account.";
                    } else if(errorParam.contains("already") || errorParam.equals("email_taken")) {
                        displayMsg = "This email is already registered. Please proceed to login.";
                    } else if(errorParam.contains("went wrong") || errorParam.contains("Server Error") || errorParam.equals("server_error")) {
                        displayMsg = "Database connection failed. Please try again later.";
                    } else {
                        displayMsg = errorParam.replace("_", " ");
                    }
            %>
                <div class="alert-box alert-error"><span>⚠️</span> <%= displayMsg %></div>
            <% } %>

            <div class="progress">
                <div id="progressBar" class="progress-bar" role="progressbar" style="width: 50%;"></div>
            </div>

            <form action="RegisterServlet" method="POST" id="regForm">
                
                <div class="step-content active" id="step1">
                    <h5 class="mb-4 text-primary">Step 1: Personal Information</h5>
                    <div class="mb-3">
                        <label class="form-label">Full Name</label>
                        <input type="text" name="fullName" class="form-control" placeholder="John Doe" required>
                    </div>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Email</label>
                            <input type="email" name="email" class="form-control" placeholder="john@example.com" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Mobile Number</label>
                            <input type="tel" name="mobileNo" class="form-control" placeholder="+123456789" required>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Date of Birth</label>
                        <input type="date" name="dob" id="dobInput" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Address</label>
                        <textarea name="address" class="form-control" rows="2" required></textarea>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Postal Code</label>
                        <input type="text" name="postalCode" class="form-control" required>
                    </div>
                    <div class="d-flex justify-content-end">
                        <button type="button" class="btn btn-next px-4" onclick="nextStep()">Next: Security Details &rarr;</button>
                    </div>
                </div>

                <div class="step-content" id="step2">
                    <h5 class="mb-4 text-primary">Step 2: Security and Initial Deposit</h5>
                    <div class="mb-3">
                        <label class="form-label">Account Type</label>
                        <select name="accType" class="form-select" required>
                            <option value="Savings">Savings Account</option>
                            <option value="Current">Current Account</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Initial Balance (Minimum $100)</label>
                        <div class="input-group">
                            <span class="input-group-text">$</span>
                            <input type="number" name="balance" class="form-control" min="100" step="0.01" required>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Set Login Password</label>
                        <input type="password" name="password" class="form-control" minlength="8" maxlength="16" placeholder="8-16 characters" required>
                        <small class="text-muted">Used to log into your internet banking portal.</small>
                    </div>

                    <div class="mb-4">
                        <label class="form-label">Set 4-Digit Security PIN</label>
                        <input type="password" name="pin" class="form-control" minlength="4" maxlength="4" pattern="\d{4}" placeholder="xxxx" required>
                        <small class="text-muted">Used to authorize withdrawals and money transfers.</small>
                    </div>
                    
                    <div class="d-flex justify-content-between">
                        <button type="button" class="btn btn-outline-secondary px-4" onclick="prevStep()">&larr; Back</button>
                        <button type="submit" class="btn btn-submit px-5">Complete Registration</button>
                    </div>
                </div>

            </form>
        </div>
    </div>
</div>

<script>
    // Age Validation: Blocks dates less than 18 years ago
    window.onload = function() {
        const dtToday = new Date();
        
        let month = dtToday.getMonth() + 1;
        let day = dtToday.getDate();
        let year = dtToday.getFullYear() - 18;

        if(month < 10) month = '0' + month.toString();
        if(day < 10) day = '0' + day.toString();

        const maxDate = year + '-' + month + '-' + day;
        document.getElementById('dobInput').setAttribute('max', maxDate);
    };

    function nextStep() {
        const step1 = document.getElementById('step1');
        const inputs = step1.querySelectorAll('input, textarea');
        let valid = true;
        
        inputs.forEach(input => {
            if (!input.checkValidity()) {
                input.reportValidity();
                valid = false;
            }
        });

        if (valid) {
            document.getElementById('step1').classList.remove('active');
            document.getElementById('step2').classList.add('active');
            document.getElementById('progressBar').style.width = '100%';
        }
    }

    function prevStep() {
        document.getElementById('step2').classList.remove('active');
        document.getElementById('step1').classList.add('active');
        document.getElementById('progressBar').style.width = '50%';
    }
</script>

</body>
</html>