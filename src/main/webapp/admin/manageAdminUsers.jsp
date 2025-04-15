<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags/admin" %>
<script src="https://cdn.tailwindcss.com"></script>

<!DOCTYPE html>
<html>
<head>
    <title>Manage Users</title>
</head>
<body class="p-6">

<!-- Pop Up Successful Message-->
<c:if test="${param.created == '1'}">
    <div id="toast"
         class="fixed top-4 right-4 bg-green-500 text-white px-4 py-2 rounded shadow-lg z-50
                opacity-100 transition-opacity duration-500 ease-in-out">
        User created successfully!!
    </div>

    <script>
        setTimeout(() => {
            const toast = document.getElementById("toast");
            toast.classList.remove("opacity-100");
            toast.classList.add("opacity-0");
            setTimeout(() => toast.remove(), 500);
        }, 2000);
    </script>
</c:if>

<my:header />
<my:adminNavBar />

<h2 class="text-2xl font-bold mb-4">Manage Users</h2>

<div class="flex justify-between items-center mb-4">
    <!-- Search + Sort Function-->
    <form method="get" action="/admin/users" class="flex gap-2">
        <input type="text" name="search" value="${param.search}" placeholder="Search username/email..." class="border p-2 rounded" />
        <select name="sort" class="border p-2 rounded">
            <option value="username" ${param.sort == 'username' ? 'selected' : ''}>Username</option>
            <option value="email" ${param.sort == 'email' ? 'selected' : ''}>Email</option>
        </select>
        <button type="submit" class="bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600">Apply</button>
    </form>

    <!-- Add New User -->
    <a href="javascript:void(0)" onclick="openModal()" class="bg-green-600 text-white px-4 py-2 rounded hover:bg-green-700">
        + Add
    </a>
</div>

<!-- User Table -->
<my:adminTable>
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
            <td class="p-2">
                <a href="/admin/users/view?username=${user.username}"
                   class="text-blue-600 hover:underline">
                        ${user.username}
                </a>
            </td>
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
</my:adminTable>


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
<my:footer />

<!-- Add New User -->
<div id="addUserModal" class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center hidden z-50">
    <div class="bg-white p-6 rounded shadow w-[400px]">
        <h2 class="text-xl font-bold mb-4">Add New User</h2>
        <form method="post" action="/admin/users/add" class="space-y-3">
            <!--Error Message-->
            <c:if test="${not empty errors}">
                <div class="bg-red-100 text-red-700 p-4 rounded mb-4">
                    <ul>
                        <c:forEach var="err" items="${errors}">
                            <li>⚠️ ${err}</li>
                        </c:forEach>
                    </ul>
                </div>
            </c:if>
            <input type="text" name="username" placeholder="Username" class="w-full border p-2 rounded" />
            <input type="email" name="email" placeholder="Email" class="w-full border p-2 rounded" />
            <input type="password" name="password" placeholder="Password" class="w-full border p-2 rounded" />

            <label class="block font-semibold mb-1">Roles:</label>
            <select name="roles" multiple class="w-full border rounded p-2">
                <option value="USER">User</option>
                <option value="STAFF">Staff</option>
                <option value="ADMIN">Admin</option>
            </select>
            <small class="text-gray-500">Hold Ctrl (or Cmd) to select multiple</small>

            <div>
                <label><input type="checkbox" name="active" value="true" /> Active</label>
            </div>

            <div class="flex justify-between">
                <button type="submit" class="bg-green-600 text-white px-4 py-2 rounded">Create</button>
                <button type="button" onclick="closeModal()" class="text-gray-500 hover:underline">Cancel</button>
            </div>
        </form>
    </div>
</div>

<c:if test="${not empty errors}">
    <script>
        window.onload = function () {
            openModal();
        };
    </script>
</c:if>


<!-- JavaScript on Add Function-->
<script>
    function openModal() {
        document.getElementById("addUserModal").classList.remove("hidden");
    }
    function closeModal() {
        document.getElementById("addUserModal").classList.add("hidden");
    }
</script>

