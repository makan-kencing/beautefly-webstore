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
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
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

        PDDocument document = new PDDocument();
        PDPage page = new PDPage();
        document.addPage(page);

        PDPageContentStream contentStream = new PDPageContentStream(document, page);
        contentStream.setFont(PDType1Font.HELVETICA_BOLD, 14);
        contentStream.beginText();
        contentStream.newLineAtOffset(50, 750);
        contentStream.showText("Top 10 Best-Selling Products Report");
        contentStream.endText();

        contentStream.setFont(PDType1Font.HELVETICA, 12);
        int y = 720;
        for (int i = 0; i < topProducts.size(); i++) {
            Object[] row = topProducts.get(i);
            String line = (i + 1) + ". " + row[0] + " - RM " + row[1];
            contentStream.beginText();
            contentStream.newLineAtOffset(50, y);
            contentStream.showText(line);
            contentStream.endText();
            y -= 20;
        }

        contentStream.close();

        resp.setContentType("application/pdf");
        resp.setHeader("Content-Disposition", "attachment; filename=\"sales_report.pdf\"");
        document.save(resp.getOutputStream());
        document.close();
    }
}