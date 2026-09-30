<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="java.util.List" %>
<%@ page import="com.ecommerce.Order" %>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <title>My Orders - E-Commerce</title>

    <style>

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f5f5f5;
        }

        /* ================= NAVBAR ================= */

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

        /* ================= CONTENT ================= */

        .container {
            width: 90%;
            max-width: 1000px;
            margin: 40px auto;
        }

        h1 {
            text-align: center;
            margin-bottom: 30px;
        }

        /* ================= ORDER CARD ================= */

        .order-card {
            background: white;
            padding: 25px;
            margin-bottom: 20px;
            border-radius: 10px;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.1);
        }

        .order-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 12px 0;
            border-bottom: 1px solid #eee;
        }

        .order-row:last-child {
            border-bottom: none;
        }

        .label {
            font-weight: bold;
        }

        .status {
            color: #ff9800;
            font-weight: bold;
        }

        .total {
            font-size: 20px;
            font-weight: bold;
        }

        /* ================= VIEW DETAILS BUTTON ================= */

        .details-btn {
            display: inline-block;
            background: #ff9800;
            color: white;
            padding: 10px 18px;
            text-decoration: none;
            border-radius: 6px;
            font-weight: bold;
        }

        .details-btn:hover {
            background: #e68900;
        }

        /* ================= CANCEL BUTTON ================= */

        .cancel-btn {
            display: inline-block;
            margin-left: 10px;
            background: #e74c3c;
            color: white;
            padding: 10px 18px;
            border: none;
            border-radius: 6px;
            font-weight: bold;
            cursor: pointer;
        }

        .cancel-btn:hover {
            background: #c0392b;
        }

        .cancel-form {
            display: inline-block;
        }

        /* ================= EMPTY ================= */

        .empty {
            background: white;
            padding: 40px;
            text-align: center;
            border-radius: 10px;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.1);
        }

        .shop-btn {
            display: inline-block;
            margin-top: 20px;
            background: #ff9800;
            color: white;
            padding: 12px 22px;
            text-decoration: none;
            border-radius: 6px;
            font-weight: bold;
        }

        .shop-btn:hover {
            background: #e68900;
        }

        /* ================= MOBILE ================= */

        @media (max-width: 700px) {

            .navbar {
                padding: 15px 20px;
                flex-direction: column;
                gap: 15px;
            }

            .nav-links {
                text-align: center;
            }

            .nav-links a {
                margin: 5px 8px;
                display: inline-block;
            }

            .order-row {
                flex-direction: column;
                align-items: flex-start;
                gap: 8px;
            }

            .details-btn {
                margin-top: 5px;
            }

            .cancel-btn {
                margin-left: 0;
                margin-top: 8px;
            }

            .cancel-form {
                display: block;
            }
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

        <a href="MyOrdersServlet">
            My Orders
        </a>

        <a href="login.jsp">
            Login
        </a>

        <a href="register.jsp">
            Register
        </a>

    </div>

</div>


<!-- ================= CONTENT ================= -->

<div class="container">

    <h1>
        My Orders
    </h1>

<%
    List<Order> orders =
        (List<Order>) request.getAttribute("orders");

    if (orders != null && !orders.isEmpty()) {

        for (Order order : orders) {
%>

        <!-- ================= ORDER CARD ================= -->

        <div class="order-card">

            <!-- ORDER ID -->

            <div class="order-row">

                <span class="label">
                    Order ID
                </span>

                <span>
                    #<%= order.getId() %>
                </span>

            </div>


            <!-- TOTAL AMOUNT -->

            <div class="order-row">

                <span class="label">
                    Total Amount
                </span>

                <span class="total">

                    &#8377;<%= String.format(
                        "%.2f",
                        order.getTotalAmount()
                    ) %>

                </span>

            </div>


            <!-- STATUS -->

            <div class="order-row">

                <span class="label">
                    Status
                </span>

                <span class="status">
                    <%= order.getStatus() %>
                </span>

            </div>


            <!-- ORDER DATE -->

            <div class="order-row">

                <span class="label">
                    Order Date
                </span>

                <span>
                    <%= order.getOrderDate() %>
                </span>

            </div>


            <!-- ================= ACTIONS ================= -->

            <div class="order-row">

                <span class="label">
                    Action
                </span>

                <span>

                    <!-- VIEW DETAILS -->

                    <a
                        href="OrderDetailsServlet?orderId=<%= order.getId() %>"
                        class="details-btn"
                    >
                        View Details
                    </a>


                    <%
                        String currentStatus =
                            order.getStatus();

                        if ("PENDING".equalsIgnoreCase(currentStatus)
                                || "CONFIRMED".equalsIgnoreCase(currentStatus)) {
                    %>

                        <!-- CANCEL ORDER -->

                        <form
                            action="CancelOrderServlet"
                            method="post"
                            class="cancel-form"
                            onsubmit="return confirm('Are you sure you want to cancel this order?');"
                        >

                            <input
                                type="hidden"
                                name="orderId"
                                value="<%= order.getId() %>"
                            >

                            <button
                                type="submit"
                                class="cancel-btn"
                            >
                                Cancel Order
                            </button>

                        </form>

                    <%
                        }
                    %>

                </span>

            </div>

        </div>


<%
        }

    } else {
%>


        <!-- ================= NO ORDERS ================= -->

        <div class="empty">

            <h2>
                No Orders Found
            </h2>

            <p>
                You have not placed any orders yet.
            </p>

            <a
                href="ProductServlet"
                class="shop-btn"
            >
                Start Shopping
            </a>

        </div>


<%
    }
%>

</div>

</body>

</html>