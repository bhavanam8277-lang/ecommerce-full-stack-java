<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>E-Shop | Online Store</title>

    <style>

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }

        html {
            scroll-behavior: smooth;
        }

        body {
            background: #f8fafc;
            color: #111827;
            overflow-x: hidden;
        }


        /* ================= NAVBAR ================= */

        .navbar {
            min-height: 70px;
            background: #111827;
            color: white;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 15px 7%;
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        .logo {
            font-size: 25px;
            font-weight: bold;
            white-space: nowrap;
        }

        .logo span {
            color: #60a5fa;
        }

        .nav-links {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 22px;
            list-style: none;
            flex-wrap: wrap;
        }

        .nav-links a {
            color: white;
            text-decoration: none;
            font-size: 15px;
            transition: 0.3s;
            white-space: nowrap;
        }

        .nav-links a:hover {
            color: #60a5fa;
        }


        /* ================= ADMIN LINK ================= */

        .admin-link {
            color: #fbbf24 !important;
            font-weight: bold;
        }

        .admin-link:hover {
            color: #f59e0b !important;
        }


        /* ================= CART ================= */

        .cart {
            background: #2563eb;
            padding: 10px 16px;
            border-radius: 8px;
        }

        .cart:hover {
            background: #1d4ed8;
            color: white !important;
        }


        /* ================= HERO ================= */

        .hero {
            min-height: 500px;
            padding: 70px 8%;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 50px;
            background: linear-gradient(
                135deg,
                #dbeafe,
                #eff6ff
            );
        }

        .hero-content {
            max-width: 600px;
        }

        .small-title {
            color: #2563eb;
            font-weight: bold;
            margin-bottom: 15px;
            text-transform: uppercase;
            letter-spacing: 2px;
        }

        .hero-content h1 {
            font-size: 55px;
            line-height: 1.1;
            margin-bottom: 20px;
            color: #111827;
        }

        .hero-content h1 span {
            color: #2563eb;
        }

        .hero-content p {
            color: #4b5563;
            font-size: 18px;
            line-height: 1.7;
            margin-bottom: 30px;
        }

        .shop-btn {
            display: inline-block;
            background: #2563eb;
            color: white;
            padding: 14px 28px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: bold;
            transition: 0.3s;
        }

        .shop-btn:hover {
            background: #1d4ed8;
            transform: translateY(-2px);
        }

        .hero-icon {
            width: 330px;
            height: 330px;
            border-radius: 50%;
            background: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 150px;
            box-shadow:
                0 20px 50px rgba(37, 99, 235, 0.15);
            flex-shrink: 0;
        }


        /* ================= FEATURES ================= */

        .features {
            padding: 40px 8%;
            background: white;
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 25px;
        }

        .feature {
            text-align: center;
            padding: 20px;
        }

        .feature-icon {
            font-size: 38px;
            margin-bottom: 10px;
        }

        .feature h3 {
            margin-bottom: 7px;
        }

        .feature p {
            color: #6b7280;
            font-size: 14px;
            line-height: 1.6;
        }


        /* ================= PRODUCTS ================= */

        .products {
            padding: 70px 8%;
        }

        .section-heading {
            text-align: center;
            margin-bottom: 40px;
        }

        .section-heading h2 {
            font-size: 36px;
            margin-bottom: 10px;
        }

        .section-heading p {
            color: #6b7280;
        }

        .product-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 25px;
        }


        /* ================= PRODUCT CARD ================= */

        .product-card {
            background: white;
            border-radius: 14px;
            overflow: hidden;
            box-shadow:
                0 5px 20px rgba(0, 0, 0, 0.07);
            transition: 0.3s;
        }

        .product-card:hover {
            transform: translateY(-8px);
            box-shadow:
                0 15px 30px rgba(0, 0, 0, 0.12);
        }

        .product-image {
            height: 210px;
            background: #f3f4f6;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 90px;
        }

        .product-info {
            padding: 20px;
        }

        .product-info h3 {
            font-size: 19px;
            margin-bottom: 8px;
        }

        .product-info p {
            color: #6b7280;
            font-size: 14px;
            line-height: 1.5;
            margin-bottom: 12px;
        }

        .price {
            color: #2563eb;
            font-size: 21px;
            font-weight: bold;
            margin-bottom: 15px;
        }

        .add-btn {
            display: block;
            width: 100%;
            border: none;
            background: #111827;
            color: white;
            padding: 11px;
            border-radius: 7px;
            cursor: pointer;
            font-weight: bold;
            text-align: center;
            text-decoration: none;
            transition: 0.3s;
        }

        .add-btn:hover {
            background: #2563eb;
        }


        /* ================= FOOTER ================= */

        footer {
            background: #111827;
            color: white;
            text-align: center;
            padding: 30px;
        }

        footer p {
            color: #d1d5db;
        }


        /* ================= TABLET ================= */

        @media (max-width: 1100px) {

            .navbar {
                padding: 15px 4%;
            }

            .nav-links {
                gap: 15px;
            }

            .product-grid {
                grid-template-columns: repeat(2, 1fr);
            }

            .hero-icon {
                width: 250px;
                height: 250px;
                font-size: 110px;
            }

        }


        /* ================= MOBILE ================= */

        @media (max-width: 800px) {

            .navbar {
                flex-direction: column;
                padding: 18px 5%;
                gap: 15px;
            }

            .nav-links {
                width: 100%;
                gap: 10px;
            }

            .nav-links a {
                font-size: 14px;
            }

            .hero {
                flex-direction: column;
                text-align: center;
                padding: 55px 6%;
                gap: 40px;
            }

            .hero-content {
                max-width: 100%;
            }

            .hero-content h1 {
                font-size: 40px;
            }

            .hero-content p {
                font-size: 16px;
            }

            .hero-icon {
                width: 220px;
                height: 220px;
                font-size: 90px;
            }

            .features {
                grid-template-columns: 1fr;
                padding: 35px 6%;
            }

            .products {
                padding: 50px 6%;
            }

        }


        /* ================= SMALL MOBILE ================= */

        @media (max-width: 550px) {

            .logo {
                font-size: 22px;
            }

            .nav-links {
                gap: 8px;
            }

            .nav-links a {
                font-size: 13px;
            }

            .cart {
                padding: 8px 12px;
            }

            .hero {
                padding: 45px 5%;
            }

            .hero-content h1 {
                font-size: 34px;
            }

            .hero-content p {
                font-size: 15px;
                line-height: 1.6;
            }

            .hero-icon {
                width: 180px;
                height: 180px;
                font-size: 70px;
            }

            .section-heading h2 {
                font-size: 30px;
            }

            .product-grid {
                grid-template-columns: 1fr;
            }

            .product-image {
                height: 190px;
            }

            footer {
                padding: 25px 15px;
            }

        }


        /* ================= VERY SMALL MOBILE ================= */

        @media (max-width: 380px) {

            .nav-links {
                gap: 6px;
            }

            .nav-links a {
                font-size: 12px;
            }

            .hero-content h1 {
                font-size: 30px;
            }

            .hero-icon {
                width: 160px;
                height: 160px;
                font-size: 60px;
            }

        }

    </style>

