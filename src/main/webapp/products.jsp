<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@ page import="java.util.List" %>
<%@ page import="java.util.Locale" %>
<%@ page import="com.ecommerce.Product" %>

<%
    List<Product> products =
            (List<Product>) request.getAttribute("products");

    String contextPath = request.getContextPath();

    String success =
            request.getParameter("success");

    String search =
            (String) request.getAttribute("search");

    if (search == null) {
        search = "";
    }
%>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Products | E-Commerce</title>

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, Helvetica, sans-serif;
            background: #f5f5f5;
            color: #222;
        }

        /* ================= NAVBAR ================= */

        .navbar {
            background: #222;
            padding: 18px 5%;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 15px;
        }

        .logo {
            color: white;
            font-size: 24px;
            font-weight: bold;
            text-decoration: none;
        }

        .nav-links {
            display: flex;
            align-items: center;
            flex-wrap: wrap;
            gap: 22px;
        }

        .nav-links a {
            color: white;
            text-decoration: none;
        }

        .nav-links a:hover {
            color: #ff9800;
        }

        /* ================= SUCCESS MESSAGE ================= */

        .success-message {
            width: 90%;
            max-width: 700px;
            margin: 20px auto 0;
            padding: 15px;
            background: #28a745;
            color: white;
            text-align: center;
            border-radius: 8px;
            font-weight: bold;
        }

        /* ================= HEADER ================= */

        .header {
            text-align: center;
            padding: 35px 15px 20px;
        }

        .header h1 {
            margin: 0 0 10px;
            font-size: 36px;
        }

        .header p {
            color: #666;
            font-size: 17px;
        }

        /* ================= SEARCH ================= */

        .search-container {
            width: 90%;
            max-width: 750px;
            margin: 0 auto 25px;
        }

        .search-form {
            display: flex;
            gap: 10px;
        }

        .search-input {
            flex: 1;
            min-width: 0;
            padding: 13px 15px;
            border: 1px solid #ccc;
            border-radius: 7px;
            font-size: 16px;
        }

        .search-btn,
        .clear-btn {
            border: none;
            padding: 13px 20px;
            border-radius: 7px;
            color: white;
            cursor: pointer;
            font-size: 15px;
            text-decoration: none;
            display: inline-block;
        }

        .search-btn {
            background: #ff9800;
        }

        .clear-btn {
            background: #333;
        }

        .search-btn:hover {
            background: #e68900;
        }

        .clear-btn:hover {
            background: #555;
        }

        /* ================= SEARCH RESULT MESSAGE ================= */

        .search-result {
            width: 90%;
            max-width: 750px;
            margin: 0 auto 25px;
            text-align: center;
            color: #666;
            font-size: 16px;
        }

        /* ================= CATEGORY FILTER ================= */

        .category-container {
            width: 90%;
            max-width: 1200px;
            margin: 0 auto 30px;
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            gap: 10px;
        }

        .category-btn {
            background: white;
            color: #333;
            border: 1px solid #ccc;
            padding: 10px 17px;
            border-radius: 20px;
            cursor: pointer;
        }

        .category-btn:hover,
        .category-btn.active {
            background: #ff9800;
            color: white;
            border-color: #ff9800;
        }

        /* ================= PRODUCT GRID ================= */

        .product-container {
            width: 90%;
            max-width: 1250px;
            margin: auto;
            display: grid;
            grid-template-columns: repeat(4, minmax(0, 1fr));
            gap: 25px;
            padding-bottom: 50px;
        }

        /* ================= PRODUCT CARD ================= */

        .product-card {
            min-width: 0;
            background: white;
            border-radius: 12px;
            padding: 15px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            text-align: center;
            transition: transform 0.2s, box-shadow 0.2s;
        }

        .product-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
        }

        /* ================= PRODUCT IMAGE ================= */

        .product-card img {
            display: block;
            width: 100%;
            height: 200px;
            object-fit: contain;
            border-radius: 8px;
            background: #fff;
        }

        .product-name {
            margin: 15px 0 8px;
            font-size: 20px;
        }

        .category-label {
            display: inline-block;
            background: #eee;
            color: #555;
            padding: 5px 12px;
            border-radius: 15px;
            font-size: 13px;
            margin-bottom: 8px;
        }

        .description {
            color: #666;
            min-height: 40px;
            line-height: 1.5;
        }

        .price {
            font-size: 21px;
            font-weight: bold;
            margin: 12px 0;
            color: #15803d;
        }

        .stock {
            color: green;
            margin-bottom: 15px;
        }

        .out-of-stock {
            color: red;
            font-weight: bold;
        }

        /* ================= BUTTONS ================= */

        .button-container {
            display: flex;
            justify-content: center;
            align-items: center;
            flex-wrap: wrap;
            gap: 8px;
            margin-top: 12px;
        }

        .btn {
            display: inline-block;
            background: #ff9800;
            color: white;
            border: none;
            padding: 10px 14px;
            border-radius: 6px;
            cursor: pointer;
            text-decoration: none;
            font-size: 14px;
            font-family: Arial, sans-serif;
        }

        .btn:hover {
            background: #e68900;
        }

        .buy-now-btn {
            background: #28a745;
        }

        .buy-now-btn:hover {
            background: #218838;
        }

        .button-container form {
            display: inline;
            margin: 0;
        }

        /* ================= NO RESULTS ================= */

        .no-results {
            text-align: center;
            width: 90%;
            margin: 30px auto;
            font-size: 18px;
            color: #666;
        }

        /* ================= FOOTER ================= */

        .footer {
            background: #222;
            color: white;
            text-align: center;
            padding: 20px;
        }

        /* ================= RESPONSIVE ================= */

        @media (max-width: 1050px) {

            .product-container {
                grid-template-columns:
                    repeat(3, minmax(0, 1fr));
            }
        }

        @media (max-width: 750px) {

            .product-container {
                grid-template-columns:
                    repeat(2, minmax(0, 1fr));

                gap: 15px;
            }

            .navbar {
                justify-content: center;
            }

            .nav-links {
                justify-content: center;
            }
        }

        @media (max-width: 500px) {

            .product-container {
                grid-template-columns: 1fr;
            }

            .search-form {
                flex-direction: column;
            }

            .search-btn,
            .clear-btn {
                width: 100%;
                text-align: center;
            }

            .header h1 {
                font-size: 29px;
            }
        }

    </style>

