package com.ecommerce;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
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

@WebServlet({"/CartServlet", "/cart"})
public class CartServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    /*
     * GET requests
     */
    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        processCartRequest(request, response);
    }

    /*
     * POST requests
     *
     * This is important because the +, -, and Remove
     * buttons in cart.jsp may use method="post".
     */
    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        processCartRequest(request, response);
    }

    /*
     * =========================================================
     * MAIN CART PROCESSING
     * =========================================================
     */
    private void processCartRequest(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {

        HttpSession session = request.getSession();

        @SuppressWarnings("unchecked")
        List<Product> cart =
                (List<Product>) session.getAttribute("cart");

        if (cart == null) {
            cart = new ArrayList<>();
            session.setAttribute("cart", cart);
        }

        String contextPath = request.getContextPath();

        /*
         * =====================================================
         * 1. ADD PRODUCT
         * =====================================================
         */

        String productId =
                request.getParameter("productId");

        if (productId != null
                && !productId.trim().isEmpty()) {

            try {

                int id =
                        Integer.parseInt(productId);

                Product product =
                        findProduct(id);

                if (product == null) {

                    response.sendRedirect(
                            contextPath
                            + "/ProductServlet?error="
                            + encode("Product not found"));

                    return;
                }

                String size =
                        normalizeSize(
                                request.getParameter("size"));

                /*
                 * Product 4 and Product 5 need size.
                 */
                if (id == 4 || id == 5) {

                    if (size.isEmpty()) {

                        response.sendRedirect(
                                contextPath
                                + "/ProductDetailsServlet"
                                + "?productId="
                                + id
                                + "&error="
                                + encode(
                                    "Please select a size"));

                        return;
                    }

                    if (!isSizeAvailable(id, size)) {

                        response.sendRedirect(
                                contextPath
                                + "/ProductDetailsServlet"
                                + "?productId="
                                + id
                                + "&error="
                                + encode(
                                    "Selected size is unavailable"));

                        return;
                    }

                } else {

                    size = "";
                }

                product.setSize(size);

                /*
                 * Add one product to cart.
                 */
                cart.add(product);

                saveCart(session, cart);

                /*
                 * After successful add:
                 * go back to Products.
                 */
                response.sendRedirect(
                        contextPath
                        + "/ProductServlet?success="
                        + encode(
                            "Product added to cart successfully"));

                return;

            } catch (NumberFormatException e) {

                response.sendRedirect(
                        contextPath
                        + "/ProductServlet?error="
                        + encode("Invalid product"));

                return;
            }
        }

        /*
         * =====================================================
         * 2. INCREASE QUANTITY
         * =====================================================
         */

        String increaseId =
                request.getParameter("increaseId");

        if (increaseId != null
                && !increaseId.trim().isEmpty()) {

            changeQuantity(
                    cart,
                    increaseId,
                    request.getParameter("size"),
                    true,
                    request,
                    response,
                    session);

            return;
        }

        /*
         * =====================================================
         * 3. DECREASE QUANTITY
         * =====================================================
         */

        String decreaseId =
                request.getParameter("decreaseId");

        if (decreaseId != null
                && !decreaseId.trim().isEmpty()) {

            changeQuantity(
                    cart,
                    decreaseId,
                    request.getParameter("size"),
                    false,
                    request,
                    response,
                    session);

            return;
        }

        /*
         * =====================================================
         * 4. REMOVE PRODUCT
         * =====================================================
         */

        String removeId =
                request.getParameter("removeId");

        if (removeId != null
                && !removeId.trim().isEmpty()) {

            try {

                int id =
                        Integer.parseInt(removeId);

                String selectedSize =
                        normalizeSize(
                                request.getParameter("size"));

                boolean removed = false;

                for (int i = 0;
                        i < cart.size();
                        i++) {

                    Product item =
                            cart.get(i);

                    String itemSize =
                            normalizeSize(
                                    item.getSize());

                    if (item.getId() == id
                            && itemSize.equals(
                                    selectedSize)) {

                        cart.remove(i);

                        removed = true;

                        break;
                    }
                }

                saveCart(session, cart);

                if (removed) {

                    response.sendRedirect(
                            contextPath
                            + "/cart.jsp?success="
                            + encode(
                                "Product removed from cart"));

                } else {

                    response.sendRedirect(
                            contextPath
                            + "/cart.jsp?error="
                            + encode(
                                "Product not found in cart"));
                }

                return;

            } catch (NumberFormatException e) {

                response.sendRedirect(
                        contextPath
                        + "/cart.jsp?error="
                        + encode(
                            "Invalid product"));

                return;
            }
        }

        /*
         * =====================================================
         * 5. JUST OPEN CART
         * =====================================================
         */

        response.sendRedirect(
                contextPath + "/cart.jsp");
    }


    /*
     * =========================================================
     * CHANGE QUANTITY
     * =========================================================
     */
    private void changeQuantity(
            List<Product> cart,
            String productId,
            String size,
            boolean increase,
            HttpServletRequest request,
            HttpServletResponse response,
            HttpSession session)
            throws IOException {

        try {

            int id =
                    Integer.parseInt(productId);

            String selectedSize =
                    normalizeSize(size);

            /*
             * =================================================
             * INCREASE
             * =================================================
             */
            if (increase) {

                Product product =
                        findProduct(id);

                if (product == null) {

                    response.sendRedirect(
                            request.getContextPath()
                            + "/cart.jsp?error="
                            + encode(
                                "Product not found"));

                    return;
                }

                /*
                 * Product 4 and 5 need size.
                 */
                if (id == 4 || id == 5) {

                    if (selectedSize.isEmpty()) {

                        response.sendRedirect(
                                request.getContextPath()
                                + "/cart.jsp?error="
                                + encode(
                                    "Please select a size"));

                        return;
                    }

                    if (!isSizeAvailable(
                            id,
                            selectedSize)) {

                        response.sendRedirect(
                                request.getContextPath()
                                + "/cart.jsp?error="
                                + encode(
                                    "Selected size is unavailable"));

                        return;
                    }

                } else {

                    selectedSize = "";
                }

                product.setSize(selectedSize);

                /*
                 * Add another copy.
                 */
                cart.add(product);
            }

            /*
             * =================================================
             * DECREASE
             * =================================================
             */
            else {

    for (int i = cart.size() - 1;
            i >= 0;
            i--) {

        Product item =
                cart.get(i);

        String itemSize =
                normalizeSize(
                        item.getSize());

        if (item.getId() == id
                && itemSize.equals(
                        selectedSize)) {

            cart.remove(i);

            break;
        }
    }
}

            saveCart(session, cart);

            response.sendRedirect(
                    request.getContextPath()
                    + "/cart.jsp");

        } catch (NumberFormatException e) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/cart.jsp?error="
                    + encode(
                        "Invalid product"));
        }
    }


    /*
     * =========================================================
     * FIND PRODUCT FROM DATABASE
     * =========================================================
     */
    private Product findProduct(int id) {

        String sql =
                "SELECT id, name, description, price, stock, image_url "
                + "FROM products WHERE id = ?";

        try (
                Connection connection =
                        DBConnection.getConnection();

                PreparedStatement statement =
                        connection.prepareStatement(sql)
        ) {

            statement.setInt(1, id);

            try (
                    ResultSet result =
                            statement.executeQuery()
            ) {

                if (result.next()) {

                    Product product =
                            new Product();

                    product.setId(
                            result.getInt("id"));

                    product.setName(
                            result.getString("name"));

                    product.setDescription(
                            result.getString("description"));

                    product.setPrice(
                            result.getDouble("price"));

                    product.setStock(
                            result.getInt("stock"));

                    product.setImageUrl(
                            result.getString("image_url"));

                    return product;
                }
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return null;
    }


    /*
     * =========================================================
     * CHECK SIZE STOCK
     * =========================================================
     */
    private boolean isSizeAvailable(
            int productId,
            String size) {

        String sql =
                "SELECT stock FROM product_sizes "
                + "WHERE product_id = ? AND size = ?";

        try (
                Connection connection =
                        DBConnection.getConnection();

                PreparedStatement statement =
                        connection.prepareStatement(sql)
        ) {

            statement.setInt(1, productId);

            statement.setString(2, size);

            try (
                    ResultSet result =
                            statement.executeQuery()
            ) {

                return result.next()
                        && result.getInt("stock") > 0;
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return false;
    }


    /*
     * =========================================================
     * SAVE CART IN SESSION
     * =========================================================
     */
    private void saveCart(
            HttpSession session,
            List<Product> cart) {

        session.setAttribute(
                "cart",
                cart);

        session.setAttribute(
                "cartCount",
                cart.size());
    }


    /*
     * =========================================================
     * NORMALIZE SIZE
     * =========================================================
     */
    private String normalizeSize(String size) {

        if (size == null) {
            return "";
        }

        return size.trim();
    }


    /*
     * =========================================================
     * URL ENCODE MESSAGE
     * =========================================================
     */
    private String encode(String message) {

        return URLEncoder.encode(
                message,
                StandardCharsets.UTF_8);
    }
}