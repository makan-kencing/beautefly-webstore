<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="admin" tagdir="/WEB-INF/tags/admin" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:useBean id="prettyTime" class="org.ocpsoft.prettytime.PrettyTime" />

<jsp:useBean id="orders" type="java.util.List<com.lavacorp.beautefly.webstore.order.dto.OrderListingDTO>"
             scope="request"/>

<admin:base pageTitle="Orders">
    <jsp:attribute name="includeHead">
        <link href="https://cdn.datatables.net/2.2.2/css/dataTables.dataTables.min.css" rel="stylesheet"/>
        <link href="https://cdn.datatables.net/colreorder/2.0.4/css/colReorder.dataTables.min.css" rel="stylesheet"/>

        <script src="https://cdn.datatables.net/2.2.2/js/dataTables.min.js"></script>
        <script src="https://cdn.datatables.net/colreorder/2.0.4/js/dataTables.colReorder.min.js"></script>
    </jsp:attribute>

    <jsp:body>
        <main class="vertical p-4">
            <div class="border rounded-xl border-border shadow-md p-4">

                <h2 class="text-2xl font-bold">Manage Orders</h2>

                <table id="table" class="hover row-border nowrap">
                    <thead>
                    <tr>
                        <th class="dt-left">#</th>
                        <th>Customer</th>
                        <th>Items</th>
                        <th class="dt-center">Shipments</th>
                        <th>Order Status</th>
                        <th>Ordered At</th>
                        <th>Total Price (RM)</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="order" items="${orders}">
                        <c:set var="totalItems" value="${order.products().size()}" />
                        <c:set var="totalCompleted"
                               value="${order.products().stream().filter(p -> p.status() == 'DELIVERED').count()}"/>

                        <tr data-href="<c:url value='/admin/order/${order.id()}' />"
                            onclick="window.location = this.dataset.href">
                            <td data-order="${order.id()}">#${order.id()}</td>
                            <td data-search="${order.account().username()}">
                                <img src="<c:url value='${order.account().profileImage().url()}' />" alt="">
                                <span>${order.account().username()}</span>
                            </td>
                            <td data-order="${order.products().size()}">${order.products().size()}</td>
                            <td data-order="${totalCompleted / totalItems}">
                                <p class="text-xs text-center">${totalCompleted}/${totalItems}</p>
                                <div class="rounded-full overflow-hidden flex *:flex-1 h-2 gap-0.5">
                                    <c:forEach var="item" items="${order.products()}">
                                        <jsp:useBean id="item" type="com.lavacorp.beautefly.webstore.order.dto.OrderListingItemDTO"/>

                                        <c:choose>
                                            <c:when test="${item.status() == 'SHIPPED'}">
                                                <div class="bg-admin -order-1" title="${item.status()}"></div>
                                            </c:when>
                                            <c:when test="${item.status() == 'OUT_FOR_DELIVERY'}">
                                                <div class="bg-yellow-500 -order-2" title="${item.status()}"></div>
                                            </c:when>
                                            <c:when test="${item.status() == 'DELIVERED'}">
                                                <div class="bg-good -order-3" title="${item.status()}"></div>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="bg-border" title="${item.status()}"></div>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                </div>
                            </td>
                            <td data-search="${order.status()}" data-order="${order.status()}" class="cell">
                                    <%-- reusing role color kek --%>
                                <span data-cell data-role="${order.status() ==  "COMPLETED" ? "USER" : "STAFF"}">
                                        ${order.status()}
                                </span>
                            </td>
                            <td data-order="${order.orderedAt().toEpochMilli()}">
                                <fmt:parseDate var="parsedDate" value="${order.orderedAt()}" timeZone="UTC"
                                               pattern="yyyy-MM-dd'T'HH:mm" type="both"/>
                                <fmt:formatDate value="${parsedDate}" pattern="yyyy-MM-dd HH:mm" />
                                (${prettyTime.format(order.orderedAt())})
                            </td>
                            <td>${order.netAmount()}</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>

                <script>
                    const table = new DataTable("#table", {
                        layout: {
                            topStart: {
                                search: {
                                    text: "",
                                    placeholder: "Search orders..."
                                }
                            },
                            topEnd: {
                                pageLength: true
                            }
                        },
                        searching: true,
                        ordering: true,
                        colReorder: true,
                        pageLength: 50,
                        paging: true,
                        scrollX: true,
                        order: [[4, 'asc'], [5, 'asc']],
                        columnDefs: [
                            {
                                targets: 0,
                                className: "dt-left"
                            }
                        ]
                    })
                </script>
            </div>
        </main>
    </jsp:body>
</admin:base>
