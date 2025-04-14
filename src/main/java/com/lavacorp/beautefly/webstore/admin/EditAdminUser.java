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
        user.setProfileImageUrl(request.getParameter("profileImageUrl"));
        user.setActive(true);

        Address address = user.getAddressBook().getDefaultAddress();
        if (address == null) {
            address = new Address();
            address.setAccount(user);
            user.getAddressBook().getAddresses().add(address);
            user.getAddressBook().setDefaultAddress(address);
        }

        String recipientName = request.getParameter("recipientName");
        String address1 = request.getParameter("address1");
        String postcode = request.getParameter("postcode");
        String state = request.getParameter("state");
        String country = request.getParameter("country");

        address.setContactNo(request.getParameter("phone"));
        address.setName(recipientName);
        address.setAddress1(address1);
        address.setAddress2(request.getParameter("address2"));
        address.setAddress3(request.getParameter("address3"));
        address.setPostcode(postcode);
        address.setState(state);
        address.setCountry(country);

        accountRepo.update(user);

        response.sendRedirect("/admin/users/view?username=" + username + "&updated=1");
    }
}
