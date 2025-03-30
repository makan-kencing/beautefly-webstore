package com.lavacorp.beautefly.webstore.account;

import com.lavacorp.beautefly.webstore.account.entity.Account;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;

import java.util.List;

public interface AccountRepository {
    Account register(Account account);

    List<Account> findByUsername(@NotBlank String username);

    Account findByEmail(@Email String email);

    void update(Account account);

    void delete(Account account);;
}
