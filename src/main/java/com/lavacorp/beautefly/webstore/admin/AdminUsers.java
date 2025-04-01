package com.lavacorp.beautefly.webstore.admin;

import com.lavacorp.beautefly.webstore.admin.model.UsersStats;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/users")
public class AdminUsers extends HttpServlet {

    @Inject
    private AdminUserDAO userDAO;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String search = request.getParameter("search");
        String sort = request.getParameter("sort");
        int page = 1;
        int pageSize = 5;

        if (request.getParameter("page") != null) {
            try {
                page = Integer.parseInt(request.getParameter("page"));
            } catch (NumberFormatException e) {
                page = 1;
            }
        }

        List<UsersStats> users = userDAO.getAllUsers();

        //Search Funtion
        if (search != null && !search.trim().isEmpty()) {
            String keyword = search.toLowerCase();
            users.removeIf(u ->
                    !u.getUsername().toLowerCase().contains(keyword) &&
                            !u.getEmail().toLowerCase().contains(keyword)
            );
        }

        //Sort Function
        if (sort != null) {
            switch (sort) {
                case "username" -> users.sort((a, b) -> a.getUsername().compareToIgnoreCase(b.getUsername()));
                case "email" -> users.sort((a, b) -> a.getEmail().compareToIgnoreCase(b.getEmail()));
                case "group" -> users.sort((a, b) -> Integer.compare(a.getGroupId(), b.getGroupId()));
            }
        }

        //Page Function
        int totalUsers = users.size();
        int fromIndex = Math.max((page - 1) * pageSize, 0);
        int toIndex = Math.min(fromIndex + pageSize, totalUsers);
        List<UsersStats> paginated = users.subList(fromIndex, toIndex);

        request.setAttribute("users", paginated);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalUsers", totalUsers);
        request.setAttribute("pageSize", pageSize);
        request.getRequestDispatcher("/admin/manageAdminUsers.jsp").forward(request, response);
    }

}
