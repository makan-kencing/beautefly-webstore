package com.lavacorp.beautefly.webstore.admin.account.servlet;

import com.lavacorp.beautefly.webstore.account.AccountService;
import com.lavacorp.beautefly.webstore.account.dto.AddressDTO;
import com.lavacorp.beautefly.webstore.account.entity.Account;
import com.lavacorp.beautefly.webstore.account.mapper.AccountMapper;
import com.lavacorp.beautefly.webstore.security.dto.AccountContextDTO;
import com.lavacorp.beautefly.webstore.file.dto.FileUploadDTO;
import jakarta.inject.Inject;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.PersistenceUnit;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.hibernate.SessionFactory;

import java.io.IOException;
import java.util.ArrayList;

@WebServlet("/admin/account")
public class AdminUserServlet extends HttpServlet {

    @PersistenceUnit
    private EntityManagerFactory emf;

    @Inject
    private AccountMapper accountMapper;

    @Inject
    private AccountService accountService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id;
        try {
            id = Integer.parseInt(req.getParameter("id"));
        } catch (NullPointerException | NumberFormatException exc) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        var session = emf.unwrap(SessionFactory.class)
                .openStatelessSession();

        var account = session.get(Account.class, id);
        if (account == null) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND, "User not found");
            return;
        }

        var dto = accountMapper.toAdminUserAccountDTO(account);
        req.setAttribute("account", dto);

        var contextDTO = new AccountContextDTO(
                account.getId(),
                account.getUsername(),
                account.getEmail(),
                account.getProfileImage() != null
                        ? new FileUploadDTO(
                        account.getProfileImage().getId(),
                        account.getProfileImage().getFilename(),
                        account.getProfileImage().getType(),
                        account.getProfileImage().getUrl()
                )
                        : null,
                new ArrayList<>(account.getCredential().getRoles())
        );

        var addressesDTO = accountService.getAccountAddressesDetails(contextDTO);
        var addresses = addressesDTO.addresses();

        AddressDTO addressDTO = null;
        if (!addresses.isEmpty()) {
            addressDTO = addresses.get(0);
        }

        if (addressDTO != null) {
            req.setAttribute("address", addressDTO);
        }


        var view = req.getRequestDispatcher("/WEB-INF/views/admin/user-details.jsp");
        view.forward(req, resp);
    }
}
