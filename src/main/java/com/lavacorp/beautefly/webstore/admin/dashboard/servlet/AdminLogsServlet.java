package com.lavacorp.beautefly.webstore.admin.dashboard.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/admin/logs")
public class AdminLogsServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        var view = req.getRequestDispatcher("/WEB-INF/views/admin/logs.jsp");
        view.forward(req, resp);
    }
}
