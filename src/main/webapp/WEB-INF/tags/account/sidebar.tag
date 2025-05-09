<%@ tag description="User Account Sidebar" pageEncoding="UTF-8" %>
<%@ attribute name="pageTitle" required="true" type="java.lang.String" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="webstore" tagdir="/WEB-INF/tags/webstore" %>

<div class="w-64 bg-gray-100 border-r border-gray-300 overflow-y-auto p-5">
    <h2 class="text-xl font-semibold mb-6">Account</h2>
    <ul class="space-y-2 **:[a]:px-5 **:[a]:py-3 **:[a]:block *:rounded *:hover:bg-blue-100 *:data-selected:bg-blue-300">
        <li ${pageTitle == "Account Details" ? "data-selected" : ""}>
            <a href="<c:url value='/account' />">
                <i class="fa-solid fa-user mr-3"></i>
                Account Details
            </a>
        </li>
        <li ${pageTitle == "Addresses" ? "data-selected" : ""}>
            <a href="<c:url value='/addresses' />">
                <i class="fa-solid fa-address-book mr-3"></i>
                Addresses
            </a>
        </li>
        <li ${pageTitle == "Password" ? "data-selected" : ""}>
            <a href="<c:url value='/account/change-password' />">
                <i class="fa-solid fa-key mr-3"></i>
                Password
            </a>
        </li>
        <li ${pageTitle == "My Orders" ? "data-selected" : ""}>
            <a href="<c:url value='/orders' />">
                <i class="fa-solid fa-truck mr-3"></i>
                My Orders
            </a>
        </li>
    </ul>
</div>
