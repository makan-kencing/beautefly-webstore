package com.lavacorp.beautefly.webstore.security;

import com.lavacorp.beautefly.webstore.account.entity.Account;
import com.lavacorp.beautefly.webstore.security.dto.AccountRegisterDTO;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.inject.Named;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.PersistenceUnit;
import jakarta.security.enterprise.identitystore.PasswordHash;
import jakarta.transaction.Transactional;
import lombok.extern.log4j.Log4j2;
import org.hibernate.SessionFactory;
import org.hibernate.exception.ConstraintViolationException;

@Log4j2
@Transactional
@ApplicationScoped
public class SecurityService {
    @PersistenceUnit
    private EntityManagerFactory emf;

    @Inject
    @Named("Argon2idPasswordHash")
    private PasswordHash passwordHash;

    public void register(AccountRegisterDTO registration) throws ConstraintViolationException {
        var session = emf.unwrap(SessionFactory.class)
                .openStatelessSession();

        var account = new Account();

        account.setUsername(registration.username());
        account.setEmail(registration.email());

        var credential = account.getCredential();
        credential.setPassword(passwordHash.generate(registration.password().toCharArray()));

        session.insert(credential);
        session.insert(account);
    }
}
