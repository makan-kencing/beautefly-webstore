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
import org.apache.pdfbox.pdmodel.graphics.image.PDImageXObject;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.time.Month;
import java.util.Base64;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;

@WebServlet("/admin/reports/tax/pdf")
public class TaxCollectedPdfServlet extends HttpServlet {

    @PersistenceContext
    private EntityManager em;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        String chartImage = req.getParameter("chartImage");

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
            String monthName = Month.of(monthNumber).name().substring(0, 1) +
                    Month.of(monthNumber).name().substring(1).toLowerCase().substring(0, 2);
            taxPerMonth.put(monthName, total);
        }

        PDDocument doc = new PDDocument();
        PDPage page = new PDPage();
        doc.addPage(page);
        PDPageContentStream content = new PDPageContentStream(doc, page);

        int x = 50, y = 750, rowHeight = 20;
        int[] colWidths = {200, 200};

        content.setFont(PDType1Font.HELVETICA_BOLD, 16);
        content.beginText();
        content.newLineAtOffset(x, y);
        content.showText("Tax Collected Report (Current Year)");
        content.endText();

        // Insert chart image if available
        if (chartImage != null && chartImage.startsWith("data:image/png;base64,")) {
            String base64 = chartImage.substring("data:image/png;base64,".length());
            byte[] imageBytes = Base64.getDecoder().decode(base64);
            BufferedImage bufferedImage = ImageIO.read(new ByteArrayInputStream(imageBytes));
            PDImageXObject pdImage = PDImageXObject.createFromByteArray(doc, imageBytes, "chart.png");
            content.drawImage(pdImage, x, y - 280, 500, 200);
        }

        // Header
        int tableY = y - 320;
        content.setFont(PDType1Font.HELVETICA_BOLD, 12);
        drawCell(content, x, tableY, colWidths[0], rowHeight, "Month");
        drawCell(content, x + colWidths[0], tableY, colWidths[1], rowHeight, "Total Tax (RM)");

        // Data
        int dataY = tableY - rowHeight;
        content.setFont(PDType1Font.HELVETICA, 12);
        for (Map.Entry<String, Double> entry : taxPerMonth.entrySet()) {
            drawCell(content, x, dataY, colWidths[0], rowHeight, entry.getKey());
            drawCell(content, x + colWidths[0], dataY, colWidths[1], rowHeight, "RM " + String.format("%.2f", entry.getValue()));
            dataY -= rowHeight;
        }

        content.close();
        resp.setContentType("application/pdf");
        resp.setHeader("Content-Disposition", "attachment; filename=tax_report.pdf");
        doc.save(resp.getOutputStream());
        doc.close();
    }

    private void drawCell(PDPageContentStream content, int x, int y, int width, int height, String text) throws IOException {
        content.addRect(x, y, width, height);
        content.stroke();
        content.beginText();
        content.setFont(PDType1Font.HELVETICA, 12);
        content.newLineAtOffset(x + 5, y + 5);
        content.showText(text.length() > 30 ? text.substring(0, 27) + "..." : text);
        content.endText();
    }
}