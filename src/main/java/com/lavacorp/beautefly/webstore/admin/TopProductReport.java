package com.lavacorp.beautefly.webstore.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.*;
import java.time.Instant;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/admin/reports")
public class TopProductReport extends HttpServlet {
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

            String url = "jdbc:postgresql://localhost:5432/user";
            String username = "user";
            String password = "password";

            String sql = """
                SELECT sop.product_id, SUM(sop.unit_price) AS totalSales
                FROM public.sales_order_product sop
                JOIN public.sales_order so ON sop.order_id = so.id
                WHERE so.ordered_at BETWEEN ? AND ?
                GROUP BY sop.product_id
                ORDER BY totalSales DESC
                LIMIT 10
            """;

            try (Connection conn = DriverManager.getConnection(url, username, password);
                 PreparedStatement stmt = conn.prepareStatement(sql)) {

                stmt.setTimestamp(1, Timestamp.from(fromInstant));
                stmt.setTimestamp(2, Timestamp.from(toInstant));

                try (ResultSet rs = stmt.executeQuery()) {
                    List<Object[]> topProducts = new ArrayList<>();
                    while (rs.next()) {
                        String productName = rs.getString("product_name");
                        double totalSales = rs.getDouble("totalSales");
                        topProducts.add(new Object[]{productName, totalSales});
                    }
                    request.setAttribute("topProducts", topProducts);
                    request.setAttribute("from", fromDate);
                    request.setAttribute("to", toDate);
                }
            } catch (SQLException e) {
                e.printStackTrace();
                request.setAttribute("error", "Database error occurred.");
            }
        }
        request.getRequestDispatcher("/admin/reportTopProducts.jsp").forward(request, response);
    }
}
