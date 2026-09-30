package com.ecommerce;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/AdminDashboardServlet")
public class AdminDashboardServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        String role = (String) session.getAttribute("userRole");

        // Only ADMIN users can access the dashboard
        if (role == null || !role.equalsIgnoreCase("ADMIN")) {
            response.sendRedirect(
                "index.jsp?error=Access%20denied"
            );
            return;
        }

        int totalUsers = 0;
        int totalProducts = 0;
        int totalOrders = 0;
        double totalSales = 0;

        try (
            Connection connection = DBConnection.getConnection()
        ) {

            // Total Users
            String usersSql =
                "SELECT COUNT(*) FROM users";

            try (
                PreparedStatement statement =
                    connection.prepareStatement(usersSql);
                ResultSet result = statement.executeQuery()
            ) {
                if (result.next()) {
                    totalUsers = result.getInt(1);
                }
            }

            // Total Products
            String productsSql =
    "SELECT COUNT(*) FROM products WHERE active = 1";

            try (
                PreparedStatement statement =
                    connection.prepareStatement(productsSql);
                ResultSet result = statement.executeQuery()
            ) {
                if (result.next()) {
                    totalProducts = result.getInt(1);
                }
            }

            // Total Orders
            String ordersSql =
                "SELECT COUNT(*) FROM orders";

            try (
                PreparedStatement statement =
                    connection.prepareStatement(ordersSql);
                ResultSet result = statement.executeQuery()
            ) {
                if (result.next()) {
                    totalOrders = result.getInt(1);
                }
            }

            // Total Sales
            String salesSql =
                "SELECT COALESCE(SUM(total_amount), 0) FROM orders";

            try (
                PreparedStatement statement =
                    connection.prepareStatement(salesSql);
                ResultSet result = statement.executeQuery()
            ) {
                if (result.next()) {
                    totalSales = result.getDouble(1);
                }
            }

            request.setAttribute("totalUsers", totalUsers);
            request.setAttribute("totalProducts", totalProducts);
            request.setAttribute("totalOrders", totalOrders);
            request.setAttribute("totalSales", totalSales);

            request.getRequestDispatcher(
                "adminDashboard.jsp"
            ).forward(request, response);

        } catch (Exception e) {

            e.printStackTrace();

            response.getWriter().println(
                "Error loading admin dashboard: "
                + e.getMessage()
            );
        }
    }
}