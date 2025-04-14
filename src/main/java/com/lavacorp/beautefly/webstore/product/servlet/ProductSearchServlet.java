package com.lavacorp.beautefly.webstore.product.servlet;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.lavacorp.beautefly.webstore.product.ProductSearchService;
import com.lavacorp.beautefly.webstore.product.dto.ProductSearchDTO;
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

    private final ObjectMapper mapper = new ObjectMapper();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        var params = req.getParameterMap();
        var search = mapper.convertValue(params, ProductSearchDTO.class);

        var result = searchService.search(search);

        req.setAttribute("result", result);

        var view = req.getRequestDispatcher("WEB-INF/views/search.jsp");
        view.forward(req, resp);
    }
}
