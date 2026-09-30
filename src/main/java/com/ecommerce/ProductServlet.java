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

@WebServlet("/ProductServlet")
public class ProductServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        List<Product> products = new ArrayList<>();

        // Get search text from the Products page
        String search =
                request.getParameter("search");

        if (search == null) {
            search = "";
        }

        search = search.trim();

        /*
         * Load only active products.
         *
         * If search is empty:
         *     show all active products.
         *
         * If search has text:
         *     search product name and description.
         */
        String sql;

        if (search.isEmpty()) {

            sql =
                "SELECT * FROM products "
                + "WHERE active = 1 "
                + "ORDER BY id";

        } else {

            sql =
                "SELECT * FROM products "
                + "WHERE active = 1 "
                + "AND (name LIKE ? OR description LIKE ?) "
                + "ORDER BY id";
        }

        try (
            Connection connection =
                DBConnection.getConnection();

            PreparedStatement statement =
                connection.prepareStatement(sql)
        ) {

            // Set search parameters only when searching
            if (!search.isEmpty()) {

                String searchValue =
                    "%" + search + "%";

                statement.setString(1, searchValue);
                statement.setString(2, searchValue);
            }

            try (
                ResultSet result =
                    statement.executeQuery()
            ) {

                while (result.next()) {

                    Product product = new Product();

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

                    // Load product category
                    product.setCategory(
                        result.getString("category")
                    );

                    products.add(product);
                }
            }

            // Send products to products.jsp
            request.setAttribute(
                "products",
                products
            );

            // Keep the search text available to JSP
            request.setAttribute(
                "search",
                search
            );

            request.getRequestDispatcher(
                "products.jsp"
            ).forward(
                request,
                response
            );

        } catch (Exception e) {

            e.printStackTrace();

            response.setContentType(
                "text/plain;charset=UTF-8"
            );

            response.getWriter().println(
                "Error loading products: "
                + e.getMessage()
            );
        }
    }
}