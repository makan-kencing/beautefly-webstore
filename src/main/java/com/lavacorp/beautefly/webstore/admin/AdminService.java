package com.lavacorp.beautefly.webstore.admin;

import com.lavacorp.beautefly.webstore.admin.dto.DashboardStatsDTO;
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

    public DashboardStatsDTO getDashboardStats() {
        var search = new AccountSearchParametersDTO();
        search.setPage(1);
        search.setPageSize(1);

        var accounts = accountSearchService.search(search);

        return new DashboardStatsDTO(
                accounts.total(),
                0,
                "OK"
        );
    }
}
