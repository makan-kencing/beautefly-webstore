package com.lavacorp.beautefly.webstore.admin.servlet;

import com.lavacorp.beautefly.webstore.admin.AdminAccountService;
import com.lavacorp.beautefly.webstore.admin.mapper.AdminAccountMapper;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/admin/account/delete")
public class AccountDeleteServlet extends HttpServlet {
    @Inject
    private AdminAccountService adminAccountService;

    @Inject
    private AdminAccountMapper adminAccountMapper;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        var dto = adminAccountMapper.toDeleteAccountDTO(req);

        adminAccountService.deleteAccounts(dto);

        resp.sendRedirect("/admin/accounts?delete=1");
    }
}
