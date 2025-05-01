<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="admin" tagdir="/WEB-INF/tags/admin" %>

<jsp:useBean id="stats" type="com.lavacorp.beautefly.webstore.admin.dashboard.dto.DashboardStatsDTO" scope="request" />

<admin:base pageTitle="Dashboard">
    <jsp:attribute name="includeHead">
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    </jsp:attribute>

    <jsp:body>

        <main class="p-6">
            <!-- Header -->
            <div class="flex justify-between items-center mb-6">
                <h1 class="text-2xl font-bold">Admin Dashboard</h1>

                <div class="relative">
                    <button id="notificationBtn" class="relative focus:outline-none">
                        <svg class="w-8 h-8 text-gray-600 hover:text-gray-800" fill="none" stroke="currentColor"
                             viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round"
                                  d="M15 17h5l-1.405-1.405A2.032 2.032 0 0118 14.158V11a6.002 6.002 0 00-4-5.659V5a2 2 0 10-4 0v.341C8.67 6.165 8 7.388 8 8.75v5.408c0 .538-.214 1.055-.595 1.436L6 17h5m4 0v1a3 3 0 11-6 0v-1m6 0H9"></path>
                        </svg>
                        <span id="notificationPing"
                              class="absolute top-0 right-0 h-3 w-3 bg-red-600 rounded-full animate-ping"></span>
                        <span id="notificationDot"
                              class="absolute top-0 right-0 h-3 w-3 bg-red-600 rounded-full"></span>
                    </button>
                    <div id="notificationMenu"
                         class="hidden absolute right-0 mt-2 w-48 bg-white border rounded shadow-lg">
                        <a href="<c:url value='/admin/orders' />" class="block px-4 py-2 hover:bg-gray-100">📦 New Orders</a>
                        <a href="<c:url value='/admin/accounts' />" class="block px-4 py-2 hover:bg-gray-100">👤 New Users</a>
                        <a href="#" class="block px-4 py-2 hover:bg-gray-100">🔔 View All</a>
                    </div>
                </div>
            </div>

            <!-- Tabs -->
            <div class="flex gap-4 mb-6">
                <button class="tab-button bg-blue-100 text-blue-700 font-semibold px-4 py-2 rounded active"
                        data-type="daily">Daily Sales
                </button>
                <button class="tab-button bg-gray-100 text-gray-700 font-semibold px-4 py-2 rounded"
                        data-type="monthly">Monthly Sales
                </button>
                <button class="tab-button bg-gray-100 text-gray-700 font-semibold px-4 py-2 rounded" data-type="total">
                    Total Sales
                </button>
            </div>

            <!-- Chart -->
            <div class="bg-white p-6 rounded shadow relative">
                <canvas id="salesChart" height="100"></canvas>
                <div id="legend-container" class="flex mt-4"></div>
            </div>

            <!-- Summary Cards -->
            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6 mt-6">
                <div class="p-6 bg-white rounded shadow text-center">
                    <h3 class="text-lg font-semibold mb-2">Total Users</h3>
                    <p class="text-2xl font-bold">${stats.totalUsers}</p>
                </div>
                <div class="p-6 bg-white rounded shadow text-center">
                    <h3 class="text-lg font-semibold mb-2">Total Sales</h3>
                    <p class="text-2xl font-bold">$${stats.totalSales}</p>
                </div>
                <div class="p-6 bg-white rounded shadow text-center">
                    <h3 class="text-lg font-semibold mb-2">Today's Sales</h3>
                    <p class="text-2xl font-bold">$${stats.todaySales}</p>
                </div>
            </div>
        </main>

        <script>
            let chartInstance = null;

            function loadChart(type) {
                fetch('/admin/salesData?type=' + type)
                    .then(response => response.json())
                    .then(data => {
                        console.log('Fetched data:', data);

                        const ctx = document.getElementById('salesChart').getContext('2d');

                        if (chartInstance) {
                            chartInstance.destroy();
                        }

                        const chartType = (type === 'total') ? 'bar' : 'line';

                        chartInstance = new Chart(ctx, {
                            type: chartType,
                            data: {
                                labels: data.categories,
                                datasets: [
                                    {
                                        label: (type === 'total') ? 'Total Sales (RM)' : 'Sales (RM)',
                                        data: data.sales,
                                        backgroundColor: chartType === 'bar' ? 'rgba(54, 162, 235, 0.5)' : 'rgba(255, 99, 132, 0.7)',
                                        borderColor: 'rgba(255, 99, 132, 1)',
                                        tension: chartType === 'line' ? 0.4 : 0,
                                        fill: false,
                                        pointBackgroundColor: chartType === 'line' ? 'white' : undefined,
                                        pointBorderColor: chartType === 'line' ? 'rgba(255, 99, 132, 1)' : undefined,
                                        pointBorderWidth: chartType === 'line' ? 2 : undefined,
                                    }
                                ]
                            },
                            options: {
                                scales: {
                                    y: {
                                        beginAtZero: true
                                    }
                                }
                            }
                        });
                    })
                    .catch(err => console.error('Chart load error:', err));
            }

            document.querySelectorAll('.tab-button').forEach(btn => {
                btn.addEventListener('click', function () {
                    document.querySelectorAll('.tab-button').forEach(b => b.classList.remove('bg-blue-100', 'text-blue-700', 'active'));
                    this.classList.add('bg-blue-100', 'text-blue-700', 'active');

                    const type = this.getAttribute('data-type');
                    loadChart(type);
                });
            });

            loadChart('daily');
        </script>
    </jsp:body>
</admin:base>




