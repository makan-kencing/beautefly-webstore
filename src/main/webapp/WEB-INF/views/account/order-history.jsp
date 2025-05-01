<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="account" tagdir="/WEB-INF/tags/account" %>
<%@ taglib prefix="webstore" tagdir="/WEB-INF/tags/webstore" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<jsp:useBean id="orders" type="java.util.List<com.lavacorp.beautefly.webstore.order.dto.OrderHistoryDTO>"
             scope="request"/>

<c:set var="pageTitle" value="My Orders"/>

<webstore:base pageTitle="${pageTitle}">
    <main class="flex min-h-screen ">
        <account:sidebar pageTitle="${pageTitle}"/>

        <div class="p-5 flex-1">


            <!-- Header -->
            <div class="flex justify-between items-center mb-4">
                <div>
                    <h1 class="text-4xl font-extrabold text-gray-900">Order History</h1>
                    <p class="text-gray-500 text-sm mt-1">Order History is track your purchases and view past orders</p>
                </div>
                <div class="flex flex-row items-end text-right">
                    <p class="text-3xl mx-2 text-gray-700 font-semibold">Total Orders:</p>
                    <p class="text-4xl font-extrabold text-indigo-300" id="orderCount">${orders.size()}</p>
                </div>
            </div>

                <%--    <!-- Summary Cards -->--%>
                <%--    <div class="max-w-300 min-h-1/4 mx-auto grid grid-cols-4 md:grid-cols-4 gap-12 mb-10">--%>
                <%--      <!-- Total Order -->--%>
                <%--      <div class="flex flex-row items-center gap-5 p-4 border border-gray-300 rounded-lg w-48">--%>
                <%--        <div class="flex flex-col items-center justify-center w-12 h-12 bg-indigo-100 rounded-full">--%>
                <%--          <img src="https://img.icons8.com/fluency/24/box.png" alt="Total Order" />--%>
                <%--        </div>--%>
                <%--        <div class="flex flex-col text-center">--%>
                <%--          <p class="text-lg font-bold text-black">36</p>--%>
                <%--          <p class="text-gray-500 text-sm">Total Orders</p>--%>
                <%--        </div>--%>
                <%--      </div>--%>

                <%--      <!-- Active Order (highlighted) -->--%>
                <%--      <div class="flex flex-row items-center gap-4 p-4 border border-gray-300 rounded-lg">--%>
                <%--        <div class="flex items-center justify-center w-12 h-12 bg-green-100 rounded-full">--%>
                <%--          <img src="https://img.icons8.com/color/24/open-box.png" alt="Active Order" />--%>
                <%--        </div>--%>
                <%--        <div class="flex flex-col text-center">--%>
                <%--          <p class="text-lg font-bold text-black">2</p>--%>
                <%--          <p class="text-gray-500 text-sm">Shipping</p>--%>
                <%--        </div>--%>
                <%--      </div>--%>

                <%--      <!-- Completed -->--%>
                <%--      <div class="flex flex-row items-center gap-4 p-4 border border-gray-300 rounded-lg">--%>
                <%--        <div class="flex items-center justify-center w-12 h-12 bg-yellow-100 rounded-full">--%>
                <%--          <img src="https://img.icons8.com/color/24/ok.png" alt="Completed" />--%>
                <%--        </div>--%>
                <%--        <div class="flex flex-col text-center">--%>
                <%--          <p class="text-lg font-bold text-black">24</p>--%>
                <%--          <p class="text-gray-500 text-sm">Completed</p>--%>
                <%--        </div>--%>
                <%--      </div>--%>

                <%--      <!-- Canceled -->--%>
                <%--      <div class="flex flex-row items-center gap-4 p-4 border border-gray-300 rounded-lg">--%>
                <%--        <div class="flex items-center justify-center w-12 h-12 bg-red-100 rounded-full">--%>
                <%--          <img src="https://img.icons8.com/color/24/cancel.png" alt="Canceled" />--%>
                <%--        </div>--%>
                <%--        <div class="flex flex-col text-center">--%>
                <%--          <p class="text-lg font-bold text-gray-400">12</p>--%>
                <%--          <p class="text-gray-400 text-sm">Canceled</p>--%>
                <%--        </div>--%>
                <%--      </div>--%>
                <%--    </div>--%>

            <!-- Tabs -->
            <div class="flex space-x-10 items-center text-gray-600 font-semibold border-b mb-5">
                <button class="tab-button flex items-center gap-2 py-3 font-medium text-gray-800 border-b-2 border-gray-800 transition"
                        onclick="filterOrders('All', event)">
                    <img src="https://img.icons8.com/ios-filled/20/grid.png" alt="All"/>
                    Show All
                </button>

                <button class="tab-button flex items-center gap-2 py-3 font-medium text-gray-500 transition hover:text-gray-800"
                        onclick="filterOrders('ARRIVING', event)">
                    <img src="https://img.icons8.com/fluency-systems-filled/20/000000/shopping-cart.png"
                         alt="OrderPlaced"/>
                    Order Placed
                </button>

                <button class="tab-button flex items-center gap-2 py-3 font-medium text-gray-500 transition hover:text-gray-800"
                        onclick="filterOrders('COMPLETED', event)">
                    <img src="https://img.icons8.com/fluency-systems-filled/20/checked--v1.png" alt="OrderReceived"/>
                    Order Received
                </button>
            </div>

            <!-- Order List -->
            <div id="orderList" class="space-y-8">
                <c:forEach var="order" items="${orders}">
                    <jsp:useBean id="order" type="com.lavacorp.beautefly.webstore.order.dto.OrderHistoryDTO"/>

                    <a href="<c:url value='/order/${order.id()}' />"
                       class="block mb-4 order-card"
                       data-status="${order.status()}">
                        <div class="border rounded-lg p-6 shadow-sm hover:shadow-md transition">
                            <!-- Order Header -->
                            <div class="flex justify-between items-center border-b border-gray-500 pb-2 mb-4">
                                <!-- 左边 (Order ID + Ship To) -->
                                <div class="flex items-center gap-24 text-sm text-gray-500">
                                    <span>Order  <span class="font-medium text-gray-700">#${order.id()}</span></span>
                                    <span>Ship to: <span
                                            class="font-medium text-gray-700">${order.shippingAddress().name()}</span></span>
                                </div>

                                <!-- 右边 (Order Time) -->
                                <div class="text-sm text-gray-500">
                                    <fmt:parseDate var="parsedDate" value="${order.orderedAt()}" timeZone="UTC"
                                                   pattern="yyyy-MM-dd'T'HH:mm" type="both"/>

                                    Ordered: <span class="font-medium text-gray-700">
                                    <fmt:formatDate value="${parsedDate}" pattern="yyyy-MM-dd HH:mm"/>
                                </span>
                                </div>
                            </div>


                            <!-- Products List -->
                            <div class="space-y-6">
                                <c:forEach var="item" items="${order.items()}">
                                    <jsp:useBean id="item"
                                                 type="com.lavacorp.beautefly.webstore.order.dto.OrderHistoryItemDTO"/>

                                    <div class="flex justify-between items-center">
                                        <div class="flex items-center gap-4">
                                            <img src="${item.product().images()[0].url()}" alt=""
                                                 class="w-16 h-16 rounded object-cover"/>
                                            <div>
                                                <h3 class="font-semibold text-gray-900">${item.product().name()}</h3>
                                                <p class="text-gray-500 text-sm">Quantity: ${item.quantity()}</p>
                                                <p class="text-pink-600 text-sm font-semibold">Unit Price:
                                                    RM ${item.unitPrice()}</p>
                                            </div>
                                        </div>
                                        <div class="text-right font-bold text-gray-700">
                                            RM ${item.total()}
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>

                            <!-- Bottom Line -->
                            <div class="border-t border-gray-300 my-4"></div>

                            <!-- Total Amount -->
                            <div class="flex justify-end">
                                <p class="text-lg font-bold text-gray-900">Total: RM ${order.netAmount()}</p>
                            </div>
                        </div>
                    </a>
                </c:forEach>
            </div>
        </div>
    </main>

    <script>
        function filterOrders(status, event) {
            const orderCards = document.querySelectorAll('.order-card');
            let visibleCount = 0;

            orderCards.forEach(card => {
                const cardStatus = card.getAttribute('data-status');
                const show = (status === 'All' || cardStatus === status);
                card.style.display = show ? 'block' : 'none';
                if (show) visibleCount++;
            });

            // 更新按钮状态
            document.querySelectorAll('.tab-button').forEach(btn => {
                btn.classList.remove('text-gray-800', 'border-b-2', 'border-gray-800');
                btn.classList.add('text-gray-500');
            });
            event.currentTarget.classList.add('text-gray-800', 'border-b-2', 'border-gray-800');
            event.currentTarget.classList.remove('text-gray-500');

            // 更新订单总数
            document.getElementById('orderCount').textContent = visibleCount;
        }
    </script>
</webstore:base>


