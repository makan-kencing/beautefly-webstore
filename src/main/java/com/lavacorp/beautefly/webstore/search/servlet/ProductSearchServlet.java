package com.lavacorp.beautefly.webstore.search.servlet;

import com.lavacorp.beautefly.webstore.search.ProductSearchService;
import com.lavacorp.beautefly.webstore.search.mapper.SearchMapper;
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
    private ProductSearchService productSearchService;

    @Inject
    private SearchMapper searchMapper;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        var search = searchMapper.toProductSearchParameters(req.getParameterMap());

        var page = productSearchService.search(search);

        req.setAttribute("result", page);
        req.setAttribute("search", search);

        var view = req.getRequestDispatcher("/WEB-INF/views/search.jsp");
        view.forward(req, resp);
    }
}
