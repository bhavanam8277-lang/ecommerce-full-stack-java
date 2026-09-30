
package com.ecommerce;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        // Get data from registration form
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword =
                request.getParameter("confirmPassword");

        // Check that passwords were entered and match
        if (password == null || confirmPassword == null
                || !password.equals(confirmPassword)) {

            response.sendRedirect(
                request.getContextPath()
                + "/register.jsp?error=Passwords%20do%20not%20match"
            );
            return;
        }

        String sql =
            "INSERT INTO users (name, email, password, role) "
            + "VALUES (?, ?, ?, 'USER')";

        try (
            Connection connection = DBConnection.getConnection();
            PreparedStatement statement =
                    connection.prepareStatement(sql)
        ) {

            statement.setString(1, name);
            statement.setString(2, email);
            statement.setString(3, password);

            int result = statement.executeUpdate();

            if (result > 0) {

                response.sendRedirect(
                    request.getContextPath()
                    + "/register.jsp?success=Registration%20successful"
                );

            } else {

                response.sendRedirect(
                    request.getContextPath()
                    + "/register.jsp?error=Registration%20failed"
                );
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                request.getContextPath()
                + "/register.jsp?error=Email%20may%20already%20exist"
            );
        }
    }
}