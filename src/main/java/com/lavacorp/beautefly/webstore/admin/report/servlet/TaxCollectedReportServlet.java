package com.lavacorp.beautefly.webstore.admin.report.servlet;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.Month;
import java.time.ZoneId;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/admin/reports/tax")
public class TaxCollectedReportServlet extends HttpServlet {

    @PersistenceContext
    private EntityManager em;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        var query = em.createNativeQuery("""
            SELECT EXTRACT(MONTH FROM ordered_at) AS month,
                   SUM(tax_amount) AS total_tax
            FROM sales_order
            WHERE EXTRACT(YEAR FROM ordered_at) = EXTRACT(YEAR FROM CURRENT_DATE)
            GROUP BY month
            ORDER BY month
        """);

        List<Object[]> results = query.getResultList();

        Map<String, Double> taxPerMonth = new LinkedHashMap<>();

        for (Object[] row : results) {
            int monthNumber = ((Number) row[0]).intValue();
            double total = ((Number) row[1]).doubleValue();
            Month monthEnum = Month.of(monthNumber);
            String monthName = monthEnum.name().substring(0, 1) + monthEnum.name().substring(1).toLowerCase().substring(0, 2); // Jan, Feb, etc
            taxPerMonth.put(monthName, total);
        }

        req.setAttribute("taxPerMonth", taxPerMonth);
        req.getRequestDispatcher("/WEB-INF/views/admin/tax-report.jsp")
                .forward(req, resp);
    }
}
