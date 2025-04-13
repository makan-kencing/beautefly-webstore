<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags/admin" %>
<script src="https://cdn.tailwindcss.com"></script>

<!DOCTYPE html>
<html>
<head>
    <title>View User Details</title>
</head>
<body class="p-6 bg-gray-50 min-h-screen">
<my:header />
<my:adminNavBar />

<div class="flex justify-between items-center mb-6">
    <h2 class="text-2xl font-bold">User Details</h2>
    <a href="/admin/users/edit?username=${user.username}"
       class="bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded">
        Edit Info
    </a>
</div>

<table class="w-full max-w-3xl bg-white rounded shadow text-sm">
    <tbody>
    <tr class="border-b">
        <td class="p-3 font-semibold w-1/3">Username:</td>
        <td class="p-3">${user.username}</td>
    </tr>
    <tr class="border-b">
        <td class="p-3 font-semibold">First Name:</td>
        <td class="p-3">${user.firstName}</td>
    </tr>
    <tr class="border-b">
        <td class="p-3 font-semibold">Last Name:</td>
        <td class="p-3">${user.lastName}</td>
    </tr>
    <tr class="border-b">
        <td class="p-3 font-semibold">Email:</td>
        <td class="p-3">${user.email}</td>
    </tr>
    <tr class="border-b">
        <td class="p-3 font-semibold">Phone:</td>
        <td class="p-3">${user.phone}</td>
    </tr>
    <tr class="border-b">
        <td class="p-3 font-semibold">Gender:</td>
        <td class="p-3">${user.gender}</td>
    </tr>
    <tr class="border-b">
        <td class="p-3 font-semibold">Address:</td>
        <td class="p-3">
            <c:choose>
                <c:when test="${not empty user.addressBook.defaultAddress}">
                    ${user.addressBook.defaultAddress.address1},
                    ${user.addressBook.defaultAddress.address2},
                    ${user.addressBook.defaultAddress.address3},
                    ${user.addressBook.defaultAddress.postcode},
                    ${user.addressBook.defaultAddress.state},
                    ${user.addressBook.defaultAddress.country}
                </c:when>
                <c:otherwise>
                    <span class="text-gray-400">No address provided</span>
                </c:otherwise>
            </c:choose>
        </td>
    </tr>
    <tr class="border-b">
        <td class="p-3 font-semibold">DOB:</td>
        <td class="p-3">${user.dob}</td>
    </tr>
    <tr class="border-b">
        <td class="p-3 font-semibold">Active:</td>
        <td class="p-3">
            <span class="${user.active ? 'text-green-600' : 'text-red-600'} font-semibold">
                ${user.active ? 'YES' : 'NO'}
            </span>
        </td>
    </tr>
    <tr class="border-b">
        <td class="p-3 font-semibold">Roles:</td>
        <td class="p-3">
            <c:forEach var="role" items="${user.credential.roles}">
                <span class="inline-block px-2 py-1 text-white text-xs rounded-full mr-1 mb-1
                    ${role == 'ADMIN' ? 'bg-red-600' :
                      role == 'STAFF' ? 'bg-blue-600' :
                      role == 'USER' ? 'bg-green-600' : 'bg-gray-500'}">
                        ${role}
                </span>
            </c:forEach>
        </td>
    </tr>
    <tr>
        <td class="p-3 font-semibold">Profile Picture:</td>
        <td class="p-3">
            <img src="${user.profileImageUrl}" class="w-20 h-20 object-cover rounded-full border" alt="Profile" />
        </td>
    </tr>
    </tbody>
</table>

<my:footer />
</body>
</html>