</head>


<body>


<!-- ===================================================== -->
<!-- NAVBAR -->
<!-- ===================================================== -->

<nav class="navbar">


    <!-- LOGO -->

    <div class="logo">

        &#128722;

        <span>E</span>-Shop

    </div>


    <!-- NAVIGATION -->

    <ul class="nav-links">


        <!-- HOME -->

        <li>
            <a href="index.jsp">
                Home
            </a>
        </li>


        <!-- PRODUCTS -->

        <li>
            <a href="ProductServlet">
                Products
            </a>
        </li>


        <!-- CHECK LOGIN STATUS -->

        <%

            Object loggedInUser =
                session.getAttribute("userId");

            String userRole =
                (String) session.getAttribute("userRole");

        %>


        <!-- ================= LOGGED OUT ================= -->

        <% if (loggedInUser == null) { %>


            <!-- LOGIN -->

            <li>
                <a href="login.jsp">
                    Login
                </a>
            </li>


            <!-- REGISTER -->

            <li>
                <a href="register.jsp">
                    Register
                </a>
            </li>


        <% } else { %>


            <!-- ================= LOGGED IN ================= -->


            <!-- MY ORDERS -->

            <li>
                <a href="MyOrdersServlet">
                    My Orders
                </a>
            </li>


            <!-- MY PROFILE -->

            <li>
                <a href="UserProfileServlet">
                    My Profile
                </a>
            </li>


            <!-- ================= ADMIN ONLY ================= -->

            <% if ("ADMIN".equalsIgnoreCase(userRole)) { %>

                <li>
                    <a
                        href="AdminProductServlet"
                        class="admin-link"
                    >
                        Manage Products
                    </a>
                </li>

            <% } %>


            <!-- LOGOUT -->

            <li>
                <a href="LogoutServlet">
                    Logout
                </a>
            </li>


        <% } %>


        <!-- CART -->

        <li>

            <a
                href="cart.jsp"
                class="cart"
            >
                &#128722; Cart
            </a>

        </li>


    </ul>

