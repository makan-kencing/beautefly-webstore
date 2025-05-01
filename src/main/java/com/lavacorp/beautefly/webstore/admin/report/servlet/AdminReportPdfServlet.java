package com.lavacorp.beautefly.webstore.admin.report.servlet;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDPage;
import org.apache.pdfbox.pdmodel.PDPageContentStream;
import org.apache.pdfbox.pdmodel.font.PDType1Font;

import java.io.IOException;
import java.time.Instant;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.List;

@WebServlet("/admin/reports/pdf")
public class AdminReportPdfServlet extends HttpServlet {

    @PersistenceContext
    private EntityManager em;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String fromDate = req.getParameter("from");
        String toDate = req.getParameter("to");

        if (fromDate == null || toDate == null) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing date parameters");
            return;
        }

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

        double totalSales = topProducts.stream()
                .mapToDouble(row -> ((Number) row[1]).doubleValue())
                .sum();

        PDDocument document = new PDDocument();
        PDPage page = new PDPage();
        document.addPage(page);
        PDPageContentStream contentStream = new PDPageContentStream(document, page);

        int startX = 50;
        int startY = 750;
        int rowHeight = 20;
        int tableWidth = 500;
        int[] colWidths = {40, 300, 160};

        // 📄 Title
        contentStream.setFont(PDType1Font.HELVETICA_BOLD, 16);
        contentStream.beginText();
        contentStream.newLineAtOffset(startX, startY);
        contentStream.showText("Top 10 Best-Selling Products Report");
        contentStream.endText();

        // 🗓 Date Range
        contentStream.setFont(PDType1Font.HELVETICA, 12);
        contentStream.beginText();
        contentStream.newLineAtOffset(startX, startY - 20);
        contentStream.showText("Date Range: " + fromDate + " to " + toDate);
        contentStream.endText();

        // 📊 Table Header
        int tableY = startY - 50;
        contentStream.setFont(PDType1Font.HELVETICA_BOLD, 12);
        drawCell(contentStream, startX, tableY, colWidths[0], rowHeight, "No.");
        drawCell(contentStream, startX + colWidths[0], tableY, colWidths[1], rowHeight, "Product Name");
        drawCell(contentStream, startX + colWidths[0] + colWidths[1], tableY, colWidths[2], rowHeight, "Total Sales (RM)");

        // 🧾 Table Rows
        contentStream.setFont(PDType1Font.HELVETICA, 12);
        int y = tableY - rowHeight;
        int i = 1;
        for (Object[] row : topProducts) {
            String product = row[0].toString();
            String sales = "RM " + String.format("%.2f", ((Number) row[1]).doubleValue());

            drawCell(contentStream, startX, y, colWidths[0], rowHeight, String.valueOf(i));
            drawCell(contentStream, startX + colWidths[0], y, colWidths[1], rowHeight, product);
            drawCell(contentStream, startX + colWidths[0] + colWidths[1], y, colWidths[2], rowHeight, sales);

            y -= rowHeight;
            i++;
        }

        // 💰 Total Summary
        contentStream.setFont(PDType1Font.HELVETICA_BOLD, 12);
        drawCell(contentStream, startX, y - 10, tableWidth, rowHeight,
                "Total Sales: RM " + String.format("%.2f", totalSales));

        contentStream.close();
        resp.setContentType("application/pdf");
        resp.setHeader("Content-Disposition", "attachment; filename=\"sales_report.pdf\"");
        document.save(resp.getOutputStream());
        document.close();
    }

    private void drawCell(PDPageContentStream contentStream, int x, int y, int width, int height, String text) throws IOException {
        contentStream.addRect(x, y, width, height);
        contentStream.stroke();

        contentStream.beginText();
        contentStream.setFont(PDType1Font.HELVETICA, 12);
        contentStream.newLineAtOffset(x + 5, y + 5);
        contentStream.showText(text.length() > 50 ? text.substring(0, 47) + "..." : text);
        contentStream.endText();
    }
}