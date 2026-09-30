<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<%
    HttpSession currentSession = request.getSession(false);

    String role = null;

    if (currentSession != null) {
        role = (String) currentSession.getAttribute("userRole");
    }

    if (role == null || !role.equalsIgnoreCase("ADMIN")) {
        response.sendRedirect("index.jsp?error=Access%20denied");
        return;
    }

    Integer totalUsers =
        (Integer) request.getAttribute("totalUsers");

    Integer totalProducts =
        (Integer) request.getAttribute("totalProducts");

    Integer totalOrders =
        (Integer) request.getAttribute("totalOrders");

    Double totalSales =
        (Double) request.getAttribute("totalSales");

    if (totalUsers == null) {
        totalUsers = 0;
    }

    if (totalProducts == null) {
        totalProducts = 0;
    }

    if (totalOrders == null) {
        totalOrders = 0;
    }

    if (totalSales == null) {
        totalSales = 0.0;
    }
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Admin Dashboard | E-Shop</title>

    <style>

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, Helvetica, sans-serif;
            background: #f4f7f9;
            color: #263238;
        }

        /* ================= NAVBAR ================= */

        .navbar {
            width: 100%;
            background: #202830;
            padding: 22px 42px;

            display: flex;
            align-items: center;
            justify-content: space-between;

            box-shadow:
                0 2px 8px rgba(0, 0, 0, 0.12);
        }

        .logo {
            color: white;
            font-size: 28px;
            font-weight: bold;
        }

        .nav-links {
            list-style: none;

            display: flex;
            align-items: center;

            gap: 40px;
        }

        .nav-links a {
            color: white;
            text-decoration: none;

            font-size: 16px;
            font-weight: 500;

            transition: 0.2s;
        }

        .nav-links a:hover {
            color: #dddddd;
        }

        /* ================= MAIN ================= */

        .container {
            width: 92%;
            max-width: 1320px;

            margin: 42px auto 55px;
        }

        .title {
            margin-bottom: 28px;
        }

        .title h1 {
            font-size: 42px;
            margin-bottom: 8px;

            color: #263238;
        }

        .title p {
            font-size: 18px;
            color: #64748b;
        }

        /* ================= STATISTICS ================= */

        .stats {
            display: grid;

            grid-template-columns:
                repeat(2, 1fr);

            gap: 26px;

            margin-bottom: 28px;
        }

        .stat-card {
            background: white;

            min-height: 160px;

            border-radius: 14px;

            padding: 28px;

            display: flex;
            align-items: center;

            box-shadow:
                0 5px 18px rgba(0, 0, 0, 0.08);
        }

        .stat-icon {
            width: 70px;
            height: 70px;

            border-radius: 50%;

            display: flex;
            align-items: center;
            justify-content: center;

            font-size: 34px;

            margin-right: 28px;

            flex-shrink: 0;
        }

        .users-icon {
            background: #e3f0ff;
        }

        .products-icon {
            background: #dff8e9;
        }

        .orders-icon {
            background: #eee4ff;
        }

        .sales-icon {
            background: #fff0bd;
        }

        .stat-content h3 {
            font-size: 18px;
            color: #54606b;

            margin-bottom: 12px;
        }

        .stat-number {
            font-size: 34px;
            font-weight: bold;

            color: #263238;

            margin-bottom: 8px;
        }

        .stat-description {
            font-size: 16px;
            color: #78838d;
        }

        /* ================= ACTION CARDS ================= */

        .actions {
            display: grid;

            grid-template-columns:
                repeat(2, 1fr);

            gap: 26px;
        }

        .action-card {
            background: white;

            border-radius: 14px;

            padding: 28px 32px;

            min-height: 170px;

            box-shadow:
                0 5px 18px rgba(0, 0, 0, 0.08);
        }

        .action-card h2 {
            font-size: 22px;

            margin-bottom: 10px;

            color: #263238;
        }

        .action-card p {
            color: #687680;

            font-size: 16px;

            margin-bottom: 20px;
        }

        .btn {
            display: inline-block;

            background: #202830;
            color: white;

            text-decoration: none;

            padding: 12px 24px;

            border-radius: 7px;

            font-size: 16px;

            transition: 0.2s;
        }

        .btn:hover {
            background: #111820;

            transform: translateY(-1px);
        }

        /* ================= BACK BUTTON ================= */

        .back-section {
            text-align: center;

            margin-top: 34px;
        }

        .back-link {
            color: #263238;

            text-decoration: none;

            font-size: 18px;

            font-weight: bold;
        }

        .back-link:hover {
            text-decoration: underline;
        }

        /* ================= RESPONSIVE ================= */

        @media (max-width: 900px) {

            .navbar {
                padding: 18px 25px;

                flex-direction: column;

                gap: 18px;
            }

            .nav-links {
                gap: 22px;

                flex-wrap: wrap;

                justify-content: center;
            }

            .stats {
                grid-template-columns: 1fr;
            }

            .actions {
                grid-template-columns: 1fr;
            }

            .title h1 {
                font-size: 34px;
            }
        }

        @media (max-width: 600px) {

            .container {
                width: 92%;

                margin-top: 30px;
            }

            .navbar {
                padding: 18px;
            }

            .logo {
                font-size: 24px;
            }

            .nav-links {
                gap: 14px;
            }

            .nav-links a {
                font-size: 14px;
            }

            .stat-card {
                padding: 22px;
            }

            .stat-icon {
                width: 58px;
                height: 58px;

                font-size: 27px;

                margin-right: 18px;
            }

            .stat-number {
                font-size: 28px;
            }

            .action-card {
                padding: 24px;
            }
        }

    </style>

