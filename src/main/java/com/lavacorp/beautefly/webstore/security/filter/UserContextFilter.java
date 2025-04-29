package com.lavacorp.beautefly.webstore.security.filter;

import com.lavacorp.beautefly.webstore.account.entity.Account;
import com.lavacorp.beautefly.webstore.account.mapper.AccountMapper;
import com.lavacorp.beautefly.webstore.security.dto.AccountContextDTO;
import jakarta.annotation.Nullable;
import jakarta.inject.Inject;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.PersistenceUnit;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.hibernate.SessionFactory;

import java.io.IOException;
import java.security.Principal;

@WebFilter("/*")
public class UserContextFilter extends HttpFilter {
    public static final String ATTRIBUTE_NAME = "user";

    @PersistenceUnit
    private EntityManagerFactory emf;

    @Inject
    private AccountMapper accountMapper;

    @Override
    protected void doFilter(HttpServletRequest req, HttpServletResponse resp, FilterChain chain) throws IOException, ServletException {
        var session = req.getSession();
        var context = getUserContext(session);
        var principal = req.getUserPrincipal();

        if (principal != null) {
            if (context == null || !principal.getName().equals(context.email())) {
                context = getAccountContext(principal);

                if (context == null)
                    req.logout();
                else
                    session.setAttribute(ATTRIBUTE_NAME, context);
            }

        } else {
            if (context != null)
                session.removeAttribute(ATTRIBUTE_NAME);
        }

        chain.doFilter(req, resp);
    }

    public AccountContextDTO getAccountContext(Principal principal) {
        var session = emf.unwrap(SessionFactory.class)
                .openStatelessSession();

        return session.createSelectionQuery("""
                        from Account a
                            left join fetch a.profileImage
                            left join fetch a.cart
                            left join fetch a.wishlist
                            join fetch a.credential.roles
                        where a.email = :email
                        """, Account.class)
                .setParameter("email", principal.getName())
                .stream()
                .map(accountMapper::toAccountContextDTO)
                .findFirst()
                .orElseThrow();

    }

    public static @Nullable AccountContextDTO getUserContext(HttpSession session) {
        var value = session.getAttribute(ATTRIBUTE_NAME);
        if (value == null)
            return null;

        return (AccountContextDTO) value;
    }


    public static @Nullable AccountContextDTO getUserContext(HttpServletRequest req) {
        return getUserContext(req.getSession());
    }
}
