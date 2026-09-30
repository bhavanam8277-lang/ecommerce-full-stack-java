<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.ecommerce.Product" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <title>Payment - E-Commerce</title>

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
            max-width: 600px;
            margin: 50px auto;
        }

        .payment-box {
            background: white;
            padding: 35px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }

        h1 {
            text-align: center;
            margin-bottom: 30px;
        }

        .amount {
            background: #f5f5f5;
            padding: 20px;
            border-radius: 8px;
            text-align: center;
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 25px;
        }

        label {
            display: block;
            margin-top: 15px;
            margin-bottom: 7px;
            font-weight: bold;
        }

        input,
        select {
            width: 100%;
            padding: 12px;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 16px;
        }

        .pay-btn {
            width: 100%;
            margin-top: 25px;
            padding: 14px;
            background: #ff9800;
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 18px;
            font-weight: bold;
            cursor: pointer;
        }

        .pay-btn:hover {
            background: #e68900;
        }

        .back-btn {
            display: block;
            text-align: center;
            margin-top: 15px;
            color: #333;
            text-decoration: none;
        }

        .back-btn:hover {
            color: #ff9800;
        }

    </style>

</head>

<body>

    <!-- NAVBAR -->

    <div class="navbar">

        <div class="logo">
            &#128722; E-Commerce
        </div>

        <div class="nav-links">

            <a href="index.jsp">Home</a>

            <a href="ProductServlet">Products</a>

            <a href="cart.jsp">Cart</a>

        </div>

    </div>


    <!-- PAYMENT -->

    <div class="container">

        <div class="payment-box">

            <h1>
                &#128179; Payment
            </h1>


<%

    List<Product> cart =
        (List<Product>) session.getAttribute("cart");

    double total = 0;

    if (cart != null) {

        for (Product product : cart) {

            total += product.getPrice();

        }

    }

%>


            <div class="amount">

                Total Amount:

                &#8377;<%= String.format(
                    "%.2f",
                    total
                ) %>

            </div>


            <form action="PlaceOrderServlet" method="post">


                <label>
                    Payment Method
                </label>

                <select name="paymentMethod" required>

                    <option value="">
                        Select Payment Method
                    </option>

                    <option value="UPI">
                        UPI
                    </option>

                    <option value="Card">
                        Credit / Debit Card
                    </option>

                    <option value="Net Banking">
                        Net Banking
                    </option>

                    <option value="Cash on Delivery">
                        Cash on Delivery
                    </option>

                </select>


                <label>
                    Name on Card
                </label>

                <input
                    type="text"
                    name="cardName"
                    placeholder="Enter name"
                >


                <label>
                    Card Number
                </label>

                <input
                    type="text"
                    name="cardNumber"
                    placeholder="Enter card number"
                    maxlength="16"
                >


                <label>
                    Expiry Date
                </label>

                <input
                    type="text"
                    name="expiry"
                    placeholder="MM/YY"
                    maxlength="5"
                >


                <label>
                    CVV
                </label>

                <input
                    type="password"
                    name="cvv"
                    placeholder="Enter CVV"
                    maxlength="3"
                >


                <button
                    type="submit"
                    class="pay-btn"
                >

                    Pay Now

                </button>

            </form>


            <a
                href="checkout.jsp"
                class="back-btn"
            >

                ← Back to Checkout

            </a>

        </div>

    </div>

</body>

</html>