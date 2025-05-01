package com.lavacorp.beautefly.webstore.account.servlet;

import com.lavacorp.beautefly.webstore.account.AccountService;
import com.lavacorp.beautefly.webstore.account.mapper.AccountMapper;
import com.lavacorp.beautefly.webstore.security.filter.UserContextFilter;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.HttpConstraint;
import jakarta.servlet.annotation.ServletSecurity;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/account/change-password")
@ServletSecurity(@HttpConstraint(rolesAllowed = {"*"}))
public class UserAccountPasswordUpdateServlet extends HttpServlet {
    @Inject
    private AccountService accountService;

    @Inject
    private AccountMapper accountMapper;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        var view = req.getRequestDispatcher("/WEB-INF/views/account/change-password.jsp");
        view.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        var user = UserContextFilter.getUserContext(req);
        assert user != null;

        var updateDTO = accountMapper.toUpdateAccountPasswordDTO(req);

        if (accountService.updateUserAccountPassword(user, updateDTO))
            resp.sendRedirect("/account/change-password");
        else
            resp.sendRedirect("/account/change-password?error=incorrect-password");
    }
}
