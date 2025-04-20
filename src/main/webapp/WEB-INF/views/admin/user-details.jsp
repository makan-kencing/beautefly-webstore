<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="admin" tagdir="/WEB-INF/tags/admin" %>

<jsp:useBean id="account" type="com.lavacorp.beautefly.webstore.admin.dto.AdminUserAccountDTO" scope="request"/>

<admin:base pageTitle="Account Details">
    <main>
        <!-- Page Header + Edit Btn -->
        <div class="flex justify-between items-center mb-6">
            <h2 class="text-2xl font-bold">User Details</h2>
            <a href="${pageContext.request.contextPath}/admin/account/${account.id()}/edit"
               class="bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded">
                ✏️ Edit Info
            </a>
        </div>

        <!-- Detail Table -->
        <table class="w-full max-w-3xl bg-white rounded shadow text-sm">
            <tbody class="divide-y">
            <tr>
                <td class="p-3 font-semibold w-1/3">Username:</td>
                <td class="p-3">${account.username()}</td>
            </tr>
            <tr>
                <td class="p-3 font-semibold">Email:</td>
                <td class="p-3">${account.email()}</td>
            </tr>
            <tr>
                <td class="p-3 font-semibold">Gender:</td>
                <td class="p-3">${account.gender()}</td>
            </tr>
            <tr>
                <td class="p-3 font-semibold">DOB:</td>
                <td class="p-3">${account.dob()}</td>
            </tr>
            <tr>
                <td class="p-3 font-semibold">Active:</td>
                <td class="p-3">
                    <span class="data-active:text-green-600 text-red-600} font-semibold"
                        ${account.active() ? "data-active" : ""}>
                            ${account.active() ? "YES" : "NO"}
                    </span>
                </td>
            </tr>
            <tr>
                <td class="p-3 font-semibold">Roles:</td>
                <td class="p-3">
                    <c:forEach var="role" items="${account.roles()}">
                        <span class="inline-block px-2 py-1 text-white text-xs rounded-full
                                data-role-admin:bg-red-600
                                data-role-staff:bg-blue-600
                                data-role-user:bg-green-600"
                            ${"data-role-" + role.name().toLowerCase()}>
                                ${role}
                        </span>
                    </c:forEach>
                </td>
            </tr>
            <tr>
                <td class="p-3 font-semibold">Profile Picture:</td>
                <td class="p-3">
                    <img src="${pageContext.request.contextPath}${account.profileImage().href()}"
                         class="w-20 h-20 object-cover rounded-full border"
                         alt="Profile"/>
                </td>
            </tr>
            </tbody>
        </table>
    </main>
</admin:base>


