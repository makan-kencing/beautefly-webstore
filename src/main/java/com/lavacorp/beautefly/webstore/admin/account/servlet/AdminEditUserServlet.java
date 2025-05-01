package com.lavacorp.beautefly.webstore.admin.account.servlet;

import com.lavacorp.beautefly.webstore.account.entity.Account;
import com.lavacorp.beautefly.webstore.account.mapper.AccountMapper;
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
import java.time.LocalDate;

@WebServlet("/admin/account/edit")
@Transactional
public class AdminEditUserServlet extends HttpServlet {
    @PersistenceUnit
    private EntityManagerFactory emf;

    @Inject
    private AccountMapper accountMapper;

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

        Account account = session.get(Account.class, id);
        if (account == null) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        var dto = accountMapper.toAdminUserAccountDTO(account);

        req.setAttribute("account", dto);

        var view = req.getRequestDispatcher("/WEB-INF/views/admin/edit-user-details.jsp");
        view.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id;
        try {
            id = Integer.parseInt(req.getParameter("id"));
        } catch (Exception e) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid user ID");
            return;
        }

        var session = emf.unwrap(SessionFactory.class)
                .openSession();
        var tx = session.beginTransaction();

        try {
            Account account = session.get(Account.class, id);
            if (account == null) {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND, "User not found");
                return;
            }

            // Update fields
            account.setUsername(req.getParameter("username"));
            account.setEmail(req.getParameter("email"));
            account.setGender(Account.Gender.valueOf(req.getParameter("gender")));
            account.setDob(LocalDate.parse(req.getParameter("dob")));

            session.merge(account);

            tx.commit();
            resp.sendRedirect(req.getContextPath() + "/admin/account?id=" + id); // Redirect back to View User Details
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            throw new ServletException("Failed to update user", e);
        } finally {
            session.close();
        }
    }

}
