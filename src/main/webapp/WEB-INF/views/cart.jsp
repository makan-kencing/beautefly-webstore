<%@ page contentType="text/html;charset=UTF-8" %>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="webstore" tagdir="/WEB-INF/tags/webstore" %>

<jsp:useBean id="cart" type="com.lavacorp.beautefly.webstore.cart.dto.CartDTO" scope="request"/>

<webstore:base pageTitle="Cart">
    <div class="my-4 flex flex-col items-center justify-center">
        <div class="flex">

            <div class="flex flex-col">
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
                            <tr>
                                <td>

                                </td>
                                <td>
                                    <img src="${item.product().imageUrls[0]}" alt="">
                                </td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/product/${item.product().id}">
                                            ${item.product().name}
                                    </a>
                                </td>
                                <td>
                                    RM ${item.product().unitPrice}
                                </td>
                                <td>
                                    <form action="${pageContext.request.contextPath}/cart" method="post">
                                        <input type="hidden" name="product" value="${item.product().id}">
                                        <label>
                                            <input type="number" name="quantity" value="${item.quantity()}" min="0">
                                        </label>
                                    </form>
                                </td>
                                <td>
                                    RM ${item.subtotal()}
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                        <tfoot>
                        <tr>
                            <td colspan="6">Subtotal (${cart.items().size()} items): RM ${cart.subtotal()}</td>
                        </tr>
                        </tfoot>
                    </table>
                </form>
            </div>

            <div class="flex flex-col">
                <c:if test="${cart.items().size() > 0}">
                    <form action="${pageContext.request.contextPath}/cart/checkout" method="get">
                        <h2>Summary</h2>

                        <table>
                            <tbody>
                            <tr>
                                <td>Subtotal</td>
                                <td>RM ${cart.subtotal()}</td>
                            </tr>
                            <tr>
                                <td>Shipping & Handling</td>
                                <td>RM ${cart.shippingCost()}</td>
                            </tr>
                            <c:if test="${cart.shippingDiscounted() == true}">
                                <tr>
                                    <td>Shipping Discount</td>
                                    <td>RM ${cart.shippingCost()}</td>
                                </tr>
                            </c:if>
                            <tr>
                                <td>Estimated Tax</td>
                                <td>RM ${cart.taxCost()}</td>
                            </tr>
                            </tbody>
                            <tfoot>
                            <tr>
                                <td>Total</td>
                                <td>RM ${cart.total()}</td>
                            </tr>
                            </tfoot>
                        </table>

                        <button type="submit">Checkout</button>
                    </form>
                </c:if>
            </div>
        </div>
    </div>
</webstore:base>
