<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags/admin" %>
<script src="https://cdn.tailwindcss.com"></script>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Address</title>
</head>
<body class="p-6 bg-gray-50 min-h-screen">
<my:header />
<my:adminNavBar />

<h2 class="text-2xl font-bold mb-6">Edit Address</h2>

<form action="/admin/users/update-address" method="post" class="w-full max-w-3xl bg-white p-6 rounded shadow">
    <input type="hidden" name="username" value="${user.username}" />

    <div class="grid grid-cols-2 gap-4">
        <div>
            <label class="block font-semibold mb-1">Recipient Name</label>
            <input type="text" name="recipientName" value="${user.addressBook.defaultAddress.name}" class="w-full border rounded p-2" required />
        </div>

        <div>
            <label class="block font-semibold mb-1">Contact Number</label>
            <input type="text" name="contactNo" value="${user.addressBook.defaultAddress.contactNo}" class="w-full border rounded p-2" required />
        </div>

        <div class="col-span-2">
            <label class="block font-semibold mb-1">Address Line 1</label>
            <input type="text" name="address1" value="${user.addressBook.defaultAddress.address1}" class="w-full border rounded p-2" required />
        </div>

        <div class="col-span-2">
            <label class="block font-semibold mb-1">Address Line 2</label>
            <input type="text" name="address2" value="${user.addressBook.defaultAddress.address2}" class="w-full border rounded p-2" />
        </div>

        <div class="col-span-2">
            <label class="block font-semibold mb-1">Address Line 3</label>
            <input type="text" name="address3" value="${user.addressBook.defaultAddress.address3}" class="w-full border rounded p-2" />
        </div>

        <div>
            <label class="block font-semibold mb-1">Postcode</label>
            <input type="text" name="postcode" value="${user.addressBook.defaultAddress.postcode}" class="w-full border rounded p-2" required />
        </div>

        <div>
            <label class="block font-semibold mb-1">State</label>
            <input type="text" name="state" value="${user.addressBook.defaultAddress.state}" class="w-full border rounded p-2" required />
        </div>

        <div>
            <label class="block font-semibold mb-1">Country</label>
            <input type="text" name="country" value="${user.addressBook.defaultAddress.country}" class="w-full border rounded p-2" required />
        </div>
    </div>

    <button type="submit" class="mt-6 bg-blue-600 hover:bg-blue-700 text-white px-6 py-2 rounded">
        Save Address
    </button>
</form>

<my:footer />
</body>
</html>
