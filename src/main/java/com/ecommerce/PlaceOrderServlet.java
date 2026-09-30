package com.ecommerce;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/PlaceOrderServlet")
public class PlaceOrderServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        Integer userId =
                (Integer) session.getAttribute("userId");

        List<Product> cart =
                (List<Product>) session.getAttribute("cart");

        // Check login
        if (userId == null) {
            response.sendRedirect(
                "login.jsp?error=Please%20login%20before%20placing%20an%20order"
            );
            return;
        }

        // Check cart
        if (cart == null || cart.isEmpty()) {
            response.sendRedirect(
                "cart.jsp?error=Your%20cart%20is%20empty"
            );
            return;
        }

        Connection connection = null;

        try {

            connection = DBConnection.getConnection();

            connection.setAutoCommit(false);

            // =========================================
            // CALCULATE TOTAL
            // =========================================

            double total = 0;

            for (Product product : cart) {
                total += product.getPrice();
            }

            // =========================================
            // INSERT ORDER
            // =========================================

            String orderSql =
                "INSERT INTO orders " +
                "(user_id, total_amount, status) " +
                "VALUES (?, ?, ?)";

            int orderId;

            try (
                PreparedStatement orderStatement =
                    connection.prepareStatement(
                        orderSql,
                        PreparedStatement.RETURN_GENERATED_KEYS
                    )
            ) {

                orderStatement.setInt(1, userId);
                orderStatement.setDouble(2, total);
                orderStatement.setString(3, "PENDING");

                orderStatement.executeUpdate();

                ResultSet keys =
                    orderStatement.getGeneratedKeys();

                if (keys.next()) {

                    orderId = keys.getInt(1);

                } else {

                    throw new Exception(
                        "Order ID could not be generated"
                    );
                }
            }

            // =========================================
            // INSERT ORDER ITEMS
            // =========================================

            String itemSql =
                "INSERT INTO order_items " +
                "(order_id, product_id, quantity, price) " +
                "VALUES (?, ?, ?, ?)";

            try (
                PreparedStatement itemStatement =
                    connection.prepareStatement(itemSql)
            ) {

                for (Product product : cart) {

                    itemStatement.setInt(
                        1,
                        orderId
                    );

                    itemStatement.setInt(
                        2,
                        product.getId()
                    );

                    itemStatement.setInt(
                        3,
                        1
                    );

                    itemStatement.setDouble(
                        4,
                        product.getPrice()
                    );

                    itemStatement.addBatch();
                }

                itemStatement.executeBatch();
            }

            // =========================================
            // COMMIT
            // =========================================

            connection.commit();

            // =========================================
            // CLEAR CART
            // =========================================

            session.removeAttribute("cart");

            session.setAttribute(
                "cartCount",
                0
            );

            // =========================================
            // SAVE ORDER ID
            // =========================================

            session.setAttribute(
                "lastOrderId",
                orderId
            );

            // =========================================
            // GO TO CONFIRMATION
            // =========================================

            response.sendRedirect(
                "orderConfirmation.jsp"
            );

        } catch (Exception e) {

            e.printStackTrace();

            try {

                if (connection != null) {
                    connection.rollback();
                }

            } catch (Exception rollbackException) {

                rollbackException.printStackTrace();
            }

            response.sendRedirect(
                "cart.jsp?error=Unable%20to%20place%20order"
            );

        } finally {

            try {

                if (connection != null) {
                    connection.close();
                }

            } catch (Exception closeException) {

                closeException.printStackTrace();
            }
        }
    }
}