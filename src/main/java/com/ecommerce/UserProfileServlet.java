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

@WebServlet("/UserProfileServlet")
public class UserProfileServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    // =========================
    // VIEW PROFILE
    // =========================
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
                request.getContextPath()
                + "/login.jsp?error=Please%20login%20to%20view%20your%20profile"
            );
            return;
        }

        String sql =
            "SELECT id, name, email, role " +
            "FROM users " +
            "WHERE id = ?";

        try (
            Connection connection =
                DBConnection.getConnection();

            PreparedStatement statement =
                connection.prepareStatement(sql)
        ) {

            statement.setInt(1, userId);

            ResultSet result =
                statement.executeQuery();

            if (result.next()) {

                request.setAttribute(
                    "userId",
                    result.getInt("id")
                );

                request.setAttribute(
                    "userName",
                    result.getString("name")
                );

                request.setAttribute(
                    "userEmail",
                    result.getString("email")
                );

                request.setAttribute(
                    "userRole",
                    result.getString("role")
                );

                request.getRequestDispatcher(
                    "profile.jsp"
                ).forward(request, response);

            } else {

                response.sendRedirect(
                    request.getContextPath()
                    + "/index.jsp"
                );
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.getWriter().println(
                "Error loading profile: "
                + e.getMessage()
            );
        }
    }


    // =========================
    // UPDATE PROFILE
    // =========================
    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        Integer userId =
                (Integer) session.getAttribute("userId");

        // Check login
        if (userId == null) {
            response.sendRedirect(
                request.getContextPath()
                + "/login.jsp?error=Please%20login"
            );
            return;
        }

        String name =
                request.getParameter("name");

        String email =
                request.getParameter("email");

        // Remove extra spaces
        if (name != null) {
            name = name.trim();
        }

        if (email != null) {
            email = email.trim();
        }

        // Validate
        if (name == null
                || name.isEmpty()
                || email == null
                || email.isEmpty()) {

            response.sendRedirect(
                request.getContextPath()
                + "/UserProfileServlet?error=Name%20and%20email%20are%20required"
            );
            return;
        }

        String sql =
            "UPDATE users " +
            "SET name = ?, email = ? " +
            "WHERE id = ?";

        try (
            Connection connection =
                DBConnection.getConnection();

            PreparedStatement statement =
                connection.prepareStatement(sql)
        ) {

            statement.setString(1, name);
            statement.setString(2, email);
            statement.setInt(3, userId);

            int rowsUpdated =
                    statement.executeUpdate();

            if (rowsUpdated > 0) {

                // Update session name
                session.setAttribute(
                    "userName",
                    name
                );

                response.sendRedirect(
                    request.getContextPath()
                    + "/UserProfileServlet?success=Profile%20updated%20successfully"
                );

            } else {

                response.sendRedirect(
                    request.getContextPath()
                    + "/UserProfileServlet?error=Profile%20update%20failed"
                );
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                request.getContextPath()
                + "/UserProfileServlet?error=Email%20may%20already%20exist"
            );
        }
    }
}