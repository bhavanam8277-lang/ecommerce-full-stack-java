
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

@WebServlet("/ReviewServlet")
public class ReviewServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    // --------------------------------------------------
    // GET: Load reviews page
    // --------------------------------------------------
    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String productIdParameter =
                request.getParameter("productId");

        if (productIdParameter == null ||
                productIdParameter.trim().isEmpty()) {

            response.sendRedirect(
                    request.getContextPath() + "/ProductServlet");
            return;
        }

        try {
            int productId =
                    Integer.parseInt(productIdParameter);

            List<Review> reviews = new ArrayList<>();

            String sql =
                    "SELECT r.id, r.product_id, r.user_id, " +
                    "u.name AS user_name, r.rating, " +
                    "r.review_text, r.review_date " +
                    "FROM reviews r " +
                    "JOIN users u ON r.user_id = u.id " +
                    "WHERE r.product_id = ? " +
                    "ORDER BY r.review_date DESC";

            try (
                Connection connection =
                        DBConnection.getConnection();

                PreparedStatement statement =
                        connection.prepareStatement(sql)
            ) {
                statement.setInt(1, productId);

                try (ResultSet result =
                        statement.executeQuery()) {

                    while (result.next()) {

                        Review review = new Review();

                        review.setId(
                                result.getInt("id"));

                        review.setProductId(
                                result.getInt("product_id"));

                        review.setUserId(
                                result.getInt("user_id"));

                        review.setUserName(
                                result.getString("user_name"));

                        review.setRating(
                                result.getInt("rating"));

                        review.setReviewText(
                                result.getString("review_text"));

                        review.setReviewDate(
                                result.getTimestamp("review_date"));

                        reviews.add(review);
                    }
                }
            }

            request.setAttribute("reviews", reviews);
            request.setAttribute("productId", productId);

            request.getRequestDispatcher(
                    "/reviews.jsp")
                    .forward(request, response);

        } catch (NumberFormatException e) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/ProductServlet?error=Invalid%20product");

        } catch (Exception e) {

            e.printStackTrace();

            response.setContentType("text/plain;charset=UTF-8");
            response.getWriter().println(
                    "Error loading reviews: " + e.getMessage());
        }
    }


    // --------------------------------------------------
    // POST: Save a review and return to product details
    // --------------------------------------------------
    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String productIdParameter =
                request.getParameter("productId");

        int productId;

        try {
            productId = Integer.parseInt(productIdParameter);
        } catch (Exception e) {
            response.sendRedirect(
                    request.getContextPath()
                    + "/ProductServlet?error=Invalid%20product");
            return;
        }

        // Check login
        HttpSession session = request.getSession(false);

        if (session == null ||
                session.getAttribute("userId") == null) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/login.jsp?error=Please%20login%20to%20write%20a%20review");

            return;
        }

        Object sessionUserId =
                session.getAttribute("userId");

        int userId;

        try {
            userId = Integer.parseInt(
                    sessionUserId.toString());
        } catch (Exception e) {
            response.sendRedirect(
                    request.getContextPath()
                    + "/login.jsp?error=Please%20login%20again");

            return;
        }

        // Get form data
        String ratingParameter =
                request.getParameter("rating");

        String reviewText =
                request.getParameter("reviewText");

        int rating;

        try {
            rating = Integer.parseInt(ratingParameter);
        } catch (Exception e) {
            response.sendRedirect(
                    request.getContextPath()
                    + "/ProductDetailsServlet?productId="
                    + productId
                    + "&error=Please%20select%20a%20rating");

            return;
        }

        // Validate rating
        if (rating < 1 || rating > 5) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/ProductDetailsServlet?productId="
                    + productId
                    + "&error=Rating%20must%20be%20between%201%20and%205");

            return;
        }

        // Validate review text
        if (reviewText == null ||
                reviewText.trim().isEmpty()) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/ProductDetailsServlet?productId="
                    + productId
                    + "&error=Please%20write%20a%20review");

            return;
        }

        String sql =
                "INSERT INTO reviews " +
                "(product_id, user_id, rating, review_text) " +
                "VALUES (?, ?, ?, ?)";

        try (
            Connection connection =
                    DBConnection.getConnection();

            PreparedStatement statement =
                    connection.prepareStatement(sql)
        ) {

            statement.setInt(1, productId);
            statement.setInt(2, userId);
            statement.setInt(3, rating);
            statement.setString(4, reviewText.trim());

            int result = statement.executeUpdate();

            if (result > 0) {

                // Review saved successfully.
                // Return to the same product details page.
                response.sendRedirect(
                        request.getContextPath()
                        + "/ProductDetailsServlet?productId="
                        + productId
                        + "&success=true"
                );

            } else {

                response.sendRedirect(
                        request.getContextPath()
                        + "/ProductDetailsServlet?productId="
                        + productId
                        + "&error=Unable%20to%20submit%20review"
                );
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    request.getContextPath()
                    + "/ProductDetailsServlet?productId="
                    + productId
                    + "&error=Unable%20to%20submit%20review"
            );
        }
    }
}