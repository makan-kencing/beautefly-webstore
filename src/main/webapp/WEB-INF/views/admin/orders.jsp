<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags/admin" %>
<script src="https://cdn.tailwindcss.com"></script>

<my:base pageTitle="Order List">
    <h2 class="text-2xl font-bold mb-6">Order List</h2>

    <table class="min-w-full border text-sm bg-white">
        <thead class="bg-gray-100">
        <tr>
            <th class="p-2 border">#</th>
            <th class="p-2 border">Customer</th>
            <th class="p-2 border">Date</th>
            <th class="p-2 border">Status</th>
            <th class="p-2 border">Payment</th>
            <th class="p-2 border">Net Amount (RM)</th>
            <th class="p-2 border">Action</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="order" items="${orders}" varStatus="loop">
            <tr class="border-b">
                <td class="p-2 border">${(currentPage - 1) * 50 + loop.index + 1}</td>
                <td class="p-2 border">${order.account.username}</td>
                <td class="p-2 border">${order.orderedAt}</td>
                <td class="p-2 border">${order.status}</td>
                <td class="p-2 border">${order.paymentMethod}</td>
                <td class="p-2 border">RM ${order.netAmount}</td>
                <td class="p-2 border">
                    <a href="/admin/orders/view?id=${order.id}" class="text-blue-600 hover:underline">View</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <!-- Pagination -->
    <div class="mt-6 flex justify-center items-center space-x-2">
        <c:if test="${currentPage > 1}">
            <a href="?page=${currentPage - 1}" class="px-3 py-1 border rounded hover:bg-gray-100">&laquo; Prev</a>
        </c:if>

        <c:forEach begin="1" end="${totalPages}" var="page">
            <a href="?page=${page}"
               class="px-3 py-1 border rounded hover:bg-gray-100
                      ${page == currentPage ? 'bg-blue-500 text-white font-semibold' : ''}">
                    ${page}
            </a>
        </c:forEach>

        <c:if test="${currentPage < totalPages}">
            <a href="?page=${currentPage + 1}" class="px-3 py-1 border rounded hover:bg-gray-100">Next &raquo;</a>
        </c:if>
    </div>
</my:base>
