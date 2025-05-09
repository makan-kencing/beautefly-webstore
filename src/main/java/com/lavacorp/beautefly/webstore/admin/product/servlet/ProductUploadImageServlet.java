package com.lavacorp.beautefly.webstore.admin.product.servlet;

import com.lavacorp.beautefly.webstore.admin.product.AdminProductService;
import com.lavacorp.beautefly.webstore.admin.product.mapper.AdminProductMapper;
import com.lavacorp.beautefly.webstore.security.filter.UserContextFilter;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@MultipartConfig
@WebServlet("/admin/product/image/upload")
public class ProductUploadImageServlet extends HttpServlet {
    @Inject
    private AdminProductService adminProductService;

    @Inject
    private AdminProductMapper adminProductMapper;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        var user = UserContextFilter.getUserContext(req);
        assert user != null;

        var dto = adminProductMapper.toUploadProductImageDTO(req);

        adminProductService.uploadProductImage(user, dto);

        resp.sendRedirect("/admin/product/" + dto.id());
    }
}
