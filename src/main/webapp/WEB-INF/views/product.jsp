<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="webstore" tagdir="/WEB-INF/tags/webstore" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<jsp:useBean id="product" type="com.lavacorp.beautefly.webstore.product.dto.ProductPageDTO" scope="request"/>

<webstore:base pageTitle="${product.name()}">
    <jsp:attribute name="includeHead">
        <link href="https://cdn.jsdelivr.net/npm/raty-js@4.3.0/src/raty.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/raty-js@4.3.0/build/raty.min.js"></script>
    </jsp:attribute>

    <jsp:body>
        <main class="font-sans px-10 py-4 space-y-5">
            <div class="flex min-h-[80vh]">
                <div class="w-[60vw]">
                    <img class="w-full max-w-md" src="${product.images()[0].url()}"
                         alt="">
                </div>

                <form action="<c:url value='/cart/add' />" method="post"
                      class="gap-10 flex flex-col items-center justify-center w-[40vw]">
                    <input type="hidden" name="productId" value="${product.id()}">

                    <div class="flex flex-col items-center gap-2">
                        <h2 class="text-2xl font-semibold">${product.name()}</h2>

                        <div class="flex items-center gap-1 text-sm">
                            4.6
                            <span data-raty data-star-type="i" data-read-only="true"
                                  data-half-show="true" data-score="4.6" class="text-orange-400 text-[0.5rem]"></span>
                            (100)
                        </div>

                        <div class="text-red-600 text-2xl font-bold">
                            <span class="text-red-500 text-xl">
                                <fmt:formatNumber value="${product.unitPrice()}" type="currency" currencySymbol="RM "/>
                            </span>
                        </div>
                    </div>

                    <p class="text-gray-700">${product.description()}</p>

                    <!-- Quantity -->
                    <div class="flex items-center gap-4">
                        <label for="quantity" class="text-base text-gray-600">Quantity</label>
                        <div class="flex border border-gray-300 rounded overflow-hidden h-8">
                            <button type="button" onclick="changeQty.call(this, -1)"
                                    class="cursor-pointer w-8 bg-white text-gray-400 text-lg">
                                −
                            </button>
                            <input type="text" name="quantity" id="quantity" value="1" min="1" readonly
                                   class="w-10 text-center text-base text-gray-800 border-none outline-none">
                            <button type="button" onclick="changeQty.call(this, 1)"
                                    class="cursor-pointer w-8 bg-white text-gray-400 text-lg">
                                +
                            </button>
                        </div>
                    </div>

                    <button type="submit"
                            class="cursor-pointer px-6 py-2 bg-blue-600 text-white rounded hover:bg-blue-700 transition">
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


            <div class="flex gap-10 *:bg-white *:rounded-xl *:shadow-md">
                    <%-- Left --%>
                <div class="p-6 w-sm space-y-6">
                    <div class="space-y-2">
                        <h2 class="text-xl font-semibold">Customer ratings</h2>

                        <div class="text-orange-400 text-4xl font-bold mb-1">
                            4.9
                            <span class="text-base font-normal">out of 5</span>
                        </div>

                        <div data-raty data-star-type="i" data-read-only="true"
                             data-half-show="true" data-score="4.6"
                             class="text-orange-400"></div>

                        <p>{total} ratings</p>

                        <table class="whitespace-nowrap text-right border-separate border-spacing-x-2 border-spacing-y-3
                            **:[td]:even:w-full **:[td]:even:*:h-full **:[td]:even:border **:[td]:even:rounded-lg">
                            <tr>
                                <td>5 star</td>
                                <td>
                                    <div></div>
                                </td>
                                <td>312</td>
                            </tr>
                            <tr>
                                <td>4 star</td>
                                <td>
                                    <div></div>
                                </td>
                                <td>11</td>
                            </tr>
                            <tr>
                                <td>3 star</td>
                                <td>
                                    <div></div>
                                </td>
                                <td>30</td>
                            </tr>
                            <tr>
                                <td>2 star</td>
                                <td>
                                    <div></div>
                                </td>
                                <td>1</td>
                            </tr>
                            <tr>
                                <td>1 star</td>
                                <td>
                                    <div></div>
                                </td>
                                <td>1</td>
                            </tr>
                        </table>
                    </div>

                    <c:if test="${true}">
                        <hr class="text-gray-300">

                        <div class="space-y-2">
                            <h2 class="text-xl font-semibold">Review this product</h2>
                            <a href="<c:url value='/review/product/${product.id()}' />"
                               class="font-bold text-center block cursor-pointer w-full px-6 py-2 bg-blue-300 text-white rounded-xl hover:bg-blue-400 transition">
                                Write a review
                            </a>
                        </div>
                    </c:if>
                </div>

                    <%-- Right --%>
                <div class="p-6 space-y-2 flex-1">
                    <h2 class="text-xl font-semibold">Reviews</h2>

                    <div class="space-y-6">
                        <div>
                            <div>
                                <img src="" alt="">
                                <span>Name</span>
                            </div>

                            <div>
                                    <span data-raty data-star-type="i" data-read-only="true" data-score="4"
                                          class="text-orange-400 text-[0.5rem]"></span>
                                <span class="font-bold">Title</span>
                            </div>

                            <div>
                                Lorem ipsum dolor sit amet, consectetur adipisicing elit. A atque dignissimos est
                                hic, iste itaque libero quo vel voluptatum. Quisquam?
                            </div>
                        </div>


                    </div>
                </div>
            </div>

            <script>
                const ratingStars = document.querySelectorAll('[data-raty]');
                for (const star of ratingStars) {
                    let raty = new Raty(star);

                    raty.init();
                }
            </script>
        </main>
    </jsp:body>
</webstore:base>
