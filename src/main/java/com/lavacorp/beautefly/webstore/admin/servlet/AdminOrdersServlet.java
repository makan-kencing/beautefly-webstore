package com.lavacorp.beautefly.webstore.admin.servlet;

import com.lavacorp.beautefly.webstore.admin.AdminOrderService;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/admin/orders")
public class AdminOrdersServlet extends HttpServlet {
    @Inject
    private AdminOrderService adminOrderService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        var orders = adminOrderService.getOrders();

        req.setAttribute("orders", orders);

        var view = req.getRequestDispatcher("/WEB-INF/views/admin/orders.jsp");
        view.forward(req, resp);
    }
}
