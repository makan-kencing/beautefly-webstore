package com.lavacorp.beautefly.webstore.admin.account.servlet;

import com.lavacorp.beautefly.webstore.account.AccountService;
import com.lavacorp.beautefly.webstore.account.dto.AddressDTO;
import com.lavacorp.beautefly.webstore.account.dto.UpdateUserAccountDetailsDTO;
import com.lavacorp.beautefly.webstore.security.dto.AccountContextDTO;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDate;

@WebServlet("/admin/account/edit")
public class AdminEditUserServlet extends HttpServlet {

    @Inject
    private AccountService accountService;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int accountId = Integer.parseInt(req.getParameter("id"));

        // Update Account Details
        var updateAccount = new UpdateUserAccountDetailsDTO(
                req.getParameter("username"),
                req.getParameter("email"),
                req.getParameter("gender") != null
                        ? Enum.valueOf(com.lavacorp.beautefly.webstore.account.entity.Account.Gender.class, req.getParameter("gender"))
                        : com.lavacorp.beautefly.webstore.account.entity.Account.Gender.PREFER_NOT_TO_SAY,
                req.getParameter("dob") != null && !req.getParameter("dob").isBlank()
                        ? LocalDate.parse(req.getParameter("dob"))
                        : null
        );

        var contextDTO = new AccountContextDTO(accountId, null, null, null, null);
        accountService.updateUserAccountDetails(contextDTO, updateAccount);

        // Update Address
        Integer.parseInt(req.getParameter("addressId"));
        var updateAddress = new AddressDTO(
                Integer.parseInt(req.getParameter("addressId")),
                req.getParameter("name"),
                req.getParameter("contactNo"),
                req.getParameter("address1"),
                req.getParameter("address2"),
                req.getParameter("address3"),
                req.getParameter("city"),
                req.getParameter("postcode"),
                req.getParameter("state"),
                req.getParameter("country")
        );

        accountService.updateAddressDetails(updateAddress);

        resp.sendRedirect(req.getContextPath() + "/admin/account?id=" + accountId);
    }
}
