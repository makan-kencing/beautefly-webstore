<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="webstore" tagdir="/WEB-INF/tags/webstore" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:useBean id="order" type="com.lavacorp.beautefly.webstore.order.dto.OrderDetailsDTO" scope="request"/>

<c:set var="pageTitle" value="Order Details"/>

<webstore:base pageTitle="${pageTitle}">
    <main class="py-10 px-6 max-w-6xl mx-auto min-h-screen flex flex-col">

        <div class="border p-6 rounded-lg flex-1">
            <!-- Back to History -->
            <div class="mb-6">
                <a href="<c:url value='/orders' />"
                   class="text-sm text-gray-600 hover:text-black hover:underline flex items-center gap-1 transition">
                    ← Back to Order History
                </a>
            </div>

            <hr class="my-4">

            <div class="flex justify-between items-center mb-10">
                    <%-- Order Placed --%>
                <div class="flex flex-col items-center flex-1">
                    <fmt:parseDate var="parsedDate" value="${order.orderedAt()}" timeZone="UTC"
                                   pattern="yyyy-MM-dd'T'HH:mm" type="both"/>

                    <div class="w-14 h-14 rounded-full flex items-center justify-center border-4 border-gray-300 data-complete:border-green-500"
                         data-complete>
                        <img src="https://img.icons8.com/ios-filled/50/000000/purchase-order.png" alt=""
                             class="w-6 h-6"/>
                    </div>
                    <p class="text-sm font-semibold mt-2">Order Placed</p>
                    <p class="text-xs text-gray-400">
                        <fmt:formatDate value="${parsedDate}" pattern="yyyy-MM-dd HH:mm"/>
                    </p>
                </div>

                <div class="flex-1 h-1  bg-gray-300 data-complete:bg-green-500"
                    ${ order.shipped ? "data-complete" : ""}>
                </div>

                    <%-- Shipped Out --%>
                <div class="flex flex-col items-center flex-1">
                    <fmt:parseDate var="parsedDate" value="${order.shippedAt()}" timeZone="UTC"
                                   pattern="yyyy-MM-dd'T'HH:mm" type="both"/>

                    <div class="w-14 h-14 rounded-full flex items-center justify-center border-4 border-gray-300 data-complete:border-green-500"
                        ${ order.shipped ? "data-complete" : ""}>
                        <img src="https://img.icons8.com/ios-filled/50/000000/money.png" alt="" class="w-6 h-6"/>
                    </div>
                    <p class="text-sm font-semibold mt-2">Shipped Out</p>
                    <p class="text-xs text-gray-400">
                        <fmt:formatDate value="${parsedDate}" pattern="yyyy-MM-dd HH:mm"/>
                    </p>
                </div>

                <div class="flex-1 h-1  bg-gray-300 data-complete:bg-green-500"
                    ${ order.delivering ? "data-complete" : ""}>
                </div>

                    <%-- Out For Delivery --%>
                <div class="flex flex-col items-center flex-1">
                    <fmt:parseDate var="parsedDate" value="${order.deliveryStartedAt()}" timeZone="UTC"
                                   pattern="yyyy-MM-dd'T'HH:mm" type="both"/>

                    <div class="w-14 h-14 rounded-full flex items-center justify-center border-4 border-gray-300 data-complete:border-green-500"
                        ${ order.delivering ? "data-complete" : ""}>
                        <img src="https://img.icons8.com/ios-filled/50/000000/delivery.png" alt="" class="w-6 h-6"/>
                    </div>
                    <p class="text-sm font-semibold mt-2">Out For Delivery</p>
                    <p class="text-xs text-gray-400">
                        <fmt:formatDate value="${parsedDate}" pattern="yyyy-MM-dd HH:mm"/>
                    </p>
                </div>

                <div class="flex-1 h-1  bg-gray-300 data-complete:bg-green-500"
                    ${ order.delivered ? "data-complete" : ""}>
                </div>

                    <%-- Order Received --%>
                <div class="flex flex-col items-center flex-1">
                    <fmt:parseDate var="parsedDate" value="${order.deliveredAt()}" timeZone="UTC"
                                   pattern="yyyy-MM-dd'T'HH:mm" type="both"/>


                    <div class="w-14 h-14 rounded-full flex items-center justify-center border-4 border-gray-300 data-complete:border-green-500"
                        ${ order.delivered ? "data-complete" : ""}>
                        <img src="https://img.icons8.com/ios-filled/50/000000/packing.png" alt="" class="w-6 h-6"/>
                    </div>
                    <p class="text-sm font-semibold mt-2">Order Received</p>
                    <p class="text-xs text-gray-400">
                        <fmt:formatDate value="${parsedDate}" pattern="yyyy-MM-dd HH:mm"/>
                    </p>
                </div>
            </div>

            <!-- Order Header -->
            <div class="mb-8 text-center">
                <h1 class="text-3xl font-bold mb-1">Order Details</h1>
                <div class="flex flex-col sm:flex-row sm:justify-center sm:items-center gap-2 text-gray-500 text-sm">
                    <fmt:parseDate var="parsedDate" value="${order.orderedAt()}" timeZone="UTC"
                                   pattern="yyyy-MM-dd'T'HH:mm" type="both"/>


                    <p>Order #: <span class="font-semibold text-black">${order.id()}</span></p>
                    <span class="hidden sm:inline-block">|</span>
                    <p>Order Date: <span class="text-black">
                        <fmt:formatDate value="${parsedDate}" pattern="yyyy-MM-dd HH:mm"/>
                    </span></p>
                </div>
            </div>

            <hr class="my-6"/>

            <div class="grid grid-cols-1 md:grid-cols-2 ms-8 gap-8 mb-8">
                <div>
                    <h2 class="text-lg font-bold mb-2">Shipping Address</h2>

                    <c:set var="address" value="${order.shippingAddress()}"/>
                    <jsp:useBean id="address" type="com.lavacorp.beautefly.webstore.account.dto.AddressDTO"/>

                    <div class="*:empty:hidden">
                        <h2 class="font-semibold">${address.name()}</h2>
                        <p>${address.address1()}</p>
                        <p>${address.address2()}</p>
                        <p>${address.address3()}</p>
                        <p>${address.city()}, ${address.state()}&ensp;${address.postcode()}</p>
                        <p>Phone number: ${address.contactNo()}</p>
                    </div>
                </div>

                <div class="ms-8">
                    <h2 class="text-lg font-bold mb-2">Payment Details</h2>
                    <p>
                        <span class="font-semibold">Method:</span>
                        <span class="capitalize">${order.paymentMethod()}</span>
                    </p>
                </div>
            </div>

            <!-- Product Section with Border -->
            <div class="mb-6 border-2 border-black-500 rounded-lg p-4">
                <h2 class="text-xl font-bold mb-4">Products</h2>
                <div class="space-y-6">
                    <c:forEach var="item" items="${order.products()}">
                        <jsp:useBean id="item" type="com.lavacorp.beautefly.webstore.order.dto.OrderItemDTO"/>

                        <div class="flex items-center justify-between pb-1">
                            <div class="flex items-center gap-4">
                                <img src="<c:url value='${item.product().images()[0].url()}' />" alt=""
                                     class="w-16 h-16 rounded object-cover"/>
                                <div>
                                    <h3 class="font-semibold">${item.product().name()}</h3>
                                    <p class="text-gray-500 text-sm">Product ID: #${item.product().id()}</p>
                                    <p class="text-gray-500 text-sm">Quantity: ${item.quantity()}</p>
                                    <p class="text-gray-500 text-sm">Unit Price: <fmt:formatNumber
                                            value="${item.unitPrice()}" type="currency" currencySymbol="RM "/></p>
                                </div>
                            </div>
                            <div class="text-right">
                                <p class="font-bold">
                                    <fmt:formatNumber value="${item.total()}" type="currency" currencySymbol="RM "/>
                                </p>
                            </div>
                        </div>

                        <!-- Custom separator replacing the black line -->
                        <div class="my-4">
                            <svg viewBox="0 0 100 10" preserveAspectRatio="none" class="w-full h-4 text-gray-500">
                                <path d="M0,5 Q5,0 10,5 T20,5 T30,5 T40,5 T50,5 T60,5 T70,5 T80,5 T90,5 T100,5"
                                      fill="transparent" stroke="currentColor" stroke-width="1"></path>
                            </svg>
                        </div>
                    </c:forEach>
                </div>

                <!-- Totals inside border -->
                <div class="text-right space-y-1 pt-6 mt-6">
                    <p class="text-gray-600">Subtotal:
                    <fmt:formatNumber value="${order.grossAmount()}" type="currency" currencySymbol="RM "/></p>
                    <p class="text-gray-600">Shipping Fee:
                    <fmt:formatNumber value="${order.shippingAmount()}" type="currency" currencySymbol="RM "/></p>
                    <p class="text-gray-600">Sales Tax:
                    <fmt:formatNumber value="${order.taxAmount()}" type="currency" currencySymbol="RM "/></p>
                    <p class="text-xl font-bold text-gray-900 pt-2">Total:
                    <fmt:formatNumber value="${order.netAmount()}" type="currency" currencySymbol="RM "/></p>
                </div>
            </div>
        </div>
    </main>
</webstore:base>
