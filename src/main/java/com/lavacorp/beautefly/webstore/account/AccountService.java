package com.lavacorp.beautefly.webstore.account;

import com.lavacorp.beautefly.webstore.account.dto.UserAccountDetailsDTO;
import com.lavacorp.beautefly.webstore.account.mapper.AccountMapper;
import com.lavacorp.beautefly.webstore.security.SecurityService;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.transaction.Transactional;

@Transactional
@ApplicationScoped
public class AccountService {
    @Inject
    private SecurityService securityService;

    @Inject
    private AccountMapper accountMapper;

    public UserAccountDetailsDTO getUserAccountDetails(HttpServletRequest req) {
        var account = securityService.getAccountContext(req);
        if (account == null)
            return null;

        return accountMapper.toUserAccountDetailsDTO(account);
    }
}
