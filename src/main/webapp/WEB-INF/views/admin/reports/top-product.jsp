<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="admin" tagdir="/WEB-INF/tags/admin" %>

<admin:base pageTitle="Top Selling Products">

    <h2 class="text-2xl font-bold mb-6">📊 Top 10 Best-Selling Products</h2>

    <form method="get" action="/admin/reports" class="mb-6 flex gap-4 items-end">
        <div>
            <label class="block font-semibold mb-1">From Date:</label>
            <input type="date" name="from" value="${from}" class="border p-2 rounded" required/>
        </div>
        <div>
            <label class="block font-semibold mb-1">To Date:</label>
            <input type="date" name="to" value="${to}" class="border p-2 rounded" required/>
        </div>
        <button type="submit" class="bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700">
            Generate Report
        </button>
    </form>

    <c:if test="${not empty topProducts}">
        <table class="min-w-full bg-white shadow-md rounded text-sm">
            <thead class="bg-gray-200">
            <tr>
                <th class="p-3 text-left">#</th>
                <th class="p-3 text-left">Product Name</th>
                <th class="p-3 text-left">Total Sales (RM)</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="item" items="${topProducts}" varStatus="loop">
                <tr class="border-b">
                    <td class="p-3">${loop.index + 1}</td>
                    <td class="p-3">${item[0]}</td>
                    <td class="p-3">RM ${item[1]}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </c:if>

    <c:if test="${empty topProducts}">
        <p class="text-gray-500 mt-4">No records found for the selected date range.</p>
    </c:if>
</admin:base>