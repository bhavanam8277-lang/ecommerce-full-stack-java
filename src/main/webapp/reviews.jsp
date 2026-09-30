<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.ecommerce.Review" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Product Reviews | E-Shop</title>

    <style>

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }

        body {
            background: #f8fafc;
            color: #111827;
        }

        /* ================= NAVBAR ================= */

        .navbar {
            min-height: 70px;
            background: #111827;
            color: white;

            display: flex;
            align-items: center;
            justify-content: space-between;

            padding: 0 7%;
        }

        .logo {
            font-size: 25px;
            font-weight: bold;
        }

        .logo span {
            color: #60a5fa;
        }

        .navbar a {
            color: white;
            text-decoration: none;
            margin-left: 20px;
            font-size: 15px;
        }

        .navbar a:hover {
            color: #60a5fa;
        }

        /* ================= CONTAINER ================= */

        .container {
            max-width: 1000px;
            margin: 50px auto;
            padding: 0 20px;
        }

        .heading {
            text-align: center;
            margin-bottom: 35px;
        }

        .heading h1 {
            font-size: 36px;
            margin-bottom: 10px;
        }

        .heading p {
            color: #6b7280;
        }

        /* ================= MESSAGE ================= */

        .message {
            padding: 12px;
            border-radius: 7px;
            margin-bottom: 20px;
            text-align: center;
            font-weight: bold;
        }

        .success {
            background: #dcfce7;
            color: #166534;
        }

        .error {
            background: #fee2e2;
            color: #991b1b;
        }

        /* ================= REVIEW FORM ================= */

        .review-form {
            background: white;
            padding: 25px;
            border-radius: 12px;

            box-shadow:
                0 5px 20px rgba(0, 0, 0, 0.08);

            margin-bottom: 35px;
        }

        .review-form h2 {
            margin-bottom: 20px;
        }

        .form-group {
            margin-bottom: 18px;
        }

        .form-group label {
            display: block;
            font-weight: bold;
            margin-bottom: 8px;
        }

        .rating-options {
            display: flex;
            gap: 10px;
        }

        .rating-options label {
            display: flex;
            align-items: center;
            gap: 4px;
            cursor: pointer;
        }

        textarea {
            width: 100%;
            min-height: 120px;

            padding: 12px;

            border: 1px solid #d1d5db;

            border-radius: 7px;

            resize: vertical;

            font-size: 15px;
        }

        textarea:focus {
            outline: none;
            border-color: #2563eb;
        }

        .submit-btn {
            border: none;

            background: #2563eb;

            color: white;

            padding: 12px 24px;

            border-radius: 7px;

            cursor: pointer;

            font-weight: bold;

            font-size: 15px;
        }

        .submit-btn:hover {
            background: #1d4ed8;
        }

        /* ================= REVIEWS ================= */

        .reviews-section {
            margin-top: 30px;
        }

        .reviews-section h2 {
            margin-bottom: 20px;
        }

        .review-card {
            background: white;

            padding: 22px;

            border-radius: 12px;

            margin-bottom: 18px;

            box-shadow:
                0 4px 15px rgba(0, 0, 0, 0.06);
        }

        .review-header {
            display: flex;

            justify-content: space-between;

            align-items: center;

            margin-bottom: 10px;
        }

        .reviewer {
            font-weight: bold;
            font-size: 17px;
        }

        .stars {
            color: #f59e0b;
            font-size: 20px;
        }

        .review-date {
            color: #6b7280;
            font-size: 13px;
            margin-bottom: 10px;
        }

        .review-text {
            color: #374151;
            line-height: 1.6;
        }

        .no-reviews {
            background: white;

            padding: 30px;

            text-align: center;

            border-radius: 10px;

            color: #6b7280;
        }

        /* ================= FOOTER ================= */

        footer {
            margin-top: 60px;

            background: #111827;

            color: white;

            text-align: center;

            padding: 25px;
        }

        /* ================= MOBILE ================= */

        @media (max-width: 600px) {

            .navbar {
                flex-direction: column;
                gap: 15px;
                padding: 20px;
            }

            .navbar a {
                margin-left: 8px;
            }

            .heading h1 {
                font-size: 28px;
            }

            .review-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 5px;
            }

            .rating-options {
                flex-wrap: wrap;
            }
        }

    </style>

