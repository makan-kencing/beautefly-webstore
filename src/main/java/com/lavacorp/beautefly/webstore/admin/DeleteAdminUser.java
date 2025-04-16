package com.lavacorp.beautefly.webstore.admin;

import com.lavacorp.beautefly.webstore.account.AccountRepository;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/admin/users/delete")
public class DeleteAdminUser extends HttpServlet {

    @Inject
    private AccountRepository accountRepo;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String[] usernames = request.getParameterValues("usernames");

        if (usernames != null && usernames.length > 0) {
            for (String username : usernames) {
                accountRepo.findByUsername(username)
                        .stream()
                        .findFirst()
                        .ifPresent(accountRepo::delete);
            }
        }

        response.sendRedirect("/admin/users?deleted=1");
    }
}
