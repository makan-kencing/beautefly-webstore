<%@ page contentType="text/html;charset=UTF-8" %>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="webstore" tagdir="/WEB-INF/tags/webstore" %>

<jsp:useBean id="result" type="com.lavacorp.beautefly.webstore.product.dto.ProductSearchResultDTO" scope="request"/>

<webstore:base pageTitle="Cart">
    <main>
        <form action="${pageContext.request.contextPath}/search" method="get">
            <div class="not-target:hidden" id="filter">

            </div>

            <div class="flex flex-col items-stretch *:border-b">
                    <%-- search header --%>
                <div class="flex flex-col items-center">
                    <p>Search for:</p>
                    <h2 class="font-bold text-xl">
                        "${result.search().query()}"
                        (${result.page().total()})
                    </h2>

                    <input type="hidden" name="query" value="${result.search().query()}">
                    <input type="hidden" name="page" value="${result.page().page()}">
                    <input type="hidden" name="pageSize" value="${result.page().pageSize()}">
                </div>

                    <%-- filters --%>
                <div>
                    <button type="button" class="float-left">
                        <i class="fa-solid fa-filter"></i>
                        Filter
                    </button>
                    <button type="button" popovertarget="sort" class="float-right">
                        <i class="fa-solid fa-sort"></i>
                        Sort
                    </button>

                    <div id="sort" popover role="menu" style="position-area: bottom">
                        <ul>
                            <li>
                                <input type="radio" name="sort" id="sort-by-id"
                                       value="id" ${result.search().sort() == 'id' ? 'checked' : ''}
                                       class="peer invisible">
                                <label for="sort-by-id" class="peer-checked:font-bold">Default</label>
                            </li>
                            <li>
                                <input type="radio" name="sort" id="sort-by-name-asc"
                                       value="name" ${result.search().sort() == 'name' ? 'checked' : ''}
                                       class="peer invisible">
                                <label for="sort-by-name-asc" class="peer-checked:font-bold">A-Z</label>
                            </li>
                            <li>
                                <input type="radio" name="sort" id="sort-by-name-desc"
                                       value="nameDesc" ${result.search().sort() == 'nameDesc' ? 'checked' : ''}
                                       class="peer invisible">
                                <label for="sort-by-name-desc" class="peer-checked:font-bold">Z-A</label>
                            </li>
                            <li>
                                <input type="radio" name="sort" id="sort-by-price-desc"
                                       id="priceDesc" ${result.search().sort() == 'priceDesc' ? 'checked' : ''}
                                       class="peer invisible">
                                <label for="sort-by-price-desc" class="peer-checked:font-bold">Price: High to
                                    Low</label>
                            </li>
                            <li>
                                <input type="radio" name="sort" id="sort-by-price-asc"
                                       id="price" ${result.search().sort() == 'price' ? 'checked' : ''}
                                       class="peer invisible">
                                <label for="sort-by-price-asc" class="peer-checked:font-bold">Price: Low to High</label>
                            </li>
                        </ul>
                    </div>
                </div>

                    <%-- product list --%>
                <div id="product-list" class="grid grid-cols-[repeat(auto-fill,minmax(28rem,1fr))] auto-rows-[60vh]">
                    <c:forEach var="product" items="${result.page().content()}">
                        <jsp:useBean id="product" type="com.lavacorp.beautefly.webstore.product.dto.ProductDTO"/>
                        <div>
                                <%-- product image --%>
                            <div class="h-[80%]">
                                <a href="${pageContext.request.contextPath}/product/${product.id()}/${product.slug()}">
                                    <img src="${product.imageUrls()[0]}" alt="${product.name()}"
                                         class="object-contain h-full w-full m-auto">
                                </a>
                            </div>
                                <%-- product details --%>
                            <div class="flex flex-col items-center h-[20%]">
                                <h3>
                                    <a href="${pageContext.request.contextPath}/product/${product.id()}/${product.slug()}">
                                            ${product.name()}
                                    </a>
                                </h3>
                                <p><fmt:formatNumber value="${product.unitPrice()}" type="currency"
                                                     currencySymbol="RM "/></p>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <div>
                    Page: ${result.page().page()} of ${result.page().maxPage()}
                </div>

                <div>
                    <c:if test="${result.page().hasPrevious()}">
                        <button type="submit" onsubmit="setPreviousPage()" class="float-left">Previous</button>
                    </c:if>
                    <c:if test="${result.page().hasNext()}">
                        <button type="submit" onsubmit="setNextPage()" class="float-right">Next</button>
                    </c:if>
                </div>
            </div>
        </form>
    </main>

    <script>
        function setPreviousPage() {
            const form = this.closest("form");
            const pageField = form.querySelector("input[name='page']");

            pageField.value -= 1;
        }

        function setNextPage() {
            const form = this.closest("form");
            const pageField = form.querySelector("input[name='page']");

            pageField.value += 1;
        }
    </script>
</webstore:base>

