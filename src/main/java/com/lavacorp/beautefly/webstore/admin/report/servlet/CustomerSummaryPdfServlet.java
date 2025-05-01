package com.lavacorp.beautefly.webstore.admin.report.servlet;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.servlet.ServletException;
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

@WebServlet("/admin/reports/customers/pdf")
public class CustomerSummaryPdfServlet extends HttpServlet {

    @PersistenceContext
    private EntityManager em;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

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
            SELECT a.username, a.email, COUNT(o.id), SUM(o.taxAmount + o.shippingAmount + o.discountAmount)
            FROM SalesOrder o
            JOIN o.account a
            WHERE o.orderedAt BETWEEN :fromDate AND :toDate
            GROUP BY a.id, a.username, a.email
            ORDER BY SUM(o.taxAmount + o.shippingAmount + o.discountAmount) DESC
        """, Object[].class);

        query.setParameter("fromDate", fromInstant);
        query.setParameter("toDate", toInstant);
        query.setMaxResults(10);

        List<Object[]> customers = query.getResultList();

        PDDocument doc = new PDDocument();
        PDPage page = new PDPage();
        doc.addPage(page);
        PDPageContentStream content = new PDPageContentStream(doc, page);

        int x = 50, y = 750, rowHeight = 20;
        int[] colWidths = {40, 150, 180, 90, 100};

        content.setFont(PDType1Font.HELVETICA_BOLD, 16);
        content.beginText();
        content.newLineAtOffset(x, y);
        content.showText("Customer Summary Report");
        content.endText();

        content.setFont(PDType1Font.HELVETICA, 12);
        content.beginText();
        content.newLineAtOffset(x, y - 25);
        content.showText("Date Range: " + fromDate + " to " + toDate);
        content.endText();

        // Header
        int tableY = y - 60;
        String[] headers = {"#", "Username", "Email", "Orders", "Total Spent"};
        content.setFont(PDType1Font.HELVETICA_BOLD, 12);
        for (int i = 0, offset = 0; i < headers.length; i++) {
            drawCell(content, x + offset, tableY, colWidths[i], rowHeight, headers[i]);
            offset += colWidths[i];
        }

        // Data Rows
        content.setFont(PDType1Font.HELVETICA, 12);
        int dataY = tableY - rowHeight;
        int index = 1;
        for (Object[] row : customers) {
            int offset = 0;
            drawCell(content, x + offset, dataY, colWidths[0], rowHeight, String.valueOf(index++));
            offset += colWidths[0];
            drawCell(content, x + offset, dataY, colWidths[1], rowHeight, row[0].toString());
            offset += colWidths[1];
            drawCell(content, x + offset, dataY, colWidths[2], rowHeight, row[1].toString());
            offset += colWidths[2];
            drawCell(content, x + offset, dataY, colWidths[3], rowHeight, row[2].toString());
            offset += colWidths[3];
            drawCell(content, x + offset, dataY, colWidths[4], rowHeight, "RM " + row[3].toString());
            dataY -= rowHeight;
        }

        content.close();
        resp.setContentType("application/pdf");
        resp.setHeader("Content-Disposition", "attachment; filename=customer_summary.pdf");
        doc.save(resp.getOutputStream());
        doc.close();
    }

    private void drawCell(PDPageContentStream content, int x, int y, int width, int height, String text) throws IOException {
        content.addRect(x, y, width, height);
        content.stroke();
        content.beginText();
        content.setFont(PDType1Font.HELVETICA, 12);
        content.newLineAtOffset(x + 4, y + 5);
        content.showText(text.length() > 35 ? text.substring(0, 32) + "..." : text);
        content.endText();
    }
}
