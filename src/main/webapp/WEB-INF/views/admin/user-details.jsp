<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="admin" tagdir="/WEB-INF/tags/admin" %>

<jsp:useBean id="account" type="com.lavacorp.beautefly.webstore.admin.account.dto.AdminUserAccountDTO" scope="request"/>

<admin:base pageTitle="Account Details">
    <main>
        <!-- Page Header + Edit Btn -->
        <div class="flex justify-between items-center mb-6">
            <h2 class="text-2xl font-bold">User Details</h2>
            <button onclick="openEditModal()"
                    class="bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded">
                ✏️ Edit Info
            </button>
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
                    <span class="data-active:text-green-600 text-red-600 font-semibold"
                        ${account.active() ? "data-active" : ""}>
                            ${account.active() ? "YES" : "NO"}
                    </span>
                </td>
            </tr>
            <tr>
                <td class="p-3 font-semibold">Roles:</td>
                <td class="p-3">
                    <c:forEach var="role" items="${account.roles()}">
                        <c:set var="roleClass" value="bg-green-600" /> <!-- Default color -->

                        <c:choose>
                            <c:when test="${role.name() == 'ADMIN'}">
                                <c:set var="roleClass" value="bg-red-600" />
                            </c:when>
                            <c:when test="${role.name() == 'STAFF'}">
                                <c:set var="roleClass" value="bg-blue-600" />
                            </c:when>
                            <c:when test="${role.name() == 'USER'}">
                                <c:set var="roleClass" value="bg-green-600" />
                            </c:when>
                        </c:choose>

                        <span class="inline-block px-2 py-1 text-white text-xs rounded-full ${roleClass}">
                                ${role}
                        </span>
                    </c:forEach>
                </td>
            </tr>
            <tr>
                <td class="p-3 font-semibold">Profile Picture:</td>
                <td class="p-3">
                    <c:if test="${not empty account.profileImageHash()}">
                        <img src="${pageContext.request.contextPath}/upload/${account.profileImageHash()}"
                             class="w-20 h-20 object-cover rounded-full border"
                             alt="Profile"/>
                    </c:if>
                    <c:if test="${empty account.profileImageHash()}">
                        <img src="${pageContext.request.contextPath}/static/default-profile.png"
                             class="w-20 h-20 object-cover rounded-full border"
                             alt="Profile"/>
                    </c:if>

                </td>
            </tr>
            </tbody>
        </table>
        
        <!-- 🔧 Edit User Modal -->
        <div id="editModal" class="fixed inset-0 bg-black bg-opacity-50 flex justify-center items-center z-50 hidden">
            <div class="bg-white w-full max-w-3xl p-6 rounded-lg shadow-lg relative">
                <button onclick="closeEditModal()" class="absolute top-2 right-3 text-gray-600 hover:text-black text-xl">&times;</button>

                <form action="${pageContext.request.contextPath}/admin/account/edit" method="post" class="space-y-4">
                    <input type="hidden" name="id" value="${account.id()}" />
                    <input type="hidden" name="username" value="${account.username()}" />

                    <div class="grid grid-cols-2 gap-4">
                        <div>
                            <label class="block font-semibold mb-1">Email</label>
                            <input type="email" name="email" value="${account.email()}" class="w-full border rounded p-2"/>
                        </div>

                        <div>
                            <label class="block font-semibold mb-1">Gender</label>
                            <input type="text" name="gender" value="${account.gender()}" class="w-full border rounded p-2"/>
                        </div>

                        <div>
                            <label class="block font-semibold mb-1">DOB</label>
                            <input type="date" name="dob" value="${account.dob()}" class="w-full border rounded p-2"/>
                        </div>
                    </div>

                    <div class="text-right">
                        <button type="submit" class="mt-6 bg-green-600 hover:bg-green-700 text-white px-6 py-2 rounded">
                            Save Changes
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </main>
</admin:base>

<script>
        function openEditModal() {
        document.getElementById("editModal").classList.remove("hidden");
    }

        function closeEditModal() {
        document.getElementById("editModal").classList.add("hidden");
    }
</script>

