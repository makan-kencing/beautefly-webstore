package com.lavacorp.beautefly.webstore.admin.servlet;

import com.lavacorp.beautefly.webstore.account.AccountRepository;
import com.lavacorp.beautefly.webstore.account.entity.Account;
import jakarta.data.page.Page;
import jakarta.data.page.PageRequest;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/accounts")
public class AdminUsersServlet extends HttpServlet {
    @Inject
    private AccountRepository accountRepository;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String search = req.getParameter("search");
        if (search == null) search = "";

        int page = req.getParameter("page") != null ? Integer.parseInt(req.getParameter("page")) : 1;
        int pageSize = 20;

        Page<Account> usersPage = accountRepository.findByUsernameLike(
                "%" + search + "%",
                PageRequest.ofPage(page, pageSize, true),
                List.of()
        );

        req.setAttribute("users", usersPage.content());
        req.setAttribute("currentPage", page);
        req.setAttribute("totalUsers", usersPage.totalElements());
        req.setAttribute("pageSize", pageSize);

        var view = req.getRequestDispatcher("/WEB-INF/views/admin/users.jsp");
        view.forward(req, resp);
    }
}
