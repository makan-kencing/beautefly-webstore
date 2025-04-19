<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="webstore" tagdir="/WEB-INF/tags/webstore" %>

<jsp:useBean id="product" type="com.lavacorp.beautefly.webstore.product.dto.ProductPageDTO" scope="request"/>

<c:if test="${param.get('slug')}">
    <c:redirect url="/product/${product.id()}/${product.slug()}"/>
</c:if>

<webstore:base pageTitle="${product.name()}">
    <body class="font-sans flex flex-col gap-10">

    <div class="px-10">
        <div class="flex gap-10">
            <!--Left-->
            <div class="flex-1">
                <img class="w-full max-w-md border border-gray-300" src="${product.imageUrls()[0]}" alt="Product Image">
                <button class="cursor-pointer mt-6 px-6 py-2 bg-blue-600 text-white rounded hover:bg-blue-700 transition">Review</button>
            </div>

            <!-- Right -->
            <div class="flex-1">
                <h2 class="text-2xl font-semibold">${product.name()}</h2>
                <div class="text-yellow-500 text-sm mt-1">★★★★☆ 4.9 (2.1k Ratings)</div>
                <div class="text-red-600 text-2xl font-bold mt-2">
                    <span class="line-through text-gray-500 text-base ml-2">
                        <fmt:formatNumber value="${product.unitPrice()}" type="currency" currencySymbol="RM "/>
                    </span>
                </div>
                <div class="mt-2 space-x-2 text-xs">
                    <span class="bg-pink-300 px-2 py-1 inline-block">RM3 OFF</span>
                    <span class="bg-pink-300 px-2 py-1 inline-block">RM5 OFF</span>
                    <span class="bg-pink-300 px-2 py-1 inline-block">95% Coins Cashback</span>
                </div>
                <p class="mt-4 text-gray-700">${product.description()}</p>

                <!-- Quantity -->
                <div class="flex items-center gap-4 mt-6">
                    <span class="text-base text-gray-600">Quantity</span>
                    <div class="flex border border-gray-300 rounded overflow-hidden h-8">
                        <button onclick="changeQty(-1)" class="cursor-pointer w-8 bg-white text-gray-400 text-lg">−</button>
                        <input type="text" id="qty" value="1" readonly class="w-10 text-center text-base text-gray-800 border-none outline-none">
                        <button onclick="changeQty(1)" class="cursor-pointer w-8 bg-white text-gray-400 text-lg">+</button>
                    </div>
                </div>

                <button class="cursor-pointer mt-6 px-6 py-2 bg-blue-600 text-white rounded hover:bg-blue-700 transition">Add to Cart</button>
            </div>
        </div>

        <div class="border-t border-gray-300 pt-8">
            <div class="bg-orange-50 border border-orange-200 p-6">
                <h3 class="text-xl font-semibold mb-2">Product Ratings</h3>
                <div class="text-red-600 text-4xl font-bold mb-1">4.9 <span class="text-base font-normal">out of 5</span></div>
                <div class="text-red-600 text-2xl mb-2">★★★★★</div>
                <div class="space-x-2 text-sm">
                    <button class="px-3 py-1 border border-gray-300 bg-white">All</button>
                    <button class="px-3 py-1 border border-gray-300 bg-white">5 Star (1.9k)</button>
                    <button class="px-3 py-1 border border-gray-300 bg-white">4 Star (101)</button>
                    <button class="px-3 py-1 border border-gray-300 bg-white">3 Star (36)</button>
                    <button class="px-3 py-1 border border-gray-300 bg-white">2 Star (10)</button>
                    <button class="px-3 py-1 border border-gray-300 bg-white">1 Star (10)</button><br>
                    <button class="px-3 py-1 border border-gray-300 bg-white mt-2">With Comments (731)</button>
                    <button class="px-3 py-1 border border-gray-300 bg-white mt-2">With Media (456)</button>
                </div>
            </div>

            <!-- Review 1 -->
            <div class="border-t border-gray-100 py-6">
                <div class="flex items-center gap-2 font-bold text-gray-800">
                    <div class="w-8 h-8 bg-gray-400 rounded-full"></div>
                    ainhilmanomar
                </div>
                <div class="text-red-500 mt-1">★★★★★</div>
                <div class="text-xs text-gray-500 mt-1">2023-12-22 18:35 | Variation: Yellow,38-39:23cm</div>
                <div class="text-sm text-gray-500 mt-2"><strong>Material:</strong> Getah Tebal dan tahan lasak</div>
                <p class="mt-2 text-gray-700">
                    Kasut/sandal anak boy order dh selamat d terima.<br>
                    Penghantaran pantas, order selasa, jumaat sampai 😊<br>
                    Anak2 suka.. Saiz y d berikan mudah d ikut (ukuran pembaris) tq saller saya beli 👍
                </p>
                <div class="flex gap-2 mt-3">
                    <img src="https://via.placeholder.com/60x60?text=vid" class="w-15 h-15 object-cover border border-gray-300">
                    <img src="https://via.placeholder.com/60x60?text=img1" class="w-15 h-15 object-cover border border-gray-300">
                    <img src="https://via.placeholder.com/60x60?text=img2" class="w-15 h-15 object-cover border border-gray-300">
                </div>
                <div class="text-sm text-gray-600 mt-2">👍 13</div>
            </div>

            <!-- Review 2 -->
            <div class="border-t border-gray-100 py-6">
                <div class="flex items-center gap-2 font-bold text-gray-800">
                    <div class="w-8 h-8 bg-gray-400 rounded-full"></div>
                    ctanoi
                </div>
                <div class="text-red-500 mt-1">★★★★★</div>
                <div class="text-xs text-gray-500 mt-1">2023-12-27 16:19 | Variation: Yellow,36-37:22cm</div>
                <p class="mt-2 text-gray-700">
                    Penghantaran pantas kasut tiada kerosakan saiz betul dan cantik anak suka pakai sebab tapak kasut tak keras dia lembut jadi tak sakit kaki kalau lama berjalan
                </p>
                <div class="flex gap-2 mt-3">
                    <img src="https://via.placeholder.com/60x60?text=img3" class="w-15 h-15 object-cover border border-gray-300">
                    <img src="https://via.placeholder.com/60x60?text=img4" class="w-15 h-15 object-cover border border-gray-300">
                    <img src="https://via.placeholder.com/60x60?text=img5" class="w-15 h-15 object-cover border border-gray-300">
                    <img src="https://via.placeholder.com/60x60?text=img6" class="w-15 h-15 object-cover border border-gray-300">
                </div>
            </div>
        </div>

    </div>

    <script>
        function changeQty(amount) {
            const input = document.getElementById('qty');
            let current = parseInt(input.value);
            if (isNaN(current)) current = 1;
            current += amount;
            if (current < 1) current = 1;
            input.value = current;
        }
    </script>

    </body>
</webstore:base>
