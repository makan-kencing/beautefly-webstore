package com.lavacorp.beautefly.webstore.account;

import com.lavacorp.beautefly.webstore.account.dto.UserAccountDetailsDTO;
import com.lavacorp.beautefly.webstore.account.mapper.AccountMapper;
import com.lavacorp.beautefly.webstore.security.dto.AccountContextDTO;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.transaction.Transactional;

@Transactional
@ApplicationScoped
public class AccountService {
    @Inject
    private AccountRepository accountRepository;

    @Inject
    private AccountMapper accountMapper;

    public UserAccountDetailsDTO getUserAccountDetails(AccountContextDTO user) {
        var account = accountRepository.find(user.id());

        return account.map(accountMapper::toUserAccountDetailsDTO).orElse(null);
    }
}
