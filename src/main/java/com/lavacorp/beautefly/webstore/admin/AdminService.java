package com.lavacorp.beautefly.webstore.admin;

import jakarta.enterprise.context.ApplicationScoped;

@ApplicationScoped
public class AdminService {
    private AdminDAO adminDAO;

    public AdminService() {
        adminDAO = new AdminDAO();
    }

    public DashboardStats getDashboardStats() {
        DashboardStats stats = new DashboardStats();
        return stats;
    }
}
