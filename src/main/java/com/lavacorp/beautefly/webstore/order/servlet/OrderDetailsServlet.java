package com.lavacorp.beautefly.webstore.order.servlet;

import com.lavacorp.beautefly.webstore.order.OrderService;
import com.lavacorp.beautefly.webstore.security.filter.UserContextFilter;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.HttpConstraint;
import jakarta.servlet.annotation.ServletSecurity;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/order")
@ServletSecurity(@HttpConstraint(rolesAllowed = {"*"}))
public class OrderDetailsServlet extends HttpServlet {
    @Inject
    private OrderService orderService;

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int orderId;
        try {
            orderId = Integer.parseUnsignedInt(req.getParameter("id"));
        } catch (NullPointerException | NumberFormatException e) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Order not found");
            return;
        }

        var user = UserContextFilter.getUserContext(req);
        assert user != null;

        var order = orderService.getOrderDetails(user, orderId);
        if (order == null) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Order not found");
            return;
        }

        req.setAttribute("order", order);

        var view = req.getRequestDispatcher("/WEB-INF/views/account/order-details.jsp");
        view.forward(req, resp);
    }
}

