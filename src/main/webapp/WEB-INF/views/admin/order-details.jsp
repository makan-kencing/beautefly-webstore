<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="admin" tagdir="/WEB-INF/tags/admin" %>

<jsp:useBean id="order" type="com.lavacorp.beautefly.webstore.order.dto.OrderDetailsDTO" scope="request"/>

<admin:base pageTitle="Order #${order.id()}">
    <jsp:body>
        <main class="vertical p-4 space-y-6">
            <!-- Order Summary Section -->
            <div class="border rounded-xl border-border shadow-md p-4">
                <div class="flex justify-between items-start">
                    <div>
                        <h2 class="text-xl font-bold mb-2">Order #${order.id()}</h2>
                        <fmt:parseDate value="${order.orderedAt()}" pattern="yyyy-MM-dd'T'HH:mm:ss'Z'" var="orderedAtDate" type="both" />
                        <p>Placed at: <fmt:formatDate value="${orderedAtDate}" pattern="yyyy-MM-dd HH:mm" /></p>
                        <p>Status: <span class="font-semibold ${order.status() == 'COMPLETED' ? 'text-green-600' : 'text-blue-600'}">${order.status()}</span></p>
                    </div>
                    <div class="text-right">
                        <p>Customer: ${order.shippingAddress().name()}</p>
                        <p>Payment: ${order.paymentMethod()}</p>
                        <p class="text-lg font-bold">Total: RM <fmt:formatNumber value="${order.netAmount()}" pattern="#,##0.00"/></p>
                    </div>
                </div>
            </div>

            <!-- Shipping Information -->
            <div class="border rounded-xl border-border shadow-md p-4">
                <h3 class="text-lg font-semibold mb-2">Shipping Information</h3>
                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <div>
                        <p class="font-medium">Shipping Address:</p>
                        <p>${order.shippingAddress().address1()}</p>
                        <c:if test="${not empty order.shippingAddress().address2()}">
                            <p>${order.shippingAddress().address2()}</p>
                        </c:if>
                        <c:if test="${not empty order.shippingAddress().address3()}">
                            <p>${order.shippingAddress().address3()}</p>
                        </c:if>
                        <p>${order.shippingAddress().postcode()} ${order.shippingAddress().city()}</p>
                        <p>${order.shippingAddress().state()}, ${order.shippingAddress().country()}</p>
                    </div>
                    <div>
                        <p class="font-medium">Contact Information:</p>
                        <p>${order.shippingAddress().name()}</p>
                        <p>${order.shippingAddress().contactNo()}</p>
                    </div>
                </div>
            </div>

            <!-- Ordered Products Section -->
            <div class="border rounded-xl border-border shadow-md p-4">
                <div class="flex justify-between items-center mb-4">
                    <h3 class="text-lg font-semibold">Ordered Products</h3>
                    <a href="/admin/orders" class="text-blue-500 hover:underline">← Back to Orders</a>
                </div>

                <c:choose>
                    <c:when test="${empty order.products()}">
                        <div class="text-center py-8 text-gray-500">
                            No products in this order
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="overflow-x-auto">
                            <table class="w-full table-auto border-collapse">
                                <thead>
                                <tr class="border-b bg-gray-50">
                                    <th class="p-3 text-left">Product</th>
                                    <th class="p-3 text-right">Price</th>
                                    <th class="p-3 text-right">Quantity</th>
                                    <th class="p-3 text-right">Subtotal</th>
                                    <th class="p-3">Status</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="item" items="${order.products()}">
                                    <tr class="border-b hover:bg-gray-50">
                                        <td class="p-3 text-left">
                                            <div class="font-medium">${item.product().name()}</div>
                                            <div class="text-sm text-gray-500">SKU: ${item.product().id()}</div>
                                        </td>
                                        <td class="p-3 text-right">
                                            RM <fmt:formatNumber value="${item.unitPrice()}" pattern="#,##0.00"/>
                                        </td>
                                        <td class="p-3 text-right">
                                                ${item.quantity()}
                                        </td>
                                        <td class="p-3 text-right">
                                            RM <fmt:formatNumber value="${item.unitPrice() * item.quantity()}" pattern="#,##0.00"/>
                                        </td>
                                        <td class="p-3 text-center space-x-2">
                                            <c:choose>
                                                <c:when test="${item.deliveredAt() != null}">
                                                    <span class="px-2 py-1 rounded-full text-xs bg-green-100 text-green-800">Delivered</span>
                                                </c:when>
                                                <c:when test="${item.deliveryStartedAt() != null}">
                                                    <span class="px-2 py-1 rounded-full text-xs bg-yellow-100 text-yellow-800">On Delivery</span>
                                                    <form action="/admin/orders/status" method="post" class="inline">
                                                        <input type="hidden" name="orderId" value="${order.id()}" />
                                                        <input type="hidden" name="productId" value="${item.product().id()}" />
                                                        <input type="hidden" name="action" value="delivered" />
                                                        <button type="submit" class="text-xs text-white bg-green-600 hover:bg-green-700 px-2 py-1 rounded">Mark Delivered</button>
                                                    </form>
                                                </c:when>
                                                <c:when test="${item.shippedAt() != null}">
                                                    <span class="px-2 py-1 rounded-full text-xs bg-blue-100 text-blue-800">Shipped</span>
                                                    <form action="/admin/orders/status" method="post" class="inline">
                                                        <input type="hidden" name="orderId" value="${order.id()}" />
                                                        <input type="hidden" name="productId" value="${item.product().id()}" />
                                                        <input type="hidden" name="action" value="delivery" />
                                                        <button type="submit" class="text-xs text-white bg-yellow-500 hover:bg-yellow-600 px-2 py-1 rounded">Mark On Delivery</button>
                                                    </form>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="px-2 py-1 rounded-full text-xs bg-gray-100 text-gray-800">Ordered</span>
                                                    <form action="/admin/orders/status" method="post" class="inline">
                                                        <input type="hidden" name="orderId" value="${order.id()}" />
                                                        <input type="hidden" name="productId" value="${item.product().id()}" />
                                                        <input type="hidden" name="action" value="shipped" />
                                                        <button type="submit" class="text-xs text-white bg-blue-600 hover:bg-blue-700 px-2 py-1 rounded">Mark Shipped</button>
                                                    </form>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                                <tfoot>
                                <tr class="border-t">
                                    <td colspan="3" class="p-3 text-right font-medium">Subtotal</td>
                                    <td class="p-3 text-right">RM <fmt:formatNumber value="${order.grossAmount()}" pattern="#,##0.00"/></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td colspan="3" class="p-3 text-right font-medium">Shipping Fee</td>
                                    <td class="p-3 text-right">RM <fmt:formatNumber value="${order.shippingAmount()}" pattern="#,##0.00"/></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td colspan="3" class="p-3 text-right font-medium">Tax</td>
                                    <td class="p-3 text-right">RM <fmt:formatNumber value="${order.taxAmount()}" pattern="#,##0.00"/></td>
                                    <td></td>
                                </tr>
                                <tr class="border-t">
                                    <td colspan="3" class="p-3 text-right font-bold">Total</td>
                                    <td class="p-3 text-right font-bold">RM <fmt:formatNumber value="${order.netAmount()}" pattern="#,##0.00"/></td>
                                    <td></td>
                                </tr>
                                </tfoot>
                            </table>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </main>
    </jsp:body>
</admin:base>