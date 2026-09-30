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

@WebServlet("/MyOrdersServlet")
public class MyOrdersServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        Integer userId =
                (Integer) session.getAttribute("userId");
                System.out.println("CURRENT LOGGED-IN USER ID = " + userId);

        // Check login
        if (userId == null) {

            response.sendRedirect(
                "login.jsp?error=Please%20login%20to%20view%20your%20orders"
            );

            return;
        }

        List<Order> orders = new ArrayList<>();

        String sql =
            "SELECT id, total_amount, status, order_date " +
            "FROM orders " +
            "WHERE user_id = ? " +
            "ORDER BY order_date DESC";

        try (
            Connection connection =
                DBConnection.getConnection();

            PreparedStatement statement =
                connection.prepareStatement(sql)
        ) {

            statement.setInt(1, userId);

            ResultSet result =
                statement.executeQuery();

            while (result.next()) {

                Order order = new Order();

                order.setId(
                    result.getInt("id")
                );

                order.setTotalAmount(
                    result.getDouble("total_amount")
                );

                order.setStatus(
                    result.getString("status")
                );

                order.setOrderDate(
                    result.getTimestamp("order_date")
                );

                orders.add(order);
            }

            request.setAttribute(
                "orders",
                orders
            );

            request.getRequestDispatcher(
                "myOrders.jsp"
            ).forward(
                request,
                response
            );

        } catch (Exception e) {

            e.printStackTrace();

            response.getWriter().println(
                "Error loading orders: " +
                e.getMessage()
            );
        }
    }
}