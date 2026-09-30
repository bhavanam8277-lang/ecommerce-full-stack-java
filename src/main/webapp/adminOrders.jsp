<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.ecommerce.Order" %>

<%
    String contextPath = request.getContextPath();

    // Admin security check
    if (session.getAttribute("userId") == null) {
        response.sendRedirect(contextPath + "/login.jsp");
        return;
    }

    String role = (String) session.getAttribute("userRole");

    if (role == null || !"ADMIN".equalsIgnoreCase(role)) {
        response.sendRedirect(contextPath + "/index.jsp");
        return;
    }

    List<Order> orders = (List<Order>) request.getAttribute("orders");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Orders | E-Shop</title>

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f5f6fa;
            color: #222;
        }

        .navbar {
            background: #222;
            padding: 15px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .navbar h2 {
            color: white;
            margin: 0;
        }

        .navbar a {
            color: white;
            text-decoration: none;
            margin-left: 20px;
        }

        .container {
            width: 95%;
            margin: 35px auto;
        }

        h1 {
            margin-bottom: 25px;
        }

        .table-container {
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 3px 12px rgba(0,0,0,0.08);
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th {
            background: #222;
            color: white;
            padding: 14px;
            text-align: left;
        }

        td {
            padding: 13px;
            border-bottom: 1px solid #ddd;
        }

        tr:hover {
            background: #f7f7f7;
        }

        .status {
            font-weight: bold;
        }

        .pending {
            color: #d68910;
        }

        .confirmed {
            color: #2874a6;
        }

        .shipped {
            color: #7d3c98;
        }

        .delivered {
            color: #229954;
        }

        .cancelled {
            color: #c0392b;
        }

        .empty {
            text-align: center;
            padding: 30px;
            color: #777;
        }

        .back-btn {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 18px;
            background: #222;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }

        .view-btn {
            display: inline-block;
            padding: 8px 14px;
            background: #2874a6;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            font-size: 14px;
        }
        .status-form {
    display: flex;
    align-items: center;
    gap: 8px;
}

.status-form select {
    padding: 8px 10px;
    border: 1px solid #ccc;
    border-radius: 5px;
    background: white;
    font-size: 14px;
}

.update-btn {
    padding: 8px 12px;
    background: #229954;
    color: white;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    font-size: 14px;
}

.update-btn:hover {
    background: #1e8449;
}

        .view-btn:hover {
            background: #1f618d;
        }
    </style>
</head>

<body>

<div class="navbar">

    <h2>E-Shop Admin</h2>

    <div>
        <a href="<%= contextPath %>/adminDashboard.jsp">Dashboard</a>
        <a href="<%= contextPath %>/index.jsp">Home</a>
        <a href="<%= contextPath %>/LogoutServlet">Logout</a>
    </div>

</div>

<div class="container">

    <h1>All Orders</h1>

    <div class="table-container">

        <% if (orders == null || orders.isEmpty()) { %>

            <div class="empty">
                <h3>No orders found.</h3>
            </div>

        <% } else { %>

            <table>

                <thead>
                    <tr>
                        <th>Order ID</th>
                        <th>Total Amount</th>
                        <th>Status</th>
                        <th>Order Date</th>
                        <th>Actions</th>
                        <th>Update Status</th>
                    </tr>
                </thead>

                <tbody>

                <% for (Order order : orders) { %>

                    <%
                        String status = order.getStatus();

                        String statusClass = "";

                        if (status != null) {
                            statusClass = status.toLowerCase();
                        }
                    %>

                    <tr>

                        <td>
                            #<%= order.getId() %>
                        </td>

                        <td>
                            &#8377;<%= String.format("%.2f", order.getTotalAmount()) %>
                        </td>

                        <td class="status <%= statusClass %>">
                            <%= status %>
                        </td>

                        <td>
                            <%= order.getOrderDate() %>
                        </td>

                        <td>
    <a href="<%= contextPath %>/AdminOrderDetailsServlet?orderId=<%= order.getId() %>"
       class="view-btn">
        View Details
    </a>
</td>

<td>

    <form
        action="<%= contextPath %>/AdminUpdateOrderStatusServlet"
        method="post"
        class="status-form">

        <input
            type="hidden"
            name="orderId"
            value="<%= order.getId() %>">

        <select name="status">

            <option value="PENDING"
                <%= "PENDING".equalsIgnoreCase(status) ? "selected" : "" %>>
                PENDING
            </option>

            <option value="CONFIRMED"
                <%= "CONFIRMED".equalsIgnoreCase(status) ? "selected" : "" %>>
                CONFIRMED
            </option>

            <option value="SHIPPED"
                <%= "SHIPPED".equalsIgnoreCase(status) ? "selected" : "" %>>
                SHIPPED
            </option>

            <option value="DELIVERED"
                <%= "DELIVERED".equalsIgnoreCase(status) ? "selected" : "" %>>
                DELIVERED
            </option>

        </select>

        <button type="submit" class="update-btn">
            Update
        </button>

    </form>

</td>

                    </tr>

                <% } %>

                </tbody>

            </table>

        <% } %>

    </div>

    <a class="back-btn"
       href="<%= contextPath %>/adminDashboard.jsp">
        Back to Dashboard
    </a>

</div>

</body>
</html>