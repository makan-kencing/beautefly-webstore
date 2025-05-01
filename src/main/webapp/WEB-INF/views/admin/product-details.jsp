<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="admin" tagdir="/WEB-INF/tags/admin" %>

<jsp:useBean id="product" type="com.lavacorp.beautefly.webstore.admin.product.dto.ProductDetailsDTO" scope="request" />
<jsp:useBean id="context" type="com.lavacorp.beautefly.webstore.admin.product.dto.CreateProductContext" scope="request" />

<admin:base pageTitle="Product Details">
    <main class = "mt-8">
        <!-- Page Header + Toggle Edit Btn -->
        <div class="flex justify-between items-center mb-6 max-w-4xl mx-auto">
            <h2 class="text-2xl font-bold">Product Details</h2>
            <button id="editBtn" type="button" onclick="toggleEdit()"
                    class="bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded">
                ✏️ Edit Product
            </button>
        </div>

        <form action="/admin/products/update" method="post" enctype="multipart/form-data" class="bg-white p-6 rounded shadow max-w-4xl mx-auto">
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                <!-- Product Image (full width on small, left side on large) -->
                <div class="md:col-span-2 flex gap-4 items-start">
                    <img src="${empty product.imageUrl ? '/static/images/product-placeholder.png' : product.imageUrl}"
                         class="w-32 h-32 object-cover rounded border" alt="Product" />
                    <button type="button" id="uploadBtn"
                            class="bg-gray-200 text-sm px-4 py-2 rounded hidden">
                        Upload Image
                    </button>
                </div>

                <!-- Name -->
                <div>
                    <label class="block font-semibold mb-1">Name</label>
                    <input name="name"
                           value="${product.name}"
                           class="w-full border border-gray-300 rounded-md p-2 text-sm bg-gray-50 text-gray-700"
                           disabled />
                </div>

                <!-- Brand -->
                <div>
                    <label class="block font-semibold mb-1">Brand</label>
                    <input name="brand" value="${product.brand}" class="w-full border border-gray-300 rounded-md p-2 text-sm bg-gray-50 text-gray-700" disabled />
                </div>

                <!-- Description (full width) -->
                <div class="md:col-span-2">
                    <label class="block font-semibold mb-1">Description</label>
                    <textarea name="description" rows="3" class="w-full border border-gray-300 rounded-md p-2 text-sm bg-gray-50 text-gray-700" disabled>${product.description}</textarea>
                </div>

                <!-- Release Date -->
                <div>
                    <label class="block font-semibold mb-1">Release Date</label>
                    <input type="date" name="releaseDate" value="${product.releaseDate}" class="w-full border border-gray-300 rounded-md p-2 text-sm bg-gray-50 text-gray-700" disabled />
                </div>

                <!-- Stock -->
                <div>
                    <label class="block font-semibold mb-1">Stock</label>
                    <input type="number" name="stock" value="${product.stock}" class="w-full border border-gray-300 rounded-md p-2 text-sm bg-gray-50 text-gray-700" disabled />
                </div>

                <!-- Unit Cost -->
                <div>
                    <label class="block font-semibold mb-1">Unit Cost</label>
                    <input type="number" name="unitCost" step="0.01" value="${product.unitCost}" class="w-full border border-gray-300 rounded-md p-2 text-sm bg-gray-50 text-gray-700" disabled />
                </div>

                <!-- Unit Price -->
                <div>
                    <label class="block font-semibold mb-1">Unit Price</label>
                    <input type="number" name="unitPrice" step="0.01" value="${product.unitPrice}" class="w-full border border-gray-300 rounded-md p-2 text-sm bg-gray-50 text-gray-700" disabled />
                </div>

                <!-- Category -->
                <div class="md:col-span-2">
                    <label class="block font-semibold mb-1">Category</label>
                    <select name="categoryId" class="w-full border border-gray-300 rounded-md p-2 text-sm bg-gray-50 text-gray-700" disabled>
                        <c:forEach var="cat" items="${categories}">
                            <option value="${cat.categoryId}" ${cat.categoryId == product.category.categoryId ? "selected" : ""}>
                                    ${cat.name}
                            </option>.
                        </c:forEach>
                    </select>
                </div>

                <!-- Color -->
                <div class="md:col-span-2">
                    <label class="block font-semibold mb-1">Color</label>
                    <input name="color" value="${product.color}"class="w-full border border-gray-300 rounded-md p-2 text-sm bg-gray-50 text-gray-700" disabled />
                </div>
            </div>

            <!-- Action Buttons -->
            <div class="mt-6 flex gap-2 hidden" id="actionBtns">
                <button type="submit" class="bg-green-600 text-white px-4 py-2 rounded">Save</button>
                <button type="button" onclick="window.location.reload()" class="bg-red-600 text-white px-4 py-2 rounded">Cancel</button>
            </div>
        </form>
    </main>
</admin:base>

<script>
    function toggleEdit() {
        // Enable all fields
        document.querySelectorAll('input, textarea, select').forEach(el => el.removeAttribute('disabled'));
        document.getElementById('uploadBtn').classList.remove('hidden');
        document.getElementById('actionBtns').classList.remove('hidden');
        document.getElementById('editBtn').classList.add('hidden');
    }
</script>

<style>
    .form-field {
        @apply w-full border border-gray-300 rounded-md p-2 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500 disabled:bg-gray-100;
    }
</style>
