<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="webstore" tagdir="/WEB-INF/tags/webstore" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<jsp:useBean id="product" type="com.lavacorp.beautefly.webstore.product.dto.ProductPageDTO" scope="request"/>

<c:if test="${param.get('slug')}">
    <c:redirect url="/product/${product.id()}/${product.slug()}"/>
</c:if>

<c:if test="${param.get('slug')}">
    <c:redirect url="/rating/${rating.id()}/${rating.slug()}"/>
</c:if>

<webstore:base pageTitle="${product.name()}">
    <body class="font-sans flex flex-col gap-10">

    <div class="px-10">
        <div class="flex gap-10 mb-5">
            <!--Left-->
            <div class="flex-1">
                <img class="w-full max-w-md border border-gray-300" src="${product.images()[0].url()}" alt="Product Image">

                <!-- Review Container -->
                <button id="toggleReviewBtn" class="cursor-pointer mt-6 px-6 py-2 bg-blue-600 text-white rounded hover:bg-blue-700 transition">Review</button>

                <div id="reviewModal" class="fixed inset-0 bg-black bg-opacity-50 hidden flex items-center justify-center z-50">
                    <div class="bg-white w-full max-w-2xl p-8 rounded-xl shadow-lg relative">
                        <button id="closeReviewBtn" class="absolute top-4 right-4 text-gray-500 hover:text-black text-2xl">&times;</button>

                        <form id="reviewForm">
                            <h2 class="text-2xl font-semibold mb-6 text-gray-800">Leave a Review</h2>

                            <label class="block text-left text-gray-600 font-semibold mb-2">Rating:</label>
                            <div class="star-rating flex justify-center text-2xl cursor-pointer gap-2" id="starRating">
                                <span class="star text-gray-400 hover:text-yellow-400" data-value="1">&#9733;</span>
                                <span class="star text-gray-400 hover:text-yellow-400" data-value="2">&#9733;</span>
                                <span class="star text-gray-400 hover:text-yellow-400" data-value="3">&#9733;</span>
                                <span class="star text-gray-400 hover:text-yellow-400" data-value="4">&#9733;</span>
                                <span class="star text-gray-400 hover:text-yellow-400" data-value="5">&#9733;</span>
                            </div>
                            <input type="hidden" name="rating" id="ratingValue" value="0">

                            <label for="comment" class="block text-left text-gray-600 font-semibold mt-6">Your Comment:</label>
                            <textarea name="comment" id="comment" required placeholder="Share your experience..." class="w-full p-3 text-base rounded-lg border border-gray-300 resize-none mt-2"></textarea>

                            <label for="images" class="block text-left text-gray-600 font-semibold mt-6">Upload Photos</label>

                            <div class="mt-2">
                                <button type="button" id="uploadBtn" class="cursor-pointer px-2 py-1 bg-green-500 text-white rounded hover:bg-green-600">
                                    Select Images
                                </button>
                                <input type="file" name="images" id="images" multiple accept="image/*" class="hidden">
                                <div id="fileNames" class="mt-2 text-sm text-gray-600"></div>
                            </div>

                            <button type="submit" class="cursor-pointer w-full py-3 mt-6 bg-blue-500 text-white text-lg rounded-lg hover:bg-blue-600">
                                Submit Review
                            </button>
                        </form>
                    </div>
                </div>
            </div>

            <!-- Right -->
            <div class="flex-1">
                <h2 class="text-2xl font-semibold">${product.name()}</h2>
                <div class="text-yellow-500 text-sm mt-1">★★★★☆ 4.9 (2.1k Ratings)</div>
                <div class="text-red-600 text-2xl font-bold mt-2">
                    <span class="text-red-500 text-xl">
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

            <div class="review-section mt-8 max-w-2xl mx-auto bg-white p-6 rounded-xl shadow-md" id="reviewList"></div>
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

        const stars = document.querySelectorAll('.star-rating .star');
        const ratingValue = document.getElementById('ratingValue');
        const reviewForm = document.getElementById('reviewForm');
        const reviewList = document.getElementById('reviewList');
        const uploadBtn = document.getElementById('uploadBtn');
        const fileInput = document.getElementById('images');
        const fileNames = document.getElementById('fileNames');

        const reviewModal = document.getElementById('reviewModal');
        const toggleReviewBtn = document.getElementById('toggleReviewBtn');
        const closeReviewBtn = document.getElementById('closeReviewBtn');

        toggleReviewBtn.addEventListener('click', () => {
            reviewModal.classList.remove('hidden');
        });

        closeReviewBtn.addEventListener('click', () => {
            reviewModal.classList.add('hidden');
        });

        // 星星评分
        stars.forEach((star, index) => {
            star.addEventListener('click', () => {
                const value = parseInt(star.getAttribute('data-value'));
                ratingValue.value = value;
                stars.forEach((s, i) => {
                    s.classList.toggle('text-yellow-400', i < value);
                });
            });

            star.addEventListener('mouseover', () => {
                stars.forEach((s, i) => {
                    s.style.color = i <= index ? '#f4c150' : '#ccc';
                });
            });

            star.addEventListener('mouseout', () => {
                const currentValue = parseInt(ratingValue.value);
                stars.forEach((s, i) => {
                    s.style.color = i < currentValue ? '#f4c150' : '#ccc';
                });
            });
        });

        uploadBtn.addEventListener('click', () => {
            fileInput.click();
        });

        fileInput.addEventListener('change', () => {
            const names = Array.from(fileInput.files).map(f => f.name).join(', ');
            fileNames.textContent = names || "No files selected";
        });

        // 提交 Review
        reviewForm.addEventListener('submit', (e) => {
            e.preventDefault();
            const rating = ratingValue.value;
            const comment = document.getElementById('comment').value;
            const files = document.getElementById('images').files;

            if (!rating || !comment) {
                alert("Please fill in rating and comment.");
                return;
            }

            const review = document.createElement('div');
            review.className = 'review border-t border-gray-200 pt-6 mt-6';

            let starsHTML = '';
            for (let i = 0; i < rating; i++) {
                starsHTML += '★';
            }

            let imagesHTML = '';
            for (let i = 0; i < files.length; i++) {
                const url = URL.createObjectURL(files[i]);
                imagesHTML += `<img src="${url}" class="w-16 h-16 object-cover rounded-md border border-gray-200">`;
            }

            const now = new Date();
            const dateStr = now.toISOString().split('T')[0] + ' ' + now.toTimeString().split(' ')[0];

            review.innerHTML = `
        <div class="user flex items-center gap-3 font-semibold">
            <div class="avatar w-8 h-8 bg-gray-400 rounded-full"></div>
            You
        </div>
        <div class="stars text-yellow-400 mt-2">${rating.rating()}</div>
        <div class="meta text-gray-500 text-xs mt-2">${dateStr} | Variation: Default</div>
        <div class="comment mt-3 text-gray-700">${fn:replace(comment, '', '<br>')}</div>
        <div class="images flex gap-3 mt-3">${imagesHTML}</div>
    `;

            reviewList.prepend(review);

            reviewForm.reset();
            ratingValue.value = 0;
            stars.forEach(s => s.classList.remove('text-yellow-400'));

            reviewModal.classList.add('hidden');
        });

    </script>

    </body>
</webstore:base>
