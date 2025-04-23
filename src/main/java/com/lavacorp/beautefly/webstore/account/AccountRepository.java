package com.lavacorp.beautefly.webstore.account;

import com.lavacorp.beautefly.webstore.account.entity.Account;
import jakarta.annotation.Nullable;
import jakarta.data.page.Page;
import jakarta.data.page.PageRequest;
import jakarta.data.repository.Find;
import jakarta.data.repository.Repository;
import jakarta.transaction.Transactional;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import org.hibernate.annotations.processing.Pattern;
import org.hibernate.query.Order;

import java.util.List;
import java.util.Optional;

@Repository
@Transactional
public interface AccountRepository {
    @Find
    Optional<Account> find(int id);

    @Find
    List<Account> findByUsernameLike(@NotBlank @Pattern String username);

    @Find
    Optional<Account> findByEmail(@Email String email);
}
