package com.lavacorp.beautefly.webstore.admin.product.servlet;

import com.lavacorp.beautefly.webstore.admin.product.AdminProductService;
import com.lavacorp.beautefly.webstore.admin.product.mapper.AdminProductMapper;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/admin/product/delete")
public class ProductDeleteServlet extends HttpServlet {
    @Inject
    private AdminProductService adminProductService;

    @Inject
    private AdminProductMapper adminProductMapper;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        var dto = adminProductMapper.toDeleteProductDTO(req);

        adminProductService.deleteProducts(dto);

        resp.sendRedirect("/admin/products?delete=1");
    }
}