</head>

<body>

    <!-- ================= NAVBAR ================= -->

    <nav class="navbar">

        <div class="logo">
            E-Shop Admin
        </div>

        <ul class="nav-links">

            <li>
                <a href="index.jsp">
                    Home
                </a>
            </li>

            <li>
                <a href="ProductServlet">
                    Products
                </a>
            </li>

            <li>
                <a href="MyOrdersServlet">
                    My Orders
                </a>
            </li>

            <li>
                <a href="UserProfileServlet">
                    My Profile
                </a>
            </li>

            <li>
                <a href="LogoutServlet">
                    Logout
                </a>
            </li>

        </ul>

    </nav>


    <!-- ================= MAIN ================= -->

    <main class="container">

        <div class="title">

            <h1>
                Admin Dashboard
            </h1>

            <p>
                Manage and monitor your E-Shop system.
            </p>

        </div>


        <!-- ================= STATISTICS ================= -->

        <section class="stats">

            <!-- USERS -->

            <div class="stat-card">

                <div class="stat-icon users-icon">
                    👥
                </div>

                <div class="stat-content">

                    <h3>
                        Total Users
                    </h3>

                    <div class="stat-number">
                        <%= totalUsers %>
                    </div>

                    <div class="stat-description">
                        Registered users
                    </div>

                </div>

            </div>


            <!-- PRODUCTS -->

            <div class="stat-card">

                <div class="stat-icon products-icon">
                    📦
                </div>

                <div class="stat-content">

                    <h3>
                        Total Products
                    </h3>

                    <div class="stat-number">
                        <%= totalProducts %>
                    </div>

                    <div class="stat-description">
                        Products available
                    </div>

                </div>

            </div>


            <!-- ORDERS -->

            <div class="stat-card">

                <div class="stat-icon orders-icon">
                    🛒
                </div>

                <div class="stat-content">

                    <h3>
                        Total Orders
                    </h3>

                    <div class="stat-number">
                        <%= totalOrders %>
                    </div>

                    <div class="stat-description">
                        Orders placed
                    </div>

                </div>

            </div>


            <!-- SALES -->

            <div class="stat-card">

                <div class="stat-icon sales-icon">
                    ₹
                </div>

                <div class="stat-content">

                    <h3>
                        Total Sales
                    </h3>

                    <div class="stat-number">
                        &#8377;<%= String.format("%,.2f", totalSales) %>
                    </div>

                    <div class="stat-description">
                        Total order value
                    </div>

                </div>

            </div>

        </section>


        <!-- ================= ADMIN ACTIONS ================= -->

        <section class="actions">

            <!-- MANAGE PRODUCTS -->

            <div class="action-card">

                <h2>
                    Manage Products
                </h2>

                <p>
                    View and manage products in your store.
                </p>

                <a href="ProductServlet"
                   class="btn">
                    View Products
                </a>

            </div>


            <!-- VIEW ORDERS -->

            <div class="action-card">

                <h2>
                    View Orders
                </h2>

                <p>
                    View customer orders and order details.
                </p>

                <a href="AdminOrdersServlet"
   class="btn">
    View Orders
</a>

            </div>


            <!-- USER PROFILE -->

            <div class="action-card">

                <h2>
                    User Profile
                </h2>

                <p>
                    View your administrator profile.
                </p>

                <a href="UserProfileServlet"
                   class="btn">
                    My Profile
                </a>

            </div>

        </section>


        <!-- ================= BACK ================= -->

        <div class="back-section">

            <a href="index.jsp"
               class="back-link">

                &larr; Back to E-Shop

            </a>

        </div>

    </main>

</body>

</html>