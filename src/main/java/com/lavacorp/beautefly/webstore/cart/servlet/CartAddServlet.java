package com.lavacorp.beautefly.webstore.cart.servlet;

import com.lavacorp.beautefly.webstore.cart.CartService;
import com.lavacorp.beautefly.webstore.cart.dto.UpdateCartProductDTO;
import com.lavacorp.beautefly.webstore.cart.mapper.CartMapper;
import com.lavacorp.beautefly.webstore.security.filter.UserContextFilter;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.transaction.Transactional;

import java.io.IOException;

@WebServlet("/cart/add")
@Transactional
public class CartAddServlet extends HttpServlet {
    @Inject
    private CartService cartService;

    @Inject
    private CartMapper cartMapper;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        var user = UserContextFilter.getUserContext(req);
        var updateDTO = cartMapper.toUpdateCartProductDTO(req.getParameterMap(), UpdateCartProductDTO.Action.INCREMENT);

        cartService.updateCartProductQuantity(req.getSession(), user, updateDTO);

        resp.sendRedirect("/cart");
    }
}
