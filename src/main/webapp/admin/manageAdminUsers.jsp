<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>
<script src="https://cdn.tailwindcss.com"></script>

<!DOCTYPE html>
<html>
<head>
    <title>Manage Users</title>
</head>
<body class="p-6">
<my:adminNavBar />

<h2 class="text-2xl font-bold mb-4">Manage Users</h2>

<!-- Search + Sort Form -->
<form method="get" action="/admin/users" class="mb-4 flex gap-2">
    <input type="text" name="search" placeholder="Search username/email..." value="${param.search}" class="border px-2 py-1 rounded" />
    <select name="sort" class="border px-2 py-1 rounded">
        <option value="username" ${param.sort == 'username' ? 'selected' : ''}>Username</option>
        <option value="email" ${param.sort == 'email' ? 'selected' : ''}>Email</option>
        <option value="group" ${param.sort == 'group' ? 'selected' : ''}>Group</option>
    </select>
    <button type="submit" class="bg-blue-500 text-white px-3 py-1 rounded">Apply</button>
</form>

<!-- User Table -->
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

<!-- Pagination -->
<div class="mt-4">
    <c:set var="totalPages" value="${(totalUsers / pageSize) + (totalUsers % pageSize > 0 ? 1 : 0)}" />
    <c:forEach var="i" begin="1" end="${totalPages}">
        <a href="?page=${i}&search=${param.search}&sort=${param.sort}"
           class="px-3 py-1 border rounded mr-1 ${i == currentPage ? 'bg-blue-500 text-white' : 'bg-white'}">
                ${i}
        </a>
    </c:forEach>
</div>
</body>
</html>
