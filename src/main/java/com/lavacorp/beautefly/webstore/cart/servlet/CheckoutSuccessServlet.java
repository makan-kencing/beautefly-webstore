package com.lavacorp.beautefly.webstore.cart.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.HttpConstraint;
import jakarta.servlet.annotation.ServletSecurity;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/checkout/success")
@ServletSecurity(@HttpConstraint(rolesAllowed = {"*"}))
public class CheckoutSuccessServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        var view = req.getRequestDispatcher("/WEB-INF/views/checkout-complete.jsp");
        view.forward(req, resp);
    }
}
