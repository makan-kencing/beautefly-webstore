<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="admin" tagdir="/WEB-INF/tags/admin" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:useBean id="product" type="com.lavacorp.beautefly.webstore.admin.product.dto.ProductDetailsDTO" scope="request"/>
<jsp:useBean id="context" type="com.lavacorp.beautefly.webstore.admin.product.dto.CreateProductContext"
             scope="request"/>

<admin:base pageTitle="Product Details">
    <jsp:attribute name="includeHead">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css"/>
        <script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>

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
    </jsp:attribute>

    <jsp:body>
        <main class="vertical p-4">
            <!-- Page Header + Toggle Edit Btn -->
            <div class="flex justify-between items-center">
                <h2 class="text-2xl font-bold">Product Details</h2>
                <div class="horizontal">
                    <form action="<c:url value='/admin/product/delete' />" method="post">
                        <input type="hidden" name="id" value="${product.id()}">
                        <button type="submit" class="button-bad">Delete Product</button>
                    </form>
                    <button type="button" onclick="document.querySelector('dialog#edit-product').showModal();"
                            class="button-link">
                        Edit Product
                    </button>
                </div>
            </div>

            <div class="vertical">
                <div class="horizontal">

                    <div class="border rounded-xl border-border shadow-md p-4 flex-1 space-y-2">
                        <div id="images" class="w-[33vw] overflow-hidden">
                            <div class="swiper-wrapper">
                                <c:forEach var="image" items="${product.images()}">
                                    <div class="swiper-slide flex! flex-col gap-2">
                                        <img src="${image.url()}" alt="">

                                        <form action="<c:url value='/admin/product/image/remove' />" method="post">
                                            <input type="hidden" name="id" value="${product.id()}">
                                            <input type="hidden" name="imageId" value="${image.id()}">

                                            <button type="submit" class="button-bad w-full text-center">Remove</button>
                                        </form>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>

                        <form action="<c:url value='/admin/product/image/upload' />" method="post"
                              enctype="multipart/form-data" class="vertical">
                            <input type="hidden" name="id" value="${product.id()}">

                            <label for="upload-image" class="button-link w-full text-center">Upload Image</label>

                            <input type="file" name="image" id="upload-image" accept="image/*" class="hidden"
                                   onchange="this.closest('form').submit()">
                        </form>

                        <script>
                            new Swiper('#images', {
                                direction: 'horizontal',
                                loop: true,
                            });
                        </script>
                    </div>

                    <div class="border rounded-xl border-border shadow-md p-4 flex-2 horizontal items-start *:flex-1">
                        <div class="vertical">
                            <div class="p-2 border border-border">
                                <table class="**:[tr]:odd:bg-gray-100 **:[td]:p-2">
                                    <tr>
                                        <td class="w-[5%]"><i class="fa-solid fa-barcode"></i></td>
                                        <td>Id</td>
                                        <td>#${product.id()}</td>
                                    </tr>
                                    <tr>
                                        <td><i class="fa-brands fa-product-hunt"></i></td>
                                        <td>Name</td>
                                        <td>${product.name()}</td>
                                    </tr>
                                    <tr>
                                        <td><i class="fa-solid fa-circle-info"></i></td>
                                        <td>Description</td>
                                        <td>${product.description()}</td>
                                    </tr>
                                </table>
                            </div>

                            <div class="p-2 border border-border">
                                <table class="**:[tr]:odd:bg-gray-100 **:[td]:p-2">
                                    <tr>
                                        <td class="w-[5%]"><i class="fa-solid fa-box"></i></td>
                                        <td>Stock Count</td>
                                        <td>${product.stockCount()}</td>
                                    </tr>
                                </table>
                            </div>
                        </div>

                        <div class="p-2 border border-border">
                            <table class="**:[tr]:odd:bg-gray-100 **:[td]:p-2">
                                <tr>
                                    <td class="w-[5%]"><i class="fa-solid fa-copyright"></i></td>
                                    <td>Brand</td>
                                    <td>${product.brand()}</td>
                                </tr>
                                <tr>
                                    <td><i class="fa-solid fa-tag"></i></td>
                                    <td>Category</td>
                                    <td>${product.category().name()}</td>
                                </tr>
                                <tr>
                                    <c:set var="color" value="${product.color()}"/>
                                        <%--suppress ELValidationInspection --%>
                                    <c:set var="r" value="${color.color().red}"/>
                                        <%--suppress ELValidationInspection --%>
                                    <c:set var="g" value="${color.color().green}"/>
                                        <%--suppress ELValidationInspection --%>
                                    <c:set var="b" value="${color.color().blue}"/>

                                    <td><i class="fa-solid fa-brush"></i></td>
                                    <td>Color</td>
                                        <%--suppress ELValidationInspection --%>
                                    <td style="color: rgb(${r}, ${g}, ${b})">${color.name()}</td>
                                </tr>
                                <tr>
                                    <td><i class="fa-solid fa-money-check"></i></td>
                                    <td>Unit Cost</td>
                                    <td><fmt:formatNumber value="${product.unitCost()}" type="currency"
                                                          currencySymbol="RM "/></td>
                                </tr>
                                <tr>
                                    <td><i class="fa-solid fa-money-check-dollar"></i></td>
                                    <td>Unit Price</td>
                                    <td>
                                        <fmt:formatNumber value="${product.unitPrice()}" type="currency"
                                                          currencySymbol="RM "/>
                                    </td>
                                </tr>
                                <tr>
                                    <td><i class="fa-solid fa-calendar-days"></i></td>
                                    <td>Release Date</td>
                                    <td>${product.releaseDate()}</td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
            </div>


        </main>

        <c:url var="endpoint" value='/admin/product/edit'/>
        <admin:dialog-form dialogid="edit-product" action="${endpoint}" method="post"
                           title="Add Product">
            <input type="hidden" name="id" value="${product.id()}">

            <div class="horizontal *:flex-1 space-y-0! *:space-y-2">
                <div>
                    <label for="name" class="block">Product Name *</label>
                    <input type="text" name="name" id="name" value="${product.name()}" required
                           class="w-full border border-border py-1 px-2 rounded">
                </div>

                <div>
                    <label for="brand" class="block">Brand *</label>
                    <input type="text" name="brand" id="brand" list="brands" value="${product.brand()}" required
                           class="w-full border border-border py-1 px-2 rounded">
                    <datalist id="brands">
                        <c:forEach var="brand" items="${context.existingBrands()}">
                            <option value="${brand}">${brand}</option>
                        </c:forEach>
                    </datalist>
                </div>
            </div>


            <div>
                <label for="description" class="block">Description</label>
                <div class="grow-wrap after:text-base after:rounded-lg after:border after:border-gray-300">
                    <textarea name="description" id="description"
                              class="w-full p-2 text-base rounded-lg border border-gray-300"
                              onInput="this.parentNode.dataset.replicatedValue = this.value">${product.description()}</textarea>
                </div>
            </div>

            <div class="horizontal *:flex-1 space-y-0! *:space-y-2">
                <div>
                    <label for="category" class="block">Category *</label>
                    <select name="categoryId" id="category" required
                            class="w-full border border-border py-1 px-2 rounded">
                        <option value=""></option>
                        <c:forEach var="category" items="${context.availableCategories()}">
                            <jsp:useBean id="category"
                                         type="com.lavacorp.beautefly.webstore.product.dto.CategoryTreeDTO"/>

                            <option value="${category.id()}" disabled
                                    class="font-bold">
                                    ${category.name()}
                            </option>

                            <c:forEach var="category" items="${category.subcategories()}">

                                <option value="${category.id()}" disabled
                                        class="font-semibold">
                                    - ${category.name()}
                                </option>

                                <c:forEach var="category" items="${category.subcategories()}">

                                    <option value="${category.id()}"
                                        ${category.id() == product.category().id() ? "selected" : ""}>
                                        - - ${category.name()}
                                    </option>

                                </c:forEach>
                            </c:forEach>
                        </c:forEach>
                    </select>
                </div>

                <div>
                    <label for="color" class="block">Color</label>
                    <select name="colorId" id="color"
                            class="w-full border border-border py-1 px-2 rounded">
                        <option value=""></option>
                        <c:forEach var="color" items="${context.availableColor()}">
                            <%--suppress ELValidationInspection --%>
                            <c:set var="r" value="${color.color().red}"/>
                            <%--suppress ELValidationInspection --%>
                            <c:set var="g" value="${color.color().green}"/>
                            <%--suppress ELValidationInspection --%>
                            <c:set var="b" value="${color.color().blue}"/>

                            <%--suppress ELValidationInspection --%>
                            <option value="${color.id()}" style="color: rgb(${r}, ${g}, ${b})" class="font-bold"
                                ${color.id() == product.color().id() ? "selected" : ""}>
                                    ${color.name()}
                            </option>
                        </c:forEach>
                    </select>
                </div>
            </div>

            <div class="horizontal *:flex-1 space-y-0! *:space-y-2">
                <div>
                    <label for="unitCost" class="block">Unit Cost (RM) *</label>
                    <input type="number" name="unitCost" id="unitCost" step="0.01" value="${product.unitCost()}"
                           required
                           class="w-full border border-border py-1 px-2 rounded">
                </div>

                <div>
                    <label for="unitPrice" class="block">Unit Price (RM) *</label>
                    <input type="number" name="unitPrice" id="unitPrice" step="0.01" value="${product.unitPrice()}"
                           required
                           class="w-full border border-border py-1 px-2 rounded">
                </div>
            </div>

            <div>
                <label for="releaseDate" class="block">Release Date *</label>
                <input type="date" name="releaseDate" id="releaseDate" value="${product.releaseDate()}" required
                       class="w-full border border-border py-1 px-2 rounded">
            </div>

            <div>
                <label for="stockCount" class="block">Stock *</label>
                <input type="number" name="stockCount" id="stockCount" min="0" step="1" value="${product.stockCount()}"
                       required
                       class="w-full border border-border py-1 px-2 rounded">
            </div>
        </admin:dialog-form>
    </jsp:body>

</admin:base>
