<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib prefix="webstore" tagdir="/WEB-INF/tags/webstore" %>
<%@ taglib prefix="account" tagdir="/WEB-INF/tags/account" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:useBean id="cart" type="com.lavacorp.beautefly.webstore.cart.dto.CartDTO" scope="request"/>
<jsp:useBean id="addresses" type="com.lavacorp.beautefly.webstore.account.dto.AddressesDTO" scope="request"/>


<webstore:base pageTitle="Checkout">
    <main class="p-4">
        <form action="<c:url value='/checkout' />" method="post" class="group horizontal justify-center gap-10 ">
            <!-- 左边内容 -->
            <div class="vertical *:border-inherit *:rounded-lg *:p-4 border-gray-200">
                <!-- 地址 -->
                <div class="vertical border-b-8">
                    <c:choose>
                        <c:when test="${addresses.addresses().size() == 0}">
                            <div>
                                <label for="null-address">
                                    <a href="<c:url value='/addresses' />" class="text-link hover:underline">
                                        Create a new address
                                    </a>
                                </label>

                                <input type="radio" name="addressId" id="null-address" required class="hidden">
                            </div>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="address" items="${addresses.addresses()}">
                                <jsp:useBean id="address"
                                             type="com.lavacorp.beautefly.webstore.account.dto.AddressDTO"/>

                                <div class="horizontal" style="order: ${address.id()}"
                                     onclick="this.querySelector('input[type=radio]').click()">
                                    <div class="*:empty:hidden">
                                        <h2 class="font-semibold">${address.name()}</h2>
                                        <p>${address.address1()}</p>
                                        <p>${address.address2()}</p>
                                        <p>${address.address3()}</p>
                                        <p>${address.city()}, ${address.state()} ${address.postcode()}</p>
                                        <p>Phone number: ${address.contactNo()}</p>
                                    </div>

                                    <label for="address"></label>

                                    <input type="radio" name="addressId" id="address" value="${address.id()}"
                                        ${address.id() == addresses.defaultAddressId() ? "checked" : ""}
                                           class="ml-auto">
                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- 商品区块 -->
                <div class="vertical border-b-8 min-w-4xl">
                    <c:forEach var="item" items="${cart.items()}">
                        <jsp:useBean id="item" type="com.lavacorp.beautefly.webstore.cart.dto.CartItemDTO"/>

                        <div class="horizontal">
                            <img src="${item.product().images()[0].url()}" alt="" class="h-50"/>
                            <div class="">
                                <h4>${item.product().name()}</h4>
                                <div>
                                    <fmt:formatNumber value="${item.product().unitPrice()}"
                                                      type="currency"
                                                      currencySymbol="RM "/>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>

            <!-- 右边付款明细 -->
            <div class="vertical *:border *:border-inherit *:rounded *:p-4 border-gray-200">
                <!-- Payment Details -->
                <div class="shadow-md min-w-sm space-y-2">
                    <h2 class="text-xl font-bold">Payment Details</h2>

                    <table class="w-full border-separate border-spacing-y-1">
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
                            class="w-full p-2 rounded-full font-bold text-white bg-blue-500 not-group-invalid:hover:bg-blue-600 not-group-invalid:cursor-pointer group-invalid:bg-blue-300">
                        Place Order
                    </button>
                </div>
            </div>
        </form>
    </main>
</webstore:base>


