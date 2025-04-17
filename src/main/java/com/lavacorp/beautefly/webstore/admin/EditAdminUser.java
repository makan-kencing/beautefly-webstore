package com.lavacorp.beautefly.webstore.admin;

import com.lavacorp.beautefly.webstore.account.AccountRepository;
import com.lavacorp.beautefly.webstore.account.entity.Address;
import com.lavacorp.beautefly.webstore.account.entity.UserAccount;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.transaction.Transactional;

import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/admin/users/edit")
@Transactional
public class EditAdminUser extends HttpServlet {

    @Inject
    private AccountRepository accountRepo;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        UserAccount user = accountRepo.findByUsername(username).stream().findFirst().orElse(null);

        if (user == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        request.setAttribute("user", user);
        request.getRequestDispatcher("/admin/editUserDetails.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        UserAccount user = accountRepo.findByUsername(username).stream().findFirst().orElse(null);

        //Error Messages
        List<String> errors = new ArrayList<>();

        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String gender = request.getParameter("gender");

        if (firstName == null || firstName.trim().isEmpty()) errors.add("First name is required.");
        if (lastName == null || lastName.trim().isEmpty()) errors.add("Last name is required.");
        if (email == null || email.trim().isEmpty()) errors.add("Email is required.");
        if (phone == null || phone.trim().isEmpty()) errors.add("Phone number is required.");
        if (gender == null || !(gender.equalsIgnoreCase("Male") || gender.equalsIgnoreCase("Female")))
            errors.add("Gender must be either 'Male' or 'Female'.");

        if (!errors.isEmpty()) {
            request.setAttribute("errors", errors);
            request.setAttribute("user", user);
            request.getRequestDispatcher("/admin/editUserDetails.jsp").forward(request, response);
            return;
        }

        if (user == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        String dobStr = request.getParameter("dob");
        if (dobStr != null && !dobStr.isEmpty()) {
            user.setDob(LocalDate.parse(dobStr));
        }

        user.setFirstName(request.getParameter("firstName"));
        user.setLastName(request.getParameter("lastName"));
        user.setPhone(request.getParameter("phone"));
        user.setGender(request.getParameter("gender"));
        user.setActive(true);

        user.getAddressBook().setDefaultAddress(null);

        accountRepo.update(user);

        response.sendRedirect("/admin/users/view?username=" + username + "&updated=1");
    }
}
