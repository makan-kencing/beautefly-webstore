package com.lavacorp.beautefly.webstore.admin.order.servlet;

import com.lavacorp.beautefly.webstore.order.entity.OrderRepository;
import com.lavacorp.beautefly.webstore.order.entity.SalesOrder;
import com.lavacorp.beautefly.webstore.order.entity.SalesOrderProduct;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import jakarta.transaction.Transactional;
import java.io.IOException;
import java.time.Instant;

@WebServlet("/admin/orders/status")
public class UpdateOrderStatusServlet extends HttpServlet {

    @Inject
    private OrderRepository orderRepo;

    @Override
    @Transactional
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {
            int orderId = Integer.parseInt(req.getParameter("orderId"));
            int productId = Integer.parseInt(req.getParameter("productId"));
            String action = req.getParameter("action");

            SalesOrder order = orderRepo.findById(orderId);
            if (order == null) {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Order not found");
                return;
            }

            SalesOrderProduct product = order.getProducts().stream()
                    .filter(p -> p.getProduct().getId() == productId)
                    .findFirst()
                    .orElse(null);

            if (product == null) {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Product not found in order");
                return;
            }

            Instant now = Instant.now();

            switch (action) {
                case "shipped" -> product.setShippedAt(now);
                case "delivery" -> product.setDeliveryStartedAt(now);
                case "delivered" -> product.setDeliveredAt(now);
                default -> {
                    resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
                    return;
                }
            }

            resp.sendRedirect(req.getContextPath() + "/admin/orders/" + orderId);

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to update product status");
        }
    }
}
