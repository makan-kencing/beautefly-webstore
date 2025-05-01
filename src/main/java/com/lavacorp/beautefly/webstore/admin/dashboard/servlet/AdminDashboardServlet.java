package com.lavacorp.beautefly.webstore.admin.dashboard.servlet;

import com.lavacorp.beautefly.webstore.admin.dashboard.AdminService;
import com.lavacorp.beautefly.webstore.admin.dashboard.dto.DashboardStatsDTO;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/admin")
public class AdminDashboardServlet extends HttpServlet {

    @Inject
    private AdminService adminService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        DashboardStatsDTO stats = adminService.getDashboardStats();
        req.setAttribute("stats", stats);

        var view = req.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp");
        view.forward(req, resp);
    }
}
