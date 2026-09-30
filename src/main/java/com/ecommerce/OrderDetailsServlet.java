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

@WebServlet("/OrderDetailsServlet")
public class OrderDetailsServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        Integer userId =
                (Integer) session.getAttribute("userId");

        // Check login
        if (userId == null) {

            response.sendRedirect(
                "login.jsp?error=Please%20login%20to%20view%20order%20details"
            );

            return;
        }

        // Get order ID
        String orderIdParameter =
                request.getParameter("orderId");

        if (orderIdParameter == null ||
            orderIdParameter.trim().isEmpty()) {

            response.sendRedirect("MyOrdersServlet");

            return;
        }

        int orderId;

        try {

            orderId =
                    Integer.parseInt(orderIdParameter);

        } catch (NumberFormatException e) {

            response.sendRedirect("MyOrdersServlet");

            return;
        }


        List<Product> products =
                new ArrayList<>();

        List<Integer> quantities =
                new ArrayList<>();

        List<Double> prices =
                new ArrayList<>();


        double orderTotal = 0;

        String sql =
            "SELECT p.id, p.name, p.description, " +
            "p.image_url, oi.quantity, oi.price " +
            "FROM order_items oi " +
            "JOIN products p " +
            "ON oi.product_id = p.id " +
            "JOIN orders o " +
            "ON oi.order_id = o.id " +
            "WHERE oi.order_id = ? " +
            "AND o.user_id = ?";


        try (
            Connection connection =
                    DBConnection.getConnection();

            PreparedStatement statement =
                    connection.prepareStatement(sql)
        ) {

            statement.setInt(1, orderId);
            statement.setInt(2, userId);

            ResultSet result =
                    statement.executeQuery();


            while (result.next()) {

                Product product =
                        new Product();

                product.setId(
                    result.getInt("id")
                );

                product.setName(
                    result.getString("name")
                );

                product.setDescription(
                    result.getString("description")
                );

                product.setImageUrl(
                    result.getString("image_url")
                );


                int quantity =
                        result.getInt("quantity");

                double price =
                        result.getDouble("price");


                products.add(product);

                quantities.add(quantity);

                prices.add(price);


                orderTotal +=
                        price * quantity;
            }


            request.setAttribute(
                "orderId",
                orderId
            );

            request.setAttribute(
                "products",
                products
            );

            request.setAttribute(
                "quantities",
                quantities
            );

            request.setAttribute(
                "prices",
                prices
            );

            request.setAttribute(
                "orderTotal",
                orderTotal
            );


            request.getRequestDispatcher(
                "orderDetails.jsp"
            ).forward(
                request,
                response
            );


        } catch (Exception e) {

            e.printStackTrace();

            response.getWriter().println(
                "Error loading order details: "
                + e.getMessage()
            );
        }
    }
}