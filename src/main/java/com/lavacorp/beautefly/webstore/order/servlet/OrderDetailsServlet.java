package com.lavacorp.beautefly.webstore.order.servlet;

import com.lavacorp.beautefly.webstore.admin.order.AdminOrderService;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/admin/orders/*")
public class OrderDetailsServlet extends HttpServlet {

    @Inject
    private AdminOrderService orderService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String pathInfo = req.getPathInfo(); // Example: "/65"

        if (pathInfo == null || pathInfo.equals("/") || pathInfo.length() <= 1) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing order ID");
            return;
        }

        try {
            int orderId = Integer.parseInt(pathInfo.substring(1)); // Remove the leading "/"
            var order = orderService.getOrderDetails(orderId);

            if (order == null) {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Order not found");
                return;
            }

            req.setAttribute("order", order);
            req.getRequestDispatcher("/WEB-INF/views/admin/order-details.jsp").forward(req, resp);

        } catch (NumberFormatException e) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid order ID format");
        }
    }
}
