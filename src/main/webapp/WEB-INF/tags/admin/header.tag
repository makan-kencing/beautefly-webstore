<%@ tag description="Admin Header" pageEncoding="UTF-8" %>

<header>
    <div class="bg-gray-900 text-white p-4">
        <h1 class="text-xl font-bold">Beautefly Admin Panel</h1>
    </div>
    <nav>
        <ul class="flex gap-6 text-sm px-4 py-3 bg-gray-100 *:hover:underline">
            <li><a href="${pageContext.request.contextPath}/admin">Dashboard</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/accounts">Accounts</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/products">Products</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/logs">View Logs</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/report">Reports</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/settings">Settings</a></li>
        </ul>
    </nav>
</header>
