<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.ecommerce.Product" %>
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

    List<Product> products =
        (List<Product>) request.getAttribute("products");
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Manage Products | E-Shop</title>

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

        .navbar {
            background: #202830;
            padding: 20px 42px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo {
            color: white;
            font-size: 27px;
            font-weight: bold;
        }

        .nav-links {
            list-style: none;
            display: flex;
            gap: 35px;
        }

        .nav-links a {
            color: white;
            text-decoration: none;
            font-size: 16px;
        }

        .nav-links a:hover {
            color: #dddddd;
        }

        .container {
            width: 92%;
            max-width: 1300px;
            margin: 40px auto;
        }

        .heading {
            margin-bottom: 25px;
        }

        .heading h1 {
            font-size: 38px;
            margin-bottom: 8px;
        }

        .heading p {
            color: #64748b;
            font-size: 17px;
        }

        .top-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .product-count {
            color: #64748b;
            font-size: 16px;
        }

        .add-btn {
            background: #202830;
            color: white;
            text-decoration: none;
            padding: 12px 20px;
            border-radius: 7px;
            font-size: 15px;
        }

        .add-btn:hover {
            background: #111820;
        }

        .table-container {
            background: white;
            border-radius: 14px;
            overflow-x: auto;
            box-shadow: 0 5px 18px rgba(0, 0, 0, 0.08);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            min-width: 900px;
        }

        th {
            background: #202830;
            color: white;
            padding: 16px;
            text-align: left;
            font-size: 15px;
        }

        td {
            padding: 15px 16px;
            border-bottom: 1px solid #eeeeee;
            vertical-align: middle;
        }

        tr:last-child td {
            border-bottom: none;
        }

        tr:hover {
            background: #f8fafc;
        }

        .product-image {
            width: 70px;
            height: 70px;
            object-fit: cover;
            border-radius: 8px;
            border: 1px solid #eeeeee;
        }

        .product-name {
            font-weight: bold;
            margin-bottom: 5px;
        }

        .description {
            color: #777;
            font-size: 13px;
            max-width: 250px;
        }

        .category {
            display: inline-block;
            background: #e8f0ff;
            color: #2563eb;
            padding: 6px 10px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: bold;
        }

        .price {
            font-weight: bold;
            font-size: 16px;
        }

        .stock {
            font-weight: bold;
        }

        .in-stock {
            color: #16803c;
        }

        .out-stock {
            color: #d32f2f;
        }

        .action-buttons {
            display: flex;
            gap: 8px;
        }

        .edit-btn,
        .delete-btn {
            padding: 8px 13px;
            border-radius: 6px;
            text-decoration: none;
            font-size: 13px;
            border: none;
            cursor: pointer;
        }

        .edit-btn {
            background: #2563eb;
            color: white;
        }

        .delete-btn {
            background: #dc2626;
            color: white;
        }

        .edit-btn:hover {
            background: #1d4ed8;
        }

        .delete-btn:hover {
            background: #b91c1c;
        }

        .empty {
            text-align: center;
            padding: 50px;
            color: #777;
        }

        .back-section {
            text-align: center;
            margin-top: 30px;
        }

        .back-link {
            color: #263238;
            text-decoration: none;
            font-weight: bold;
            font-size: 17px;
        }

        .back-link:hover {
            text-decoration: underline;
        }

        .message {
            padding: 14px 18px;
            margin-bottom: 20px;
            border-radius: 8px;
            font-weight: bold;
        }

        .success {
            background: #dcfce7;
            color: #166534;
        }

        .error {
            background: #fee2e2;
            color: #991b1b;
        }

        @media (max-width: 800px) {

            .navbar {
                flex-direction: column;
                gap: 18px;
                padding: 18px;
            }

            .nav-links {
                flex-wrap: wrap;
                justify-content: center;
                gap: 18px;
            }

            .container {
                width: 94%;
            }

            .heading h1 {
                font-size: 30px;
            }

            .top-bar {
                flex-direction: column;
                align-items: flex-start;
                gap: 15px;
            }
        }

    </style>

</head>

<body>

    <nav class="navbar">

        <div class="logo">
            E-Shop Admin
        </div>

        <ul class="nav-links">

            <li>
                <a href="index.jsp">Home</a>
            </li>

            <li>
                <a href="AdminDashboardServlet">Dashboard</a>
            </li>

            <li>
                <a href="MyOrdersServlet">My Orders</a>
            </li>

            <li>
                <a href="UserProfileServlet">My Profile</a>
            </li>

            <li>
                <a href="LogoutServlet">Logout</a>
            </li>

        </ul>

    </nav>


    <main class="container">

        <div class="heading">

            <h1>
                Manage Products
            </h1>

            <p>
                View and manage all products in your E-Shop.
            </p>

        </div>


        <% if (request.getParameter("success") != null) { %>

            <div class="message success">
                <%= request.getParameter("success") %>
            </div>

        <% } %>


        <% if (request.getParameter("error") != null) { %>

            <div class="message error">
                <%= request.getParameter("error") %>
            </div>

        <% } %>


        <div class="top-bar">

            <div class="product-count">

                Total Products:

                <strong>
                    <%= products != null ? products.size() : 0 %>
                </strong>

            </div>


            <a href="addProduct.jsp"
               class="add-btn">

                + Add Product

            </a>

        </div>


        <div class="table-container">

            <% if (products != null && !products.isEmpty()) { %>

                <table>

                    <thead>

                        <tr>

                            <th>Image</th>
                            <th>Product</th>
                            <th>Category</th>
                            <th>Price</th>
                            <th>Stock</th>
                            <th>Actions</th>

                        </tr>

                    </thead>


                    <tbody>

                    <% for (Product product : products) { %>

                        <tr>

                            <td>

                                <%
    String contextPath = request.getContextPath();

    String imageUrl = product.getImageUrl();
    String finalImageUrl;

    if (imageUrl == null || imageUrl.trim().isEmpty()) {

        finalImageUrl =
                contextPath + "/images/no-image.png";

    } else if (imageUrl.startsWith("http://")
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
                contextPath + "/images/" + imageUrl;
    }
%>

<img
    src="<%= finalImageUrl %>"
    alt="<%= product.getName() %>"
    class="product-image"
    onerror="this.src='<%= contextPath %>/images/no-image.png';">
                            </td>


                            <td>

                                <div class="product-name">

                                    <%= product.getName() %>

                                </div>

                                <div class="description">

                                    <%= product.getDescription() %>

                                </div>

                            </td>


                            <td>

                                <span class="category">

                                    <%= product.getCategory() != null
                                        ? product.getCategory()
                                        : "Uncategorized" %>

                                </span>

                            </td>


                            <td>

                                <div class="price">

                                    &#8377;<%= String.format(
                                        "%,.2f",
                                        product.getPrice()
                                    ) %>

                                </div>

                            </td>


                            <td>

                                <% if (product.getStock() > 0) { %>

                                    <span class="stock in-stock">

                                        <%= product.getStock() %>
                                        available

                                    </span>

                                <% } else { %>

                                    <span class="stock out-stock">

                                        Out of Stock

                                    </span>

                                <% } %>

                            </td>


                            <td>

                                <div class="action-buttons">


                                    <a
                                        href="editProduct.jsp?id=<%= product.getId() %>&name=<%= java.net.URLEncoder.encode(product.getName(), "UTF-8") %>&description=<%= java.net.URLEncoder.encode(product.getDescription() == null ? "" : product.getDescription(), "UTF-8") %>&price=<%= product.getPrice() %>&stock=<%= product.getStock() %>&imageUrl=<%= java.net.URLEncoder.encode(product.getImageUrl() == null ? "" : product.getImageUrl(), "UTF-8") %>&category=<%= java.net.URLEncoder.encode(product.getCategory() == null ? "" : product.getCategory(), "UTF-8") %>"
                                        class="edit-btn">

                                        Edit

                                    </a>


                                    <a
                                        href="DeleteProductServlet?id=<%= product.getId() %>"
                                        class="delete-btn"
                                        onclick="return confirm('Are you sure you want to delete this product?');">

                                        Delete

                                    </a>


                                </div>

                            </td>

                        </tr>

                    <% } %>

                    </tbody>

                </table>

            <% } else { %>

                <div class="empty">

                    <h2>
                        No Products Found
                    </h2>

                    <p>
                        There are currently no products in the store.
                    </p>

                </div>

            <% } %>

        </div>


        <div class="back-section">

            <a
                href="AdminDashboardServlet"
                class="back-link">

                &larr; Back to Admin Dashboard

            </a>

        </div>

    </main>

</body>

</html>