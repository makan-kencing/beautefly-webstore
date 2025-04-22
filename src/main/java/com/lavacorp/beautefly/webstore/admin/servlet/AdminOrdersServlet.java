package com.lavacorp.beautefly.webstore.admin.servlet;

import com.lavacorp.beautefly.webstore.order.entity.OrderRepository;
import com.lavacorp.beautefly.webstore.order.entity.SalesOrder;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/orders")
public class AdminOrdersServlet extends HttpServlet {

    @Inject
    private OrderRepository orderRepository;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int pageNumber = 1;
        int pageSize = 50;

        String pageParam = req.getParameter("page");
        if (pageParam != null && pageParam.matches("\\d+")) {
            pageNumber = Integer.parseInt(pageParam);
        }

        int offset = (pageNumber - 1) * pageSize;

        List<SalesOrder> orders = orderRepository.findPaged(offset, pageSize);
        long totalOrders = orderRepository.count();
        int totalPages = (int) Math.ceil((double) totalOrders / pageSize);

        req.setAttribute("orders", orders);
        req.setAttribute("currentPage", pageNumber);
        req.setAttribute("totalPages", totalPages);

        var view = req.getRequestDispatcher("/WEB-INF/views/admin/orders.jsp");
        view.forward(req, resp);
    }
}
