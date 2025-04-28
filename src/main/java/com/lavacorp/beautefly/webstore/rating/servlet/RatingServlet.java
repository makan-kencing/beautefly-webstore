package com.lavacorp.beautefly.webstore.rating.servlet;

import com.lavacorp.beautefly.webstore.rating.RatingService;
import com.lavacorp.beautefly.webstore.rating.mapper.RatingMapper;
import com.lavacorp.beautefly.webstore.search.ProductSearchService;
import com.lavacorp.beautefly.webstore.security.filter.UserContextFilter;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.HttpConstraint;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.ServletSecurity;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@MultipartConfig
@WebServlet("/review")
@ServletSecurity(@HttpConstraint(rolesAllowed = {"*"}))
public class RatingServlet extends HttpServlet {
    @Inject
    private RatingService ratingService;

    @Inject
    private ProductSearchService productService;

    @Inject
    private RatingMapper ratingMapper;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int productId;
        try {
            productId = Integer.parseInt(req.getParameter("productId"));
        } catch (NullPointerException | NumberFormatException exc) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        var product = productService.getProductDetailsById(productId);
        req.setAttribute("product", product);

        var view = req.getRequestDispatcher("/WEB-INF/views/review.jsp");
        view.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        var user = UserContextFilter.getUserContext(req);
        assert user != null;

        var newRating = ratingMapper.toRatingNewDTO(req);

        ratingService.rate(newRating, user);

        resp.sendRedirect("/product/" + newRating.productId());
    }
}
