<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="account" type="com.lavacorp.beautefly.webstore.admin.dto.AdminUserAccountDTO" scope="request" />

<table class="w-full text-sm">
    <tbody>
    <tr><td class="p-2 font-bold">Username</td><td class="p-2">${account.username()}</td></tr>
    <tr><td class="p-2 font-bold">Email</td><td class="p-2">${account.email()}</td></tr>
    <tr><td class="p-2 font-bold">Gender</td><td class="p-2">${account.gender()}</td></tr>
    <tr><td class="p-2 font-bold">DOB</td><td class="p-2">${account.dob()}</td></tr>
    <tr><td class="p-2 font-bold">Active</td><td class="p-2">${account.active() ? "YES" : "NO"}</td></tr>
    </tbody>
</table>

<div class="mt-4 text-right">
    <button
            type="button"
            onclick="openEditModal(${account.id()})"
            class="bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded">
        ✏️ Edit Info
    </button>
</div>

