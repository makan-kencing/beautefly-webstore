<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="webstore" tagdir="/WEB-INF/tags/webstore" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<c:set var="pageTitle" value="Order Details" />

<webstore:base pageTitle="${pageTitle}">
    <main class="py-10 px-6 max-w-6xl mx-auto min-h-screen flex flex-col">
        <account:sidebar pageTitle="${pageTitle}" />

        <div class="border p-6 rounded-lg flex-1">
            <!-- Back to History -->
            <div class="mb-6">
                <a href="/history"
                   class="text-sm text-gray-600 hover:text-black hover:underline flex items-center gap-1 transition">
                    ← Back to Order History
                </a>
            </div>

            <hr class="my-4">
            <c:set var="currentStatus" value="${order['status']}" />

            <!-- 自动判断当前步骤 -->
            <c:set var="steps" value="${[
  {'title': 'Order Placed', 'date': '03-03-2025 21:02', 'icon': 'https://img.icons8.com/ios-filled/50/000000/purchase-order.png', 'status': 'Order Placed'},
  {'title': 'Shipped Out', 'date': '03-03-2025 21:03', 'icon': 'https://img.icons8.com/ios-filled/50/000000/money.png', 'status': 'Shipped Out'},
  {'title': 'Out Of Delivery', 'date': '04-03-2025 13:51', 'icon': 'https://img.icons8.com/ios-filled/50/000000/delivery.png', 'status': 'Out Of Delivery'},
  {'title': 'Order Received', 'date': '09-03-2025 04:05', 'icon': 'https://img.icons8.com/ios-filled/50/000000/packing.png', 'status': 'Order Received'}
]}" />

            <c:set var="currentStepIndex" value="0" />
            <c:forEach var="step" items="${steps}" varStatus="loop">
                <c:if test="${fn:toLowerCase(fn:trim(step.status)) == fn:toLowerCase(fn:trim(order['status']))}">
                <c:set var="currentStepIndex" value="${loop.index}" />
                </c:if>
            </c:forEach>

            <div class="flex justify-between items-center mb-10">
                <c:forEach var="step" items="${steps}" varStatus="loop">
                    <div class="flex flex-col items-center flex-1">
                        <div class="
        w-14 h-14 rounded-full flex items-center justify-center
        ${loop.index <= currentStepIndex ? 'border-4 border-green-500' : 'border-4 border-gray-300'}
        bg-white">
                            <img src="${step.icon}" class="w-6 h-6" />
                        </div>
                        <p class="text-sm font-semibold mt-2">${step.title}</p>
                        <p class="text-xs text-gray-400">${step.date}</p>
                    </div>
                    <c:if test="${!loop.last}">
                        <div class="flex-1 h-1 ${loop.index < currentStepIndex ? 'bg-green-500' : 'bg-gray-300'}"></div>
                    </c:if>
                </c:forEach>
            </div>



            <!-- Order Header -->
            <div class="mb-8 text-center">
                <h1 class="text-3xl font-bold mb-1">Order Details</h1>
                <div class="flex flex-col sm:flex-row sm:justify-center sm:items-center gap-2 text-gray-500 text-sm">
                    <p>Order #: <span class="font-semibold text-black">${order.orderNumber}</span></p>
                    <span class="hidden sm:inline-block">|</span>
                    <p>Order Date: <span class="text-black">${order.orderDate}</span></p>
                </div>
            </div>

            <hr class="my-6" />

            <div class="grid grid-cols-1 md:grid-cols-2 ms-8 gap-8 mb-8">
                <div>
                    <h2 class="text-lg font-bold mb-2">Shipping Address</h2>
                    <p><span class="font-semibold">Name:</span> ${order.shippingName}</p>
                    <p><span class="font-semibold">Phone:</span> ${order.shippingPhone}</p>
                    <p><span class="font-semibold">Email:</span> buyer@example.com</p> <!-- Add email if available -->
                    <p><span class="font-semibold">Address:</span> ${order.shippingAddress}</p>
                </div>

                <div class="ms-8">
                    <h2 class="text-lg font-bold mb-2">Payment Details</h2>
                    <p><span class="font-semibold">Transaction ID:</span> TXN123456789</p>
                    <p><span class="font-semibold">Method:</span> ${order.paymentMethod}</p>
                    <p><span class="font-semibold">Address:</span> ${order.shippingAddress}</p>
                </div>
            </div>

            <!-- Product Section with Border -->
            <div class="mb-6 border-2 border-black-500 rounded-lg p-4">
                <h2 class="text-xl font-bold mb-4">Products</h2>
                <div class="space-y-6">
                    <c:forEach var="product" items="${order.products}">
                        <div class="flex items-center justify-between pb-1">
                            <div class="flex items-center gap-4">
                                <img src="${product.imageUrl}" alt="${product.name}" class="w-16 h-16 rounded object-cover" />
                                <div>
                                    <h3 class="font-semibold">${product.name}</h3>
                                    <p class="text-gray-500 text-sm">Product ID: P12345</p>
                                    <p class="text-gray-500 text-sm">Quantity: ${product.quantity}</p>
                                    <p class="text-gray-500 text-sm">Unit Price: RM <fmt:formatNumber value="${product.unitPrice}" type="number" minFractionDigits="2" /></p>
                                </div>
                            </div>
                            <div class="text-right">
                                <p class="font-bold">
                                    RM <fmt:formatNumber value="${product.subtotal}" type="number" minFractionDigits="2" />
                                </p>
                            </div>
                        </div>

                        <!-- Custom separator replacing the black line -->
                        <div class="my-4">
                            <svg viewBox="0 0 100 10" preserveAspectRatio="none" class="w-full h-4 text-gray-500">
                                <path d="M0,5 Q5,0 10,5 T20,5 T30,5 T40,5 T50,5 T60,5 T70,5 T80,5 T90,5 T100,5"
                                      fill="transparent" stroke="currentColor" stroke-width="1" />
                            </svg>
                        </div>
                    </c:forEach>
                </div>

                <!-- Totals inside border -->
                <div class="text-right space-y-1 pt-6 mt-6">
                    <p class="text-gray-600">Subtotal: RM <fmt:formatNumber value="${order.subtotal}" type="number" minFractionDigits="2" /></p>
                    <p class="text-gray-600">Shipping Fee: RM <fmt:formatNumber value="${order.shippingFee}" type="number" minFractionDigits="2" /></p>
                    <p class="text-xl font-bold text-gray-900 pt-2">Total: RM <fmt:formatNumber value="${order.totalAmount}" type="number" minFractionDigits="2" /></p>
                </div>
            </div>


        </div>
    </main>
</webstore:base>
