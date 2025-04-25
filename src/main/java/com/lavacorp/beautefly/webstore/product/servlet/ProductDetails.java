package com.lavacorp.beautefly.webstore.product.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
@WebServlet("/admin/product/details")

public class ProductDetails extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String productId = req.getParameter("id"); // Include hidden input for ID
        String name = req.getParameter("name");
        String brand = req.getParameter("brand");
        String description = req.getParameter("description");
        String releaseDate = req.getParameter("releaseDate");
        int stock = Integer.parseInt(req.getParameter("stock"));
        double unitCost = Double.parseDouble(req.getParameter("unitCost"));
        double unitPrice = Double.parseDouble(req.getParameter("unitPrice"));
        String color = req.getParameter("color");
        String categoryId = req.getParameter("categoryId");

        // Set updated fields
//        product.setName(name);
//        product.setBrand(brand);
//        product.setDescription(description);
//        product.setReleaseDate(LocalDate.parse(releaseDate));
//        product.setStock(stock);
//        product.setUnitCost(unitCost);
//        product.setUnitPrice(unitPrice);
//        product.setColor(color);

        var view = req.getRequestDispatcher("/WEB-INF/views/admin/product-details.jsp");
        view.forward(req, resp);
    }
}