</head>

<body>

<!-- ================= NAVBAR ================= -->

<div class="navbar">

    <a class="logo"
       href="<%= contextPath %>/index.jsp">
        E-Commerce
    </a>

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

        <a href="<%= contextPath %>/login.jsp">
            Login
        </a>

        <a href="<%= contextPath %>/register.jsp">
            Register
        </a>

    </div>

</div>


<!-- ================= SUCCESS MESSAGE ================= -->

<%
    if (success != null
            && !success.trim().isEmpty()) {
%>

    <div id="successMessage"
         class="success-message">

        &#10004; <%= success %>

    </div>

<%
    }
%>


<!-- ================= HEADER ================= -->

<div class="header">

    <h1>
        Our Products
    </h1>

    <p>
        Choose your favorite products
    </p>

</div>


<!-- ================= SEARCH ================= -->

<div class="search-container">

    <form
        action="<%= contextPath %>/ProductServlet"
        method="get"
        class="search-form"
    >

        <input
            type="text"
            name="search"
            class="search-input"
            placeholder="Search products..."
            value="<%= search %>"
            aria-label="Search products"
        >

        <button
            type="submit"
            class="search-btn"
        >
            Search
        </button>

        <a
            href="<%= contextPath %>/ProductServlet"
            class="clear-btn"
        >
            Clear
        </a>

    </form>

</div>


<!-- ================= SEARCH RESULT ================= -->

<%
    if (!search.trim().isEmpty()) {
%>

    <div class="search-result">

        Search results for:
        <strong><%= search %></strong>

    </div>

<%
    }
%>


<!-- ================= CATEGORY FILTERS ================= -->

<div class="category-container">

    <button
        type="button"
        class="category-btn active"
        onclick="filterCategory('All', this)"
    >
        All
    </button>

    <button
        type="button"
        class="category-btn"
        onclick="filterCategory('Electronics', this)"
    >
        Electronics
    </button>

    <button
        type="button"
        class="category-btn"
        onclick="filterCategory('Mobile', this)"
    >
        Mobile
    </button>

    <button
        type="button"
        class="category-btn"
        onclick="filterCategory('Audio', this)"
    >
        Audio
    </button>

    <button
        type="button"
        class="category-btn"
        onclick="filterCategory('Fashion', this)"
    >
        Fashion
    </button>

    <button
        type="button"
        class="category-btn"
        onclick="filterCategory('Wearables', this)"
    >
        Wearables
    </button>

    <button
        type="button"
        class="category-btn"
        onclick="filterCategory('Camera', this)"
    >
        Camera
    </button>

    <button
        type="button"
        class="category-btn"
        onclick="filterCategory('Furniture', this)"
    >
        Furniture
    </button>

</div>


<!-- ================= PRODUCTS ================= -->

<div class="product-container">

