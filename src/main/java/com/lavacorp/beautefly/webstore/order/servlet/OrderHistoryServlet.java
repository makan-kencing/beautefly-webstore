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

@WebServlet("/orders")
@ServletSecurity(@HttpConstraint(rolesAllowed = {"*"}))
public class OrderHistoryServlet extends HttpServlet {
    @Inject
    private OrderService orderService;

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        var user = UserContextFilter.getUserContext(req);
        assert user != null;

        var orders = orderService.getOrderHistory(user);

        req.setAttribute("orders", orders);

        var view = req.getRequestDispatcher("/WEB-INF/views/account/order-history.jsp");
        view.forward(req, resp);
    }
}