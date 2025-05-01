package com.lavacorp.beautefly.webstore.admin.order.servlet;

import com.lavacorp.beautefly.webstore.admin.order.AdminOrderService;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/admin/order")
public class OrderDetailsServlet extends HttpServlet {

    @Inject
    private AdminOrderService orderService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int orderId;
        try {
            orderId = Integer.parseInt(req.getParameter("id"));
        } catch (NullPointerException | NumberFormatException e) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid order ID format");
            return;
        }

        var order = orderService.getOrderDetails(orderId);
        if (order == null) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Order not found");
        }

        req.setAttribute("order", order);
        var view = req.getRequestDispatcher("/WEB-INF/views/admin/order-details.jsp");
        view.forward(req, resp);
    }
}
