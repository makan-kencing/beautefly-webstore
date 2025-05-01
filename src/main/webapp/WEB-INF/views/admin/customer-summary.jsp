<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="admin" tagdir="/WEB-INF/tags/admin" %>

<admin:base pageTitle="Customer Summary Report">

    <h2 class="text-2xl font-bold mb-6">👥 Customer Summary Report</h2>

    <!-- Filter Form -->
    <form method="get" action="/admin/reports/customers" class="mb-6 flex gap-4 items-end">
        <div>
            <label class="block font-semibold mb-1">From Date:</label>
            <input type="date" name="from" value="${from}" class="border p-2 rounded" required />
        </div>
        <div>
            <label class="block font-semibold mb-1">To Date:</label>
            <input type="date" name="to" value="${to}" class="border p-2 rounded" required />
        </div>
        <button type="submit" class="bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700">
            Generate Report
        </button>
    </form>

    <!-- Results Table -->
    <c:if test="${not empty customers}">
        <table class="min-w-full bg-white shadow-md rounded text-sm">
            <thead class="bg-gray-200">
            <tr>
                <th class="p-3 text-left">#</th>
                <th class="p-3 text-left">Username</th>
                <th class="p-3 text-left">Email</th>
                <th class="p-3 text-left">Order Count</th>
                <th class="p-3 text-left">Total Spent (RM)</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="c" items="${customers}" varStatus="loop">
                <tr class="border-b">
                    <td class="p-3">${loop.index + 1}</td>
                    <td class="p-3">${c[0]}</td> <!-- username -->
                    <td class="p-3">${c[1]}</td> <!-- email -->
                    <td class="p-3">${c[2]}</td> <!-- order count -->
                    <td class="p-3">RM ${c[3]}</td> <!-- total spent -->
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </c:if>

    <!-- Download PDF Button -->
    <c:if test="${not empty customers}">
        <form method="post" action="/admin/reports/customers/pdf">
            <input type="hidden" name="from" value="${from}" />
            <input type="hidden" name="to" value="${to}" />
            <button type="submit" class="bg-red-600 text-white px-4 py-2 rounded hover:bg-red-700 mt-4">
                🧾 Download PDF
            </button>
        </form>
    </c:if>

    <!-- No Records -->
    <c:if test="${empty customers && not empty param.from}">
        <p class="text-gray-500 mt-4">No records found for the selected date range.</p>
    </c:if>

</admin:base>
