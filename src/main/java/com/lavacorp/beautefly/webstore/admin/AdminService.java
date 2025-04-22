package com.lavacorp.beautefly.webstore.admin;

import com.lavacorp.beautefly.webstore.account.AccountRepository;
import com.lavacorp.beautefly.webstore.admin.dto.DashboardStatsDTO;
import jakarta.data.page.PageRequest;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.transaction.Transactional;

import java.util.List;

@Transactional
@ApplicationScoped
public class AdminService {
    @Inject
    private AccountRepository accountRepository;

    public DashboardStatsDTO getDashboardStats() {
        var page = accountRepository.findByUsernameLike(
                "",
                PageRequest.ofPage(1, 1, true),
                List.of()
        );

        return new DashboardStatsDTO(
                (int) page.totalElements(),
                0,
                "OK"
        );
    }
}
