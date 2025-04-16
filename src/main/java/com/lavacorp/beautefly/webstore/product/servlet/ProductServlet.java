package com.lavacorp.beautefly.webstore.product.servlet;

import com.lavacorp.beautefly.webstore.product.ProductSearchService;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/product/*")
public class ProductServlet extends HttpServlet {
    @Inject
    private ProductSearchService productService;

    // https://stackoverflow.com/questions/8715474/servlet-and-path-parameters-like-xyz-value-test-how-to-map-in-web-xml
    public Integer resolveProductId(String path) {
        // /product
        if (path == null)
            return null;

        // /product/{productId}/{slug}
        String[] parts = path.split("/");

        if (parts.length < 2)
            return null;

        try {
            return Integer.parseInt(parts[1]);
        } catch (NumberFormatException e) {
            return null;
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        var productId = resolveProductId(req.getPathInfo());
        if (productId == null) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        var product = productService.getProductDetailsById(productId);
        if (product == null) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        req.setAttribute("product", product);

        var view = req.getRequestDispatcher("/WEB-INF/views/product.jsp");
        view.forward(req, resp);
    }
}
