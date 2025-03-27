package com.lavacorp.beautefly.webstore.account;

import com.lavacorp.beautefly.webstore.account.entity.Account;
import jakarta.annotation.Nullable;
import jakarta.data.repository.CrudRepository;
import jakarta.data.repository.Find;
import jakarta.data.repository.Repository;
import jakarta.transaction.Transactional;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;

import java.util.List;

@Transactional
@Repository
public interface AccountRepository extends CrudRepository<Account, Integer> {
    @Find
    List<Account> findByUsername(@NotBlank String username);

    @Find
    @Nullable
    Account findByEmail(@Email String email);
}
