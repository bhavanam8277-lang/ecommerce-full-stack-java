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

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        // Get email and password from login form
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        String sql =
            "SELECT id, name, role FROM users " +
            "WHERE email = ? AND password = ?";

        try (
            Connection connection = DBConnection.getConnection();
            PreparedStatement statement =
                connection.prepareStatement(sql)
        ) {

            statement.setString(1, email);
            statement.setString(2, password);

            try (ResultSet result = statement.executeQuery()) {

                if (result.next()) {

                    // Login successful
                    HttpSession session =
                            request.getSession();

                    session.setAttribute(
                        "userId",
                        result.getInt("id")
                    );

                    session.setAttribute(
                        "userName",
                        result.getString("name")
                    );

                    session.setAttribute(
                        "userRole",
                        result.getString("role")
                    );

                    response.sendRedirect(
                        request.getContextPath() +
                        "/index.jsp"
                    );

                } else {

                    // Login failed
                    response.sendRedirect(
                        request.getContextPath() +
                        "/login.jsp?error=Invalid%20email%20or%20password"
                    );
                }
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                request.getContextPath() +
                "/login.jsp?error=Something%20went%20wrong"
            );
        }
    }
}