</head>

<body>


<!-- ================= NAVBAR ================= -->

<nav class="navbar">

    <div class="logo">

        &#128722;

        <span>E</span>-Shop

    </div>

    <div>

        <a href="index.jsp">
            Home
        </a>

        <a href="ProductServlet">
            Products
        </a>

        <a href="cart.jsp">
            Cart
        </a>

    </div>

</nav>


<!-- ================= MAIN ================= -->

<div class="container">


    <div class="heading">

        <h1>
            ⭐ Product Reviews
        </h1>

        <p>
            Share your experience with this product
        </p>

    </div>


    <!-- ================= MESSAGES ================= -->

    <%
        String success =
            request.getParameter("success");

        String error =
            request.getParameter("error");
    %>


    <% if (success != null) { %>

        <div class="message success">

            <%= success %>

        </div>

    <% } %>


    <% if (error != null) { %>

        <div class="message error">

            <%= error %>

        </div>

    <% } %>


    <!-- ================= REVIEW FORM ================= -->

    <%
        Integer userId =
            (Integer) session.getAttribute("userId");
    %>


    <% if (userId != null) { %>

        <div class="review-form">

            <h2>
                Write a Review
            </h2>


            <form
                action="ReviewServlet"
                method="post">


                <input
                    type="hidden"
                    name="productId"
                    value="<%= request.getAttribute("productId") %>">


                <!-- RATING -->

                <div class="form-group">

                    <label>
                        Your Rating
                    </label>


                    <div class="rating-options">

                        <label>
                            <input
                                type="radio"
                                name="rating"
                                value="1"
                                required>
                            1 ⭐
                        </label>

                        <label>
                            <input
                                type="radio"
                                name="rating"
                                value="2">
                            2 ⭐
                        </label>

                        <label>
                            <input
                                type="radio"
                                name="rating"
                                value="3">
                            3 ⭐
                        </label>

                        <label>
                            <input
                                type="radio"
                                name="rating"
                                value="4">
                            4 ⭐
                        </label>

                        <label>
                            <input
                                type="radio"
                                name="rating"
                                value="5">
                            5 ⭐
                        </label>

                    </div>

                </div>


                <!-- REVIEW -->

                <div class="form-group">

                    <label>
                        Your Review
                    </label>

                    <textarea
                        name="reviewText"
                        placeholder="Write your review here..."
                        maxlength="500"
                        required></textarea>

                </div>


                <button
                    type="submit"
                    class="submit-btn">

                    Submit Review

                </button>

            </form>

        </div>


    <% } else { %>


        <div class="message error">

            Please
            <a href="login.jsp">
                login
            </a>
            to write a review.

        </div>


    <% } %>


    <!-- ================= EXISTING REVIEWS ================= -->

    <div class="reviews-section">

        <h2>
            Customer Reviews
        </h2>


        <%

            List<Review> reviews =
                (List<Review>)
                request.getAttribute("reviews");

        %>


        <% if (reviews != null && !reviews.isEmpty()) { %>


            <% for (Review review : reviews) { %>


                <div class="review-card">


                    <div class="review-header">

                        <div class="reviewer">

                            <%= review.getUserName() %>

                        </div>


                        <div class="stars">

                            <%
                                for (
                                    int i = 1;
                                    i <= review.getRating();
                                    i++
                                ) {
                            %>

                                ⭐

                            <%
                                }
                            %>

                        </div>

                    </div>


                    <div class="review-date">

                        <%= review.getReviewDate() %>

                    </div>


                    <div class="review-text">

                        <%= review.getReviewText() %>

                    </div>


                </div>


            <% } %>


        <% } else { %>


            <div class="no-reviews">

                No reviews yet.

                Be the first customer to review this product!

            </div>


        <% } %>


    </div>

</div>


<!-- ================= FOOTER ================= -->

<footer>

    &copy; 2026 E-Shop. All Rights Reserved.

</footer>


</body>

</html>