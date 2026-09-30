package com.ecommerce;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/BuyNowServlet")
public class BuyNowServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        // Buy Now can also be opened with GET
        doPost(request, response);
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String contextPath = request.getContextPath();

        // -------------------------------------------------
        // 1. CHECK LOGIN
        // -------------------------------------------------

        HttpSession session = request.getSession(false);

        if (session == null ||
                session.getAttribute("userId") == null) {

            response.sendRedirect(
                contextPath +
                "/login.jsp?error=Please%20login%20before%20buying"
            );

            return;
        }

        // Get logged-in user ID
        Integer userId =
                (Integer) session.getAttribute("userId");

        // -------------------------------------------------
        // 2. GET PRODUCT ID
        // -------------------------------------------------

        String productIdParameter =
                request.getParameter("productId");

        int productId;

        try {

            productId =
                    Integer.parseInt(productIdParameter);

        } catch (Exception e) {

            response.sendRedirect(
                contextPath +
                "/ProductServlet?error=Invalid%20product"
            );

            return;
        }

        Connection connection = null;

        try {

            // -------------------------------------------------
            // 3. CONNECT TO DATABASE
            // -------------------------------------------------

            connection = DBConnection.getConnection();

            connection.setAutoCommit(false);

            // -------------------------------------------------
            // 4. GET PRODUCT
            // -------------------------------------------------

            String productSql =
                    "SELECT id, name, price, stock " +
                    "FROM products " +
                    "WHERE id = ? AND active = 1";

            double price;
            int stock;
            String productName;

            try (
                PreparedStatement productStatement =
                    connection.prepareStatement(productSql)
            ) {

                productStatement.setInt(1, productId);

                try (
                    ResultSet result =
                        productStatement.executeQuery()
                ) {

                    if (!result.next()) {

                        connection.rollback();

                        response.sendRedirect(
                            contextPath +
                            "/ProductServlet?error=Product%20not%20found"
                        );

                        return;
                    }

                    productName =
                            result.getString("name");

                    price =
                            result.getDouble("price");

                    stock =
                            result.getInt("stock");
                }
            }

            // -------------------------------------------------
            // 5. CHECK STOCK
            // -------------------------------------------------

            if (stock <= 0) {

                connection.rollback();

                response.sendRedirect(
                    contextPath +
                    "/ProductServlet?error=Product%20is%20out%20of%20stock"
                );

                return;
            }

            // -------------------------------------------------
            // 6. CREATE ORDER
            // -------------------------------------------------

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
                orderStatement.setDouble(2, price);
                orderStatement.setString(3, "PENDING");

                int rows =
                        orderStatement.executeUpdate();

                if (rows == 0) {

                    throw new Exception(
                        "Order could not be created"
                    );
                }

                try (
                    ResultSet generatedKeys =
                        orderStatement.getGeneratedKeys()
                ) {

                    if (generatedKeys.next()) {

                        orderId =
                                generatedKeys.getInt(1);

                    } else {

                        throw new Exception(
                            "Order ID could not be generated"
                        );
                    }
                }
            }

            // -------------------------------------------------
            // 7. CREATE ORDER ITEM
            // -------------------------------------------------

            String itemSql =
                    "INSERT INTO order_items " +
                    "(order_id, product_id, quantity, price) " +
                    "VALUES (?, ?, ?, ?)";

            try (
                PreparedStatement itemStatement =
                    connection.prepareStatement(itemSql)
            ) {

                itemStatement.setInt(1, orderId);
                itemStatement.setInt(2, productId);
                itemStatement.setInt(3, 1);
                itemStatement.setDouble(4, price);

                int rows =
                        itemStatement.executeUpdate();

                if (rows == 0) {

                    throw new Exception(
                        "Order item could not be created"
                    );
                }
            }

            // -------------------------------------------------
            // 8. COMMIT
            // -------------------------------------------------

            connection.commit();

            // -------------------------------------------------
            // 9. SAVE ORDER ID IN SESSION
            // -------------------------------------------------

            session.setAttribute(
                "lastOrderId",
                orderId
            );

            // Optional: save product information
            session.setAttribute(
                "lastOrderProductName",
                productName
            );

            // -------------------------------------------------
            // 10. GO TO ORDER CONFIRMATION
            // -------------------------------------------------

            response.sendRedirect(
                contextPath +
                "/orderConfirmation.jsp"
            );

        } catch (Exception e) {

            e.printStackTrace();

            // -------------------------------------------------
            // ROLLBACK
            // -------------------------------------------------

            try {

                if (connection != null) {
                    connection.rollback();
                }

            } catch (Exception rollbackException) {

                rollbackException.printStackTrace();
            }

            // -------------------------------------------------
            // SHOW ACTUAL ERROR
            // -------------------------------------------------

            response.setContentType("text/html;charset=UTF-8");

            PrintWriter out =
                    response.getWriter();

            out.println("<html>");
            out.println("<head>");
            out.println("<title>Buy Now Error</title>");
            out.println("</head>");
            out.println("<body>");

            out.println("<h2>Buy Now Error</h2>");

            out.println(
                "<p><b>User ID:</b> " +
                userId +
                "</p>"
            );

            out.println(
                "<p><b>Product ID:</b> " +
                productId +
                "</p>"
            );

            out.println(
                "<p><b>Error Message:</b> " +
                e.getMessage() +
                "</p>"
            );

            out.println("<h3>Technical Details:</h3>");

            StringWriter stringWriter =
                    new StringWriter();

            PrintWriter printWriter =
                    new PrintWriter(stringWriter);

            e.printStackTrace(printWriter);

            out.println(
                "<pre>" +
                stringWriter.toString() +
                "</pre>"
            );

            out.println("</body>");
            out.println("</html>");

        } finally {

            // -------------------------------------------------
            // CLOSE CONNECTION
            // -------------------------------------------------

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