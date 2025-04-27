package com.lavacorp.beautefly.webstore.admin.servlet;

import com.lavacorp.beautefly.webstore.account.AccountService;
import com.lavacorp.beautefly.webstore.account.entity.Account;
import com.lavacorp.beautefly.webstore.account.entity.Credential;
import com.lavacorp.beautefly.webstore.account.entity.Account.Gender;
import com.lavacorp.beautefly.webstore.account.entity.Credential.Role;
import com.lavacorp.beautefly.webstore.admin.AdminAccountService;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDate;
import java.util.*;
import java.util.stream.Collectors;

@WebServlet("/admin/account/add")
public class AdminAddUserServlet extends HttpServlet {

    @Inject
    private AdminAccountService adminAccountService;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String username = req.getParameter("username");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String confirmPassword = req.getParameter("confirm-password");
        String[] rolesParam = req.getParameterValues("roles");
        String genderParam = req.getParameter("gender");
        String dobParam = req.getParameter("dob");
        boolean active = req.getParameter("active") != null;

        List<String> errors = new ArrayList<>();

        if (password == null || confirmPassword == null || !password.equals(confirmPassword)) {
            errors.add("Password and Confirm Password must match.");
        }

        if (password != null) {
            if (!password.matches(".*[a-z].*")) {
                errors.add("Password must contain at least one lowercase letter.");
            }
            if (!password.matches(".*[A-Z].*")) {
                errors.add("Password must contain at least one uppercase letter.");
            }
            if (password.length() < 8) {
                errors.add("Password must be at least 8 characters long.");
            }
        }

        if (username == null || username.isBlank()) errors.add("Username is required.");
        if (email == null || email.isBlank()) errors.add("Email is required.");
        if (rolesParam == null || rolesParam.length == 0) errors.add("At least one role must be selected.");

        if (!errors.isEmpty()) {
            req.setAttribute("errors", errors);
            req.getRequestDispatcher("/WEB-INF/views/admin/users.jsp").forward(req, resp);
            return;
        }

        Credential credential = new Credential();
        credential.setPassword(password);

        Set<Role> roles = Arrays.stream(rolesParam)
                .map(Role::valueOf)
                .collect(Collectors.toSet());
        credential.setRoles(roles);

        Account user = new Account();
        user.setId(0);
        user.setUsername(username);
        user.setEmail(email);
        user.setCredential(credential);

        try {
            user.setGender(Gender.valueOf(genderParam));
        } catch (IllegalArgumentException e) {
            user.setGender(Gender.PREFER_NOT_TO_SAY); // fallback
        }

        if (dobParam != null && !dobParam.isEmpty()) {
            try {
                user.setDob(LocalDate.parse(dobParam));
            } catch (Exception e) {
                errors.add("Invalid date format.");
            }
        }

        user.setActive(active);

        if (!errors.isEmpty()) {
            req.setAttribute("errors", errors);
            req.getRequestDispatcher("/WEB-INF/views/admin/users.jsp").forward(req, resp);
            return;
        }

        adminAccountService.register(user);

        resp.sendRedirect(req.getContextPath() + "/admin/accounts?created=1");
    }
}
