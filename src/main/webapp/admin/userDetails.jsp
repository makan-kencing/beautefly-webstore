<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="admin" tagdir="/WEB-INF/tags/admin" %>
<script src="https://cdn.tailwindcss.com"></script>

<!DOCTYPE html>
<html>
<head>
    <title>User Details</title>
</head>
<body class="p-6 bg-gray-50">
<admin:header />
<admin:adminNavBar />

<div class="max-w-3xl mx-auto bg-white shadow-md rounded p-6">
    <div class="flex justify-between items-center mb-4">
        <h2 class="text-2xl font-bold">User Details</h2>
        <a href="/admin/users/edit?username=${user.username}"
           class="bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700">
            ✏️ Edit
        </a>
    </div>

    <div class="grid grid-cols-2 gap-4 text-sm">
        <p><strong>Username:</strong> ${user.username}</p>
        <p><strong>Email:</strong> ${user.email}</p>
        <p><strong>First Name:</strong> ${user.firstName}</p>
        <p><strong>Last Name:</strong> ${user.lastName}</p>
        <p><strong>Date of Birth:</strong> ${user.dob}</p>
        <p><strong>Age:</strong> ${user.age}</p>
        <p><strong>Active:</strong> ${user.active ? 'Yes' : 'No'}</p>
        <p><strong>Roles:</strong>
            <c:forEach var="role" items="${user.credential.roles}">
                <span class="inline-block bg-gray-200 text-gray-800 px-2 py-1 rounded text-xs mr-1">${role}</span>
            </c:forEach>
        </p>
    </div>
</div>

<admin:footer />
</body>
</html>
