package com.lavacorp.beautefly.webstore.admin;

import com.lavacorp.beautefly.webstore.account.mapper.AccountMapper;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.PersistenceUnit;
import jakarta.transaction.Transactional;

@Transactional
@ApplicationScoped
public class AdminAccountService {
    @PersistenceUnit
    private EntityManagerFactory emf;

    @Inject
    private AccountMapper accountMapper;
}
