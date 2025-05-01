<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="admin" tagdir="/WEB-INF/tags/admin" %>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<admin:base pageTitle="Tax Collected Report">
    <h2 class="text-2xl font-bold mb-6">💰 Monthly Tax Collected Report</h2>

    <c:if test="${not empty taxPerMonth}">
        <div class="my-6 flex justify-center">
            <div style="width: 800px; height: 400px;">
                <canvas id="taxChart"></canvas>
            </div>
        </div>

        <table class="min-w-full bg-white shadow-md rounded text-sm mt-6">
            <thead class="bg-gray-200">
            <tr>
                <th class="p-3 text-left">Month</th>
                <th class="p-3 text-left">Total Tax Collected (RM)</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="entry" items="${taxPerMonth}">
                <tr class="border-b">
                    <td class="p-3">${entry.key}</td>
                    <td class="p-3">RM ${entry.value}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>

        <script>
            const taxLabels = [
                <c:forEach var="entry" items="${taxPerMonth}" varStatus="loop">
                "${entry.key}"<c:if test="${!loop.last}">,</c:if>
                </c:forEach>
            ];
            const taxData = [
                <c:forEach var="entry" items="${taxPerMonth}" varStatus="loop">
                ${entry.value}<c:if test="${!loop.last}">,</c:if>
                </c:forEach>
            ];

            new Chart(document.getElementById("taxChart").getContext("2d"), {
                type: "bar",
                data: {
                    labels: taxLabels,
                    datasets: [{
                        label: "Total Tax Collected (RM)",
                        data: taxData,
                        backgroundColor: "#4F46E5"
                    }]
                },
                options: {
                    responsive: true,
                    plugins: {
                        legend: { display: false }
                    },
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            });
        </script>
    </c:if>

    <c:if test="${not empty taxPerMonth}">
        <form id="taxPdfForm" method="post" action="/admin/reports/tax/pdf">
            <input type="hidden" name="chartImage" id="chartImageInput" />
            <button type="submit" class="bg-red-600 text-white px-4 py-2 rounded hover:bg-red-700 mt-4">
                🧾 Download PDF
            </button>
        </form>
    </c:if>

    <script>
        const form = document.getElementById("taxPdfForm");
        form.addEventListener("submit", function (e) {
            e.preventDefault();

            const canvas = document.getElementById("taxChart");
            const imageBase64 = canvas.toDataURL("image/png");

            document.getElementById("chartImageInput").value = imageBase64;
            form.submit();
        });
    </script>

    <!-- No Records -->
    <c:if test="${empty taxPerMonth && not empty param.from}">
        <p class="text-gray-500 mt-4">No records found for the selected date range.</p>
    </c:if>
</admin:base>