<%
    if (products != null && !products.isEmpty()) {

        for (Product product : products) {

            String imagePath =
                    product.getImageUrl();

            if (imagePath == null
                    || imagePath.trim().isEmpty()) {

                imagePath =
                    "images/no-image.png";
            }

            imagePath = imagePath.trim();

            // Remove leading slashes
            while (imagePath.startsWith("/")) {
                imagePath =
                    imagePath.substring(1);
            }

            // Add images/ only when needed
            if (!imagePath.startsWith("images/")) {
                imagePath =
                    "images/" + imagePath;
            }

            String productName =
                    product.getName() == null
                    ? "Product"
                    : product.getName();

            String productCategory =
                    product.getCategory() == null
                    ? ""
                    : product.getCategory();

            String productDescription =
                    product.getDescription() == null
                    ? "No description available."
                    : product.getDescription();

            String encodedImagePath =
                    response.encodeURL(
                        contextPath
                        + "/"
                        + imagePath
                    );
%>

    <!-- ================= PRODUCT CARD ================= -->

    <div
        class="product-card"
        data-product-name="<%= productName.toLowerCase(Locale.ROOT) %>"
        data-product-category="<%= productCategory.toLowerCase(Locale.ROOT) %>"
    >

        <!-- PRODUCT IMAGE -->

        <a
            href="<%= contextPath %>/ProductDetailsServlet?productId=<%= product.getId() %>"
            aria-label="View <%= productName %> details"
        >

            <img
                src="<%= encodedImagePath %>"
                alt="<%= productName %>"
                loading="lazy"
                onerror="this.onerror=null; this.src='<%= contextPath %>/images/no-image.png';"
            >

        </a>


        <!-- PRODUCT NAME -->

        <h3 class="product-name">
            <%= productName %>
        </h3>


        <!-- CATEGORY -->

        <div class="category-label">

            <%= productCategory.isEmpty()
                    ? "Product"
                    : productCategory %>

        </div>


        <!-- DESCRIPTION -->

        <p class="description">

            <%= productDescription %>

        </p>


        <!-- PRICE -->

        <div class="price">

            &#8377;<%= String.format(
                Locale.US,
                "%.2f",
                product.getPrice()
            ) %>

        </div>


        <!-- STOCK -->

        <%
            if (product.getStock() > 0) {
        %>

            <div class="stock">

                In Stock:
                <%= product.getStock() %>

            </div>

        <%
            } else {
        %>

            <div class="stock out-of-stock">

                Out of Stock

            </div>

        <%
            }
        %>


        <!-- BUTTONS -->

        <div class="button-container">

        <%
            if (product.getStock() > 0) {
        %>

            <!-- ADD TO CART -->

            <a
                class="btn"
                href="<%= contextPath %>/CartServlet?productId=<%= product.getId() %>"
            >
                Add to Cart
            </a>


            <!-- BUY NOW -->

            <form
                action="<%= contextPath %>/BuyNowServlet"
                method="post"
            >

                <input
                    type="hidden"
                    name="productId"
                    value="<%= product.getId() %>"
                >

                <button
                    type="submit"
                    class="btn buy-now-btn"
                >
                    Buy Now
                </button>

            </form>

        <%
            } else {
        %>

            <span
                class="btn"
                style="background:#999; cursor:not-allowed;"
            >
                Out of Stock
            </span>

        <%
            }
        %>

        </div>

    </div>

<%
        }

    } else {
%>

    <div class="no-results">

        <p>
            No products found.
        </p>

    </div>

<%
    }
%>

</div>


<!-- ================= FOOTER ================= -->

<div class="footer">

    <p>
        &copy; 2026 E-Commerce. All Rights Reserved.
    </p>

</div>


<!-- ================= JAVASCRIPT ================= -->

<script>

    let selectedCategory = "All";

    function filterCategory(category, button) {

        selectedCategory = category;

        document
            .querySelectorAll(".category-btn")
            .forEach(function(btn) {

                btn.classList.remove("active");

            });

        button.classList.add("active");

        const cards =
            document.querySelectorAll(".product-card");

        let found = false;

        cards.forEach(function(card) {

            const productCategory =
                card.getAttribute(
                    "data-product-category"
                ) || "";

            const categoryMatches =
                selectedCategory === "All"
                ||
                productCategory.includes(
                    selectedCategory.toLowerCase()
                );

            if (categoryMatches) {

                card.style.display = "";
                found = true;

            } else {

                card.style.display = "none";

            }

        });

        const noResults =
            document.querySelector(".no-results");

        if (noResults) {

            noResults.style.display =
                found ? "none" : "block";

        }
    }


    /* ================= SUCCESS MESSAGE ================= */

    const successMessage =
        document.getElementById(
            "successMessage"
        );

    if (successMessage) {

        setTimeout(function() {

            successMessage.style.display =
                "none";

        }, 3000);
    }

</script>

</body>

</html>