<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="admin" tagdir="/WEB-INF/tags/admin" %>

<admin:base pageTitle="Orders">
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
                <td class="p-2 border">${loop.index + 1}</td>
                <td class="p-2 border">${order.account.username}</td>
                <td class="p-2 border">${order.orderedAt}</td>
                <td class="p-2 border">${order.status}</td>
                <td class="p-2 border">${order.paymentMethod}</td>
                <td class="p-2 border">RM ${order.netAmount}</td>
                <td class="p-2 border">
                    <a href="<c:url value='/admin/order/${order.id}' />" class="text-blue-600 hover:underline">View</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</admin:base>