package com.lavacorp.beautefly.webstore.account.servlet;

import com.lavacorp.beautefly.webstore.account.AccountRepository;
import com.lavacorp.beautefly.webstore.account.entity.UserAccount;
import com.lavacorp.beautefly.webstore.security.SecurityService;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/account")
public class UserAccountServlet extends HttpServlet {
    @Inject
    private AccountRepository accountRepo;

    @Inject
    private SecurityService securityService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        var user = securityService.getUserAccountContext(req);
        if (user == null) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        req.setAttribute("user", user);
        req.getRequestDispatcher("/WEB-INF/views/useraccount.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        var user = securityService.getUserAccountContext(req);
        if (user == null) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        List<String> errors = new ArrayList<>();
        String firstName = req.getParameter("firstName");
        String lastName = req.getParameter("lastName");
        String email = req.getParameter("email");
        String phone = req.getParameter("phone");
        String gender = req.getParameter("gender");

        if (firstName == null || firstName.trim().isEmpty()) errors.add("First name is required.");
        if (lastName == null || lastName.trim().isEmpty()) errors.add("Last name is required.");
        if (email == null || email.trim().isEmpty()) errors.add("Email is required.");
        if (phone == null || phone.trim().isEmpty()) errors.add("Phone number is required.");
        if (gender == null || !(gender.equalsIgnoreCase("Male") || gender.equalsIgnoreCase("Female"))) {
            errors.add("Gender must be either 'Male' or 'Female'.");
        }

        if (!errors.isEmpty()) {
            req.setAttribute("errors", errors);
            req.setAttribute("user", user);
            req.getRequestDispatcher("/WEB-INF/views/useraccount.jsp").forward(req, resp);
            return;
        }

        String dobStr = req.getParameter("dob");
        if (dobStr != null && !dobStr.isEmpty()) {
            user.setDob(LocalDate.parse(dobStr));
        }

        user.setEmail(email);
        user.setActive(true);

        if (user.getAddressBook() != null) {
            user.getAddressBook().setDefaultAddress(null);
        }

        accountRepo.update(user);

        req.setAttribute("user", user);
        req.setAttribute("success", "User updated successfully.");
        req.getRequestDispatcher("/WEB-INF/views/useraccount.jsp").forward(req, resp);
    }
}
