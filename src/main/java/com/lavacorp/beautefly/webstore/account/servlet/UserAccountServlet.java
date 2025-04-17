package com.lavacorp.beautefly.webstore.account.servlet;

import com.lavacorp.beautefly.webstore.account.AccountRepository;
import com.lavacorp.beautefly.webstore.account.entity.UserAccount;
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

@WebServlet("/useraccount")
public class UserAccountServlet extends HttpServlet {
    @Inject
    private AccountRepository accountRepo;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        var username = request.getParameter("username");

        if (username == null || username.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        UserAccount user = accountRepo.findByUsername(username).stream().findFirst().orElse(null);
        if (user == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        // 检查是否有 updated 成功提示
        String updated = request.getParameter("updated");
        if ("1".equals(updated)) {
            request.setAttribute("success", "User updated successfully.");
        }

        request.setAttribute("user", user);
        request.getRequestDispatcher("/WEB-INF/views/useraccount.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        var username = request.getParameter("username");
        UserAccount user = accountRepo.findByUsername(username).stream().findFirst().orElse(null);

        if (user == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        // 表单校验
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
        if (gender == null || !(gender.equalsIgnoreCase("Male") || gender.equalsIgnoreCase("Female"))) {
            errors.add("Gender must be either 'Male' or 'Female'.");
        }

        if (!errors.isEmpty()) {
            request.setAttribute("errors", errors);
            request.setAttribute("user", user);
            request.getRequestDispatcher("/WEB-INF/views/useraccount.jsp").forward(request, response);
            return;
        }

        // 更新字段
        String dobStr = request.getParameter("dob");
        if (dobStr != null && !dobStr.isEmpty()) {
            user.setDob(LocalDate.parse(dobStr));
        }

        user.setFirstName(firstName);
        user.setLastName(lastName);
        user.setEmail(email);
        user.setPhone(phone);
        user.setGender(gender);
        user.setProfileImageUrl(request.getParameter("profileImageUrl"));
        user.setActive(true);

        if (user.getAddressBook() != null) {
            user.getAddressBook().setDefaultAddress(null); // 防止空指针
        }

        accountRepo.update(user);

        request.setAttribute("user", user);
        request.setAttribute("success", "User updated successfully.");
        request.getRequestDispatcher("/WEB-INF/views/useraccount.jsp").forward(request, response);
    }
}
