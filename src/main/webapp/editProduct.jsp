<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    String role = (String) session.getAttribute("userRole");

    if (role == null || !role.equalsIgnoreCase("ADMIN")) {
        response.sendRedirect("index.jsp?error=Access%20denied");
        return;
    }

    String id = request.getParameter("id");
    String name = request.getParameter("name");
    String description = request.getParameter("description");
    String price = request.getParameter("price");
    String stock = request.getParameter("stock");
    String imageUrl = request.getParameter("imageUrl");
    String category = request.getParameter("category");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Product | E-Shop</title>

    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: Arial, sans-serif;
            background: #f4f6f8;
            color: #333;
        }

        .navbar {
            background: #111827;
            padding: 18px 50px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo {
            color: white;
            font-size: 24px;
            font-weight: bold;
            text-decoration: none;
        }

        .nav-links {
            display: flex;
            gap: 25px;
        }

        .nav-links a {
            color: white;
            text-decoration: none;
            font-size: 15px;
        }

        .nav-links a:hover {
            color: #60a5fa;
        }

        .container {
            width: 90%;
            max-width: 850px;
            margin: 45px auto;
        }

        .page-title {
            text-align: center;
            margin-bottom: 30px;
        }

        .page-title h1 {
            font-size: 32px;
            color: #111827;
            margin-bottom: 8px;
        }

        .page-title p {
            color: #6b7280;
        }

        .form-card {
            background: white;
            padding: 35px;
            border-radius: 14px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.08);
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: #374151;
        }

        input,
        textarea,
        select {
            width: 100%;
            padding: 13px 15px;
            border: 1px solid #d1d5db;
            border-radius: 8px;
            font-size: 15px;
            outline: none;
            background: white;
        }

        input:focus,
        textarea:focus,
        select:focus {
            border-color: #2563eb;
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
        }

        textarea {
            min-height: 120px;
            resize: vertical;
        }

        .row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        .button-area {
            display: flex;
            gap: 15px;
            margin-top: 30px;
        }

        .btn {
            flex: 1;
            padding: 14px;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            text-align: center;
            text-decoration: none;
        }

        .update-btn {
            background: #2563eb;
            color: white;
        }

        .update-btn:hover {
            background: #1d4ed8;
        }

        .cancel-btn {
            background: #e5e7eb;
            color: #374151;
        }

        .cancel-btn:hover {
            background: #d1d5db;
        }

        .required {
            color: #dc2626;
        }

        @media (max-width: 700px) {

            .navbar {
                padding: 18px 20px;
                flex-direction: column;
                gap: 15px;
            }

            .nav-links {
                flex-wrap: wrap;
                justify-content: center;
                gap: 15px;
            }

            .container {
                width: 94%;
                margin: 25px auto;
            }

            .form-card {
                padding: 22px;
            }

            .row {
                grid-template-columns: 1fr;
                gap: 0;
            }

            .button-area {
                flex-direction: column;
            }
        }
    </style>
</head>

<body>

    <nav class="navbar">

        <a href="index.jsp" class="logo">
            E-Shop
        </a>

        <div class="nav-links">
            <a href="index.jsp">Home</a>
            <a href="ProductServlet">Products</a>
            <a href="AdminDashboardServlet">Dashboard</a>
            <a href="AdminProductServlet">Manage Products</a>
            <a href="UserProfileServlet">My Profile</a>
            <a href="LogoutServlet">Logout</a>
        </div>

    </nav>


    <div class="container">

        <div class="page-title">
            <h1>Edit Product</h1>
            <p>Update the product information below</p>
        </div>


        <div class="form-card">

            <form action="EditProductServlet" method="post">

                <input
                    type="hidden"
                    name="id"
                    value="<%= id != null ? id : "" %>">


                <div class="form-group">

                    <label for="name">
                        Product Name <span class="required">*</span>
                    </label>

                    <input
                        type="text"
                        id="name"
                        name="name"
                        value="<%= name != null ? name : "" %>"
                        placeholder="Enter product name"
                        required>

                </div>


                <div class="form-group">

                    <label for="description">
                        Description
                    </label>

                    <textarea
                        id="description"
                        name="description"
                        placeholder="Enter product description"><%= description != null ? description : "" %></textarea>

                </div>


                <div class="row">

                    <div class="form-group">

                        <label for="price">
                            Price (&#8377;) <span class="required">*</span>
                        </label>

                        <input
                            type="number"
                            id="price"
                            name="price"
                            value="<%= price != null ? price : "" %>"
                            min="0"
                            step="0.01"
                            required>

                    </div>


                    <div class="form-group">

                        <label for="stock">
                            Stock <span class="required">*</span>
                        </label>

                        <input
                            type="number"
                            id="stock"
                            name="stock"
                            value="<%= stock != null ? stock : "" %>"
                            min="0"
                            required>

                    </div>

                </div>


                <div class="form-group">

                    <label for="category">
                        Category <span class="required">*</span>
                    </label>

                    <select
                        id="category"
                        name="category"
                        required>

                        <option value="">
                            -- Select Category --
                        </option>

                        <option value="Electronics"
                            <%= "Electronics".equals(category) ? "selected" : "" %>>
                            Electronics
                        </option>

                        <option value="Mobile"
                            <%= "Mobile".equals(category) ? "selected" : "" %>>
                            Mobile
                        </option>

                        <option value="Audio"
                            <%= "Audio".equals(category) ? "selected" : "" %>>
                            Audio
                        </option>

                        <option value="Fashion"
                            <%= "Fashion".equals(category) ? "selected" : "" %>>
                            Fashion
                        </option>

                        <option value="Wearables"
                            <%= "Wearables".equals(category) ? "selected" : "" %>>
                            Wearables
                        </option>

                        <option value="Camera"
                            <%= "Camera".equals(category) ? "selected" : "" %>>
                            Camera
                        </option>

                        <option value="Furniture"
                            <%= "Furniture".equals(category) ? "selected" : "" %>>
                            Furniture
                        </option>

                    </select>

                </div>


                <div class="form-group">

                    <label for="imageUrl">
                        Image File Name
                    </label>

                    <input
                        type="text"
                        id="imageUrl"
                        name="imageUrl"
                        value="<%= imageUrl != null ? imageUrl : "" %>"
                        placeholder="Example: laptop.jpg">

                </div>


                <div class="button-area">

                    <button
                        type="submit"
                        class="btn update-btn">
                        Update Product
                    </button>

                    <a
                        href="AdminProductServlet"
                        class="btn cancel-btn">
                        Cancel
                    </a>

                </div>

            </form>

        </div>

    </div>

</body>
</html>