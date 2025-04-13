package com.lavacorp.beautefly.webstore.admin;

import com.lavacorp.beautefly.webstore.admin.model.DashboardStats;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.HttpConstraint;
import jakarta.servlet.annotation.ServletSecurity;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/admin/dashboard")
public class AdminDashboard extends HttpServlet {

    @Inject
    private AdminService adminService;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DashboardStats stats = adminService.getDashboardStats();
        request.setAttribute("stats", stats);
        request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);
    }
}
