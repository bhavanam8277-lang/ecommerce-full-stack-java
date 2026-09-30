<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <title>Order Confirmation - E-Commerce</title>

    <style>

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f5f5f5;
        }

        .navbar {
            background: #222;
            padding: 18px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo {
            color: white;
            font-size: 24px;
            font-weight: bold;
        }

        .nav-links a {
            color: white;
            text-decoration: none;
            margin-left: 25px;
        }

        .nav-links a:hover {
            color: #ff9800;
        }

        .container {
            width: 90%;
            max-width: 700px;
            margin: 70px auto;
        }

        .confirmation-box {
            background: white;
            padding: 45px;
            border-radius: 12px;
            text-align: center;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        .confirmation-box h1 {
            color: #28a745;
            margin-bottom: 20px;
        }

        .confirmation-box p {
            font-size: 18px;
            color: #555;
            line-height: 1.6;
        }

        .order-id {
            font-size: 20px;
            font-weight: bold;
            margin: 25px 0;
        }

        .home-btn {
            display: inline-block;
            margin-top: 20px;
            background: #ff9800;
            color: white;
            padding: 12px 25px;
            text-decoration: none;
            border-radius: 6px;
            font-weight: bold;
        }

        .home-btn:hover {
            background: #e68900;
        }

    </style>

</head>

<body>


<!-- ================= NAVBAR ================= -->

<div class="navbar">

    <div class="logo">

        &#128722; E-Commerce

    </div>


    <div class="nav-links">

        <a href="index.jsp">
            Home
        </a>

        <a href="ProductServlet">
            Products
        </a>

        <a href="cart.jsp">
            Cart
        </a>

        <a href="login.jsp">
            Login
        </a>

        <a href="register.jsp">
            Register
        </a>

    </div>

</div>


<!-- ================= CONFIRMATION ================= -->

<div class="container">

    <div class="confirmation-box">

        <h1>
            Order Placed Successfully!
        </h1>

        <p>
            Thank you for shopping with us.
        </p>

        <p>
            Your order has been successfully placed.
        </p>


<%

    Integer orderId =
        (Integer) session.getAttribute("lastOrderId");

%>


<%

    if (orderId != null) {

%>

        <div class="order-id">

            Order ID:
            #<%= orderId %>

        </div>

<%

    }

%>


        <a
            href="index.jsp"
            class="home-btn"
        >
            Continue Shopping
        </a>

    </div>

</div>


</body>

</html>