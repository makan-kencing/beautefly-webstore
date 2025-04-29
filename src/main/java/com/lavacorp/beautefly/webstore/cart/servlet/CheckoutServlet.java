package com.lavacorp.beautefly.webstore.cart.servlet;

import com.lavacorp.beautefly.webstore.account.AccountService;
import com.lavacorp.beautefly.webstore.cart.CartService;
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

@WebServlet("/checkout")
@ServletSecurity(@HttpConstraint(rolesAllowed = {"*"}))
public class CheckoutServlet extends HttpServlet {
    @Inject
    private CartService cartService;

    @Inject
    private AccountService accountService;

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        var user = UserContextFilter.getUserContext(req);
        assert user != null;

        var cart = cartService.getCartDetails(req.getSession(), user);
        var addresses = accountService.getAccountAddressesDetails(user);

        req.setAttribute("cart", cart);
        req.setAttribute("addresses", addresses);

        var view = req.getRequestDispatcher("/WEB-INF/views/checkout.jsp");
        view.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int addressId;
        try {
            addressId = Integer.parseInt(req.getParameter("selectedAddressId"));
        } catch (NullPointerException | NumberFormatException exc) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        var user = UserContextFilter.getUserContext(req);
        assert user != null;

        cartService.updateSelectedAddress(req.getSession(), user, addressId);

        resp.sendRedirect("/checkout/payment");
    }
}
