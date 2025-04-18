package com.lavacorp.beautefly.webstore.admin.servlet;

import com.lavacorp.beautefly.webstore.account.AccountRepository;
import com.lavacorp.beautefly.webstore.account.entity.Address;
import com.lavacorp.beautefly.webstore.account.mapper.AddressMapper;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.transaction.Transactional;

import java.io.IOException;
import java.util.NoSuchElementException;

@WebServlet("/admin/account/address")
@Transactional
public class AdminAddressServlet extends HttpServlet {
    @Inject
    private AccountRepository accountRepository;

    @Inject
    private AddressMapper addressMapper;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int accountId;
        try {
            accountId = Integer.parseInt(req.getParameter("accountId"));
        } catch (NullPointerException | NumberFormatException exc) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        int id;
        try {
            id = Integer.parseInt(req.getParameter("id"));
        } catch (NullPointerException | NumberFormatException exc) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        var account = accountRepository.findUserAccount(accountId);
        if (account == null) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        Address address;
        try {
            address = account.getAddressBook()
                    .getAddresses()
                    .stream()
                    .filter(a -> a.getId() == id)
                    .findFirst()
                    .orElseThrow();
        } catch (NoSuchElementException e) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        req.setAttribute("address", addressMapper.toAddressDTO(address));

        var view = req.getRequestDispatcher("/admin/editAddress.jsp");
        view.forward(req, resp);
    }
}
