<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="java.util.List" %>
<%@ page import="com.ecommerce.Product" %>

<%
    String contextPath = request.getContextPath();
%>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <title>Order Details - E-Commerce</title>

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
            max-width: 1000px;
            margin: 40px auto;
        }

        h1 {
            text-align: center;
            margin-bottom: 30px;
        }

        .order-box {
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 3px 10px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }

        .order-item {
            display: flex;
            align-items: center;
            gap: 25px;
            padding: 20px 0;
            border-bottom: 1px solid #ddd;
        }

        .order-item:last-child {
            border-bottom: none;
        }

        .order-item img {
            width: 120px;
            height: 100px;
            object-fit: contain;
        }

        .details {
            flex: 1;
        }

        .details h3 {
            margin: 0 0 10px;
        }

        .details p {
            color: #555;
        }

        .price {
            font-weight: bold;
            margin-top: 8px;
        }

        .total {
            text-align: right;
            font-size: 24px;
            font-weight: bold;
            margin-top: 20px;
        }

        .back-btn {
            display: block;
            width: fit-content;
            margin: 25px auto;
            padding: 12px 25px;
            background: #ff9800;
            color: white;
            text-decoration: none;
            border-radius: 6px;
            font-weight: bold;
        }

        .back-btn:hover {
            background: #e68900;
        }

        .empty {
            text-align: center;
            background: white;
            padding: 40px;
            border-radius: 10px;
        }

        @media (max-width: 600px) {

            .navbar {
                padding: 15px;
            }

            .nav-links a {
                margin-left: 10px;
            }

            .order-item {
                flex-direction: column;
                text-align: center;
            }

            .total {
                text-align: center;
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

        <a href="<%= contextPath %>/index.jsp">
            Home
        </a>

        <a href="<%= contextPath %>/ProductServlet">
            Products
        </a>

        <a href="<%= contextPath %>/cart.jsp">
            Cart
        </a>

        <a href="<%= contextPath %>/MyOrdersServlet">
            My Orders
        </a>

    </div>

</div>


<!-- ================= ORDER DETAILS ================= -->

<div class="container">

    <h1>
        &#128230; Order Details
    </h1>


<%

    Integer orderId =
        (Integer) request.getAttribute("orderId");

    List<Product> products =
        (List<Product>) request.getAttribute("products");

    List<Integer> quantities =
        (List<Integer>) request.getAttribute("quantities");

    List<Double> prices =
        (List<Double>) request.getAttribute("prices");

    Double orderTotal =
        (Double) request.getAttribute("orderTotal");


    if (products != null && !products.isEmpty()) {

%>


    <div class="order-box">

        <h2>
            Order ID: #<%= orderId %>
        </h2>


<%

        for (int i = 0; i < products.size(); i++) {

            Product product =
                products.get(i);

            int quantity =
                quantities.get(i);

            double price =
                prices.get(i);

            double itemTotal =
                price * quantity;

            String imageUrl =
                product.getImageUrl();

            String finalImageUrl;

            /*
             * Handle different possible values stored
             * in the database.
             */

            if (imageUrl == null || imageUrl.trim().isEmpty()) {

                finalImageUrl =
                    contextPath + "/images/no-image.png";

            }
            else if (imageUrl.startsWith("http://") ||
                     imageUrl.startsWith("https://")) {

                finalImageUrl =
                    imageUrl;

            }
            else if (imageUrl.startsWith("/")) {

                finalImageUrl =
                    contextPath + imageUrl;

            }
            else if (imageUrl.startsWith("images/")) {

                finalImageUrl =
                    contextPath + "/" + imageUrl;

            }
            else {

                finalImageUrl =
                    contextPath + "/images/" + imageUrl;

            }

%>


        <div class="order-item">


            <!-- PRODUCT IMAGE -->

            <img
                src="<%= finalImageUrl %>"
                alt="<%= product.getName() %>"
                onerror="this.src='<%= contextPath %>/images/no-image.png';"
            >


            <div class="details">

                <h3>
                    <%= product.getName() %>
                </h3>

                <p>
                    <%= product.getDescription() %>
                </p>

                <div class="price">

                    Price:
                    &#8377;<%= String.format(
                        "%.2f",
                        price
                    ) %>

                </div>

                <div class="price">

                    Quantity:
                    <%= quantity %>

                </div>

                <div class="price">

                    Item Total:
                    &#8377;<%= String.format(
                        "%.2f",
                        itemTotal
                    ) %>

                </div>

            </div>


        </div>


<%

        }

%>


        <div class="total">

            Order Total:
            &#8377;<%= String.format(
                "%.2f",
                orderTotal
            ) %>

        </div>


    </div>


    <a
        href="<%= contextPath %>/MyOrdersServlet"
        class="back-btn"
    >
        ← Back to My Orders
    </a>


<%

    } else {

%>


    <div class="empty">

        <h2>
            Order details not found
        </h2>

        <p>
            The selected order could not be found.
        </p>

        <a
            href="<%= contextPath %>/MyOrdersServlet"
            class="back-btn"
        >
            Back to My Orders
        </a>

    </div>


<%

    }

%>


</div>


</body>

</html>