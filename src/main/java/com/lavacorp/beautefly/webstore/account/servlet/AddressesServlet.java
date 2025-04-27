package com.lavacorp.beautefly.webstore.account.servlet;

import com.lavacorp.beautefly.webstore.account.AccountService;
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

@WebServlet("/addresses")
@ServletSecurity(@HttpConstraint(rolesAllowed = {"*"}))
public class AddressesServlet extends HttpServlet {
    @Inject
    private AccountService accountService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        var user = UserContextFilter.getUserContext(req);
        assert user != null;

        var addresses = accountService.getAccountAddressesDetails(user);

        req.setAttribute("addresses", addresses);

        var view = req.getRequestDispatcher("/WEB-INF/views/account/addresses.jsp");
        view.forward(req, resp);
    }
}
