<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Register | E-Shop</title>

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }

        body {
            min-height: 100vh;
            background: linear-gradient(135deg, #dbeafe, #eff6ff);
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .register-container {
            width: 420px;
            background: white;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.12);
        }

        .logo {
            text-align: center;
            font-size: 30px;
            font-weight: bold;
            color: #111827;
            margin-bottom: 10px;
        }

        .logo span {
            color: #2563eb;
        }

        .subtitle {
            text-align: center;
            color: #6b7280;
            margin-bottom: 30px;
        }

        .form-group {
            margin-bottom: 18px;
        }

        label {
            display: block;
            margin-bottom: 7px;
            font-weight: bold;
            color: #374151;
        }

        input {
            width: 100%;
            padding: 13px;
            border: 1px solid #d1d5db;
            border-radius: 8px;
            font-size: 15px;
            outline: none;
        }

        input:focus {
            border-color: #2563eb;
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
        }

        .register-btn {
            width: 100%;
            padding: 13px;
            border: none;
            border-radius: 8px;
            background: #2563eb;
            color: white;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            margin-top: 10px;
        }

        .register-btn:hover {
            background: #1d4ed8;
        }

        .login-link {
            text-align: center;
            margin-top: 20px;
            color: #6b7280;
        }

        .login-link a {
            color: #2563eb;
            text-decoration: none;
            font-weight: bold;
        }

        .login-link a:hover {
            text-decoration: underline;
        }

        .back-home {
            text-align: center;
            margin-top: 15px;
        }

        .back-home a {
            color: #374151;
            text-decoration: none;
            font-size: 14px;
        }

        .back-home a:hover {
            color: #2563eb;
        }

        .error-message {
            color: #dc2626;
            text-align: center;
            margin-bottom: 15px;
            font-weight: bold;
        }

        .success-message {
            color: #16a34a;
            text-align: center;
            margin-bottom: 15px;
            font-weight: bold;
        }
    </style>
</head>

<body>

    <div class="register-container">

        <div class="logo">
            E<span>-Shop</span>
        </div>

        <p class="subtitle">
            Create your account
        </p>

        <% 
            String error = request.getParameter("error");
            String success = request.getParameter("success");
        %>

        <% if (error != null) { %>
            <div class="error-message">
                <%= error %>
            </div>
        <% } %>

        <% if (success != null) { %>
            <div class="success-message">
                <%= success %>
            </div>
        <% } %>

        <form action="RegisterServlet" method="post"
              onsubmit="return validatePassword()">

            <div class="form-group">

                <label for="name">Full Name</label>

                <input
                    type="text"
                    id="name"
                    name="name"
                    placeholder="Enter your full name"
                    required>

            </div>

            <div class="form-group">

                <label for="email">Email Address</label>

                <input
                    type="email"
                    id="email"
                    name="email"
                    placeholder="Enter your email"
                    required>

            </div>

            <div class="form-group">

                <label for="password">Password</label>

                <input
                    type="password"
                    id="password"
                    name="password"
                    placeholder="Create a password"
                    required>

            </div>

            <div class="form-group">

                <label for="confirmPassword">Confirm Password</label>

                <input
                    type="password"
                    id="confirmPassword"
                    name="confirmPassword"
                    placeholder="Confirm your password"
                    required>

            </div>

            <button type="submit" class="register-btn">
                Create Account
            </button>

        </form>

        <div class="login-link">

            Already have an account?

            <a href="login.jsp">
                Login
            </a>

        </div>

        <div class="back-home">

            <a href="index.jsp">
                ← Back to Home
            </a>

        </div>

    </div>

    <script>

        function validatePassword() {

            let password =
                document.getElementById("password").value;

            let confirmPassword =
                document.getElementById("confirmPassword").value;

            if (password !== confirmPassword) {

                alert("Passwords do not match!");

                return false;
            }

            return true;
        }

    </script>

</body>

</html>