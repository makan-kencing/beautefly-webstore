package com.lavacorp.beautefly.webstore.account;

import com.lavacorp.beautefly.webstore.account.entity.Account;
import jakarta.data.page.Page;
import jakarta.data.page.PageRequest;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import org.hibernate.query.Order;

import java.util.List;

public interface AccountRepository {
    Account register(Account account);

    List<Account> findByUsername(@NotBlank String username);

    Account findByEmail(@Email String email);

    Page<Account> findByUsernameLike(@NotBlank String username, PageRequest page, List<Order<? super Account>> orderBy);

    void update(Account account);

    void delete(Account account);
}
