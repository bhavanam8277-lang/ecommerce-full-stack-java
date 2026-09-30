package com.ecommerce;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/DeleteProductServlet")
public class DeleteProductServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String role = (String) session.getAttribute("userRole");

        if (role == null || !role.equalsIgnoreCase("ADMIN")) {
            response.sendRedirect("index.jsp?error=Access%20denied");
            return;
        }

        try {

            int id = Integer.parseInt(
                request.getParameter("id")
            );

            String sql =
                "DELETE FROM products WHERE id = ?";

            try (
                Connection connection = DBConnection.getConnection();
                PreparedStatement statement =
                    connection.prepareStatement(sql)
            ) {

                statement.setInt(1, id);

                int rowsDeleted =
                    statement.executeUpdate();

                if (rowsDeleted > 0) {
                    response.sendRedirect(
                        "AdminProductServlet?success=Product%20deleted%20successfully"
                    );
                } else {
                    response.sendRedirect(
                        "AdminProductServlet?error=Product%20not%20found"
                    );
                }
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                "AdminProductServlet?error=Unable%20to%20delete%20product"
            );
        }
    }
}