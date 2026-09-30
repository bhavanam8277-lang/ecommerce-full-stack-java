package com.ecommerce;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/AdminUpdateOrderStatusServlet")
public class AdminUpdateOrderStatusServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        // Check admin login
        HttpSession session = request.getSession(false);

        if (session == null
                || session.getAttribute("userId") == null) {

            response.sendRedirect(
                request.getContextPath()
                + "/login.jsp?error=Please%20login%20as%20admin"
            );

            return;
        }

        // Check admin role
        String role =
            (String) session.getAttribute("userRole");

        if (role == null
                || !role.equalsIgnoreCase("ADMIN")) {

            response.sendRedirect(
                request.getContextPath()
                + "/index.jsp?error=Access%20denied"
            );

            return;
        }

        // Get order ID
        String orderIdParameter =
            request.getParameter("orderId");

        // Get new status
        String status =
            request.getParameter("status");

        if (orderIdParameter == null
                || status == null
                || orderIdParameter.trim().isEmpty()
                || status.trim().isEmpty()) {

            response.sendRedirect(
                request.getContextPath()
                + "/AdminOrdersServlet?error=Invalid%20order%20details"
            );

            return;
        }

        int orderId;

        try {

            orderId =
                Integer.parseInt(orderIdParameter);

        } catch (NumberFormatException e) {

            response.sendRedirect(
                request.getContextPath()
                + "/AdminOrdersServlet?error=Invalid%20order%20ID"
            );

            return;
        }

        // Allow only valid order statuses
        if (!status.equals("PENDING")
                && !status.equals("CONFIRMED")
                && !status.equals("SHIPPED")
                && !status.equals("DELIVERED")) {

            response.sendRedirect(
                request.getContextPath()
                + "/AdminOrdersServlet?error=Invalid%20order%20status"
            );

            return;
        }

        String sql =
            "UPDATE orders "
            + "SET status = ? "
            + "WHERE id = ?";

        try (
            Connection connection =
                DBConnection.getConnection();

            PreparedStatement statement =
                connection.prepareStatement(sql)
        ) {

            statement.setString(1, status);
            statement.setInt(2, orderId);

            int rowsUpdated =
                statement.executeUpdate();

            if (rowsUpdated > 0) {

                response.sendRedirect(
                    request.getContextPath()
                    + "/AdminOrdersServlet?success=Status%20updated"
                );

            } else {

                response.sendRedirect(
                    request.getContextPath()
                    + "/AdminOrdersServlet?error=Order%20not%20found"
                );
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                request.getContextPath()
                + "/AdminOrdersServlet?error=Unable%20to%20update%20status"
            );
        }
    }
}