package com.lavacorp.beautefly.webstore.admin;

import com.lavacorp.beautefly.webstore.account.AccountRepository;
import com.lavacorp.beautefly.webstore.account.entity.UserAccount;
import com.lavacorp.beautefly.webstore.account.entity.Credential;

import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@WebServlet("/admin/users/add")
public class AddAdminUser extends HttpServlet {

    @Inject
    private AccountRepository accountRepo;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/admin/addAdminUser.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //Error Message
        List<String> errors = new ArrayList<>();

        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String[] roles = request.getParameterValues("roles");
        boolean isActive = request.getParameter("active") != null;

        if (username == null || username.trim().isEmpty()) errors.add("Username is required.");
        if (email == null || email.trim().isEmpty()) errors.add("Email is required.");
        if (password == null || password.trim().isEmpty()) errors.add("Password is required.");
        if (roles == null || roles.length == 0) errors.add("At least one role must be selected.");

        if (accountRepo.findByUsername(username).stream().findFirst().isPresent()) {
            errors.add("Username already exists.");
        }

        if (accountRepo.findByEmail(email) != null) {
            errors.add("Email already exists.");
        }

        if (!errors.isEmpty()) {
            request.setAttribute("errors", errors);
            request.getRequestDispatcher("/admin/manageAdminUsers.jsp").forward(request, response);
            return;
        }

        UserAccount newUser = new UserAccount();
        newUser.setUsername(username);
        newUser.setEmail(email);
        newUser.setActive(isActive);
        newUser.setDob(LocalDate.of(2000, 1, 1));

        Credential credential = new Credential();
        credential.setPassword(password);

        Set<Credential.Role> roleSet = new HashSet<>();
        for (String r : roles) {
            roleSet.add(Credential.Role.valueOf(r));
        }
        credential.setRoles(roleSet);
        newUser.setCredential(credential);

        accountRepo.register(newUser);

        response.sendRedirect("/admin/users?created=1");
    }
}
