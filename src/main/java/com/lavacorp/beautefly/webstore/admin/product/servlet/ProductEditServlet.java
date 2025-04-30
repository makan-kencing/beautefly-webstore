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

@WebServlet("/admin/product/edit")
public class ProductEditServlet extends HttpServlet {
    @Inject
    private AdminProductService adminProductService;

    @Inject
    private AdminProductMapper adminProductMapper;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        var dto = adminProductMapper.toEditProductDTO(req);

        adminProductService.editProduct(dto);

        resp.sendRedirect("/admin/product/" + dto.id());
    }
}
