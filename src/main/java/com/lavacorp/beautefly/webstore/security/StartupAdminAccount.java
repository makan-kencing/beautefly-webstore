package com.lavacorp.beautefly.webstore.security;

import com.lavacorp.beautefly.util.env.ConfigurableEnvironment;
import com.lavacorp.beautefly.util.env.ExpressionEvaluator;
import com.lavacorp.beautefly.util.env.el.ELExpressionEvaluator;
import com.lavacorp.beautefly.webstore.account.entity.Account;
import com.lavacorp.beautefly.webstore.account.entity.Account_;
import com.lavacorp.beautefly.webstore.account.entity.Credential;
import jakarta.annotation.PostConstruct;
import jakarta.ejb.Singleton;
import jakarta.ejb.Startup;
import jakarta.inject.Inject;
import jakarta.inject.Named;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.security.enterprise.identitystore.PasswordHash;
import lombok.extern.log4j.Log4j2;
import org.hibernate.Session;

import java.util.Set;

@Log4j2
@Startup
@Singleton
@SuppressWarnings("unused")
public class StartupAdminAccount {
    @PersistenceContext
    private EntityManager em;

    @Inject
    @Named("Argon2idPasswordHash")
    private PasswordHash passwordHash;

    @PostConstruct
    public void initAdmin() {
        ExpressionEvaluator evaluator = new ELExpressionEvaluator();
        ConfigurableEnvironment environment = new ConfigurableEnvironment(evaluator);

        var username = environment.getProperty("Admin Username", "admin.username");
        var email = environment.getProperty("Admin Email", "admin.email");
        var password = environment.getProperty("Admin Password", "admin.password");

        var session = em.unwrap(Session.class);
        if (session.byNaturalId(Account.class)
                .using(Account_.email, email)
                .load() != null) {
            log.info("Admin account already exists, skipping creation.");
            return;
        }

        var account = new Account();
        account.setUsername(username);
        account.setEmail(email);

        var credential = account.getCredential();
        credential.setPassword(passwordHash.generate(password.toCharArray()));
        credential.setRoles(Set.of(Credential.Role.USER, Credential.Role.ADMIN));

        log.info("Created default admin account. Username: {}, Email: {}, Password: {}", username, email, password);
        session.persist(account);
        session.flush();
    }
}
