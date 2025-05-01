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

@WebServlet("/account/update")
@ServletSecurity(@HttpConstraint(rolesAllowed = {"*"}))
public class UserAccountUpdateServlet extends HttpServlet {
    @Inject
    private AccountMapper accountMapper;

    @Inject
    private AccountService accountService;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        var user = UserContextFilter.getUserContext(req);
        assert user != null;

        var updateDTO = accountMapper.toUpdateUserAccountDetailsDTO(req);

        accountService.updateUserAccountDetails(user, updateDTO);

        resp.sendRedirect("/account");
    }
}
