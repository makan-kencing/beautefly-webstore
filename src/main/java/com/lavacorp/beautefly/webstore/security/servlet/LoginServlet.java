package com.lavacorp.beautefly.webstore.security.servlet;

import com.lavacorp.beautefly.webstore.security.filter.PageVisitTracker;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.HttpConstraint;
import jakarta.servlet.annotation.ServletSecurity;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.net.URI;

@WebServlet("/login")
@ServletSecurity(@HttpConstraint(rolesAllowed = {"*"}))
public class LoginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        var session = req.getSession();
        var url = PageVisitTracker.getFirst(session)
                .orElse(URI.create("/"));

        resp.sendRedirect(url.toString());
    }
}
