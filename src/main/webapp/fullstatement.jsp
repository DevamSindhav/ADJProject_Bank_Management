<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Transaction History | United Bank</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-navy: #1a237e;
            --accent-gold: #ffd700;
            --text-dark: #1e293b;
            --bg-light: #f8fafc;
            --white: #ffffff;
            --success-green: #10b981;
            --error-red: #ef4444;
            --border-color: #e2e8f0;
        }

        body {
            margin: 0;
            font-family: 'Inter', sans-serif;
            background-color: var(--bg-light);
            color: var(--text-dark);
            min-height: 100vh;
        }

        /* Navigation */
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

        /* Main Layout */
        .main-content { padding: 40px 10%; }
        
        .header-section {
            display: flex;
            justify-content: space-between;
            align-items: flex-end;
            margin-bottom: 30px;
        }

        .header-info h1 {
            font-size: 1.8rem;
            color: var(--primary-navy);
            margin: 0 0 5px 0;
        }

        .header-info p { color: #64748b; margin: 0; font-size: 0.95rem; }

        /* Controls */
        .actions { display: flex; gap: 15px; }

        .btn-print {
            background: var(--primary-navy);
            color: var(--white);
            border: none;
            padding: 12px 24px;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 8px;
            transition: opacity 0.3s;
        }

        .btn-print:hover { opacity: 0.9; }

        /* Statement Table */
        .table-card {
            background: var(--white);
            border-radius: 16px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.05);
            overflow: hidden;
            border: 1px solid var(--border-color);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            text-align: left;
        }

        th {
            background: #f8fafc;
            padding: 20px 25px;
            font-weight: 600;
            color: #475569;
            font-size: 0.85rem;
            text-transform: uppercase;
            letter-spacing: 0.025em;
            border-bottom: 1px solid var(--border-color);
        }

        td {
            padding: 20px 25px;
            border-bottom: 1px solid #f1f5f9;
            font-size: 0.95rem;
            vertical-align: middle;
        }

        tr:last-child td { border-bottom: none; }

        .txn-id {
            color: #64748b;
            font-family: monospace;
            font-weight: 600;
        }

        .txn-type {
            display: inline-block;
            padding: 6px 12px;
            border-radius: 6px;
            font-size: 0.75rem;
            font-weight: 700;
            letter-spacing: 0.05em;
        }

        .type-deposit { background: #dcfce7; color: #166534; }
        .type-withdraw { background: #fee2e2; color: #991b1b; }

        .amount { font-weight: 700; font-size: 1rem; text-align: right; }
        .amt-credit { color: var(--success-green); }
        .amt-debit { color: var(--error-red); }

        .empty-state {
            padding: 60px;
            text-align: center;
            color: #94a3b8;
        }

        /* Printing logic */
        @media print {
            nav, .actions, .footer-note { display: none !important; }
            .main-content { padding: 0; }
            .table-card { border: 1px solid #000; box-shadow: none; }
            body { background: white; }
        }
    </style>
</head>
<body>

    <nav>
        <a href="DashBoardServlet" class="logo">
            <span>🏦</span> UNITED BANK
        </a>
        <a href="DashBoardServlet" style="color: var(--primary-navy); text-decoration: none; font-weight: 600; font-size: 0.9rem;">
            &larr; Back to Dashboard
        </a>
    </nav>

    <main class="main-content">
        <div class="header-section">
            <div class="header-info">
                <h1>Account Statement</h1>
                <p>Detailed transaction history for Account No: <strong>${sessionScope.accNo}</strong></p>
            </div>
            <div class="actions">
                <button class="btn-print" onclick="window.print()">
                    <span>🖨️</span> Print Statement
                </button>
            </div>
        </div>

        <div class="table-card">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Date & Time</th>
                        <th>Narration</th>
                        <th>Status</th>
                        <th style="text-align: right;">Amount</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty allTransactions}">
                            <c:forEach var="t" items="${allTransactions}">
                                <tr>
                                    <td class="txn-id">#${t.transactionId}</td>
                                    <td>${t.timeStamp}</td>
                                    <td style="font-weight: 500;">
                                        ${t.transactionType == 'DEPOSIT' ? 'Credit to Account' : 'Debit from Account'}
                                    </td>
                                    <td>
                                        <span class="txn-type ${t.transactionType == 'DEPOSIT' ? 'type-deposit' : 'type-withdraw'}">
                                            ${t.transactionType}
                                        </span>
                                    </td>
                                    <td class="amount ${t.transactionType == 'DEPOSIT' ? 'amt-credit' : 'amt-debit'}">
                                        ${t.transactionType == 'DEPOSIT' ? '+' : '-'} ₹${t.amount}
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="5" class="empty-state">
                                    <div style="font-size: 3rem; margin-bottom: 10px;">📄</div>
                                    <p>No transaction records found for this period.</p>
                                </td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>

        <div class="footer-note" style="margin-top: 30px; text-align: center; color: #94a3b8; font-size: 0.85rem;">
            <p>&copy; 2026 United Bank. This is a computer-generated document. No signature required.</p>
            <p>Regulated by the Reserve Bank of India (RBI).</p>
        </div>
    </main>

</body>
</html>