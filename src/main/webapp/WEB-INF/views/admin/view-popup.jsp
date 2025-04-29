<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="account" type="com.lavacorp.beautefly.webstore.admin.dto.AdminUserAccountDTO" scope="request"/>

<div class="space-y-4 text-sm">
    <table class="w-full">
        <tr>
            <td class="font-semibold pr-2">Username:</td>
            <td>${account.username()}</td>
        </tr>
        <tr>
            <td class="font-semibold pr-2">Email:</td>
            <td>${account.email()}</td>
        </tr>
        <tr>
            <td class="font-semibold pr-2">Gender:</td>
            <td>${account.gender()}</td>
        </tr>
        <tr>
            <td class="font-semibold pr-2">DOB:</td>
            <td>${account.dob()}</td>
        </tr>
        <tr>
            <td class="font-semibold pr-2">Active:</td>
            <td>${account.active() ? "YES" : "NO"}</td>
        </tr>
        <tr>
            <td class="font-semibold pr-2 align-top">Roles:</td>
            <td>
                <c:forEach var="role" items="${account.roles()}">
                    <span class="inline-block bg-gray-800 text-white px-2 py-1 rounded text-xs mr-1">${role}</span>
                </c:forEach>
            </td>
        </tr>
    </table>
</div>

<div class="text-right mt-4">
    <button onclick="openEditPopup('${account.id()}')" class="bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded">
        ✏️ Edit Info
    </button>
</div>
