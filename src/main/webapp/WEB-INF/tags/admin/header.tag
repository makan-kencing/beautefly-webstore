<%@ tag description="Admin Header" pageEncoding="UTF-8" %>
<%@ attribute name="pageTitle" required="false" type="java.lang.String" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<jsp:useBean id="user" type="com.lavacorp.beautefly.webstore.security.dto.AccountContextDTO" scope="request"/>

<header>
    <nav>
        <div class="bg-gray-900 text-white p-5 flex items-center">
            <h1 class="text-xl font-bold mr-auto">${initParam["company.name"]} Admin Panel</h1>

            <div>
                <button type="button" popovertarget="settings">
                    ${user.username()}
                    <i class="fa-solid fa-chevron-down ml-1"></i>
                </button>
            </div>
        </div>

        <div class="px-4 py-2 bg-gray-100">
            <ul class="flex text-sm
                **:[a]:block **:[a]:px-3 **:[a]:py-2 *:border-b-2 *:border-gray-300 *:hover:bg-gray-200
                *:data-selected:bg-blue-200 *:data-selected:border-blue-300">
                <li ${pageTitle == "Dashboard" ? "data-selected" : ""}>
                    <a href="<c:url value='/admin' />">
                        <i class="fa-solid fa-gauge-high mr-2"></i>
                        Dashboard
                    </a>
                </li>
                <li ${pageTitle == "Accounts" ? "data-selected" : ""}>
                    <a href="<c:url value='/admin/accounts' />">
                        <i class="fa-solid fa-users mr-2"></i>
                        Accounts
                    </a>
                </li>
                <li ${pageTitle == "Products" ? "data-selected" : ""}>
                    <a href="<c:url value='/admin/products' />">
                        <i class="fa-solid fa-boxes-stacked mr-2"></i>
                        Products
                    </a>
                </li>
                <li ${pageTitle == "Orders" ? "data-selected" : ""}>
                    <a href="<c:url value='/admin/orders' />">
                        <i class="fa-solid fa-truck mr-2"></i>
                        Orders
                    </a>
                </li>
                <li ${pageTitle == "View Logs" ? "data-selected" : ""}>
                    <a href="<c:url value='/admin/logs' />">
                        <i class="fa-solid fa-book mr-2"></i>
                        View Logs
                    </a>
                </li>
                <li ${pageTitle == "Reports" ? "data-selected" : ""}>
                    <a href="<c:url value='/admin/report' />">
                        <i class="fa-solid fa-clipboard mr-2"></i>
                        Reports
                    </a>
                </li>
            </ul>
        </div>

        <%-- settings popup --%>
        <div id="settings" popover role="menu" style="position-area: bottom span-left"
             class="mt-2 p-1 border-gray-500 shadow w-60">
            <h3 class="py-1 px-2 text-sm">Settings</h3>
            <ul class="*:hover:bg-gray-200 *:transition **:[a]:py-1 **:[a]:px-4">
                <li>
                    <a href="<c:url value='/admin/settings' />">
                        <i class="fa-solid fa-user-gear mr-1"></i> Account Settings
                    </a>
                </li>
                <li class="px-1! hover:bg-transparent!">
                    <hr class="text-gray-300">
                </li>
                <li>
                    <a href="<c:url value='/logout' />">
                        <i class="fa-solid fa-right-from-bracket mr-1"></i> Logout
                    </a>
                </li>
            </ul>
        </div>
    </nav>
</header>
