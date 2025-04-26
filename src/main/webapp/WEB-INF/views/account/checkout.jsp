<%--
  Created by IntelliJ IDEA.
  User: CheeHua
  Date: 4/25/2025
  Time: 1:15 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="webstore" tagdir="/WEB-INF/tags/webstore" %>
<%@ taglib prefix="account" tagdir="/WEB-INF/tags/account" %>

<jsp:useBean id="account" type="com.lavacorp.beautefly.webstore.account.dto.UserAccountDetailsDTO" scope="request"/>

<c:set var="pageTitle" value="Checkout" />

<webstore:base pageTitle="${pageTitle}">
    <main class="p-4">

        <!-- Sidebar -->
        <account:sidebar pageTitle="${pageTitle}" />

        <!-- Checkout Body -->
        <div class="container mx-auto flex gap-6 mt-6">

            <!-- Left Area -->
            <div class="flex-1 flex flex-col gap-4">

                <!-- Address Section -->
                <div class="bg-white p-4 rounded shadow">
                    <strong>${account.username}</strong> (+60) 12-345 6789 <br />
                        ${account.address.street} <br />
                        ${account.address.city}, ${account.address.state} ${account.address.zip}
                </div>

                <!-- Product List -->
                <div class="bg-white p-4 rounded shadow">
                    <c:forEach var="item" items="${cartItems}">
                        <div class="flex gap-4 border-b pb-4 mb-4">
                            <img src="${item.product.imageUrl}" alt="Product" class="w-20 h-20 object-cover rounded">
                            <div>
                                <h4 class="font-semibold">${item.product.name}</h4>
                                <div class="text-orange-500 font-bold">RM ${item.product.unitPrice}</div>
                                <div class="text-sm text-gray-500">Qty: ${item.quantity}</div>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <!-- Payment Option -->
                <div class="bg-white p-4 rounded shadow">
                    <div class="flex justify-between items-center mb-2">
                        <div>
                            <div class="font-semibold">Payment Option</div>
                            <div id="selected-payment" class="text-sm mt-1">Online Banking - Maybank</div>
                        </div>
                        <button type="button" onclick="openModal()" class="text-blue-500 text-sm">View All</button>
                    </div>
                </div>
            </div>

            <!-- Right Area -->
            <div class="w-1/3 sticky top-20">
                <div class="bg-white p-4 rounded shadow">
                    <div class="font-semibold mb-3">Payment Details</div>

                    <div class="flex justify-between text-sm mb-2">
                        <div>Merchandise Subtotal</div>
                        <div>RM ${subtotal}</div>
                    </div>

                    <div class="flex justify-between text-sm mb-2">
                        <div>Shipping Subtotal (excl. SST)</div>
                        <div>RM ${shippingFee}</div>
                    </div>

                    <div class="flex justify-between text-sm mb-2">
                        <div>Shipping Fee SST</div>
                        <div>RM ${shippingTax}</div>
                    </div>

                    <div class="flex justify-between font-bold mt-4">
                        <div>Total Payment</div>
                        <div>RM ${totalPayment}</div>
                    </div>

                    <form action="/checkout/confirm" method="post">
                        <button type="submit" class="w-full bg-orange-500 text-white mt-6 py-3 rounded">
                            Place Order
                        </button>
                    </form>
                </div>
            </div>

        </div>

        <!-- Payment Method Modal -->
        <div id="modal" class="hidden fixed inset-0 bg-black bg-opacity-40 flex items-center justify-center z-50">
            <div class="bg-white rounded-lg w-96 p-4">
                <div class="flex items-center mb-4">
                    <button onclick="closeModal()" class="text-lg">&larr;</button>
                    <h3 class="text-lg font-bold ml-4">Select Payment Method</h3>
                </div>

                <div class="flex flex-col gap-3">
                    <button onclick="selectPayment('Maybank2u')" class="border rounded p-3">Maybank2u</button>
                    <button onclick="selectPayment('Public Bank')" class="border rounded p-3">Public Bank</button>
                    <button onclick="selectPayment('Cash on Delivery')" class="border rounded p-3">Cash on Delivery</button>
                </div>
            </div>
        </div>

    </main>
</webstore:base>

<script>
    function openModal() {
        document.getElementById('modal').classList.remove('hidden');
    }
    function closeModal() {
        document.getElementById('modal').classList.add('hidden');
    }
    function selectPayment(name) {
        document.getElementById('selected-payment').innerText = name;
        closeModal();
    }
</script>

