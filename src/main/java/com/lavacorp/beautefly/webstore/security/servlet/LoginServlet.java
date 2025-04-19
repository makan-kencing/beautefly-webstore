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

@WebServlet("/login")
@ServletSecurity(@HttpConstraint(rolesAllowed = {"USER", "STAFF" , "ADMIN"}))
public class LoginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        var session = req.getSession();
        var url = PageVisitTracker.getLastUrl(session);

        resp.sendRedirect(url != null ? url.toString() : "/");
    }
}
