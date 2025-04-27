<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="webstore" tagdir="/WEB-INF/tags/webstore" %>
<%@ taglib prefix="account" tagdir="/WEB-INF/tags/account" %>

<c:set var="pageTitle" value="Order History" />

<webstore:base pageTitle="${pageTitle}">
  <c:set var="orders" value="${[
    {
        'orderNumber': 'BK1000001',
        'recipient': 'Ali Baba',
        'orderTime': '2025-04-27 15:30',
        'totalAmount': 207.90,
        'products': [
            {
                'name': 'Minimalist Bag',
                'imageUrl': 'https://down-my.img.susercontent.com/file/9db5556f3acc5c0992ed9988fc0a2fac',
                'quantity': 1,
                'unitPrice': 29.90
            },
            {
                'name': 'Wireless Earbuds',
                'imageUrl': 'https://down-my.img.susercontent.com/file/3d4d90f8da2348e1af8aff11887981e4',
                'quantity': 2,
                'unitPrice': 89.00
            }
        ]
    },
    {
        'orderNumber': 'BK1000002',
        'recipient': 'Chee Hua',
        'orderTime': '2025-04-28 10:15',
        'totalAmount': 45.50,
        'products': [
            {
                'name': 'Stainless Steel Water Bottle',
                'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQi3Fz5_XMRRnh19vUPn-hg7s724__VY5Kxig&s',
                'quantity': 1,
                'unitPrice': 45.50
            }
        ]
    }
]}" />
  <body class="flex flex-col min-h-screen">
  <main class="flex-1 py-10 px-10 max-w-5xl w-full mx-auto">
    <!-- Header -->
    <div class="flex justify-between items-center mb-4">
      <div>
        <h1 class="text-4xl font-extrabold text-gray-900">Order History</h1>
        <p class="text-gray-500 text-sm mt-1">Order History is track your purchases and view past orders</p>
      </div>
      <div class="flex flex-row items-end text-right">
        <p class="text-3xl mx-2 text-gray-700 font-semibold">Total Orders:</p>
        <p class="text-4xl font-extrabold text-indigo-300">??</p>
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
    <div class="flex space-x-10 border-b border-gray-300 mb-8">
      <button id="Orders" class="tab-button py-2 font-medium text-gray-800 border-b-2 border-gray-800" onclick="setActiveTab('Orders')">
        Orders
      </button>
      <button id="Shipping" class="tab-button py-2 font-medium text-gray-500" onclick="setActiveTab('Shipping')">
        Shipping
      </button>
      <button id="Completed" class="tab-button py-2 font-medium text-gray-500" onclick="setActiveTab('Completed')">
        Completed
      </button>
    </div>
    <!-- Order List -->
    <div class="space-y-8">
      <c:forEach var="order" items="${orders}">
        <div class="border rounded-lg p-6 shadow-sm">
          <!-- Order Header -->
          <div class="flex justify-between items-center border-b border-gray-500 pb-2 mb-4">
            <!-- 左边 (Order ID + Ship To) -->
            <div class="flex items-center gap-24 text-sm text-gray-500">
              <span>Order  <span class="font-medium text-gray-700">#${order.orderNumber}</span></span>
              <span>Ship to: <span class="font-medium text-gray-700">${order.recipient}</span></span>
            </div>

            <!-- 右边 (Order Time) -->
            <div class="text-sm text-gray-500">
              Ordered: <span class="font-medium text-gray-700">${order.orderTime}</span>
            </div>
          </div>


          <!-- Products List -->
          <div class="space-y-6">
            <c:forEach var="product" items="${order.products}">
              <div class="flex justify-between items-center">
                <div class="flex items-center gap-4">
                  <img src="${product.imageUrl}" alt="Product Image" class="w-16 h-16 rounded object-cover" />
                  <div>
                    <h3 class="font-semibold text-gray-900">${product.name}</h3>
                    <p class="text-gray-500 text-sm">Quantity: ${product.quantity}</p>
                    <p class="text-pink-600 text-sm font-semibold">Unit Price: RM ${product.unitPrice}</p>
                  </div>
                </div>
                <div class="text-right font-bold text-gray-700">
                  RM <c:out value="${product.unitPrice * product.quantity}" />
                </div>
              </div>
            </c:forEach>
          </div>

          <!-- Bottom Line -->
          <div class="border-t border-gray-300 my-4"></div>

          <!-- Total Amount -->
          <div class="flex justify-end">
            <p class="text-lg font-bold text-gray-900">Total: RM ${order.totalAmount}</p>
          </div>
        </div>
      </c:forEach>
    </div>
  </main>
  </body>
</webstore:base>

<script>
  function setActiveTab(tabName) {
    document.querySelectorAll('.tab-button').forEach(btn => {
      btn.classList.remove('text-gray-800', 'border-b-2', 'border-gray-800');
      btn.classList.add('text-gray-500');
    });

    const activeBtn = document.getElementById(tabName);
    activeBtn.classList.add('text-gray-800', 'border-b-2', 'border-gray-800');
    activeBtn.classList.remove('text-gray-500');
  }
</script>
