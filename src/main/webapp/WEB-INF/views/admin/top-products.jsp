<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="admin" tagdir="/WEB-INF/tags/admin" %>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<admin:base pageTitle="Top Products Report">

    <h2 class="text-2xl font-bold mb-6">📊 Top 10 Best-Selling Products</h2>

    <!-- Date Filter Form -->
    <form method="get" action="/admin/reports/top" class="mb-6 flex gap-4 items-end">
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

    <!-- Chart -->
    <c:if test="${not empty topProducts}">
        <div class="my-6 flex justify-center">
            <div style="width: 650px; height: 650px;">
                <canvas id="salesChart"></canvas>
            </div>
        </div>
    </c:if>

    <!-- Table -->
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

    <!-- Download PDF Button -->
    <c:if test="${not empty topProducts}">
        <form method="post" action="/admin/reports/pdf">
            <input type="hidden" name="from" value="${from}" />
            <input type="hidden" name="to" value="${to}" />
            <button type="submit" class="bg-red-600 text-white px-4 py-2 rounded hover:bg-red-700 mt-4">
                🧾 Download PDF
            </button>
        </form>
    </c:if>

    <c:if test="${empty topProducts && not empty param.from}">
        <p class="text-gray-500 mt-4">No records found for the selected date range.</p>
    </c:if>

</admin:base>

<!-- Chart Script -->
<c:if test="${not empty topProducts}">
    <script>
        const productNames = [
            <c:forEach var="item" items="${topProducts}" varStatus="loop">
            "${item[0]}"<c:if test="${!loop.last}">,</c:if>
            </c:forEach>
        ];
        const salesValues = [
            <c:forEach var="item" items="${topProducts}" varStatus="loop">
            ${item[1]}<c:if test="${!loop.last}">,</c:if>
            </c:forEach>
        ];
        const ctx = document.getElementById("salesChart").getContext("2d");
        new Chart(ctx, {
            type: "pie",
            data: {
                labels: productNames,
                datasets: [{
                    label: "Total Sales",
                    data: salesValues,
                    backgroundColor: [
                        "#4F46E5", "#EC4899", "#22C55E", "#F59E0B", "#6366F1",
                        "#E11D48", "#10B981", "#F97316", "#3B82F6", "#A855F7"
                    ],
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: true,
                plugins: {
                    legend: { position: "bottom" }
                }
            }
        });
    </script>
</c:if>
