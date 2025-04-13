<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags/admin" %>
<script src="https://cdn.tailwindcss.com"></script>

<!DOCTYPE html>
<html>
<head>
    <title>Edit User</title>
</head>
<body class="p-6 bg-gray-50 min-h-screen">
<my:header />
<my:adminNavBar />

<h2 class="text-2xl font-bold mb-4">Edit User</h2>

<form method="post" action="/admin/users/edit">
    <input type="hidden" name="username" value="${user.username}" />

    <div class="grid grid-cols-2 gap-4 bg-white p-6 rounded shadow mb-6">
        <div>
            <label class="block font-medium">First Name</label>
            <input type="text" name="firstName" value="${user.firstName}" class="border p-2 rounded w-full"/>
        </div>

        <div>
            <label class="block font-medium">Last Name</label>
            <input type="text" name="lastName" value="${user.lastName}" class="border p-2 rounded w-full"/>
        </div>

        <div>
            <label class="block font-medium">Phone</label>
            <input type="text" name="phone" value="${user.phone}" class="border p-2 rounded w-full"/>
        </div>

        <div>
            <label class="block font-medium">Gender</label>
            <input type="text" name="gender" value="${user.gender}" class="border p-2 rounded w-full"/>
        </div>

        <div class="col-span-2">
            <label class="block font-medium">Profile Image URL</label>
            <input type="text" name="profileImageUrl" value="${user.profileImageUrl}" class="border p-2 rounded w-full"/>
        </div>

        <div class="col-span-2">
            <label class="block font-medium">Recipient Name</label>
            <input type="text" name="recipientName" value="${user.addressBook.defaultAddress.name}" class="border p-2 rounded w-full"/>
        </div>

        <div>
            <label class="block font-medium">Contact No</label>
            <input type="text" name="contactNo" value="${user.addressBook.defaultAddress.contactNo}" class="border p-2 rounded w-full"/>
        </div>

        <div>
            <label class="block font-medium">Address 1</label>
            <input type="text" name="address1" value="${user.addressBook.defaultAddress.address1}" class="border p-2 rounded w-full"/>
        </div>

        <div>
            <label class="block font-medium">Address 2</label>
            <input type="text" name="address2" value="${user.addressBook.defaultAddress.address2}" class="border p-2 rounded w-full"/>
        </div>

        <div>
            <label class="block font-medium">Address 3</label>
            <input type="text" name="address3" value="${user.addressBook.defaultAddress.address3}" class="border p-2 rounded w-full"/>
        </div>

        <div>
            <label class="block font-medium">Postcode</label>
            <input type="text" name="postcode" value="${user.addressBook.defaultAddress.postcode}" class="border p-2 rounded w-full"/>
        </div>

        <div>
            <label class="block font-medium">State</label>
            <input type="text" name="state" value="${user.addressBook.defaultAddress.state}" class="border p-2 rounded w-full"/>
        </div>

        <div>
            <label class="block font-medium">Country</label>
            <input type="text" name="country" value="${user.addressBook.defaultAddress.country}" class="border p-2 rounded w-full"/>
        </div>

        <div>
            <label class="inline-flex items-center">
                <input type="checkbox" name="active" ${user.active ? "checked" : ""} class="mr-2"/>
                Active
            </label>
        </div>
    </div>

    <div class="text-right">
        <button type="submit" class="bg-blue-600 text-white px-6 py-2 rounded hover:bg-blue-700">Save Changes</button>
    </div>
</form>

</body>
</html>
