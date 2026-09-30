<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <title>My Profile - E-Commerce</title>

    <style>

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f5f5f5;
        }

        /* ================= NAVBAR ================= */

        .navbar {
            background: #222;
            padding: 18px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo {
            color: white;
            font-size: 24px;
            font-weight: bold;
        }

        .nav-links a {
            color: white;
            text-decoration: none;
            margin-left: 25px;
        }

        .nav-links a:hover {
            color: #ff9800;
        }

        /* ================= PROFILE ================= */

        .container {
            width: 90%;
            max-width: 700px;
            margin: 50px auto;
        }

        h1 {
            text-align: center;
            margin-bottom: 30px;
        }

        .profile-card {
            background: white;
            padding: 35px;
            border-radius: 12px;
            box-shadow: 0 3px 12px rgba(0, 0, 0, 0.1);
        }

        .profile-icon {
            width: 90px;
            height: 90px;
            margin: 0 auto 25px;
            border-radius: 50%;
            background: #ff9800;
            color: white;
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 42px;
        }

        .profile-row {
            display: flex;
            justify-content: space-between;
            padding: 18px 0;
            border-bottom: 1px solid #eee;
        }

        .profile-row:last-child {
            border-bottom: none;
        }

        .label {
            font-weight: bold;
        }

        .value {
            color: #555;
        }

        /* ================= EDIT PROFILE ================= */

        .edit-section {
            display: none;
            margin-top: 25px;
            padding-top: 25px;
            border-top: 1px solid #eee;
        }

        .edit-section h2 {
            text-align: center;
            margin-bottom: 20px;
        }

        .form-group {
            margin-bottom: 18px;
        }

        .form-group label {
            display: block;
            font-weight: bold;
            margin-bottom: 7px;
        }

        .form-group input {
            width: 100%;
            box-sizing: border-box;
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 15px;
        }

        .form-group input:focus {
            outline: none;
            border-color: #ff9800;
        }

        /* ================= BUTTONS ================= */

        .buttons {
            text-align: center;
            margin-top: 30px;
        }

        .btn {
            display: inline-block;
            background: #ff9800;
            color: white;
            padding: 12px 22px;
            text-decoration: none;
            border-radius: 6px;
            font-weight: bold;
            margin: 5px;
            border: none;
            cursor: pointer;
            font-size: 15px;
        }

        .btn:hover {
            background: #e68900;
        }

        .save-btn {
            background: #229954;
        }

        .save-btn:hover {
            background: #1e8449;
        }

        .cancel-btn {
            background: #777;
        }

        .cancel-btn:hover {
            background: #555;
        }

        /* ================= MESSAGE ================= */

        .success-message {
            background: #d4edda;
            color: #155724;
            padding: 12px;
            border-radius: 6px;
            margin-bottom: 20px;
            text-align: center;
        }

        .error-message {
            background: #f8d7da;
            color: #721c24;
            padding: 12px;
            border-radius: 6px;
            margin-bottom: 20px;
            text-align: center;
        }

        /* ================= MOBILE ================= */

        @media (max-width: 700px) {

            .navbar {
                padding: 15px 20px;
                flex-direction: column;
                gap: 15px;
            }

            .nav-links {
                text-align: center;
            }

            .nav-links a {
                margin: 5px 8px;
                display: inline-block;
            }

            .profile-row {
                flex-direction: column;
                gap: 8px;
            }

            .profile-card {
                padding: 25px;
            }

        }

    </style>

</head>

<body>

<!-- ================= NAVBAR ================= -->

<div class="navbar">

    <div class="logo">
        &#128722; E-Commerce
    </div>

    <div class="nav-links">

        <a href="index.jsp">
            Home
        </a>

        <a href="ProductServlet">
            Products
        </a>

        <a href="cart.jsp">
            Cart
        </a>

        <a href="MyOrdersServlet">
            My Orders
        </a>

        <a href="LogoutServlet">
            Logout
        </a>

    </div>

</div>


<!-- ================= CONTENT ================= -->

<div class="container">

    <h1>
        My Profile
    </h1>

    <div class="profile-card">

        <div class="profile-icon">
            &#128100;
        </div>


        <!-- SUCCESS MESSAGE -->

        <%
            String success =
                    request.getParameter("success");

            if (success != null) {
        %>

            <div class="success-message">
                <%= success %>
            </div>

        <%
            }
        %>


        <!-- ERROR MESSAGE -->

        <%
            String error =
                    request.getParameter("error");

            if (error != null) {
        %>

            <div class="error-message">
                <%= error %>
            </div>

        <%
            }
        %>


        <!-- USER ID -->

        <div class="profile-row">

            <span class="label">
                User ID
            </span>

            <span class="value">
                #<%= request.getAttribute("userId") %>
            </span>

        </div>


        <!-- NAME -->

        <div class="profile-row">

            <span class="label">
                Name
            </span>

            <span class="value">
                <%= request.getAttribute("userName") %>
            </span>

        </div>


        <!-- EMAIL -->

        <div class="profile-row">

            <span class="label">
                Email
            </span>

            <span class="value">
                <%= request.getAttribute("userEmail") %>
            </span>

        </div>


        <!-- ROLE -->

        <div class="profile-row">

            <span class="label">
                Role
            </span>

            <span class="value">
                <%= request.getAttribute("userRole") %>
            </span>

        </div>


        <!-- ================= EDIT PROFILE FORM ================= -->

        <div id="editSection" class="edit-section">

            <h2>
                Edit Profile
            </h2>

            <form
                action="UserProfileServlet"
                method="post">

                <!-- NAME -->

                <div class="form-group">

                    <label for="name">
                        Name
                    </label>

                    <input
                        type="text"
                        id="name"
                        name="name"
                        value="<%= request.getAttribute("userName") %>"
                        required>

                </div>


                <!-- EMAIL -->

                <div class="form-group">

                    <label for="email">
                        Email
                    </label>

                    <input
                        type="email"
                        id="email"
                        name="email"
                        value="<%= request.getAttribute("userEmail") %>"
                        required>

                </div>


                <!-- SAVE / CANCEL -->

                <div class="buttons">

                    <button
                        type="submit"
                        class="btn save-btn">
                        Save Changes
                    </button>

                    <button
                        type="button"
                        class="btn cancel-btn"
                        onclick="hideEditProfile()">
                        Cancel
                    </button>

                </div>

            </form>

        </div>


        <!-- ================= MAIN BUTTONS ================= -->

        <div class="buttons">

            <button
                type="button"
                class="btn"
                onclick="showEditProfile()">
                Edit Profile
            </button>

            <a
                href="MyOrdersServlet"
                class="btn">
                My Orders
            </a>

            <a
                href="index.jsp"
                class="btn">
                Back to Home
            </a>

        </div>

    </div>

</div>


<!-- ================= JAVASCRIPT ================= -->

<script>

    function showEditProfile() {

        document.getElementById("editSection").style.display = "block";

        window.scrollTo({
            top: document.getElementById("editSection").offsetTop - 20,
            behavior: "smooth"
        });
    }


    function hideEditProfile() {

        document.getElementById("editSection").style.display = "none";

    }

</script>

</body>

</html>