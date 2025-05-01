<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="admin" tagdir="/WEB-INF/tags/admin" %>

<jsp:useBean id="account" type="com.lavacorp.beautefly.webstore.admin.account.dto.AdminUserAccountDTO" scope="request"/>
<jsp:useBean id="address" type="com.lavacorp.beautefly.webstore.account.dto.AddressDTO" scope="request"/>

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
        <table class="w-full max-w-4xl bg-white rounded shadow text-sm border border-gray-300">
            <tbody>
            <tr><td class="p-3 font-semibold w-1/3 bg-gray-50">Username:</td><td class="p-3">${account.username()}</td></tr>
            <tr><td class="p-3 font-semibold bg-gray-50">Email:</td><td class="p-3">${account.email()}</td></tr>
            <tr><td class="p-3 font-semibold bg-gray-50">Gender:</td><td class="p-3">${account.gender()}</td></tr>
            <tr><td class="p-3 font-semibold bg-gray-50">DOB:</td><td class="p-3">${account.dob()}</td></tr>
            <tr><td class="p-3 font-semibold bg-gray-50">Updated At:</td><td class="p-3">${account.createdAt()}</td></tr>

            <c:if test="${not empty address}">
                <tr><td class="p-3 font-semibold bg-gray-50">Full Name:</td><td class="p-3">${address.name()}</td></tr>
                <tr><td class="p-3 font-semibold bg-gray-50">Phone:</td><td class="p-3">${address.contactNo()}</td></tr>
                <tr>
                    <td class="p-3 font-semibold bg-gray-50">Address:</td>
                    <td class="p-3">
                            ${address.address1()}<br/>
                        <c:if test="${not empty address.address2()}">${address.address2()}<br/></c:if>
                        <c:if test="${not empty address.address3()}">${address.address3()}<br/></c:if>
                            ${address.postcode()} ${address.city()}, ${address.state()}, ${address.country()}
                    </td>
                </tr>
            </c:if>

            <tr><td class="p-3 font-semibold bg-gray-50">Active:</td>
                <td class="p-3">
                <span class="${account.active() ? 'text-green-600 font-semibold' : 'text-red-600 font-semibold'}">
                        ${account.active() ? "YES" : "NO"}
                </span>
                </td>
            </tr>

            <tr><td class="p-3 font-semibold bg-gray-50">Roles:</td>
                <td class="p-3 space-x-1">
                    <c:forEach var="role" items="${account.roles()}">
                        <c:set var="roleClass" value="bg-green-600" />
                        <c:choose>
                            <c:when test="${role.name() == 'ADMIN'}"><c:set var="roleClass" value="bg-red-600" /></c:when>
                            <c:when test="${role.name() == 'STAFF'}"><c:set var="roleClass" value="bg-blue-600" /></c:when>
                            <c:when test="${role.name() == 'USER'}"><c:set var="roleClass" value="bg-green-600" /></c:when>
                        </c:choose>
                        <span class="inline-block px-2 py-1 text-white text-xs rounded-full ${roleClass}">${role}</span>
                    </c:forEach>
                </td>
            </tr>

            <tr><td class="p-3 font-semibold bg-gray-50">Profile Picture:</td>
                <td class="p-3">
                    <img src="${pageContext.request.contextPath}${not empty account.profileImageHash()
                    ? '/upload/' += account.profileImageHash()
                    : '/static/default-profile.png'}"
                         class="w-20 h-20 object-cover rounded-full border"
                         alt="Profile"/>
                </td>
            </tr>
            </tbody>
        </table>

        <!-- 🔧 Edit User Modal -->
        <div id="editModal" class="fixed inset-0 bg-black bg-opacity-50 flex justify-center items-center z-50 hidden">
            <div class="bg-white w-full max-w-3xl p-6 rounded-lg shadow-lg relative">
                <button onclick="closeEditModal()" class="absolute top-2 right-3 text-gray-600 hover:text-black text-xl">&times;</button>

                <form action="${pageContext.request.contextPath}/admin/account/edit" method="post" class="space-y-6">
                    <input type="hidden" name="id" value="${account.id()}" />
                    <input type="hidden" name="username" value="${account.username()}" />
                    <input type="hidden" name="addressId" value="${address.id()}" />

                    <div class="grid grid-cols-2 gap-4">
                        <div>
                            <label class="block text-sm font-medium mb-1 text-gray-700">Email</label>
                            <input type="email" name="email" value="${account.email()}" class="w-full border border-gray-300 rounded-lg p-2"/>
                        </div>

                        <div>
                            <label class="block text-sm font-medium mb-1 text-gray-700">Gender</label>
                            <input type="text" name="gender" value="${account.gender()}" class="w-full border border-gray-300 rounded-lg p-2"/>
                        </div>

                        <div>
                            <label class="block text-sm font-medium mb-1 text-gray-700">Date of Birth</label>
                            <input type="date" name="dob" value="${account.dob()}" class="w-full border border-gray-300 rounded-lg p-2"/>
                        </div>

                        <div>
                            <label class="block text-sm font-medium mb-1 text-gray-700">Full Name</label>
                            <input type="text" name="name" value="${address.name()}" class="w-full border border-gray-300 rounded-lg p-2"/>
                        </div>

                        <div>
                            <label class="block text-sm font-medium mb-1 text-gray-700">Phone</label>
                            <input type="text" name="contactNo" value="${address.contactNo()}" class="w-full border border-gray-300 rounded-lg p-2"/>
                        </div>

                        <div>
                            <label class="block text-sm font-medium mb-1 text-gray-700">Address Line 1</label>
                            <input type="text" name="address1" value="${address.address1()}" class="w-full border border-gray-300 rounded-lg p-2"/>
                        </div>

                        <div>
                            <label class="block text-sm font-medium mb-1 text-gray-700">Address Line 2</label>
                            <input type="text" name="address2" value="${address.address2()}" class="w-full border border-gray-300 rounded-lg p-2"/>
                        </div>

                        <div>
                            <label class="block text-sm font-medium mb-1 text-gray-700">Address Line 3</label>
                            <input type="text" name="address3" value="${address.address3()}" class="w-full border border-gray-300 rounded-lg p-2"/>
                        </div>

                        <div>
                            <label class="block text-sm font-medium mb-1 text-gray-700">City</label>
                            <input type="text" name="city" value="${address.city()}" class="w-full border border-gray-300 rounded-lg p-2"/>
                        </div>

                        <div>
                            <label class="block text-sm font-medium mb-1 text-gray-700">State</label>
                            <input type="text" name="state" value="${address.state()}" class="w-full border border-gray-300 rounded-lg p-2"/>
                        </div>

                        <div>
                            <label class="block text-sm font-medium mb-1 text-gray-700">Postcode</label>
                            <input type="text" name="postcode" value="${address.postcode()}" class="w-full border border-gray-300 rounded-lg p-2"/>
                        </div>

                        <div>
                            <label class="block text-sm font-medium mb-1 text-gray-700">Country</label>
                            <input type="text" name="country" value="${address.country()}" class="w-full border border-gray-300 rounded-lg p-2"/>
                        </div>
                    </div>

                    <div class="text-right">
                        <button type="submit" class="bg-green-600 hover:bg-green-700 text-white px-6 py-2 rounded-lg">
                            ✅ Save Changes
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

