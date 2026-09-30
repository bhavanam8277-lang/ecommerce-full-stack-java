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

@WebServlet("/EditProductServlet")
public class EditProductServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(
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

            String name = request.getParameter("name");

            String description = request.getParameter("description");

            double price = Double.parseDouble(
                request.getParameter("price")
            );

            int stock = Integer.parseInt(
                request.getParameter("stock")
            );

            String imageUrl = request.getParameter("imageUrl");

            String category = request.getParameter("category");

            String sql =
                "UPDATE products SET " +
                "name = ?, " +
                "description = ?, " +
                "price = ?, " +
                "stock = ?, " +
                "image_url = ?, " +
                "category = ? " +
                "WHERE id = ?";

            try (
                Connection connection = DBConnection.getConnection();
                PreparedStatement statement =
                    connection.prepareStatement(sql)
            ) {

                statement.setString(1, name);
                statement.setString(2, description);
                statement.setDouble(3, price);
                statement.setInt(4, stock);
                statement.setString(5, imageUrl);
                statement.setString(6, category);
                statement.setInt(7, id);

                statement.executeUpdate();
            }

            response.sendRedirect(
                "AdminProductServlet?success=Product%20updated%20successfully"
            );

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                "AdminProductServlet?error=Unable%20to%20update%20product"
            );
        }
    }
}