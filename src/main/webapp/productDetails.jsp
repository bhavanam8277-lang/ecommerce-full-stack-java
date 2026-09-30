
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.ecommerce.Product" %>
<%@ page import="com.ecommerce.Review" %>

<%
    Product product = (Product) request.getAttribute("product");
    List<Review> reviews = (List<Review>) request.getAttribute("reviews");
    List<Map<String, Object>> sizes =
            (List<Map<String, Object>>) request.getAttribute("sizes");

    if (product == null) {
        response.sendRedirect("ProductServlet");
        return;
    }

    boolean needsSize = product.getId() == 4 || product.getId() == 5;

    String imageUrl = product.getImageUrl();
    if (imageUrl == null || imageUrl.trim().isEmpty()) {
        imageUrl = "images/no-image.png";
    }

    Object sessionUserId = session.getAttribute("userId");
    boolean isLoggedIn = sessionUserId != null;
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= product.getName() %> | E-Shop</title>

    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: Arial, sans-serif;
            background: #f5f7fb;
            color: #222;
        }

        header {
            background: #172554;
            color: white;
            padding: 18px 6%;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 15px;
        }

        .logo {
            font-size: 25px;
            font-weight: bold;
            color: white;
            text-decoration: none;
        }

        nav {
            display: flex;
            gap: 22px;
            flex-wrap: wrap;
        }

        nav a {
            color: white;
            text-decoration: none;
            font-weight: bold;
        }

        nav a:hover {
            color: #bfdbfe;
        }

        .breadcrumb {
            max-width: 1100px;
            margin: 22px auto;
            padding: 0 20px;
            color: #666;
            font-size: 14px;
        }

        .breadcrumb a {
            color: #1d4ed8;
            text-decoration: none;
        }

        .product-container {
            max-width: 1100px;
            margin: 0 auto 40px;
            padding: 30px;
            background: white;
            border-radius: 12px;
            box-shadow: 0 4px 18px rgba(0, 0, 0, 0.08);
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 40px;
        }

        .product-image-container {
            display: flex;
            align-items: center;
            justify-content: center;
            background: #f8fafc;
            border-radius: 10px;
            min-height: 350px;
            padding: 20px;
        }

        .product-image {
            width: 100%;
            max-width: 450px;
            max-height: 480px;
            object-fit: contain;
        }

        .product-info {
            padding: 10px 0;
        }

        .category {
            color: #64748b;
            font-size: 14px;
            text-transform: capitalize;
            margin-bottom: 12px;
        }

        h1 {
            font-size: 30px;
            line-height: 1.3;
            margin-bottom: 15px;
        }

        .price {
            font-size: 28px;
            font-weight: bold;
            color: #15803d;
            margin: 18px 0;
        }

        .stock {
            margin: 12px 0;
            font-weight: bold;
        }

        .in-stock {
            color: #15803d;
        }

        .out-stock {
            color: #dc2626;
        }

        .description {
            color: #555;
            line-height: 1.7;
            margin: 20px 0;
            white-space: pre-wrap;
        }

        .size-section {
            margin: 22px 0;
        }

        .size-section label {
            display: block;
            font-weight: bold;
            margin-bottom: 9px;
        }

        .size-section select {
            width: 100%;
            max-width: 280px;
            padding: 12px;
            border: 1px solid #cbd5e1;
            border-radius: 6px;
            background: white;
            font-size: 16px;
        }

        .button-group {
            display: flex;
            gap: 12px;
            flex-wrap: wrap;
            margin-top: 25px;
        }

        .btn {
            display: inline-block;
            border: none;
            border-radius: 6px;
            padding: 13px 22px;
            font-size: 16px;
            font-weight: bold;
            text-align: center;
            text-decoration: none;
            cursor: pointer;
        }

        .btn-cart {
            background: #2563eb;
            color: white;
        }

        .btn-buy {
            background: #f59e0b;
            color: #111827;
        }

        .btn:hover {
            opacity: 0.88;
        }

        .btn:disabled {
            background: #9ca3af;
            color: white;
            cursor: not-allowed;
            opacity: 1;
        }

        /* CUSTOMER REVIEWS */

        .reviews-section {
            max-width: 1100px;
            margin: 0 auto 45px;
            padding: 30px;
            background: white;
            border-radius: 12px;
            box-shadow: 0 4px 18px rgba(0, 0, 0, 0.06);
        }

        .reviews-section h2 {
            margin-bottom: 20px;
            font-size: 25px;
            color: #172554;
        }

        .write-review {
            margin: 25px 0;
            padding: 22px;
            background: #f8fafc;
            border: 1px solid #e2e8f0;
            border-radius: 10px;
        }

        .write-review h3 {
            margin-bottom: 18px;
            font-size: 21px;
            color: #172554;
        }

        .write-review label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: #334155;
        }

        .write-review select,
        .write-review textarea {
            display: block;
            width: 100%;
            max-width: 550px;
            padding: 12px;
            border: 1px solid #cbd5e1;
            border-radius: 6px;
            background: white;
            font-family: Arial, sans-serif;
            font-size: 16px;
            color: #222;
        }

        .write-review select {
            cursor: pointer;
        }

        .write-review textarea {
            min-height: 120px;
            resize: vertical;
        }

        .write-review select:focus,
        .write-review textarea:focus {
            outline: none;
            border-color: #2563eb;
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.12);
        }

        .write-review button {
            margin-top: 5px;
        }

        .write-review a {
            color: #2563eb;
            font-weight: bold;
            text-decoration: none;
        }

        .write-review a:hover {
            text-decoration: underline;
        }

        .review-success {
            margin: 25px 0;
            padding: 22px;
            background: #f0fdf4;
            border: 1px solid #86efac;
            border-radius: 10px;
            color: #166534;
        }

        .review-success h3 {
            margin: 0;
            font-size: 20px;
            color: #166534;
        }

        .review {
            padding: 18px 0;
            border-bottom: 1px solid #e5e7eb;
        }

        .review:last-child {
            border-bottom: none;
        }

        .review h3 {
            margin-bottom: 8px;
            font-size: 17px;
            color: #172554;
        }

        .review p {
            color: #555;
            line-height: 1.6;
            margin-top: 8px;
            overflow-wrap: anywhere;
        }

        .empty-reviews {
            color: #64748b;
            padding: 12px 0;
        }

        footer {
            text-align: center;
            padding: 22px;
            background: #172554;
            color: white;
        }

        @media (max-width: 768px) {
            .product-container {
                grid-template-columns: 1fr;
                margin: 0 12px 25px;
                padding: 20px;
                gap: 20px;
            }

            .product-image-container {
                min-height: 250px;
            }

            h1 {
                font-size: 25px;
            }

            .reviews-section {
                margin: 0 12px 25px;
                padding: 20px;
            }

            .write-review {
                padding: 16px;
            }

            header {
                padding: 18px 20px;
            }

            nav {
                gap: 14px;
            }
        }
    </style>
