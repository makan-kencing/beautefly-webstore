<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="admin" tagdir="/WEB-INF/tags/admin" %>

<admin:base pageTitle="Reports Hub">

    <h2 class="text-2xl font-bold mb-6">📋 Choose a Report to View</h2>

    <ul class="space-y-4 text-lg">
        <li>
            <a href="/admin/reports/top" class="text-blue-600 hover:underline">
                🧾 Top 10 Best-Selling Products
            </a>
        </li>
        <li>
            <span class="text-gray-400">📦 Sales by Category (coming soon)</span>
        </li>
        <li>
            <a href="/admin/reports/customers" class="text-blue-600 hover:underline">
                👥 Customer Summary Report
            </a>
        </li>
        <li>
            <a href="/admin/reports/tax" class="text-blue-600 hover:underline">
                💰 Tax Collected Report
            </a>
        </li>
    </ul>

</admin:base>
