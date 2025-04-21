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

@WebServlet("/cart/remove")
@Transactional
public class CartRemoveServlet extends HttpServlet {
    @Inject
    private CartService cartService;

    @Inject
    private CartMapper cartMapper;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        var item = cartMapper.toSetCartProductDTO(req);

        cartService.removeCartProductQuantity(req, item);

        resp.sendRedirect("/cart");
    }
}
