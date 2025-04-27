<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="webstore" tagdir="/WEB-INF/tags/webstore" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:useBean id="cart" type="com.lavacorp.beautefly.webstore.cart.dto.CartDTO" scope="request"/>

<webstore:base pageTitle="Cart">
    <div class="flex flex-col items-center justify-center">
        <div class="flex w-full justify-center gap-5 p-4">

            <div class="flex max-w-6xl flex-1 flex-col">
                <div class="rounded-xl border border-border p-4 shadow">
                    <c:choose>
                        <c:when test="${cart.items().size() <= 0}">
                            <div class="space-y-2">
                                <h2 class="text-2xl font-bold">Your cart is empty</h2>

                                <p>Once you add something to your cart, it will appear here. Ready to get started?</p>

                                <a href="<c:url value='/' />" class="text-blue-500">Get started</a>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="space-y-2">
                                <h2 class="text-2xl font-bold py-2">Shopping Cart</h2>

                                <table class="w-full">
                                    <thead class="border-b border-border">
                                    <tr class="*:p-2">
                                        <th></th>
                                        <th>Product</th>
                                        <th class="text-center">Price</th>
                                        <th class="text-center">Quantity</th>
                                        <th>Subtotal</th>
                                    </tr>
                                    </thead>
                                    <tbody class="divide-y divide-border">
                                    <c:forEach var="item" items="${cart.items()}">
                                        <jsp:useBean id="item"
                                                     type="com.lavacorp.beautefly.webstore.cart.dto.CartItemDTO"/>

                                        <tr class="*:py-4 *:px-2">
                                            <td>
                                                <img src="${item.product().images()[0].url()}" alt="" class="h-60">
                                            </td>
                                            <td>
                                                <a href="<c:url value='/product/${item.product().id()}' />"
                                                   class="text-link hover:underline">
                                                        ${item.product().name()}
                                                </a>
                                            </td>
                                            <td class="text-center">
                                                <fmt:formatNumber value="${item.product().unitPrice()}"
                                                                  type="currency"
                                                                  currencySymbol="RM "/>
                                            </td>
                                            <td class="text-center">
                                                <form action="<c:url value='/cart/' />" method="post">
                                                    <input type="hidden" name="productId" value="${item.product().id()}">
                                                    <div class="flex items-center justify-between border border-border rounded h-8">
                                                        <button type="button" onclick="updateQuantity.call(this, -1)"
                                                                class="cursor-pointer w-8 h-full text-gray-400 border-r border-border">
                                                            <i class="fa-solid fa-minus"></i>
                                                        </button>
                                                        <label>
                                                            <input type="text" name="quantity" value="${item.quantity()}" min="0" readonly
                                                                   class="text-center text-gray-800 border-none outline-none w-8">
                                                        </label>
                                                        <button type="button" onclick="updateQuantity.call(this, 1)"
                                                                class="cursor-pointer w-8 h-full text-gray-400 border-l border-border">
                                                            <i class="fa-solid fa-plus"></i>
                                                        </button>
                                                    </div>
                                                </form>
                                            </td>
                                            <td class="text-right font-bold">
                                                <fmt:formatNumber value="${item.subtotal()}"
                                                                  type="currency"
                                                                  currencySymbol="RM "/>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                    <tfoot class="border-t border-border">
                                    <tr class="*:p-2">
                                        <td colspan="5" class="text-right text-lg">
                                            Subtotal (${cart.items().size()} items):
                                            <span class="font-bold">
                                                <fmt:formatNumber value="${cart.subtotal()}"
                                                                  type="currency"
                                                                  currencySymbol="RM "/>
                                            </span>
                                        </td>
                                    </tr>
                                    </tfoot>
                                </table>

                                <script>
                                    function updateQuantity(diff) {
                                        const form = this.closest("form");
                                        const quantityInput = form.querySelector("input#quantity");

                                        quantityInput.value += diff;
                                        quantityInput.value = Math.max(0, quantityInput.value);

                                        form.submit();
                                    }
                                </script>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <div class="flex flex-col w-xs">
                <c:if test="${cart.items().size() > 0}">
                    <div class="rounded-xl border border-border px-6 py-4 shadow">
                        <form action="<c:url value='/checkout' />" method="get" class="space-y-2">
                            <h2 class="text-2xl font-bold">Summary</h2>

                            <table class="w-full">
                                <tbody>
                                <tr>
                                    <td>Subtotal</td>
                                    <td class="text-right">
                                        <fmt:formatNumber value="${cart.subtotal()}"
                                                          type="currency"
                                                          currencySymbol="RM "/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Shipping & Handling</td>
                                    <td class="text-right">
                                        <fmt:formatNumber value="${cart.shippingCost()}"
                                                          type="currency"
                                                          currencySymbol="RM "/>
                                    </td>
                                </tr>
                                    <%--suppress ELValidationInspection --%>
                                <c:if test="${cart.isShippingDiscounted() == true}">
                                    <tr>
                                        <td>Shipping Discount</td>
                                        <td class="text-right">
                                            - <fmt:formatNumber value="${cart.shippingCost()}"
                                                                type="currency"
                                                                currencySymbol="RM "/>
                                        </td>
                                    </tr>
                                </c:if>
                                <tr>
                                    <td>Estimated Tax</td>
                                    <td class="text-right">
                                        <fmt:formatNumber value="${cart.estimatedTax()}"
                                                          type="currency"
                                                          currencySymbol="RM "/>
                                    </td>
                                </tr>
                                </tbody>
                                <tfoot>
                                <tr class="text-lg font-bold">
                                    <td>Total</td>
                                    <td class="text-right">
                                        <fmt:formatNumber value="${cart.total()}"
                                                          type="currency"
                                                          currencySymbol="RM "/>
                                    </td>
                                </tr>
                                </tfoot>
                            </table>

                            <button type="submit"
                                    class="w-full p-2 rounded-full font-bold text-white bg-blue-500 hover:bg-blue-600 cursor-pointer">
                                Checkout
                            </button>
                        </form>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
</webstore:base>
