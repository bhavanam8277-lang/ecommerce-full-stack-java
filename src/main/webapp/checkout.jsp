<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.ecommerce.Product" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <title>Checkout - E-Commerce</title>

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

        .nav-links {
            display: flex;
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
            max-width: 900px;
            margin: 40px auto;
        }

        h1 {
            text-align: center;
            margin-bottom: 30px;
        }

        .checkout-box {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.1);
        }

        .checkout-box h2 {
            margin-top: 0;
        }

        .order-item {
            display: flex;
            justify-content: space-between;
            padding: 15px 0;
            border-bottom: 1px solid #ddd;
        }

        .product-name {
            font-weight: bold;
        }

        .product-price {
            font-weight: bold;
        }

        .total {
            text-align: right;
            font-size: 24px;
            font-weight: bold;
            margin-top: 25px;
        }

        .place-order-container {
            text-align: center;
            margin-top: 30px;
        }

        .place-order-btn {
            background: #ff9800;
            color: white;
            border: none;
            padding: 13px 30px;
            border-radius: 6px;
            font-size: 17px;
            font-weight: bold;
            cursor: pointer;
        }

        .place-order-btn:hover {
            background: #e68900;
        }

        .back-btn {
            display: inline-block;
            margin-top: 20px;
            color: #555;
            text-decoration: none;
        }

        .back-btn:hover {
            color: #ff9800;
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


<!-- ================= CHECKOUT ================= -->

<div class="container">

    <h1>
        Checkout
    </h1>


    <div class="checkout-box">

        <h2>
            Order Summary
        </h2>


<%

    List<Product> cart =
        (List<Product>) session.getAttribute("cart");

    double total = 0;


    if (cart != null && !cart.isEmpty()) {


        for (Product product : cart) {

            total += product.getPrice();

%>


        <div class="order-item">

            <div class="product-name">

                <%= product.getName() %>

            </div>

            <div class="product-price">

                &#8377;<%= String.format(
                    "%.2f",
                    product.getPrice()
                ) %>

            </div>

        </div>


<%

        }

%>


        <div class="total">

            Total:

            &#8377;<%= String.format(
                "%.2f",
                total
            ) %>

        </div>


        <div class="place-order-container">

            <form action="payment.jsp" method="get">

                <button
                    type="submit"
                    class="place-order-btn"
                >
                     Proceed to Payment
                </button>

            </form>


            <br>


            <a
                href="cart.jsp"
                class="back-btn"
            >
                Back to Cart
            </a>

        </div>


<%

    } else {

%>


        <h2>
            Your cart is empty.
        </h2>


        <p>
            Please add products before proceeding to checkout.
        </p>


        <a
            href="ProductServlet"
            class="back-btn"
        >
            Continue Shopping
        </a>


<%

    }

%>


    </div>

</div>


</body>

</html>