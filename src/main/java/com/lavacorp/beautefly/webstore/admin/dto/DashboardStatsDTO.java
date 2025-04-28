package com.lavacorp.beautefly.webstore.admin.dto;

import java.io.Serializable;
import java.math.BigDecimal;

public class DashboardStatsDTO implements Serializable {
    private int totalUsers;
    private BigDecimal totalSales;
    private BigDecimal todaySales;
    private BigDecimal monthSales;
    private String systemStatus;

    public DashboardStatsDTO(int totalUsers, BigDecimal totalSales, BigDecimal todaySales, BigDecimal monthSales, String systemStatus) {
        this.totalUsers = totalUsers;
        this.totalSales = totalSales;
        this.todaySales = todaySales;
        this.monthSales = monthSales;
        this.systemStatus = systemStatus;
    }

    public int getTotalUsers() {
        return totalUsers;
    }

    public BigDecimal getTotalSales() {
        return totalSales;
    }

    public BigDecimal getTodaySales() {
        return todaySales;
    }

    public BigDecimal getMonthSales() {
        return monthSales;
    }

    public String getSystemStatus() {
        return systemStatus;
    }
}