</nav>


<!-- ===================================================== -->
<!-- HERO -->
<!-- ===================================================== -->

<section class="hero">


    <div class="hero-content">


        <div class="small-title">

            Welcome to E-Shop

        </div>


        <h1>

            Shop Smart.<br>

            Shop <span>Easy.</span>

        </h1>


        <p>

            Discover the latest products at amazing prices.
            Find everything you need in one convenient place.

        </p>


        <a
            href="ProductServlet"
            class="shop-btn"
        >
            Shop Now &rarr;
        </a>


    </div>


    <div class="hero-icon">

        &#128717;

    </div>


</section>


<!-- ===================================================== -->
<!-- FEATURES -->
<!-- ===================================================== -->

<section class="features">


    <!-- FAST DELIVERY -->

    <div class="feature">

        <div class="feature-icon">
            &#128666;
        </div>

        <h3>
            Fast Delivery
        </h3>

        <p>
            Quick and reliable delivery to your doorstep.
        </p>

    </div>


    <!-- SECURE PAYMENT -->

    <div class="feature">

        <div class="feature-icon">
            &#128274;
        </div>

        <h3>
            Secure Payment
        </h3>

        <p>
            Your payment information is safe and secure.
        </p>

    </div>


    <!-- QUALITY PRODUCTS -->

    <div class="feature">

        <div class="feature-icon">
            &#11088;
        </div>

        <h3>
            Quality Products
        </h3>

        <p>
            Shop high-quality products at great prices.
        </p>

    </div>


</section>


<!-- ===================================================== -->
<!-- FEATURED PRODUCTS -->
<!-- ===================================================== -->

<section class="products">


    <div class="section-heading">

        <h2>
            Featured Products
        </h2>

        <p>
            Explore our popular products
        </p>

    </div>


    <div class="product-grid">


        <!-- ================================================= -->
        <!-- SMARTPHONE -->
        <!-- ================================================= -->

        <div class="product-card">


            <div class="product-image">

                &#128241;

            </div>


            <div class="product-info">

                <h3>
                    Smartphone
                </h3>

                <p>
                    Latest smartphone with powerful features.
                </p>

                <div class="price">
                    &#8377;25,000.00
                </div>

                <a
                    class="add-btn"
                    href="CartServlet?productId=2"
                >
                    Add to Cart
                </a>

            </div>

        </div>


        <!-- ================================================= -->
        <!-- LAPTOP -->
        <!-- ================================================= -->

        <div class="product-card">


            <div class="product-image">

                &#128187;

            </div>


            <div class="product-info">

                <h3>
                    Laptop
                </h3>

                <p>
                    Powerful laptop for work and entertainment.
                </p>

                <div class="price">
                    &#8377;55,000.00
                </div>

                <a
                    class="add-btn"
                    href="CartServlet?productId=1"
                >
                    Add to Cart
                </a>

            </div>

        </div>


        <!-- ================================================= -->
        <!-- HEADPHONES -->
        <!-- ================================================= -->

        <div class="product-card">


            <div class="product-image">

                &#127911;

            </div>


            <div class="product-info">

                <h3>
                    Headphones
                </h3>

                <p>
                    Enjoy high-quality sound and deep bass.
                </p>

                <div class="price">
                    &#8377;2,500.00
                </div>

                <a
                    class="add-btn"
                    href="CartServlet?productId=3"
                >
                    Add to Cart
                </a>

            </div>

        </div>


        <!-- ================================================= -->
        <!-- SMART WATCH -->
        <!-- ================================================= -->

        <div class="product-card">


            <div class="product-image">

                &#8986;

            </div>


            <div class="product-info">

                <h3>
                    Smart Watch
                </h3>

                <p>
                    Track your activities with a modern smartwatch.
                </p>

                <div class="price">
                    &#8377;3,999.00
                </div>

                <a
                    class="add-btn"
                    href="CartServlet?productId=7"
                >
                    Add to Cart
                </a>

            </div>

        </div>


    </div>

</section>


<!-- ===================================================== -->
<!-- FOOTER -->
<!-- ===================================================== -->

<footer>

    <p>
        &copy; 2026 E-Shop. All Rights Reserved.
    </p>

</footer>


</body>

</html>