package com.lavacorp.beautefly.webstore.account;

import com.lavacorp.beautefly.webstore.account.entity.Account;
import jakarta.annotation.Nullable;
import jakarta.data.repository.*;
import jakarta.transaction.Transactional;
import jakarta.validation.Valid;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;

import java.util.List;

@Transactional
@Repository
public interface AccountRepository {
    @Find
    List<Account> findAll();

    @Find
    List<Account> findByUsername(@NotBlank String username);

    @Find
    @Nullable
    Account findByEmail(@Email String email);

    @Insert
    void insert(@Valid Account account);

    @Save
    void save(@Valid Account account);

    @Delete
    void delete(@Valid Account account);
}
