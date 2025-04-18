package com.lavacorp.beautefly.webstore.admin.servlet;

import com.lavacorp.beautefly.webstore.account.AccountRepository;
import com.lavacorp.beautefly.webstore.account.mapper.AccountMapper;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/admin/account")
public class AdminUserServlet extends HttpServlet {
    @Inject
    private AccountRepository accountRepository;

    @Inject
    private AccountMapper accountMapper;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id;
        try {
            id = Integer.parseInt(req.getParameter("id"));
        } catch (NullPointerException | NumberFormatException exc) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        var account = accountRepository.findUserAccount(id);
        if (account == null) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND, "User not found");
            return;
        }

        req.setAttribute("account", accountMapper.toUserAccountDTO(account));

        var view = req.getRequestDispatcher("/WEB-INF/views/admin/user-details.jsp");
        view.forward(req, resp);
    }
}
