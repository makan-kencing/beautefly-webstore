package com.lavacorp.beautefly.webstore.admin;

import com.lavacorp.beautefly.webstore.account.AccountRepository;
import com.lavacorp.beautefly.webstore.account.entity.Account;

import jakarta.data.page.Page;
import jakarta.data.page.PageRequest;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.Collections;
import java.util.Optional;

@WebServlet("/admin/users")
public class AdminUsers extends HttpServlet {

    @Inject
    private AccountRepository accountRepo;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String search = Optional.ofNullable(request.getParameter("search")).orElse("");
        int page = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;
        int pageSize = 5;

        PageRequest pageRequest = PageRequest.ofPage(page, pageSize, true);

        Page<Account> usersPage = accountRepo.findByUsernameLike(
                "%" + search + "%",
                pageRequest,
                Collections.emptyList()
        );

        request.setAttribute("users", usersPage.content());
        request.setAttribute("currentPage", page);
        request.setAttribute("totalUsers", usersPage.totalElements());
        request.setAttribute("pageSize", pageSize);

        request.getRequestDispatcher("/admin/manageAdminUsers.jsp").forward(request, response);
    }
}
