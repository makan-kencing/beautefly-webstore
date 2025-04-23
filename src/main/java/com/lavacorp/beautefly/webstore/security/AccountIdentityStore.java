package com.lavacorp.beautefly.webstore.security;

import com.lavacorp.beautefly.webstore.account.entity.Account;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.inject.Named;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.PersistenceUnit;
import jakarta.security.enterprise.credential.UsernamePasswordCredential;
import jakarta.security.enterprise.identitystore.CredentialValidationResult;
import jakarta.security.enterprise.identitystore.IdentityStore;
import jakarta.security.enterprise.identitystore.PasswordHash;
import jakarta.transaction.Transactional;
import org.hibernate.SessionFactory;

import java.util.Set;

import static jakarta.security.enterprise.identitystore.CredentialValidationResult.INVALID_RESULT;

@ApplicationScoped
public class AccountIdentityStore implements IdentityStore {
    @PersistenceUnit
    private EntityManagerFactory emf;

    @Inject
    @Named("Argon2idPasswordHash")
    private PasswordHash passwordHash;

    @SuppressWarnings("unused")
    @Transactional
    public CredentialValidationResult validate(UsernamePasswordCredential credential) {
        var session = emf.unwrap(SessionFactory.class)
                .openStatelessSession();

        var account = session.createSelectionQuery("from Account where email = :email", Account.class)
                .setParameter("email", credential.getCaller())
                .getSingleResultOrNull();

        if (account == null)
            return INVALID_RESULT;

        if (passwordHash.verify(
                credential.getPasswordAsString().toCharArray(),
                account.getCredential().getPassword()
        ))
            return new CredentialValidationResult(
                    credential.getCaller(),
                    account.getCredential().getRolesAsString()
            );

        return INVALID_RESULT;
    }

    @Override
    @Transactional
    public Set<String> getCallerGroups(CredentialValidationResult validationResult) {
        var session = emf.unwrap(SessionFactory.class)
                .openStatelessSession();

        var account = session.createSelectionQuery("from Account where email = :email", Account.class)
                .setParameter("email", validationResult.getCallerPrincipal().getName())
                .getSingleResultOrNull();

        if (account == null)
            return null;
        return account.getCredential().getRolesAsString();
    }
}
