package com.lavacorp.beautefly.webstore.security;

import com.lavacorp.beautefly.webstore.account.AccountRepository;
import com.lavacorp.beautefly.webstore.account.entity.Account;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.transaction.Transactional;
import jakarta.ws.rs.core.SecurityContext;
import lombok.extern.log4j.Log4j2;
import org.jetbrains.annotations.Nullable;

import java.security.Principal;

@Log4j2
@Transactional
@ApplicationScoped
public class SecurityService {
    @Inject
    private AccountRepository accountRepository;

    public @Nullable Account getAccountContext(Principal principal) {
        return accountRepository.findByEmail(principal.getName());
    }

    public @Nullable Account getAccountContext(HttpServletRequest req) {
        var principal = req.getUserPrincipal();
        if (principal == null)  // no login context
            return null;

        var account = getAccountContext(principal);
        if (account != null)
            return account;

        // principal probably wrong, invalidate context
        try {
            req.logout();
        } catch (ServletException exc) {
            log.error(exc);
        }
        return null;
    }

    public @Nullable Account getAccountContext(SecurityContext context) {
        var principal = context.getUserPrincipal();
        if (principal == null)  // no login context
            return null;

        return getAccountContext(principal);
    }
}
