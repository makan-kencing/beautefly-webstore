<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="admin" tagdir="/WEB-INF/tags/admin" %>

<jsp:useBean id="account" type="com.lavacorp.beautefly.webstore.admin.dto.AdminUserAccountDTO" scope="request"/>

<admin:base pageTitle="Edit Account Details">
    <h2 class="text-2xl font-bold mb-6">Edit User Details</h2>

    <form action="${pageContext.request.contextPath}/admin/account/edit" method="post" class="w-full max-w-4xl bg-white p-6 rounded shadow">
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

        <input type="hidden" name="username" value="${account.username()}"/>

        <div class="grid grid-cols-2 gap-4">

            <input type="hidden" name="id" value="${account.id()}" />

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

        <button type="submit" class="mt-6 bg-green-600 hover:bg-green-700 text-white px-6 py-2 rounded">
            Save Changes
        </button>
    </form>
</admin:base>