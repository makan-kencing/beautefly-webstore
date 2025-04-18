package com.lavacorp.beautefly.webstore.admin;

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

@WebServlet("/admin/reports")
public class TopProductReport extends HttpServlet {

    @PersistenceContext
    private EntityManager em;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String fromDate = request.getParameter("from");
        String toDate = request.getParameter("to");

        if (fromDate != null && toDate != null) {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            Instant fromInstant = LocalDate.parse(fromDate, formatter)
                    .atStartOfDay(ZoneId.systemDefault()).toInstant();
            Instant toInstant = LocalDate.parse(toDate, formatter)
                    .atStartOfDay(ZoneId.systemDefault()).toInstant();

            var query = em.createQuery("""
                SELECT sop.product.name, SUM(sop.unitPrice) AS totalSales
                FROM SalesOrderProduct sop
                JOIN sop.order so
                WHERE so.orderedAt BETWEEN :fromDate AND :toDate
                GROUP BY sop.product.id, sop.product.name
                ORDER BY totalSales DESC
            """, Object[].class);

            query.setParameter("fromDate", fromInstant);
            query.setParameter("toDate", toInstant);
            query.setMaxResults(10);

            List<Object[]> topProducts = query.getResultList();
            request.setAttribute("topProducts", topProducts);
            request.setAttribute("from", fromDate);
            request.setAttribute("to", toDate);
        }

        request.getRequestDispatcher("/admin/reportTopProducts.jsp").forward(request, response);
    }
}
