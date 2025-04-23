package com.lavacorp.beautefly.webstore.security;

import com.lavacorp.beautefly.webstore.account.entity.Account;
import com.lavacorp.beautefly.webstore.security.dto.AccountRegisterDTO;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.inject.Named;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.security.enterprise.identitystore.PasswordHash;
import jakarta.transaction.Transactional;
import lombok.extern.log4j.Log4j2;
import org.hibernate.exception.ConstraintViolationException;

@Log4j2
@Transactional
@ApplicationScoped
public class SecurityService {
    @PersistenceContext
    private EntityManager em;

    @Inject
    @Named("Argon2idPasswordHash")
    private PasswordHash passwordHash;

    public void register(AccountRegisterDTO registration) throws ConstraintViolationException {
        var account = new Account();

        account.setUsername(registration.username());
        account.setEmail(registration.email());

        var credential = account.getCredential();
        credential.setPassword(passwordHash.generate(registration.password().toCharArray()));

        em.persist(account);
    }
}
