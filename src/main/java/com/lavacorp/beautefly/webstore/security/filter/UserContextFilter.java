package com.lavacorp.beautefly.webstore.security.filter;

import com.lavacorp.beautefly.webstore.account.mapper.AccountMapper;
import com.lavacorp.beautefly.webstore.security.SecurityService;
import jakarta.inject.Inject;
import jakarta.servlet.*;
import jakarta.servlet.http.HttpServletRequest;

import java.io.IOException;

public class UserContextFilter implements Filter {
    @Inject
    private SecurityService securityService;

    @Inject
    private AccountMapper accountMapper;

    @Override
    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws IOException, ServletException {
        var httpReq = (HttpServletRequest) req;

        var user = securityService.getAccountContext(httpReq);
        if (user != null)
            httpReq.setAttribute("user", accountMapper.toAccountContextDTO(user));

        chain.doFilter(req, resp);
    }
}
