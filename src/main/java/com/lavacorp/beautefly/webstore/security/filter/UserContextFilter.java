package com.lavacorp.beautefly.webstore.security.filter;

import com.lavacorp.beautefly.webstore.account.AccountRepository;
import com.lavacorp.beautefly.webstore.account.mapper.AccountMapper;
import com.lavacorp.beautefly.webstore.security.dto.AccountContextDTO;
import jakarta.annotation.Nullable;
import jakarta.inject.Inject;
import jakarta.servlet.*;
import jakarta.servlet.http.HttpServletRequest;

import java.io.IOException;

public class UserContextFilter implements Filter {
    public static final String ATTRIBUTE_NAME = "user";

    @Inject
    private AccountRepository accountRepository;

    @Inject
    private AccountMapper accountMapper;

    @Override
    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws IOException, ServletException {
        var principal = ((HttpServletRequest) req).getUserPrincipal();

        if (principal != null) {
            var account = accountRepository.findByEmail(principal.getName());

            if (account.isPresent())
                req.setAttribute(
                        ATTRIBUTE_NAME,
                        accountMapper.toAccountContextDTO(account.get())
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
