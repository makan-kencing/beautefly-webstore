package com.lavacorp.beautefly.webstore.admin.report.servlet;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.Instant;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.List;

@WebServlet("/admin/reports/customers")
public class CustomerSummaryReportServlet extends HttpServlet {

    @PersistenceContext
    private EntityManager em;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String fromDate = req.getParameter("from");
        String toDate = req.getParameter("to");

        if (fromDate != null && toDate != null) {
            try {
                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
                Instant fromInstant = LocalDate.parse(fromDate, formatter)
                        .atStartOfDay(ZoneId.systemDefault()).toInstant();
                Instant toInstant = LocalDate.parse(toDate, formatter)
                        .atStartOfDay(ZoneId.systemDefault()).toInstant();

                var query = em.createQuery("""
                    SELECT a.username, a.email, COUNT(o.id), SUM(o.taxAmount + o.shippingAmount + o.discountAmount)
                    FROM SalesOrder o
                    JOIN o.account a
                    WHERE o.orderedAt BETWEEN :fromDate AND :toDate
                    GROUP BY a.id, a.username, a.email
                    ORDER BY SUM(o.taxAmount + o.shippingAmount + o.discountAmount) DESC
                """, Object[].class);

                query.setParameter("fromDate", fromInstant);
                query.setParameter("toDate", toInstant);

                List<Object[]> customers = query.setMaxResults(10).getResultList();

                req.setAttribute("customers", customers);
                req.setAttribute("from", fromDate);
                req.setAttribute("to", toDate);
            } catch (Exception e) {
                req.setAttribute("error", "Invalid date format.");
            }
        }

        req.getRequestDispatcher("/WEB-INF/views/admin/customer-summary.jsp")
                .forward(req, resp);
    }
}
