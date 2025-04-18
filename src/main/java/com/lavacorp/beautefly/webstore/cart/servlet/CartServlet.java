package com.lavacorp.beautefly.webstore.cart.servlet;

import com.lavacorp.beautefly.webstore.cart.CartService;
import com.lavacorp.beautefly.webstore.security.SecurityService;
import com.lavacorp.beautefly.util.response.ResponseStatus;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.transaction.Transactional;
import jakarta.validation.ValidationException;

import java.io.IOException;
import java.util.NoSuchElementException;

@WebServlet("/cart")
@Transactional
public class CartServlet extends HttpServlet {
    @Inject
    private SecurityService securityService;

    @Inject
    private CartService cartService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        var account = securityService.getAccountContext(req);

        req.setAttribute("cart", cartService.toCartDto(account.getCart()));

        var view = req.getRequestDispatcher("WEB-INF/views/cart.jsp");
        view.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        var account = securityService.getAccountContext(req);

        try {
            var cartProduct = cartService.getCartProductFromParameter(req);
            account.getCart().setProduct(cartProduct);
        } catch (ValidationException exc) {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        } catch (NoSuchElementException exc) {
            resp.setStatus(ResponseStatus.UNPROCESSABLE_ENTITY.getStatusCode());
        }
    }
}
