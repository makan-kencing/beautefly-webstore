<%--
  Created by IntelliJ IDEA.
  User: CheeHua
  Date: 4/4/2025
  Time: 9:01 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags/admin" %>
<script src="https://cdn.tailwindcss.com"></script>

<!DOCTYPE html>
<html>
<head>
    <title>Manage Products</title>
</head>
<body class="p-6">
<c:if test="${param.created == '1'}">
    <div id="toast"
         class="fixed top-4 right-4 bg-green-500 text-white px-4 py-2 rounded shadow-lg z-50 opacity-100 transition-opacity duration-500 ease-in-out">
        User created successfully!!
    </div>
    <script>
        setTimeout(() => {
            const toast = document.getElementById("toast");
            toast.classList.remove("opacity-100");
            toast.classList.add("opacity-0");
            setTimeout(() => toast.remove(), 500);
        }, 2000);
    </script>
</c:if>

<!-- Pop Up Successful Delete Message-->
<c:if test="${param.deleted == '1'}">
    <div id="toast"
         class="fixed top-4 right-4 bg-red-500 text-white px-4 py-2 rounded shadow-lg z-50 opacity-100 transition-opacity duration-500 ease-in-out">
        User(s) deleted successfully!
    </div>
    <script>
        setTimeout(() => {
            const toast = document.getElementById("toast");
            toast.classList.remove("opacity-100");
            toast.classList.add("opacity-0");
            setTimeout(() => toast.remove(), 500);
        }, 2000);
    </script>
</c:if>

<my:header />


<h2 class="text-2xl font-bold mb-4">Manage Products</h2>

<div class="flex justify-between items-center mb-4">
    <!-- Search bar (pink box) -->
    <input id="searchInput"
           onkeyup="filterTable()"
           type="text"
           placeholder="Search products..."
           class="border border-gray-300 p-2 rounded w-[50%] shadow-sm" />

    <!-- Right controls (add & delete buttons) -->
    <div class="flex items-center gap-4">
        <!-- Add -->
        <button onclick="openModal()" class="text-green-600 text-4xl font-bold hover:scale-125 transition-transform">
            +
        </button>
        <!-- Delete -->
        <button onclick="toggleDeleteMode()" class="text-red-600 text-3xl font-bold hover:scale-125 transition-transform">
            –
        </button>
    </div>
</div>
<!-- Product Table -->
<form id="deleteForm" method="post" action="/admin/products/delete">
    <table class="min-w-full border text-sm" id="productTable">
        <thead class="bg-gray-200 text-left">
        <tr>
            <th class="p-2"><input type="checkbox" onclick="toggleAll(this)" /></th>
            <th class="p-2" data-sort="id">Product ID ↕</th>
            <th class="p-2" data-sort="name">Product Name ↕</th>
            <th class="p-2" data-sort="category">Category ↕</th>
            <th class="p-2" data-sort="price">Unit Price ↕</th>
            <th class="p-2" data-sort="stock">Stock ↕</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="product" items="${products}">
            <tr class="border-b">
                <td class="p-2">
                    <input type="checkbox" name="productIds" value="${product.productId}" class="delete-checkbox hidden" />
                </td>
                <td class="p-2">${product.productId}</td>
                <td class="p-2">${product.name}</td>
                <td class="p-2">${product.category.name}</td>
                <td class="p-2">RM ${product.unitPrice}</td>
                <td class="p-2">${product.stock}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <!-- Delete Selected Button -->
    <div id="deleteBtnContainer" class="mt-4 hidden">
        <button type="submit" class="bg-red-600 text-white px-4 py-2 rounded hover:bg-red-700">
            🗑️ Delete Selected
        </button>
    </div>
</form>

<!-- Add Product Modal -->
<div id="addProductModal" class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 hidden">
    <div class="bg-white rounded-lg shadow-xl w-full max-w-xl overflow-y-auto max-h-[90vh] p-6">
        <div class="flex justify-between items-center mb-4">
            <h2 class="text-xl font-bold">Add Product</h2>
            <button onclick="closeModal()" class="text-gray-500 hover:text-red-600 text-2xl leading-none">&times;</button>
        </div>

        <form action="/admin/products/add" method="post" class="space-y-4">
            <div>
                <label class="block font-semibold">Product Name *</label>
                <input type="text" name="name" class="w-full border p-2 rounded" required>
            </div>
            <div>
                <label class="block font-semibold">Category *</label>
                <select name="categoryId" class="w-full border p-2 rounded" required>
                    <option value="">Select a category</option>
                    <c:forEach var="cat" items="${categories}">
                        <option value="${cat.categoryId}">${cat.name}</option>
                    </c:forEach>
                </select>
            </div>
            <div>
                <label class="block font-semibold">Description</label>
                <textarea name="description" class="w-full border p-2 rounded" rows="3"></textarea>
            </div>
            <div>
                <label class="block font-semibold">Unit Price *</label>
                <input type="number" name="unitPrice" class="w-full border p-2 rounded" step="0.01" required>
            </div>
            <div>
                <label class="block font-semibold">Stock *</label>
                <input type="number" name="stock" class="w-full border p-2 rounded" required>
            </div>

            <!-- Buttons -->
            <div class="flex justify-end gap-2">
                <button type="button" onclick="closeModal()" class="px-4 py-2 border border-gray-300 rounded hover:bg-gray-100">Cancel</button>
                <button type="submit" class="bg-green-600 text-white px-4 py-2 rounded hover:bg-green-700">Submit</button>
            </div>
        </form>
    </div>
</div>
</body>
</html>

<my:footer />
<script>
    function toggleDeleteMode() {
        const elements = document.querySelectorAll('.delete-mode-toggle');
        elements.forEach(el => el.classList.toggle('hidden'));

        const deleteBtn = document.getElementById('deleteBtn');
        if (deleteBtn.innerText === 'Delete') {
            deleteBtn.innerText = 'Cancel';
        } else {
            deleteBtn.innerText = 'Delete';
            // Optional: Uncheck all boxes when cancelling
            document.querySelectorAll('input[name="deleteIds"]').forEach(cb => cb.checked = false);
        }
    }
    function openModal() {
        document.getElementById("addProductModal").classList.remove("hidden");
    }
    function closeModal() {
        document.getElementById("addProductModal").classList.add("hidden");
    }
</script>
