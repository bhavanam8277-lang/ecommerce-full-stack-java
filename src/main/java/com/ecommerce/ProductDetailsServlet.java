
package com.ecommerce;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/ProductDetailsServlet")
public class ProductDetailsServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String productId = request.getParameter("productId");

        if (productId == null || productId.trim().isEmpty()) {
            response.sendRedirect("ProductServlet");
            return;
        }

        try {
            int id = Integer.parseInt(productId);

            Product product = null;
            List<Review> reviews = new ArrayList<>();
            List<Map<String, Object>> sizes = new ArrayList<>();

            try (Connection con = DBConnection.getConnection()) {

                // ================= PRODUCT =================

                String productSql =
                        "SELECT id, name, description, price, stock, " +
                        "image_url, category " +
                        "FROM products WHERE id = ?";

                try (PreparedStatement ps =
                             con.prepareStatement(productSql)) {

                    ps.setInt(1, id);

                    try (ResultSet rs = ps.executeQuery()) {

                        if (rs.next()) {
                            product = new Product();

                            product.setId(rs.getInt("id"));
                            product.setName(rs.getString("name"));
                            product.setDescription(
                                    rs.getString("description"));
                            product.setPrice(rs.getDouble("price"));
                            product.setStock(rs.getInt("stock"));
                            product.setImageUrl(
                                    rs.getString("image_url"));
                            product.setCategory(
                                    rs.getString("category"));
                        }
                    }
                }

                // Product not found
                if (product == null) {
                    response.sendRedirect("ProductServlet");
                    return;
                }

                // ================= REVIEWS =================

                String reviewSql =
                        "SELECT r.id, r.product_id, r.user_id, " +
                        "u.name AS user_name, r.rating, " +
                        "r.review_text, r.review_date " +
                        "FROM reviews r " +
                        "JOIN users u ON r.user_id = u.id " +
                        "WHERE r.product_id = ? " +
                        "ORDER BY r.review_date DESC";

                try (PreparedStatement ps =
                             con.prepareStatement(reviewSql)) {

                    ps.setInt(1, id);

                    try (ResultSet rs = ps.executeQuery()) {

                        while (rs.next()) {
                            Review review = new Review();

                            review.setId(rs.getInt("id"));
                            review.setProductId(
                                    rs.getInt("product_id"));
                            review.setUserId(
                                    rs.getInt("user_id"));
                            review.setUserName(
                                    rs.getString("user_name"));
                            review.setRating(
                                    rs.getInt("rating"));
                            review.setReviewText(
                                    rs.getString("review_text"));
                            review.setReviewDate(
                                    rs.getTimestamp("review_date"));

                            reviews.add(review);
                        }
                    }
                }

                // ================= PRODUCT SIZES =================

                if (id == 4 || id == 5) {

                    String sizeSql =
                            "SELECT size, stock FROM product_sizes " +
                            "WHERE product_id = ? ORDER BY size";

                    try (PreparedStatement ps =
                                 con.prepareStatement(sizeSql)) {

                        ps.setInt(1, id);

                        try (ResultSet rs = ps.executeQuery()) {

                            while (rs.next()) {
                                Map<String, Object> size =
                                        new LinkedHashMap<>();

                                size.put(
                                        "size",
                                        rs.getString("size"));

                                size.put(
                                        "stock",
                                        rs.getInt("stock"));

                                sizes.add(size);
                            }
                        }
                    }
                }

            } // Database connection closes here

            // ================= SEND DATA TO JSP =================

            request.setAttribute("product", product);
            request.setAttribute("reviews", reviews);
            request.setAttribute("sizes", sizes);

            request.getRequestDispatcher("/productDetails.jsp")
        .forward(request, response);

        } catch (NumberFormatException e) {

            response.sendRedirect(
        request.getContextPath() + "/ProductServlet");

        } catch (Exception e) {

            e.printStackTrace();

            response.setContentType("text/html;charset=UTF-8");
            response.getWriter().println(
                    "<h2>Unable to load product details.</h2>");
        }
    }
}
