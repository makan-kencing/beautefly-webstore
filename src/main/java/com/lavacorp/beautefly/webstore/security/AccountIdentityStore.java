package com.lavacorp.beautefly.webstore.security;

import com.lavacorp.beautefly.webstore.account.AccountRepository;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.inject.Named;
import jakarta.security.enterprise.credential.UsernamePasswordCredential;
import jakarta.security.enterprise.identitystore.CredentialValidationResult;
import jakarta.security.enterprise.identitystore.IdentityStore;
import jakarta.security.enterprise.identitystore.PasswordHash;
import jakarta.transaction.Transactional;
import org.hibernate.Hibernate;

import java.util.Set;
import java.util.stream.Collectors;

import static jakarta.security.enterprise.identitystore.CredentialValidationResult.INVALID_RESULT;

@ApplicationScoped
public class AccountIdentityStore implements IdentityStore {
    @Inject
    private AccountRepository accountRepository;

    @Inject
    private PasswordHash passwordHash;

    public CredentialValidationResult validate(UsernamePasswordCredential credential) {
        // TODO: redo logic to prevent timing attacks
        var account = accountRepository.findByEmail(credential.getCaller());

        if (account == null)
            return INVALID_RESULT;

        if (passwordHash.verify(
                credential.getPasswordAsString().toCharArray(),
                account.getPassword()
        ))
            return new CredentialValidationResult(
                    credential.getCaller(),
                    account.getRoles()
                            .stream()
                            .map(Enum::name)
                            .collect(Collectors.toSet())
            );

        return INVALID_RESULT;
    }

    @Override
    public Set<String> getCallerGroups(CredentialValidationResult validationResult) {
        var account = accountRepository.findByEmail(validationResult.getCallerPrincipal().getName());

        if (account == null)
            return null;

        return account.getRoles()
                .stream()
                .map(Enum::name)
                .collect(Collectors.toSet());
    }
}
