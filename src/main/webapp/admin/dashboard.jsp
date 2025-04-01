<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="p-6">
<my:adminNavBar />

<h1 class="text-2xl font-bold mb-4">Admin Dashboard</h1>

<div class="grid grid-cols-3 gap-6">
    <div class="border rounded p-4 bg-white shadow">
        <h3 class="text-lg font-semibold">Total Users</h3>
        <p class="text-xl mt-2">${stats.totalUsers}</p>
    </div>
    <div class="border rounded p-4 bg-white shadow">
        <h3 class="text-lg font-semibold">Total Sales</h3>
        <p class="text-xl mt-2">$${stats.totalSales}</p>
    </div>
    <div class="border rounded p-4 bg-white shadow">
        <h3 class="text-lg font-semibold">System Status</h3>
        <p class="text-xl mt-2">${stats.systemStatus}</p>
    </div>
</div>
</body>
</html>
