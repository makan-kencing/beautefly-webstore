package com.lavacorp.beautefly.webstore.admin;

import com.lavacorp.beautefly.webstore.account.AccountRepository;
import com.lavacorp.beautefly.webstore.account.mapper.AccountMapper;
import com.lavacorp.beautefly.webstore.admin.dto.AdminContextDTO;
import com.lavacorp.beautefly.webstore.admin.dto.DashboardStatsDTO;
import com.lavacorp.beautefly.webstore.security.SecurityService;
import jakarta.annotation.Nullable;
import jakarta.data.page.PageRequest;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.transaction.Transactional;

import java.util.List;

@Transactional
@ApplicationScoped
public class AdminService {
    @Inject
    private AccountRepository accountRepository;

    @Inject
    private SecurityService securityService;

    @Inject
    private AccountMapper accountMapper;

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

    public @Nullable AdminContextDTO getAdminContext(HttpServletRequest req) {
        var account = securityService.getAccountContext(req);
        if (account == null)
            return null;

        return accountMapper.toAdminContextDTO(account);
    }
}
