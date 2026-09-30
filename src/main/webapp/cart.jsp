<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.util.List"
    import="java.util.ArrayList"
    import="java.util.LinkedHashMap"
    import="java.util.Map"
    import="com.ecommerce.Product" %>

<%
    String contextPath = request.getContextPath();

    @SuppressWarnings("unchecked")
    List<Product> cart =
            (List<Product>) session.getAttribute("cart");

    if (cart == null) {
        cart = new ArrayList<Product>();
    }

    String success =
            request.getParameter("success");

    String error =
            request.getParameter("error");

    /*
     * Group products by:
     *
     * product ID + size
     *
     * This allows:
     *
     * Product A = quantity 3
     * Product B = quantity 1
     */
    Map<String, List<Product>> groupedCart =
            new LinkedHashMap<String, List<Product>>();

    for (Product product : cart) {

        String productSize =
                product.getSize();

        if (productSize == null) {
            productSize = "";
        }

        String key =
                product.getId()
                + "_"
                + productSize;

        if (!groupedCart.containsKey(key)) {

            groupedCart.put(
                    key,
                    new ArrayList<Product>());
        }

        groupedCart.get(key).add(product);
    }

    double subtotal = 0.0;
%>

<!DOCTYPE html>
<html>
<head>

    <meta charset="UTF-8">

    <title>Shopping Cart | E-Shop</title>

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f5f5f5;
            color: #222;
        }

        .navbar {
            background: #222;
            color: white;
            padding: 16px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo {
            font-size: 24px;
            font-weight: bold;
        }

        .nav-links {
            display: flex;
            gap: 25px;
        }

        .nav-links a {
            color: white;
            text-decoration: none;
            font-size: 16px;
        }

        .nav-links a:hover {
            text-decoration: underline;
        }

        .container {
            width: 90%;
            max-width: 1100px;
            margin: 40px auto;
        }

        h1 {
            margin-bottom: 25px;
        }

        .message {
            padding: 14px;
            margin-bottom: 20px;
            border-radius: 5px;
        }

        .success {
            background: #d4edda;
            color: #155724;
        }

        .error {
            background: #f8d7da;
            color: #721c24;
        }

        .empty-cart {
            background: white;
            padding: 40px;
            text-align: center;
            border-radius: 8px;
        }

        .cart-item {
            background: white;
            padding: 20px;
            margin-bottom: 15px;
            border-radius: 8px;

            display: flex;
            align-items: center;
            gap: 20px;
        }

        .product-image {
            width: 120px;
            height: 120px;
            object-fit: contain;
            border-radius: 8px;
            border: 1px solid #ddd;
            padding: 5px;
        }

        .product-info {
            flex: 1;
        }

        .product-name {
            font-size: 20px;
            font-weight: bold;
            margin-bottom: 8px;
        }

        .product-price {
            font-size: 17px;
            margin-bottom: 8px;
        }

        .product-size {
            margin-bottom: 12px;
        }

        .quantity-section {
            display: flex;
            align-items: center;
            gap: 8px;
            margin-bottom: 12px;
        }

        .quantity-form {
            display: inline;
        }

        .quantity-btn {
            width: 35px;
            height: 35px;
            border: none;
            background: #222;
            color: white;
            font-size: 20px;
            border-radius: 4px;
            cursor: pointer;
        }

        .quantity-btn:hover {
            background: #444;
        }

        .quantity-btn:disabled {
            background: #aaa;
            cursor: not-allowed;
        }

        .quantity {
            min-width: 35px;
            text-align: center;
            font-weight: bold;
            font-size: 18px;
        }

        .item-total {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .remove-btn {
            border: none;
            background: #dc3545;
            color: white;
            padding: 9px 15px;
            border-radius: 4px;
            cursor: pointer;
        }

        .remove-btn:hover {
            background: #b02a37;
        }

        .summary {
            background: white;
            padding: 25px;
            margin-top: 25px;
            border-radius: 8px;
            text-align: right;
        }

        .subtotal {
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 20px;
        }

        .continue-btn {
            display: inline-block;
            padding: 12px 20px;
            background: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }

        .continue-btn:hover {
            background: #0056b3;
        }

        @media (max-width: 700px) {

            .navbar {
                padding: 15px;
            }

            .container {
                width: 95%;
            }

            .cart-item {
                flex-direction: column;
                align-items: flex-start;
            }

            .product-image {
                width: 100%;
                height: 180px;
            }

        }

    </style>

</head>

<body>

<!-- =========================
     NAVIGATION
     ========================= -->

<div class="navbar">

    <div class="logo">
        E-Shop
    </div>

    <div class="nav-links">

        <a href="<%= contextPath %>/ProductServlet">
            Products
        </a>

        <a href="<%= contextPath %>/cart.jsp">
            Cart
        </a>

    </div>

</div>


<!-- =========================
     MAIN CONTENT
     ========================= -->

<div class="container">

    <h1>
        Shopping Cart
    </h1>


    <!-- SUCCESS MESSAGE -->

    <% if (success != null) { %>

        <div class="message success">
            <%= success %>
        </div>

    <% } %>


    <!-- ERROR MESSAGE -->

    <% if (error != null) { %>

        <div class="message error">
            <%= error %>
        </div>

    <% } %>


    <!-- EMPTY CART -->

    <% if (groupedCart.isEmpty()) { %>

        <div class="empty-cart">

            <h2>
                Your cart is empty
            </h2>

            <p>
                Add some products to your cart.
            </p>

            <a
    class="continue-btn"
    href="<%= contextPath %>/ProductServlet">

    Continue Shopping

</a>

        </div>

    <% } else { %>


        <!-- =========================
             CART ITEMS
             ========================= -->

        <% for (Map.Entry<String, List<Product>> entry
                : groupedCart.entrySet()) {

            List<Product> items =
                    entry.getValue();

            Product product =
                    items.get(0);

            int quantity =
                    items.size();

            double itemTotal =
                    product.getPrice()
                    * quantity;

            subtotal += itemTotal;

            String size =
                    product.getSize();

            if (size == null) {
                size = "";
            }
        %>


        <div class="cart-item">

            <!-- PRODUCT IMAGE -->

            <%
                String imageUrl =
                        product.getImageUrl();

                if (imageUrl == null) {
                    imageUrl = "";
                }

                if (imageUrl.startsWith("images/")) {
                    imageUrl =
                            contextPath
                            + "/"
                            + imageUrl;
                } else if (!imageUrl.isEmpty()) {
                    imageUrl =
                            contextPath
                            + "/images/"
                            + imageUrl;
                }
            %>

            <% if (!imageUrl.isEmpty()) { %>

                <img
                    class="product-image"
                    src="<%= imageUrl %>"
                    alt="<%= product.getName() %>">

            <% } %>


            <!-- PRODUCT INFORMATION -->

            <div class="product-info">

                <div class="product-name">
                    <%= product.getName() %>
                </div>


                <div class="product-price">

                    Price:
                    ₹<%= String.format(
                            "%.2f",
                            product.getPrice()) %>

                </div>


                <!-- SIZE -->

                <% if (!size.isEmpty()) { %>

                    <div class="product-size">

                        <strong>
                            Size:
                        </strong>

                        <%= size %>

                    </div>

                <% } %>


                <!-- =====================
                     QUANTITY
                     ===================== -->

                <div class="quantity-section">

                    <!-- DECREASE -->

                    <form
                        class="quantity-form"
                        action="<%= contextPath %>/CartServlet"
                        method="get">

                        <input
                            type="hidden"
                            name="decreaseId"
                            value="<%= product.getId() %>">

                        <input
                            type="hidden"
                            name="size"
                            value="<%= size %>">

                        <button
                            class="quantity-btn"
                            type="submit"
                            <%= quantity <= 1
                                ? "disabled"
                                : "" %>>

                            −

                        </button>

                    </form>


                    <!-- QUANTITY -->

                    <span class="quantity">

                        <%= quantity %>

                    </span>


                    <!-- INCREASE -->

                    <form
                        class="quantity-form"
                        action="<%= contextPath %>/CartServlet"
                        method="get">

                        <input
                            type="hidden"
                            name="increaseId"
                            value="<%= product.getId() %>">

                        <input
                            type="hidden"
                            name="size"
                            value="<%= size %>">

                        <button
                            class="quantity-btn"
                            type="submit">

                            +

                        </button>

                    </form>

                </div>


                <!-- ITEM TOTAL -->

                <div class="item-total">

                    Total:
                    ₹<%= String.format(
                            "%.2f",
                            itemTotal) %>

                </div>


                <!-- REMOVE -->

                <form
                    action="<%= contextPath %>/CartServlet"
                    method="get">

                    <input
                        type="hidden"
                        name="removeId"
                        value="<%= product.getId() %>">

                    <input
                        type="hidden"
                        name="size"
                        value="<%= size %>">

                    <button
                        class="remove-btn"
                        type="submit">

                        Remove

                    </button>

                </form>

            </div>

        </div>


        <% } %>


        <!-- =========================
             SUMMARY
             ========================= -->

        <div class="summary">

           
<div class="summary">
    <div class="subtotal">
        Subtotal:
        ₹<%= String.format(
                "%.2f",
                subtotal) %>
    </div>

    <a href="<%= contextPath %>/checkout.jsp"
       class="continue-btn"
       style="background:#ff9800; margin-right:10px;">
        Proceed to Checkout
    </a>

    <a href="<%= contextPath %>/ProductServlet"
       class="continue-btn">
        Continue Shopping
    </a>
</div>

    <% } %>

</div>

</body>
</html>