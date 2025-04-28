<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="webstore" tagdir="/WEB-INF/tags/webstore" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<jsp:useBean id="product" type="com.lavacorp.beautefly.webstore.product.dto.ProductPageDTO" scope="request" />

<webstore:base pageTitle="Review">
    <jsp:attribute name="includeHead">
        <link href="https://cdn.jsdelivr.net/npm/raty-js@4.3.0/src/raty.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/raty-js@4.3.0/build/raty.min.js"></script>
    </jsp:attribute>

    <jsp:body>
        <main class="flex flex-col items-center p-6">

            <form id="review"
                  action="<c:url value='/review' ><c:param name='productId' value='${product.id()}'/></c:url>"
                  method="post"
                  enctype="multipart/form-data"
                  class="w-4xl space-y-5">
                <h2 class="text-2xl font-bold">Leave a Review</h2>

                <div class="space-y-3">
                    <div class="horizontal items-center">
                        <img src="<c:url value='${product.images()[0].url()}' />" alt="" class="h-10">
                        <h2 class="text-xl font-bold">How was the item?</h2>
                    </div>

                    <div class="space-y-2">
                        <div data-raty data-star-type="i" data-score-name="rating"
                             class="text-yellow-300 space-x-2 peer">
                        </div>
                        <div class="text-bad not-peer-data-invalid:hidden">
                            Choose a rating to continue
                        </div>
                    </div>

                    <div class="space-y-2">
                        <label for="title" class="block font-semibold">Title</label>
                        <input type="text" name="title" id="title" placeholder="What's most important to know?"
                               class="border border-gray-300 rounded-lg p-2 w-full">
                    </div>

                        <%-- https://css-tricks.com/the-cleanest-trick-for-autogrowing-textareas/ --%>
                    <style>
                        .grow-wrap {
                            display: grid;

                            &::after {
                                content: attr(data-replicated-value) " ";
                                white-space: pre-wrap;
                                visibility: hidden;
                            }

                            > textarea {
                                resize: none;
                                overflow: hidden;
                            }

                            > textarea,
                            &::after {
                                grid-area: 1 / 1 / 2 / 2;
                            }
                        }
                    </style>

                    <div class="space-y-2">
                        <label for="message" class="block font-semibold">Message</label>
                        <div class="grow-wrap after:text-base after:rounded-lg after:border after:border-gray-300">
                            <textarea name="message" id="message" placeholder="What should other customers know?"
                                      class="w-full p-2 text-base rounded-lg border border-gray-300"
                                      onInput="this.parentNode.dataset.replicatedValue = this.value"></textarea>
                        </div>
                    </div>

                    <div class="space-y-2">
                        <p class="font-semibold">Upload Photos</p>

                        <div id="files" class="peer empty:hidden flex gap-2
                                *:h-20 *:w-20 *:object-cover *:border *:rounded-lg *:border-gray-300 *:bg-gray-50
                                text-3xl text-gray-500"></div>

                        <label for="images"
                               class="block cursor-pointer p-6 w-full border border-dashed rounded-lg border-gray-300 bg-gray-50 text-center not-peer-empty:hidden">
                            <i class="fa-solid fa-camera"></i> Share a video or photo
                        </label>

                        <button type="button" onclick="clearImages()" class="border rounded-lg border-red-100 button-bad font-bold peer-empty:hidden">
                            <i class="fa-solid fa-trash mr-2"></i> Clear Images
                        </button>

                        <input type="file" name="images" id="images" multiple accept="image/*" hidden>
                    </div>

                    <div>
                        <button type="submit"
                                class="float-right cursor-pointer px-6 py-2 bg-blue-500 text-white rounded-lg hover:bg-blue-600">
                            Submit
                        </button>
                    </div>
                </div>
            </form>

            <script>
                const ratyContainer = document.querySelector('[data-raty]');
                const raty = new Raty(ratyContainer, {
                    click: () => {delete ratyContainer.dataset.invalid}
                });

                raty.init();
            </script>
            <script>
                const reviewFileInput = document.querySelector("input[type='file']");
                const imageDisplays = document.querySelector("#files");
                reviewFileInput.addEventListener("change", function (e) {
                    imageDisplays.textContent = "";  // remove children

                    for (const image of this.files) {
                        const child = document.createElement("img");

                        const reader = new FileReader();
                        reader.onload = (e) => {
                            child.src = e.target.result;
                        };
                        reader.readAsDataURL(image);

                        imageDisplays.appendChild(child);
                    }
                });

                function clearImages() {
                    imageDisplays.textContent = "";  // remove children

                    reviewFileInput.value = null;
                }

                document.querySelector("form#review").addEventListener("submit", function (e) {
                    e.preventDefault();

                    const score = raty.score();

                    if (score)
                        this.submit();
                    else
                        ratyContainer.dataset.invalid = "";
                })
            </script>
        </main>
    </jsp:body>
</webstore:base>
