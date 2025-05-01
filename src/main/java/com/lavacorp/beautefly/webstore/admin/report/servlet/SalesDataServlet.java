package com.lavacorp.beautefly.webstore.admin.report.servlet;

import com.google.gson.Gson;
import jakarta.inject.Inject;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.lavacorp.beautefly.webstore.order.entity.OrderRepository;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

@WebServlet("/admin/salesData")
public class SalesDataServlet extends HttpServlet {

    @Inject
    private OrderRepository orderRepo;

    private final Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String type = req.getParameter("type");

        List<BigDecimal> salesData;
        List<String> categories;
        List<Integer> ordersData;

        if ("daily".equals(type)) {
            salesData = orderRepo.getDailySales();
            categories = orderRepo.getDailyLabels();
            ordersData = orderRepo.getDailyOrderCount();
        } else if ("monthly".equals(type)) {
            salesData = orderRepo.getMonthlySales();
            categories = orderRepo.getMonthlyLabels();
            ordersData = orderRepo.getMonthlyOrderCount();
        } else if ("total".equals(type)) {
            salesData = orderRepo.getTotalSales();
            categories = orderRepo.getTotalLabels();
            ordersData = orderRepo.getTotalOrderCount();
        } else {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid type parameter");
            return;
        }

        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        var out = resp.getWriter();

        out.print(gson.toJson(Map.of(
                "sales", salesData,
                "categories", categories,
                "orders", ordersData
        )));
        out.flush();
    }
}
