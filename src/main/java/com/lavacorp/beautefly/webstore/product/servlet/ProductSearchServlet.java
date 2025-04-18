package com.lavacorp.beautefly.webstore.product.servlet;

import com.lavacorp.beautefly.webstore.product.ProductSearchService;
import com.lavacorp.beautefly.webstore.product.mapper.ProductMapper;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/search")
public class ProductSearchServlet extends HttpServlet {
    @Inject
    private ProductSearchService searchService;

    @Inject
    private ProductMapper productMapper;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        var search = productMapper.fromReq(req);

        var result = searchService.search(search);

        req.setAttribute("result", result);

        var view = req.getRequestDispatcher("/WEB-INF/views/search.jsp");
        view.forward(req, resp);
    }
}
