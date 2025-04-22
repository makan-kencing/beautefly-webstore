<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="webstore" tagdir="/WEB-INF/tags/webstore" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<jsp:useBean id="product" type="com.lavacorp.beautefly.webstore.product.dto.ProductPageDTO" scope="request"/>

<webstore:base pageTitle="${product.name()}">
    <jsp:attribute name="includeHead">
        <link href="https://cdn.jsdelivr.net/npm/raty-js@4.3.0/src/raty.min.css " rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/raty-js@4.3.0/build/raty.min.js"></script>
    </jsp:attribute>

    <jsp:body>
        <dialog id="review" class="backdrop:brightness-50 p-6 rounded-xl max-w-2xl w-full shadow m-auto">
            <form action="<c:url value='/api/rating' />" method="dialog">
                <div>
                    <button type="button" onclick="this.closest('dialog').close()" class="float-right">
                        <i class="fa-solid fa-xmark text-gray-500 hover:text-black"></i>
                    </button>
                </div>

                <div class="space-y-5 p-2">
                    <h2 class="text-2xl font-semibold text-gray-800">Leave a Review</h2>

                    <div class="space-y-4">
                        <%--suppress XmlInvalidId --%>
                        <label for="rating" class="text-gray-600 font-semibold">Rating:</label>
                        <div data-raty class="text-yellow-300 text-xs space-x-2 text-center"></div>
                    </div>

                    <div class="space-y-4">
                        <label for="comment" class="text-gray-600 font-semibold">Your Comment:</label>
                        <textarea name="comment" id="comment" placeholder="Share your experience..."
                                  class="mt-2 w-full p-2 text-base rounded-lg border border-gray-300 resize-none"></textarea>
                    </div>

                    <div class="space-y-4">
                        <p class="text-gray-600 font-semibold">Upload Photos:</p>
                        <label for="images"
                               class="cursor-pointer px-2 py-1 bg-green-500 text-white rounded hover:bg-green-600">
                            Select Images
                        </label>
                        <input type="file" name="images" id="images" multiple accept="image/*" class="hidden">

                        <input type="hidden" name="imageId">
                    </div>

                    <div class="mt-8">
                        <button type="submit"
                                class="cursor-pointer w-full py-3 bg-blue-500 text-white text-lg rounded-lg hover:bg-blue-600">
                            Submit Review
                        </button>
                    </div>
                </div>
            </form>

            <script>
                const ratingStar = document.querySelector('[data-raty]');
                const raty = new Raty(ratingStar, {
                    starType: "i",
                    scoreName: "rating",
                    value: 0
                });

                raty.init();
            </script>
        </dialog>

        <main class="font-sans px-10 py-4">
            <div class="flex gap-10 mb-5 *:flex-1">
                <div>
                    <img class="w-full max-w-md border border-gray-300" src="${product.images()[0].url()}"
                         alt="Product Image">
                </div>

                <form action="<c:url value='/cart/add' />" method="post">
                    <input type="hidden" name="productId" value="${product.id()}">

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
                        <label for="quantity" class="text-base text-gray-600">Quantity</label>
                        <div class="flex border border-gray-300 rounded overflow-hidden h-8">
                            <button onclick="changeQty(-1)" class="cursor-pointer w-8 bg-white text-gray-400 text-lg">
                                −
                            </button>
                            <input type="text" name="quantity" id="quantity" value="1" min="1" readonly
                                   class="w-10 text-center text-base text-gray-800 border-none outline-none">
                            <button onclick="changeQty(1)" class="cursor-pointer w-8 bg-white text-gray-400 text-lg">
                                +
                            </button>
                        </div>
                    </div>

                    <button type="submit"
                            class="cursor-pointer mt-6 px-6 py-2 bg-blue-600 text-white rounded hover:bg-blue-700 transition">
                        Add to Cart
                    </button>
                </form>

                <script>
                    function changeQty(amount) {
                        const quantityInput = this.parentElement.querySelector("input#quantity");

                        let value = parseInt(quantityInput.value);
                        if (isNaN(value)) value = 1;
                        value += amount;
                        if (value < 1) value = 1;

                        quantityInput.value = value;
                    }
                </script>
            </div>


            <div class="border-t border-gray-300 pt-8">
                <button onclick="window.review.showModal()"
                        class="cursor-pointer mt-6 px-6 py-2 bg-blue-600 text-white rounded hover:bg-blue-700 transition">
                    Review
                </button>
                <div class="bg-orange-50 border border-orange-200 p-6">
                    <h3 class="text-xl font-semibold mb-2">Product Ratings</h3>
                    <div class="text-red-600 text-4xl font-bold mb-1">4.9 <span
                            class="text-base font-normal">out of 5</span></div>
                    <div class="text-red-600 text-2xl mb-2">★★★★★</div>
                    <div class="space-x-2 text-sm">
                        <button class="px-3 py-1 border border-gray-300 bg-white">All</button>
                        <button class="px-3 py-1 border border-gray-300 bg-white">5 Star (1.9k)</button>
                        <button class="px-3 py-1 border border-gray-300 bg-white">4 Star (101)</button>
                        <button class="px-3 py-1 border border-gray-300 bg-white">3 Star (36)</button>
                        <button class="px-3 py-1 border border-gray-300 bg-white">2 Star (10)</button>
                        <button class="px-3 py-1 border border-gray-300 bg-white">1 Star (10)</button>
                        <br>
                        <button class="px-3 py-1 border border-gray-300 bg-white mt-2">With Comments (731)</button>
                        <button class="px-3 py-1 border border-gray-300 bg-white mt-2">With Media (456)</button>
                    </div>
                </div>

                <div class="review-section mt-8 max-w-2xl mx-auto bg-white p-6 rounded-xl shadow-md"
                     id="reviewList"></div>
            </div>

            <script>


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

                fileInput.addEventListener('change', () => {
                    const names = Array.from(fileInput.files).map(f => f.name).join(', ');
                    fileNames.textContent = names || "No files selected";
                });

                reviewForm.addEventListener('submit', (e) => {
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

                    reviewList.prepend(review);

                    reviewForm.reset();
                    ratingValue.value = 0;
                    stars.forEach(s => s.classList.remove('text-yellow-400'));

                    reviewModal.classList.add('hidden');
                });

            </script>
        </main>
    </jsp:body>
</webstore:base>
