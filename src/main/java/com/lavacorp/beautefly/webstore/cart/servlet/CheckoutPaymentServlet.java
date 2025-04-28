package com.lavacorp.beautefly.webstore.cart.servlet;

import com.lavacorp.beautefly.webstore.cart.CheckoutService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.HttpConstraint;
import jakarta.servlet.annotation.ServletSecurity;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.log4j.Log4j2;

import java.io.IOException;

@Log4j2
@WebServlet("/checkout/payment")
@ServletSecurity(@HttpConstraint(rolesAllowed = {"*"}))
public class CheckoutPaymentServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("publishableKey", CheckoutService.publishableKey);

        var view = req.getRequestDispatcher("/WEB-INF/views/payment.jsp");
        view.forward(req, resp);
    }
}
