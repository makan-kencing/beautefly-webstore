package com.lavacorp.beautefly.webstore.security;

import com.lavacorp.beautefly.webstore.account.AccountRepository;
import com.lavacorp.beautefly.webstore.account.entity.Account;
import com.lavacorp.beautefly.webstore.account.entity.GuestAccount;
import com.lavacorp.beautefly.webstore.account.entity.UserAccount;
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

    public Account getAccountContext(HttpServletRequest req) {
        var account = getUserAccountContext(req);

        if (account != null)
            return account;

        // treat as guest
        return getGuestContext(req);
    }

    public @Nullable UserAccount getUserAccountContext(Principal principal) {
        return accountRepository.findByEmail(principal.getName());
    }

    public @Nullable UserAccount getUserAccountContext(HttpServletRequest req) {
        var principal = req.getUserPrincipal();
        if (principal == null)  // no login context
            return null;

        var account = getUserAccountContext(principal);
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

    public @Nullable UserAccount getUserAccountContext(SecurityContext context) {
        var principal = context.getUserPrincipal();
        if (principal == null)  // no login context
            return null;

        return getUserAccountContext(principal);
    }

    public GuestAccount getGuestContext(HttpServletRequest req) {
        var session = req.getSession();

        var guest = accountRepository.findBySessionId(session.getId());
        if (guest != null)
            return guest;

        guest = new GuestAccount();
        guest.setSessionId(session.getId());
        return accountRepository.createGuest(guest);
    }
}
