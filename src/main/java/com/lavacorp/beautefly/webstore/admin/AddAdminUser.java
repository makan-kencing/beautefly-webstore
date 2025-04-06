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
import java.util.HashSet;
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

        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String[] roles = request.getParameterValues("roles");
        boolean isActive = request.getParameter("active") != null;

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
