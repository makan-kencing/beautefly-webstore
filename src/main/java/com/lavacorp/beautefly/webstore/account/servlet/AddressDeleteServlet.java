package com.lavacorp.beautefly.webstore.account.servlet;

import com.lavacorp.beautefly.webstore.account.AccountService;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.HttpConstraint;
import jakarta.servlet.annotation.ServletSecurity;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/address/delete")
@ServletSecurity(@HttpConstraint(rolesAllowed = {"*"}))
public class AddressDeleteServlet extends HttpServlet {
    @Inject
    private AccountService accountService;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id;
        try {
            id = Integer.parseInt(req.getParameter("id"));
        } catch (NullPointerException | NumberFormatException exc) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        accountService.deleteAddress(id);

        resp.sendRedirect("/addresses");
    }
}
