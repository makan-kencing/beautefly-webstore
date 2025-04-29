<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="account" type="com.lavacorp.beautefly.webstore.admin.dto.AdminUserAccountDTO" scope="request"/>

<form action="${pageContext.request.contextPath}/admin/account/edit" method="post" class="grid gap-4 text-sm">
    <input type="hidden" name="id" value="${account.id()}"/>
    <input type="hidden" name="username" value="${account.username()}"/>

    <div>
        <label>Email</label>
        <input type="email" name="email" value="${account.email()}" class="w-full border p-2 rounded"/>
    </div>

    <div>
        <label>Gender</label>
        <input type="text" name="gender" value="${account.gender()}" class="w-full border p-2 rounded"/>
    </div>

    <div>
        <label>DOB</label>
        <input type="date" name="dob" value="${account.dob()}" class="w-full border p-2 rounded"/>
    </div>

    <div class="text-right">
        <button type="submit" class="bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded">💾 Save</button>
    </div>
</form>
