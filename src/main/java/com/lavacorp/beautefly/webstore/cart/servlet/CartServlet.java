package com.lavacorp.beautefly.webstore.cart.servlet;

import com.lavacorp.beautefly.webstore.cart.CartService;
import com.lavacorp.beautefly.webstore.cart.mapper.CartMapper;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.transaction.Transactional;

import java.io.IOException;

@WebServlet("/cart")
@Transactional
public class CartServlet extends HttpServlet {
    @Inject
    private CartService cartService;

    @Inject
    private CartMapper cartMapper;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        var cart = cartService.getCartDetails(req);

        req.setAttribute("cart", cart);

        var view = req.getRequestDispatcher("WEB-INF/views/cart.jsp");
        view.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        var item = cartMapper.toSetCartProductDTO(req);

        cartService.setCartProductQuantity(req, item);

        resp.sendRedirect("/cart");
    }
}
