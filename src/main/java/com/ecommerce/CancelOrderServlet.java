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

@WebServlet("/CancelOrderServlet")
public class CancelOrderServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Check login
        if (session == null
                || session.getAttribute("userId") == null) {

            response.sendRedirect(
                request.getContextPath()
                + "/login.jsp?error=Please%20login"
            );

            return;
        }

        Integer userId =
                (Integer) session.getAttribute("userId");

        String orderIdParameter =
                request.getParameter("orderId");

        // Check order ID
        if (orderIdParameter == null
                || orderIdParameter.trim().isEmpty()) {

            response.sendRedirect(
                request.getContextPath()
                + "/MyOrdersServlet?error=Invalid%20order"
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
                + "/MyOrdersServlet?error=Invalid%20order"
            );

            return;
        }

        /*
         * First check that this order belongs
         * to the currently logged-in customer.
         */
        String checkSql =
            "SELECT status "
            + "FROM orders "
            + "WHERE id = ? AND user_id = ?";

        try (
            Connection connection =
                DBConnection.getConnection();

            PreparedStatement checkStatement =
                connection.prepareStatement(checkSql)
        ) {

            checkStatement.setInt(1, orderId);
            checkStatement.setInt(2, userId);

            ResultSet result =
                checkStatement.executeQuery();

            if (!result.next()) {

                response.sendRedirect(
                    request.getContextPath()
                    + "/MyOrdersServlet?error=Order%20not%20found"
                );

                return;
            }

            String currentStatus =
                result.getString("status");

            /*
             * Customer can cancel only PENDING
             * or CONFIRMED orders.
             */
            if (!"PENDING".equalsIgnoreCase(currentStatus)
                    && !"CONFIRMED".equalsIgnoreCase(currentStatus)) {

                response.sendRedirect(
                    request.getContextPath()
                    + "/MyOrdersServlet?error=This%20order%20cannot%20be%20cancelled"
                );

                return;
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                request.getContextPath()
                + "/MyOrdersServlet?error=Unable%20to%20check%20order"
            );

            return;
        }

        /*
         * Update order status to CANCELLED.
         */
        String updateSql =
            "UPDATE orders "
            + "SET status = 'CANCELLED' "
            + "WHERE id = ? AND user_id = ?";

        try (
            Connection connection =
                DBConnection.getConnection();

            PreparedStatement updateStatement =
                connection.prepareStatement(updateSql)
        ) {

            updateStatement.setInt(1, orderId);
            updateStatement.setInt(2, userId);

            int rowsUpdated =
                updateStatement.executeUpdate();

            if (rowsUpdated > 0) {

                response.sendRedirect(
                    request.getContextPath()
                    + "/MyOrdersServlet?success=Order%20cancelled%20successfully"
                );

            } else {

                response.sendRedirect(
                    request.getContextPath()
                    + "/MyOrdersServlet?error=Unable%20to%20cancel%20order"
                );
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                request.getContextPath()
                + "/MyOrdersServlet?error=Unable%20to%20cancel%20order"
            );
        }
    }
}