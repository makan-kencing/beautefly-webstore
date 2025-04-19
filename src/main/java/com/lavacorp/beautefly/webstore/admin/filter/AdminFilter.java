package com.lavacorp.beautefly.webstore.admin.filter;

import com.lavacorp.beautefly.webstore.admin.AdminService;
import jakarta.inject.Inject;
import jakarta.servlet.*;
import jakarta.servlet.http.HttpServletRequest;

import java.io.IOException;

public class AdminFilter implements Filter {
    @Inject
    private AdminService adminService;

    @Override
    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws IOException, ServletException {
        var httpReq = (HttpServletRequest) req;

        var context = adminService.getAdminContext(httpReq);
        if (context != null)
            httpReq.setAttribute("admin", context);

        chain.doFilter(req, resp);
    }
}
