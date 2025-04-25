<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="admin" tagdir="/WEB-INF/tags/admin" %>

<jsp:useBean id="orders" type="java.util.List<com.lavacorp.beautefly.webstore.order.dto.OrderDetailsDTO>"
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
                        <th>#</th>
                        <th class="dt-body-left">Customer</th>
                        <th>Items</th>
                        <th>Shipments</th>
                        <th>Order Status</th>
                        <th>Ordered At</th>
                        <th>Total Price (RM)</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="order" items="${orders}">
                        <tr data-href="<c:url value='/admin/order/${order.id()}' />" onclick="window.location = this.dataset.href">
                            <td>#${order.id()}</td>
                            <td>
                                <img src="<c:url value='${order.account().profileImage().url()}' />" alt="">
                                <span>${order.account().username()}</span>
                            </td>
                            <td>${order.products().size()}</td>
                            <td>
                                <div>
                                    <p class="text-center">
                                            ${order.products().stream().filter(p -> p.status == "DELIVERED").count()}
                                        /
                                            ${order.products().size()}
                                    </p>
                                    <div class="rounded-full flex *:flex-1">
                                        <c:forEach var="item" items="${order.products()}">
                                            <c:choose>
                                                <c:when test="">
                                                    <div class="bg-good"></div>
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="bg-border"></div>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:forEach>
                                    </div>
                                </div>
                            </td>
                            <td class="cell">
                                    <%-- reusing role color kek --%>
                                <span data-role="${order.status() ==  "COMPLETED" ? "USER" : "STAFF"}">
                                        ${order.status()}
                                </span>
                            </td>
                            <td>${order.orderedAt()}</td>
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
                        order: [[0, 'asc']],
                        columnDefs: [
                            {
                                targets: 3,
                                orderable: false
                            }
                        ]
                    })
                </script>
            </div>
        </main>
    </jsp:body>
</admin:base>
