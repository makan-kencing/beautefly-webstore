package com.lavacorp.beautefly.webstore.admin.product.servlet;

import com.lavacorp.beautefly.webstore.admin.product.AdminProductService;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/admin/products")
public class ProductListServlet extends HttpServlet {
    @Inject
    private AdminProductService adminProductService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        var context = adminProductService.getCreateProductContext();

        req.setAttribute("context", context);

        var view = req.getRequestDispatcher("/WEB-INF/views/admin/products.jsp");
        view.forward(req, resp);
    }
}