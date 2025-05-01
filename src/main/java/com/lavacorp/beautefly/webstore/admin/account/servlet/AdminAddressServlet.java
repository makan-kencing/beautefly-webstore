package com.lavacorp.beautefly.webstore.admin.account.servlet;

import com.lavacorp.beautefly.webstore.account.entity.Account;
import com.lavacorp.beautefly.webstore.account.entity.Address;
import com.lavacorp.beautefly.webstore.account.mapper.AddressMapper;
import jakarta.inject.Inject;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.PersistenceUnit;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.transaction.Transactional;
import org.hibernate.SessionFactory;

import java.io.IOException;
import java.util.NoSuchElementException;

@WebServlet("/admin/account/address")
@Transactional
public class AdminAddressServlet extends HttpServlet {
    @PersistenceUnit
    private EntityManagerFactory emf;

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

        var session = emf.unwrap(SessionFactory.class)
                .openStatelessSession();

        var account = session.get(Account.class, accountId);
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

        var view = req.getRequestDispatcher("/WEB-INF/views/admin/edit-address.jsp");
        view.forward(req, resp);
    }
}
