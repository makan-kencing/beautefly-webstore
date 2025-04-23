package com.lavacorp.beautefly.webstore.security.filter;

import com.lavacorp.beautefly.webstore.account.entity.Account;
import com.lavacorp.beautefly.webstore.account.mapper.AccountMapper;
import com.lavacorp.beautefly.webstore.security.dto.AccountContextDTO;
import jakarta.annotation.Nullable;
import jakarta.inject.Inject;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.PersistenceUnit;
import jakarta.servlet.*;
import jakarta.servlet.http.HttpServletRequest;
import org.hibernate.SessionFactory;

import java.io.IOException;

public class UserContextFilter implements Filter {
    public static final String ATTRIBUTE_NAME = "user";

    @PersistenceUnit
    private EntityManagerFactory emf;

    @Inject
    private AccountMapper accountMapper;

    @Override
    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws IOException, ServletException {
        var session = emf.unwrap(SessionFactory.class)
                .openStatelessSession();

        var principal = ((HttpServletRequest) req).getUserPrincipal();

        if (principal != null) {
            var account = session.createSelectionQuery("""
                            from Account a
                                left join fetch a.profileImage
                                left join fetch a.cart
                                left join fetch a.wishlist
                                join fetch a.credential.roles
                            where a.email = :email
                            """, Account.class)
                    .setParameter("email", principal.getName())
                    .getSingleResultOrNull();

            if (account != null)
                req.setAttribute(
                        ATTRIBUTE_NAME,
                        accountMapper.toAccountContextDTO(account)
                );
            else
                ((HttpServletRequest) req).logout();
        }

        chain.doFilter(req, resp);
    }

    public static @Nullable AccountContextDTO getUserContext(ServletRequest req) {
        var value = req.getAttribute(ATTRIBUTE_NAME);
        if (value == null)
            return null;

        return (AccountContextDTO) value;
    }
}
