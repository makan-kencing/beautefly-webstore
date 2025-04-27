<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="webstore" tagdir="/WEB-INF/tags/webstore" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:useBean id="cart" type="com.lavacorp.beautefly.webstore.cart.dto.CartDTO" scope="request"/>

<webstore:base pageTitle="Cart">
    <div class="flex flex-col items-center justify-center">
        <div class="flex w-full justify-center gap-5 p-4">

            <div class="flex max-w-6xl flex-1 flex-col">
                <div class="rounded-xl border p-4 shadow">
                    <c:choose>
                        <c:when test="${cart.items().size() > 0}">
                            <form>
                                <h2>Shopping Cart</h2>

                                <table>
                                    <thead>
                                    <tr>
                                        <th></th>
                                        <th></th>
                                        <th>Product</th>
                                        <th>Price</th>
                                        <th>Quantity</th>
                                        <th>Subtotal</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="item" items="${cart.items()}">
                                        <jsp:useBean id="item"
                                                     type="com.lavacorp.beautefly.webstore.cart.dto.CartItemDTO"/>

                                        <tr>
                                            <td></td>
                                            <td>
                                                <img src="${item.product().images()[0].url()}" alt="">
                                            </td>
                                            <td>
                                                <a href="<c:url value='/product/${item.product().id}' />">
                                                        ${item.product().name}
                                                </a>
                                            </td>
                                            <td>
                                                <fmt:formatNumber value="${item.product().unitPrice}"
                                                                  type="currency"
                                                                  currencySymbol="RM "/>
                                            </td>
                                            <td>
                                                <form action="<c:url value='/cart' />" method="post">
                                                    <input type="hidden" name="product" value="${item.product().id}">
                                                    <label>
                                                        <input type="number" name="quantity" value="${item.quantity()}"
                                                               min="0">
                                                    </label>
                                                </form>
                                            </td>
                                            <td>
                                                <fmt:formatNumber value="${item.subtotal()}"
                                                                  type="currency"
                                                                  currencySymbol="RM "/>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                    <tfoot>
                                    <tr>
                                        <td colspan="6">
                                            Subtotal (${cart.items().size()} items):
                                            <fmt:formatNumber value="${cart.subtotal()}"
                                                              type="currency"
                                                              currencySymbol="RM "/>
                                        </td>
                                    </tr>
                                    </tfoot>
                                </table>
                            </form>
                        </c:when>
                        <c:otherwise>
                            <div class="space-y-2">
                                <h2 class="text-2xl font-bold">Your cart is empty</h2>

                                <p>Once you add something to your cart, it will appear here. Ready to get started?</p>

                                <a href="<c:url value='/' />" class="text-blue-500">Get started</a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <div class="flex flex-col w-xs">
                <c:if test="${cart.items().size() > 0}">
                    <div class="rounded border p-4 shadow">
                        <form action="<c:url value='/cart/checkout' />" method="get" class="space-y-2">
                            <h2>Summary</h2>

                            <table>
                                <tbody>
                                <tr>
                                    <td>Subtotal</td>
                                    <td>
                                        <fmt:formatNumber value="${cart.subtotal()}"
                                                          type="currency"
                                                          currencySymbol="RM "/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Shipping & Handling</td>
                                    <td>
                                        <fmt:formatNumber value="${cart.shippingCost()}"
                                                          type="currency"
                                                          currencySymbol="RM "/>
                                    </td>
                                </tr>
                                <c:if test="${cart.shippingDiscounted() == true}">
                                    <tr>
                                        <td>Shipping Discount</td>
                                        <td>
                                            - <fmt:formatNumber value="${cart.shippingCost()}"
                                                              type="currency"
                                                              currencySymbol="RM "/>
                                        </td>
                                    </tr>
                                </c:if>
                                <tr>
                                    <td>Estimated Tax</td>
                                    <td>
                                        <fmt:formatNumber value="${cart.estimatedTax()}"
                                                          type="currency"
                                                          currencySymbol="RM "/>
                                    </td>
                                </tr>
                                </tbody>
                                <tfoot>
                                <tr>
                                    <td>Total</td>
                                    <td>
                                        <fmt:formatNumber value="${cart.total()}"
                                                          type="currency"
                                                          currencySymbol="RM "/>
                                    </td>
                                </tr>
                                </tfoot>
                            </table>

                            <button type="submit">Checkout</button>
                        </form>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
</webstore:base>
