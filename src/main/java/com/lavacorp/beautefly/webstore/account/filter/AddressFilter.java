package com.lavacorp.beautefly.webstore.account.filter;

import com.lavacorp.beautefly.webstore.account.AccountService;
import com.lavacorp.beautefly.webstore.security.filter.UserContextFilter;
import jakarta.inject.Inject;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.HttpConstraint;
import jakarta.servlet.annotation.ServletSecurity;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebFilter("/address")
@ServletSecurity(@HttpConstraint(rolesAllowed = {"*"}))
public class AddressFilter extends HttpFilter {
    @Inject
    private AccountService accountService;

    @Override
    protected void doFilter(HttpServletRequest req, HttpServletResponse resp, FilterChain chain) throws IOException, ServletException {
        var idParam = req.getParameter("id");
        if (idParam != null) {
            var user = UserContextFilter.getUserContext(req);
            assert user != null;

            int id;
            try {
                id = Integer.parseInt(idParam);
            } catch (NumberFormatException exc) {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND);
                return;
            }

            if (!accountService.checkAddressOwnership(user.id(), id)) {
                resp.sendError(HttpServletResponse.SC_FORBIDDEN);
                return;
            }
        }

        chain.doFilter(req, resp);
    }
}
