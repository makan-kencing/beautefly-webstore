package com.lavacorp.beautefly.webstore.admin.dto;

public record DashboardStatsDTO(
        int totalUsers,
        double totalSales,
        String systemStatus
) {
}
