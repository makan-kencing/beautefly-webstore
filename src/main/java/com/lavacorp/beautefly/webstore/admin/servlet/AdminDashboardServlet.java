package com.lavacorp.beautefly.webstore.admin.servlet;

import com.lavacorp.beautefly.webstore.admin.AdminService;
import com.lavacorp.beautefly.webstore.admin.dto.DashboardStatsDTO;
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
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DashboardStatsDTO stats = adminService.getDashboardStats();
        request.setAttribute("stats", stats);
        request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);
    }
}
