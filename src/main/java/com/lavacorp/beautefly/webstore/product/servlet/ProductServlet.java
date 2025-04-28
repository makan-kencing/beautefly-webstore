package com.lavacorp.beautefly.webstore.product.servlet;

import com.lavacorp.beautefly.webstore.rating.RatingService;
import com.lavacorp.beautefly.webstore.search.ProductSearchService;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/product")
public class ProductServlet extends HttpServlet {
    @Inject
    private ProductSearchService productService;

    @Inject
    private RatingService ratingService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int productId;
        try {
            productId = Integer.parseInt(req.getParameter("id"));
        } catch (NullPointerException | NumberFormatException exc) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        var product = productService.getProductDetailsById(productId);
        if (product == null) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        var slug = req.getParameter("slug");
        if (!product.slug().equals(slug)) {
            resp.sendRedirect("/product/" + product.id() + "/" +product.slug());
            return;
        }

        req.setAttribute("product", product);

        var reviews = ratingService.getProductRatings(productId);
        req.setAttribute("reviews", reviews);

        var view = req.getRequestDispatcher("/WEB-INF/views/product.jsp");
        view.forward(req, resp);
    }
}
