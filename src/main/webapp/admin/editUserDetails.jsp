<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags/admin" %>
<script src="https://cdn.tailwindcss.com"></script>

<!DOCTYPE html>
<html>
<head>
    <title>Edit User Details</title>
</head>
<body class="p-6 bg-gray-50 min-h-screen">
<my:header />
<my:adminNavBar />

<h2 class="text-2xl font-bold mb-6">Edit User Details</h2>

<form action="/admin/users/edit" method="post" class="w-full max-w-4xl bg-white p-6 rounded shadow">
    <input type="hidden" name="username" value="${user.username}" />

    <div class="grid grid-cols-2 gap-4">
        <div>
            <label class="block font-semibold mb-1">Profile Image URL</label>
            <input type="text" name="profileImageUrl" value="${user.profileImageUrl}" class="w-full border rounded p-2" />
        </div>

        <div>
            <label class="block font-semibold mb-1">First Name</label>
            <input type="text" name="firstName" value="${user.firstName}" class="w-full border rounded p-2" />
        </div>

        <div>
            <label class="block font-semibold mb-1">Last Name</label>
            <input type="text" name="lastName" value="${user.lastName}" class="w-full border rounded p-2" />
        </div>

        <div>
            <label class="block font-semibold mb-1">Email</label>
            <input type="email" name="email" value="${user.email}" class="w-full border rounded p-2" readonly />
        </div>

        <div>
            <label class="block font-semibold mb-1">Phone</label>
            <input type="text" name="phone" value="${user.phone}" class="w-full border rounded p-2" />
        </div>

        <div>
            <label class="block font-semibold mb-1">Gender</label>
            <input type="text" name="gender" value="${user.gender}" class="w-full border rounded p-2" />
        </div>

        <div>
            <label class="block font-semibold mb-1">DOB</label>
            <input type="date" name="dob" value="${user.dob}" class="w-full border rounded p-2" />
        </div>
    </div>

    <button type="submit" class="mt-6 bg-green-600 hover:bg-green-700 text-white px-6 py-2 rounded">
        Save Changes
    </button>
</form>

<my:footer />
</body>
</html>
