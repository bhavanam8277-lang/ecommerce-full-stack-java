package com.ecommerce;

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

@WebServlet("/AdminOrdersServlet")
public class AdminOrdersServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Check admin login
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath()
                    + "/login.jsp?error=Please%20login");
            return;
        }

        String role = (String) session.getAttribute("userRole");
    

        if (role == null || !"ADMIN".equalsIgnoreCase(role)) {
            response.sendRedirect(request.getContextPath()
                    + "/index.jsp?error=Access%20denied");
            return;
        }

        List<Order> orders = new ArrayList<>();

        String sql =
                "SELECT o.id, o.user_id, u.name AS user_name, "
                + "o.total_amount, o.status, o.order_date "
                + "FROM orders o "
                + "JOIN users u ON o.user_id = u.id "
                + "ORDER BY o.order_date DESC";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet result = statement.executeQuery()) {

            while (result.next()) {

                Order order = new Order();

                order.setId(result.getInt("id"));
                order.setTotalAmount(result.getDouble("total_amount"));
                order.setStatus(result.getString("status"));
                order.setOrderDate(result.getTimestamp("order_date"));

                orders.add(order);
            }

            request.setAttribute("orders", orders);

            request.getRequestDispatcher("/adminOrders.jsp")
                    .forward(request, response);

        } catch (Exception e) {

            e.printStackTrace();

            throw new ServletException(
                    "Error loading admin orders: " + e.getMessage(), e);
        }
    }
}