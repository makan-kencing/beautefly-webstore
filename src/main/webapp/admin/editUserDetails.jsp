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
            <div>
                <label class="block font-semibold mb-1">Profile Image URL</label>
                <input type="text" name="profileImageUrl" value="${user.profileImageUrl}" class="w-full border rounded p-2" />
            </div>
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

        <div>
            <div>
                <label class="block font-semibold mb-1">Recipient Name</label>
                <input type="text" name="recipientName" value="${user.addressBook.defaultAddress.name}" class="w-full border rounded p-2" required />
            </div>

            <div>
                <label class="block font-semibold mb-1">Address Line 1</label>
                <input type="text" name="address1" value="${user.addressBook.defaultAddress.address1}" class="w-full border rounded p-2" required />
            </div>

            <div>
                <label class="block font-semibold mb-1">Address Line 2</label>
                <input type="text" name="address2" value="${user.addressBook.defaultAddress.address2}" class="w-full border rounded p-2" />
            </div>

            <div>
                <label class="block font-semibold mb-1">Address Line 3</label>
                <input type="text" name="address3" value="${user.addressBook.defaultAddress.address3}" class="w-full border rounded p-2" />
            </div>

            <div>
                <label class="block font-semibold mb-1">Postcode</label>
                <input type="text" name="postcode" value="${user.addressBook.defaultAddress.postcode}" class="w-full border rounded p-2" required />
            </div>

            <div>
                <label class="block font-semibold mb-1">State</label>
                <select name="state" class="w-full border p-2 rounded" required>
                    <option value="">-- Select State --</option>
                    <option value="Johor" ${user.addressBook.defaultAddress.state == 'Johor' ? 'selected' : ''}>Johor</option>
                    <option value="Kedah" ${user.addressBook.defaultAddress.state == 'Kedah' ? 'selected' : ''}>Kedah</option>
                    <option value="Kelantan" ${user.addressBook.defaultAddress.state == 'Kelantan' ? 'selected' : ''}>Kelantan</option>
                    <option value="Melaka" ${user.addressBook.defaultAddress.state == 'Melaka' ? 'selected' : ''}>Melaka</option>
                    <option value="Negeri Sembilan" ${user.addressBook.defaultAddress.state == 'Negeri Sembilan' ? 'selected' : ''}>Negeri Sembilan</option>
                    <option value="Pahang" ${user.addressBook.defaultAddress.state == 'Pahang' ? 'selected' : ''}>Pahang</option>
                    <option value="Penang" ${user.addressBook.defaultAddress.state == 'Penang' ? 'selected' : ''}>Penang</option>
                    <option value="Perak" ${user.addressBook.defaultAddress.state == 'Perak' ? 'selected' : ''}>Perak</option>
                    <option value="Perlis" ${user.addressBook.defaultAddress.state == 'Perlis' ? 'selected' : ''}>Perlis</option>
                    <option value="Sabah" ${user.addressBook.defaultAddress.state == 'Sabah' ? 'selected' : ''}>Sabah</option>
                    <option value="Sarawak" ${user.addressBook.defaultAddress.state == 'Sarawak' ? 'selected' : ''}>Sarawak</option>
                    <option value="Selangor" ${user.addressBook.defaultAddress.state == 'Selangor' ? 'selected' : ''}>Selangor</option>
                    <option value="Terengganu" ${user.addressBook.defaultAddress.state == 'Terengganu' ? 'selected' : ''}>Terengganu</option>
                    <option value="Kuala Lumpur" ${user.addressBook.defaultAddress.state == 'Kuala Lumpur' ? 'selected' : ''}>Kuala Lumpur</option>
                    <option value="Labuan" ${user.addressBook.defaultAddress.state == 'Labuan' ? 'selected' : ''}>Labuan</option>
                    <option value="Putrajaya" ${user.addressBook.defaultAddress.state == 'Putrajaya' ? 'selected' : ''}>Putrajaya</option>
                </select>
            </div>

            <div>
                <label class="block font-semibold mb-1">Country</label>
                <select name="country" class="w-full border p-2 rounded" required>
                    <option value="">-- Select Country --</option>
                    <option value="Malaysia" ${user.addressBook.defaultAddress.country == 'Malaysia' ? 'selected' : ''}>Malaysia</option>
                    <option value="Singapore" ${user.addressBook.defaultAddress.country == 'Singapore' ? 'selected' : ''}>Singapore</option>
                    <option value="Brunei" ${user.addressBook.defaultAddress.country == 'Brunei' ? 'selected' : ''}>Brunei</option>
                </select>
            </div>
        </div>
    </div>

    <button type="submit" class="mt-6 bg-green-600 hover:bg-green-700 text-white px-6 py-2 rounded">
        Save Changes
    </button>
</form>

<my:footer />
</body>
</html>
