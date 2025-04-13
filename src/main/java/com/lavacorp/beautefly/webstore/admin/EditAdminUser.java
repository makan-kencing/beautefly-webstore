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

@WebServlet("/admin/users/edit")
@Transactional
public class EditAdminUser extends HttpServlet {

    @Inject
    private AccountRepository accountRepo;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        UserAccount user = (UserAccount) accountRepo.findByUsername(username)
                .stream().findFirst().orElse(null);

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
        UserAccount user = (UserAccount) accountRepo.findByUsername(username)
                .stream().findFirst().orElse(null);

        if (user == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        user.setFirstName(request.getParameter("firstName"));
        user.setLastName(request.getParameter("lastName"));
        user.setPhone(request.getParameter("phone"));
        user.setGender(request.getParameter("gender"));
        user.setProfileImageUrl(request.getParameter("profileImageUrl"));
        user.setActive(request.getParameter("active") != null);

        Address address = user.getAddressBook().getDefaultAddress();
        if (address == null) {
            address = new Address();
            address.setAccount(user);
            user.getAddressBook().setDefaultAddress(address);
        }

        address.setName(request.getParameter("recipientName"));
        address.setContactNo(request.getParameter("contactNo"));
        address.setAddress1(request.getParameter("address1"));
        address.setAddress2(request.getParameter("address2"));
        address.setAddress3(request.getParameter("address3"));
        address.setPostcode(request.getParameter("postcode"));
        address.setState(request.getParameter("state"));
        address.setCountry(request.getParameter("country"));

        accountRepo.update(user);

        response.sendRedirect("/admin/users/view?username=" + username + "&updated=1");
    }
}
