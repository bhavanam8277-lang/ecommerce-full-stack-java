<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.ecommerce.Order" %>
<%@ page import="com.ecommerce.Product" %>

<%
    String contextPath = request.getContextPath();

    Order order = (Order) request.getAttribute("order");
    List<Product> products =
            (List<Product>) request.getAttribute("products");
                java.util.Map<Integer, Integer> quantities =
        (java.util.Map<Integer, Integer>)
        request.getAttribute("quantities");

    Integer userId =
            (Integer) request.getAttribute("userId");

    String userName =
            (String) request.getAttribute("userName");

    String userEmail =
            (String) request.getAttribute("userEmail");

    if (order == null) {
        response.sendRedirect(
                contextPath + "/AdminOrdersServlet");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">

    <title>Admin - Order Details</title>

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f5f7fb;
            color: #333;
        }

        .header {
            background: #222;
            color: white;
            padding: 20px 40px;
        }

        .header h1 {
            margin: 0;
            font-size: 26px;
        }

        .container {
            width: 90%;
            max-width: 1100px;
            margin: 30px auto;
        }

        .card {
            background: white;
            border-radius: 10px;
            padding: 25px;
            margin-bottom: 25px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
        }

        .card h2 {
            margin-top: 0;
            color: #222;
        }

        .info-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
        }

        .info-box {
            background: #f8f9fa;
            padding: 15px;
            border-radius: 7px;
        }

        .label {
            font-size: 13px;
            color: #777;
            margin-bottom: 5px;
        }

        .value {
            font-size: 16px;
            font-weight: bold;
        }

        .status {
            display: inline-block;
            padding: 7px 14px;
            border-radius: 20px;
            background: #fff3cd;
            color: #856404;
            font-weight: bold;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
        }

        th {
            background: #222;
            color: white;
            padding: 14px;
            text-align: left;
        }

        td {
            padding: 14px;
            border-bottom: 1px solid #ddd;
            vertical-align: middle;
        }

        tr:hover {
            background: #f8f9fa;
        }

        .product-image {
            width: 70px;
            height: 70px;
            object-fit: contain;
            border-radius: 6px;
            border: 1px solid #ddd;
            background: white;
        }

        .total {
            text-align: right;
            font-size: 22px;
            font-weight: bold;
            margin-top: 20px;
        }

        .back-btn {
            display: inline-block;
            padding: 12px 22px;
            background: #222;
            color: white;
            text-decoration: none;
            border-radius: 6px;
        }

        .back-btn:hover {
            background: #444;
        }

        @media (max-width: 700px) {

            .info-grid {
                grid-template-columns: 1fr;
            }

            .container {
                width: 95%;
            }

            table {
                font-size: 13px;
            }

            th,
            td {
                padding: 8px;
            }

            .product-image {
                width: 50px;
                height: 50px;
            }
        }

    </style>
</head>

<body>

<div class="header">
    <h1>Admin - Order Details</h1>
</div>

<div class="container">

    <!-- ORDER INFORMATION -->
    <div class="card">

        <h2>Order Information</h2>

        <div class="info-grid">

            <div class="info-box">
                <div class="label">Order ID</div>
                <div class="value">
                    #<%= order.getId() %>
                </div>
            </div>

            <div class="info-box">
                <div class="label">Order Date</div>
                <div class="value">
                    <%= order.getOrderDate() %>
                </div>
            </div>

            <div class="info-box">
                <div class="label">Status</div>
                <div class="value">
                    <span class="status">
                        <%= order.getStatus() %>
                    </span>
                </div>
            </div>

            <div class="info-box">
                <div class="label">Total Amount</div>
                <div class="value">
                    &#8377;<%= String.format("%.2f",
                            order.getTotalAmount()) %>
                </div>
            </div>

        </div>

    </div>


    <!-- CUSTOMER INFORMATION -->
    <div class="card">

        <h2>Customer Information</h2>

        <div class="info-grid">

            <div class="info-box">
                <div class="label">User ID</div>
                <div class="value">
                    <%= userId != null ? userId : "" %>
                </div>
            </div>

            <div class="info-box">
                <div class="label">Customer Name</div>
                <div class="value">
                    <%= userName != null ? userName : "" %>
                </div>
            </div>

            <div class="info-box">
                <div class="label">Email</div>
                <div class="value">
                    <%= userEmail != null ? userEmail : "" %>
                </div>
            </div>

        </div>

    </div>


    <!-- PRODUCTS -->
    <div class="card">

        <h2>Ordered Products</h2>

        <table>

            <thead>
                <tr>
                    <th>Image</th>
                    <th>Product</th>
                    <th>Price</th>
                    <th>Quantity</th>
                    <th>Subtotal</th>
                </tr>
            </thead>

            <tbody>

            <%
                if (products != null && !products.isEmpty()) {

                    for (Product product : products) {

                        String imageUrl =
                                product.getImageUrl();

                        String finalImageUrl;

                        if (imageUrl == null
                                || imageUrl.trim().isEmpty()) {

                            finalImageUrl =
                                    contextPath
                                    + "/images/no-image.png";

                        } else if (
                                imageUrl.startsWith("http://")
                                || imageUrl.startsWith("https://")) {

                            finalImageUrl = imageUrl;

                        } else if (imageUrl.startsWith("/")) {

                            finalImageUrl =
                                    contextPath + imageUrl;

                        } else if (imageUrl.startsWith("images/")) {

                            finalImageUrl =
                                    contextPath + "/" + imageUrl;

                        } else {

                            finalImageUrl =
                                    contextPath
                                    + "/images/"
                                    + imageUrl;
                        }
            %>

                <tr>

                    <td>
                        <img
                            src="<%= finalImageUrl %>"
                            class="product-image"
                            alt="Product"
                            onerror="this.src='<%= contextPath %>/images/no-image.png';">
                    </td>

                    <td>
                        <strong>
                            <%= product.getName() %>
                        </strong>
                    </td>

                    <td>
                        &#8377;<%= String.format("%.2f",
                                product.getPrice()) %>
                    </td>

                    <td>
    <%
        Integer quantity = quantities != null
                ? quantities.get(product.getId())
                : null;
    %>

    <%= quantity != null ? quantity : 0 %>
</td>

                    <td>
    <%
        double subtotal = quantity != null
                ? product.getPrice() * quantity
                : 0.0;
    %>

    &#8377;<%= String.format("%.2f", subtotal) %>
</td>

                </tr>

            <%
                    }
                } else {
            %>

                <tr>
                    <td colspan="5"
                        style="text-align:center;">
                        No products found for this order.
                    </td>
                </tr>

            <%
                }
            %>

            </tbody>

        </table>

        <div class="total">
            Total:
            &#8377;<%= String.format("%.2f",
                    order.getTotalAmount()) %>
        </div>

    </div>


    <!-- BACK BUTTON -->
    <a
        href="<%= contextPath %>/AdminOrdersServlet"
        class="back-btn">
        Back to All Orders
    </a>

</div>

</body>
</html>