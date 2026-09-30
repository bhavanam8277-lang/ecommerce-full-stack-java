package com.ecommerce;

import java.util.HashMap;
import java.util.Map;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/AdminOrderDetailsServlet")
public class AdminOrderDetailsServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Check login
        if (session == null
                || session.getAttribute("userId") == null) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/login.jsp?error=Please%20login");

            return;
        }

        // Check admin
        String role =
                (String) session.getAttribute("userRole");

        if (role == null
                || !"ADMIN".equalsIgnoreCase(role)) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/index.jsp?error=Access%20denied");

            return;
        }

        // Get order ID
        String orderIdParameter =
                request.getParameter("orderId");

        if (orderIdParameter == null
                || orderIdParameter.trim().isEmpty()) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/AdminOrdersServlet");

            return;
        }

        int orderId;

        try {

            orderId =
                    Integer.parseInt(orderIdParameter);

        } catch (NumberFormatException e) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/AdminOrdersServlet");

            return;
        }

        Order order = null;

        List<Product> products = new ArrayList<>();
Map<Integer, Integer> quantities = new HashMap<>();

        String orderSql =
                "SELECT o.id, o.user_id, "
                + "u.name AS user_name, "
                + "u.email AS user_email, "
                + "o.total_amount, "
                + "o.status, "
                + "o.order_date "
                + "FROM orders o "
                + "JOIN users u "
                + "ON o.user_id = u.id "
                + "WHERE o.id = ?";

        String productSql =
                "SELECT p.id, "
                + "p.name, "
                + "p.description, "
                + "p.price, "
                + "p.stock, "
                + "p.image_url, "
                + "oi.quantity, "
                + "oi.price AS order_price "
                + "FROM order_items oi "
                + "JOIN products p "
                + "ON oi.product_id = p.id "
                + "WHERE oi.order_id = ?";

        try (Connection connection =
                     DBConnection.getConnection()) {

            // ============================
            // GET ORDER INFORMATION
            // ============================

            try (PreparedStatement statement =
                         connection.prepareStatement(orderSql)) {

                statement.setInt(1, orderId);

                try (ResultSet result =
                             statement.executeQuery()) {

                    if (result.next()) {

                        order = new Order();

                        order.setId(
                                result.getInt("id"));

                        order.setTotalAmount(
                                result.getDouble(
                                        "total_amount"));

                        order.setStatus(
                                result.getString(
                                        "status"));

                        order.setOrderDate(
                                result.getTimestamp(
                                        "order_date"));

                        request.setAttribute(
                                "userId",
                                result.getInt("user_id"));

                        request.setAttribute(
                                "userName",
                                result.getString(
                                        "user_name"));

                        request.setAttribute(
                                "userEmail",
                                result.getString(
                                        "user_email"));
                    }
                }
            }

            // ============================
            // ORDER NOT FOUND
            // ============================

            if (order == null) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/AdminOrdersServlet");

                return;
            }

            // ============================
            // GET ORDER PRODUCTS
            // ============================

            try (PreparedStatement statement =
                         connection.prepareStatement(productSql)) {

                statement.setInt(1, orderId);

                try (ResultSet result =
                             statement.executeQuery()) {

                    while (result.next()) {

                        Product product =
                                new Product();

                        product.setId(
                                result.getInt("id"));

                        product.setName(
                                result.getString("name"));

                        product.setDescription(
                                result.getString(
                                        "description"));

                        product.setPrice(
                                result.getDouble("order_price"));

                        product.setStock(
                                result.getInt("stock"));

                        product.setImageUrl(
        result.getString("image_url"));

quantities.put(
        product.getId(),
        result.getInt("quantity"));

products.add(product);
                    }
                }
            }

            request.setAttribute(
                    "order",
                    order);

            request.setAttribute(
                    "products",
                    products);

                    request.setAttribute(
        "quantities",
        quantities);

            request.getRequestDispatcher(
                    "/adminOrderDetails.jsp")
                    .forward(request, response);

        } catch (Exception e) {

            e.printStackTrace();

            throw new ServletException(
                    "Error loading admin order details: "
                    + e.getMessage(),
                    e);
        }
    }
}