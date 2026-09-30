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

@WebServlet("/AdminProductServlet")
public class AdminProductServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Check whether user is logged in
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

        List<Product> products =
                new ArrayList<>();

        String sql =
                "SELECT id, name, description, price, stock, "
                + "image_url, category "
                + "FROM products "
                + "WHERE active = 1 "
                + "ORDER BY id";

        try (
                Connection connection =
                        DBConnection.getConnection();

                PreparedStatement statement =
                        connection.prepareStatement(sql);

                ResultSet result =
                        statement.executeQuery()
        ) {

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

                product.setPrice(
                        result.getDouble("price")
                );

                product.setStock(
                        result.getInt("stock")
                );

                product.setImageUrl(
                        result.getString("image_url")
                );

                product.setCategory(
                        result.getString("category")
                );

                products.add(product);
            }

            request.setAttribute(
                    "products",
                    products
            );

            request.getRequestDispatcher(
                    "/adminProducts.jsp"
            ).forward(request, response);

        } catch (Exception e) {

            e.printStackTrace();

            throw new ServletException(
                    "Error loading admin products: "
                    + e.getMessage(),
                    e
            );
        }
    }
}