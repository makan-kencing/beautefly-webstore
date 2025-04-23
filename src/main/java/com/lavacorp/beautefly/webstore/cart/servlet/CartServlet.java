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
import lombok.extern.log4j.Log4j2;

import java.io.IOException;

@Log4j2
@WebServlet("/cart")
@Transactional
public class CartServlet extends HttpServlet {
    @Inject
    private CartService cartService;

    @Inject
    private CartMapper cartMapper;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        var user = UserContextFilter.getUserContext(req);

        var cart = cartService.getCartDetails(req.getSession(), user);

        req.setAttribute("cart", cart);

        var view = req.getRequestDispatcher("WEB-INF/views/cart.jsp");
        view.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        var user = UserContextFilter.getUserContext(req);
        var updateDTO = cartMapper.toUpdateCartProductDTO(req.getParameterMap(), UpdateCartProductDTO.Action.SET);

        cartService.updateCartProductQuantity(req.getSession(), user, updateDTO);

        resp.sendRedirect("/cart");
    }
}