</head>

<body>

<header>
    <a class="logo" href="index.jsp">E-Shop</a>

    <nav>
        <a href="index.jsp">Home</a>
        <a href="ProductServlet">Products</a>
        <a href="login.jsp">Login</a>
        <a href="register.jsp">Register</a>
        <a href="cart.jsp">Cart</a>
    </nav>
</header>

<div class="breadcrumb">
    <a href="index.jsp">Home</a>
    &nbsp; / &nbsp;
    <a href="ProductServlet">Products</a>
    &nbsp; / &nbsp;
    <%= product.getName() %>
</div>

<main>
    <section class="product-container">

        <div class="product-image-container">
            <img
                class="product-image"
                src="<%= imageUrl %>"
                alt="<%= product.getName() %>"
                onerror="this.onerror=null; this.src='images/no-image.png';">
        </div>

        <div class="product-info">

            <div class="category">
                <%= product.getCategory() == null
                        ? "Product"
                        : product.getCategory() %>
            </div>

            <h1><%= product.getName() %></h1>

            <div class="price">
                &#8377;<%= String.format("%.2f", product.getPrice()) %>
            </div>

            <div class="stock <%= product.getStock() > 0
                    ? "in-stock"
                    : "out-stock" %>">
                <% if (product.getStock() > 0) { %>
                    In Stock: <%= product.getStock() %>
                <% } else { %>
                    Out of Stock
                <% } %>
            </div>

            <div class="description">
                <%= product.getDescription() == null
                        ? "No description available."
                        : product.getDescription() %>
            </div>

            <form id="productForm" method="get" action="CartServlet">

                <input
                    type="hidden"
                    name="productId"
                    value="<%= product.getId() %>">

                <% if (needsSize) { %>
                    <div class="size-section">
                        <label for="size">Select Size *</label>

                        <select id="size" name="size" required>
                            <option value="">-- Choose your size --</option>

                            <% if (sizes != null) {
                                for (Map<String, Object> sizeItem : sizes) {
                                    String sizeValue =
                                            String.valueOf(sizeItem.get("size"));

                                    int sizeStock =
                                            ((Number) sizeItem.get("stock")).intValue();
                            %>
                                <option
                                    value="<%= sizeValue %>"
                                    <%= sizeStock <= 0 ? "disabled" : "" %>>
                                    <%= sizeValue %>
                                    <%= sizeStock <= 0
                                            ? "(Out of stock)"
                                            : "" %>
                                </option>
                            <%  }
                            } %>
                        </select>
                    </div>
                <% } %>

                <div class="button-group">

                    <button
                        type="submit"
                        class="btn btn-cart"
                        <%= product.getStock() <= 0 ? "disabled" : "" %>>
                        Add to Cart
                    </button>

                    <button
                        type="button"
                        class="btn btn-buy"
                        onclick="buyNow()"
                        <%= product.getStock() <= 0 ? "disabled" : "" %>>
                        Buy Now
                    </button>

                </div>
            </form>

            <form id="buyNowForm" method="post" action="BuyNowServlet">
                <input
                    type="hidden"
                    name="productId"
                    value="<%= product.getId() %>">

                <input
                    type="hidden"
                    name="size"
                    id="buyNowSize"
                    value="">
            </form>

        </div>
    </section>

    <!-- CUSTOMER REVIEWS SECTION -->

    <section class="reviews-section">

        <h2>Customer Reviews</h2>

        <!-- WRITE A REVIEW FORM -->

        <div class="write-review">

            <% if ("true".equals(request.getParameter("success"))) { %>

                <div class="review-success">
                    Your review added successfully!
                </div>

            <% } else { %>

                <% if (isLoggedIn) { %>

                    <form action="ReviewServlet" method="post">

                        <input
                            type="hidden"
                            name="productId"
                            value="<%= product.getId() %>">

                        <label for="rating">Rating:</label>

                        <select name="rating" id="rating" required>
                            <option value="">Select rating</option>
                            <option value="5">5 - Excellent</option>
                            <option value="4">4 - Very good</option>
                            <option value="3">3 - Good</option>
                            <option value="2">2 - Fair</option>
                            <option value="1">1 - Poor</option>
                        </select>

                        <br><br>

                        <label for="reviewText">Your review:</label>

                        <textarea
                            name="reviewText"
                            id="reviewText"
                            rows="4"
                            required></textarea>

                        <br><br>

                        <button type="submit" class="btn btn-cart">
                            Submit Review
                        </button>

                    </form>

                <% } else { %>

                    <p>
                        Please <a href="login.jsp">log in</a>
                        to write a review.
                    </p>

                <% } %>

            <% } %>

        </div>

        <!-- DISPLAY EXISTING REVIEWS -->

        <% if (reviews != null && !reviews.isEmpty()) { %>

            <% for (Review review : reviews) { %>

                <div class="review">

                    <h3>
                        <%= review.getUserName() == null
                                ? "Customer"
                                : review.getUserName() %>
                    </h3>

                    <p>
                        Rating: <%= review.getRating() %>/5
                    </p>

                    <p>
                        <%= review.getReviewText() == null
                                ? ""
                                : review.getReviewText() %>
                    </p>

                </div>

            <% } %>

        <% } else { %>

            <p class="empty-reviews">
                No reviews available for this product yet.
            </p>

        <% } %>

    </section>
</main>

<footer>
    &copy; <%= java.time.Year.now().getValue() %>
    E-Shop. All rights reserved.
</footer>

<script>
    function buyNow() {
        const sizeSelect = document.getElementById("size");

        // Require a size only when this product has a size dropdown.
        if (sizeSelect && !sizeSelect.value) {
            alert("Please select a size before buying.");
            sizeSelect.focus();
            return;
        }

        const selectedSize = sizeSelect ? sizeSelect.value : "";

        document.getElementById("buyNowSize").value = selectedSize;
        document.getElementById("buyNowForm").submit();
    }
</script>

</body>
</html>