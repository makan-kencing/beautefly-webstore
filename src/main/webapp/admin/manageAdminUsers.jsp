<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.lavacorp.beautefly.webstore.admin.model.DashboardStats" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>
<script src="https://cdn.tailwindcss.com"></script>


<!DOCTYPE html>
<html>
<head>
    <title>Users</title>
</head>
<body>
<h1>Admin Dashboard</h1>

<%
    DashboardStats stats = (DashboardStats) request.getAttribute("stats");
%>

<h2>Manage Users</h2>

<%--Search Funtion--%>
<form method="get" action="/admin/users">
    <input type="text" name="search" placeholder="Search username..." />
    <button type="submit">Search</button>
</form>

<%--Sort Funtion--%>
<form method="get" action="/admin/users">
    <input type="text" name="search" value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>" placeholder="Search username/email..." />
    <select name="sort">
        <option value="username">Username</option>
        <option value="email">Email</option>
        <option value="group">Group</option>
    </select>
    <button type="submit">Apply</button>
</form>

<table class="w-full mt-4 border-collapse text-sm">
    <thead class="bg-gray-200 text-left">
    <tr>
        <th class="p-2">Username</th>
        <th class="p-2">Email</th>
        <th class="p-2">Roles</th>
        <th class="p-2">Active</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="user" items="${users}">
        <tr class="border-b">
            <td class="p-2">${user.username}</td>
            <td class="p-2">${user.email}</td>
            <td class="p-2">
                <c:forEach var="role" items="${user.credential.roles}">
                        <span class="px-2 py-1 text-white text-xs rounded-full mr-1
                            ${role == 'ADMIN' ? 'bg-red-600' :
                              role == 'STAFF' ? 'bg-blue-600' :
                              role == 'USER' ? 'bg-green-600' : 'bg-gray-500'}">
                                ${role}
                        </span>
                </c:forEach>
            </td>
            <td class="p-2">
                    <span class="${user.active ? 'text-green-600' : 'text-red-600'} font-semibold">
                            ${user.active ? 'YES' : 'NO'}
                    </span>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>

<%
    int totalUsers = (int) request.getAttribute("totalUsers");
    int pageSize = (int) request.getAttribute("pageSize");
    int currentPage = (int) request.getAttribute("currentPage");
    int totalPages = (int) Math.ceil((double) totalUsers / pageSize);
%>

<%--Paging Funtion--%>
<div style="margin-top: 20px;">
    <% for (int i = 1; i <= totalPages; i++) { %>
    <a href="?page=<%= i %>&search=<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>&sort=<%= request.getParameter("sort") != null ? request.getParameter("sort") : "" %>">
        <%= (i == currentPage ? "<strong>" + i + "</strong>" : i) %>
    </a>
    <% } %>
</div>


</body>
</html>

