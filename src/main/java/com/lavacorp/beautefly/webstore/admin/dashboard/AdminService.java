package com.lavacorp.beautefly.webstore.admin.dashboard;

import com.lavacorp.beautefly.webstore.admin.dashboard.dto.DashboardStatsDTO;
import com.lavacorp.beautefly.webstore.order.entity.OrderRepository;
import com.lavacorp.beautefly.webstore.search.AccountSearchService;
import com.lavacorp.beautefly.webstore.search.dto.AccountSearchParametersDTO;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.transaction.Transactional;

@Transactional
@ApplicationScoped
public class AdminService {
    @Inject
    private AccountSearchService accountSearchService;

    @Inject
    private OrderRepository orderRepository;

    public DashboardStatsDTO getDashboardStats() {
        var search = new AccountSearchParametersDTO(
                null, null, null, null, null, 1, 1, null
        );
        var accounts = accountSearchService.search(search);

        var totalSales = orderRepository.sumTotalSales();
        var todaySales = orderRepository.sumTodaySales();
        var monthSales = orderRepository.sumMonthlySales();

        return new DashboardStatsDTO(
                (int) accounts.filteredTotal(),
                totalSales,
                todaySales,
                monthSales,
                "OK"
        );
    }

}
