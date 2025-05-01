<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="webstore" tagdir="/WEB-INF/tags/webstore" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<jsp:useBean id="product" type="com.lavacorp.beautefly.webstore.product.dto.ProductPageDTO" scope="request"/>
<jsp:useBean id="reviews" type="java.util.List<com.lavacorp.beautefly.webstore.rating.dto.RatingDTO>" scope="request"/>

<webstore:base pageTitle="${product.name()}">
    <jsp:attribute name="includeHead">
        <link href="https://cdn.jsdelivr.net/npm/raty-js@4.3.0/src/raty.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/raty-js@4.3.0/build/raty.min.js"></script>
    </jsp:attribute>

    <jsp:body>
        <main class="font-sans px-10 py-4 space-y-5">
            <div class="flex justify-center gap-x-8 px-4 min-h-[80vh]">
                <div class="w-[55%] max-w-[600px] items-center justify-center gap-10 flex flex-col">
                    <img class="w-full max-w-md border-4 border-gray-300 rounded-md" src="${product.images()[0].url()}" alt="">
                </div>

                <form action="<c:url value='/cart/add' />" method="post"
                      class="w-[35%] max-w-[400px] items-center justify-center gap-10 flex flex-col">
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

                    <div class="flex items-center gap-4">
                        <label for="quantity" class="text-base text-gray-600">Quantity</label>
                        <div class="flex border border-gray-300 rounded overflow-hidden h-8">
                            <button type="button" onclick="changeQty.call(this, -1)"
                                    class="cursor-pointer w-8 bg-white text-gray-400 text-lg">−
                            </button>
                            <input type="text" name="quantity" id="quantity" value="1" min="1" readonly
                                   class="w-10 text-center text-base text-gray-800 border-none outline-none">
                            <button type="button" onclick="changeQty.call(this, 1)"
                                    class="cursor-pointer w-8 bg-white text-gray-400 text-lg">+
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

            <div class="max-w-screen-xl mx-auto px-4 flex gap-8 *:bg-white *:rounded-xl *:shadow-md">
                    <%-- Left --%>
                <div class="p-6 w-sm space-y-6">
                    <div class="space-y-2">
                        <h2 class="text-xl font-semibold">Customer ratings</h2>
                        <div class="text-orange-400 text-4xl font-bold mb-1">
                            4.9 <span class="text-base font-normal">out of 5</span>
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
                            <a href="<c:url value='/review' ><c:param name='productId' value='${product.id()}'/></c:url>"
                               class="font-bold text-center block cursor-pointer w-full px-6 py-2 bg-blue-300 text-white rounded-xl hover:bg-blue-400 transition">
                                Write a review
                            </a>
                        </div>
                    </c:if>
                </div>

                    <%-- Right --%>
                <div class="space-y-6 p-6 flex-1">
                    <c:forEach var="review" items="${reviews}">
                        <div class="comment rounded-lg p-4 shadow-lg bg-white">
                            <div class="flex items-center space-x-2 mb-2">
                                <img src="${review.account().profileImage().url()}" alt="" class="w-8 h-8 rounded-full">
                                <span class="font-semibold">${review.account().username()}</span>
                            </div>

                            <div>
                                <span class="text-base font-semibold text-gray-800">${review.title()}</span><br/>
                                <span data-raty data-star-type="i" data-read-only="true" data-score="${review.rating()}"
                                    class="text-orange-400 text-[3xl] text-[0.5rem]"></span>
                            </div>
                            <div class="text-gray-700 text-sm mb-4">
                                    ${review.message()}
                            </div>

                            <div class="flex gap-4 mt-2">
                                <c:forEach var="reviewImages" items="${review.images()}" >
                                    <img src="${reviewImages.url()}" alt="" class="w-[175px] h-[125px]">
                                </c:forEach>
                            </div>

                            <c:if test="${pageContext.request.userPrincipal != null}">
                                <button class="mt-3 text-blue-500 reply-button cursor-pointer">Reply</button>
                            </c:if>
                            
                            <div class="reply-box hidden mt-3">
                                <form id="reply-form"
                                      action="<c:url value='/reply'/>"
                                      method="post"
                                      class="reply-form w-full space-y-3">
                                    <input type="hidden" name="ratingId" value="${review.id()}" />
                                    <textarea name="message" class="w-full p-2 border border-gray-300 rounded-lg" rows="3"
                                              placeholder="Write your reply..."></textarea>
                                    <button type="submit" class="cursor-pointer mt-2 bg-blue-500 text-white py-1 px-4 rounded-lg">
                                        Submit Reply
                                    </button>
                                </form>
                            </div>

                            <c:forEach var="reply" items="${review.replies()}">
                            <div class="replies mt-3 space-y-2 p-2 bg-gray-50 rounded-lg max-h-60 overflow-y-auto">
                                <div>
                                    <div class="flex items-center space-x-2 mb-2">
                                        <img src="${reply.account().profileImage().url()}" alt="" class="w-8 h-8 rounded-full">
                                        <span class="font-medium text-sm">${reply.account().username()}</span>
                                    </div>
                                    <span class="text-sm text-gray-700">${reply.message()}</span>
                                </div>
                            </div>
                            </c:forEach>
                        </div>
                    </c:forEach>
                </div>

            </div>

            <script>
                const ratingStars = document.querySelectorAll('[data-raty]');
                for (const star of ratingStars) {
                    let raty = new Raty(star);
                    raty.init();
                }

                document.querySelectorAll('.reply-button').forEach(button => {
                    button.addEventListener('click', () => {
                        const replyBox = button.nextElementSibling;
                        replyBox.style.display = replyBox.style.display === 'block' ? 'none' : 'block';
                    });
                });

                function submitReply(button) {
                    const replyBox = button.parentElement;
                    const textarea = replyBox.querySelector('textarea');
                    const replyText = textarea.value.trim();

                    if (!replyText) {
                        alert('Enter reply...');
                        return;
                    }

                    const repliesContainer = replyBox.nextElementSibling;

                    const replyDiv = document.createElement('div');
                    replyDiv.className = 'reply border-b border-gray-300 py-2';

                    const userContainer = document.createElement('div');
                    userContainer.className = 'flex items-center mb-1';

                    const avatar = document.createElement('img');
                    avatar.src = '';
                    avatar.alt = 'Avatar';
                    avatar.className = 'w-6 h-6 rounded-full mr-2';

                    const usernameDiv = document.createElement('span');
                    usernameDiv.className = 'font-semibold text-sm';
                    usernameDiv.textContent = 'Me';

                    userContainer.appendChild(avatar);
                    userContainer.appendChild(usernameDiv);

                    const textDiv = document.createElement('div');
                    textDiv.className = 'text-sm text-gray-700';
                    textDiv.textContent = replyText;

                    replyDiv.appendChild(userContainer);
                    replyDiv.appendChild(textDiv);
                    repliesContainer.appendChild(replyDiv);

                    textarea.value = '';
                    replyBox.style.display = 'none';
                }


            </script>
        </main>
    </jsp:body>
</webstore:base>
