<%@ page contentType="text/html;charset=UTF-8" %>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="webstore" tagdir="/WEB-INF/tags/webstore" %>

<jsp:useBean id="result" type="com.lavacorp.beautefly.webstore.common.dto.PaginatedResult<com.lavacorp.beautefly.webstore.search.dto.ProductSearchResultDTO>" scope="request"/>
<jsp:useBean id="search" type="com.lavacorp.beautefly.webstore.search.dto.ProductSearchParametersDTO" scope="request"/>

<webstore:base pageTitle="Search">
    <main>
        <form action="${pageContext.request.contextPath}/search" method="get" id="search">
            <div class="not-target:hidden" id="filter">

            </div>

            <div class="flex flex-col items-stretch divide-y divide-gray-500">
                    <%-- search header --%>
                <div class="flex flex-col items-center p-1">
                    <p>Search for:</p>
                    <h2 class="font-bold text-xl">
                        "${search.query()}"
                        (${result.filteredTotal()})
                    </h2>

                    <input type="hidden" name="query" value="${search.query()}">
                    <input type="hidden" name="page" value="${result.page()}">
                    <input type="hidden" name="pageSize" value="${result.pageSize()}">
                </div>

                    <%-- filters --%>
                <div class="p-1 px-3">
                    <button type="button" class="float-left">
                        <i class="fa-solid fa-filter mr-1"></i>
                        Filter
                    </button>
                    <button type="button" popovertarget="sort" class="float-right">
                        <i class="fa-solid fa-sort mr-1"></i>
                        Sort
                    </button>

                    <div id="sort" popover role="menu" class="py-2 px-5 w-52 shadow-xl rounded text-xs"
                         style="position-area: bottom span-left">
                        <ul class="space-y-2">
                            <c:set var="attribute" value="${search.sort()[0].direction()}"/>
                            <c:set var="direction" value="${search.sort()[0].by()}"/>
                            <li>
                                <input type="radio" name="sort" id="sort-by-id"
                                       value="id" ${attribute == 'id' ? 'checked' : ''}
                                       class="peer hidden">
                                <label for="sort-by-id" class="peer-checked:font-bold w-full block">
                                    Default
                                </label>
                            </li>
                            <li>
                                <input type="radio" name="sort" id="sort-by-name-asc"
                                       value="name" ${attribute == 'name' && direction == "asc" ? 'checked' : ''}
                                       class="peer hidden">
                                <label for="sort-by-name-asc" class="peer-checked:font-bold w-full block">
                                    A-Z
                                </label>
                            </li>
                            <li>
                                <input type="radio" name="sort" id="sort-by-name-desc"
                                       value="name" ${attribute == 'name' && direction == "desc" ? 'checked' : ''}
                                       class="peer hidden">
                                <label for="sort-by-name-desc" class="peer-checked:font-bold w-full block">
                                    Z-A
                                </label>
                            </li>
                            <li>
                                <input type="radio" name="sort" id="sort-by-price-desc"
                                       value="unitPrice" ${attribute == 'unitPrice' && direction == "desc" ? 'checked' : ''}
                                       class="peer hidden">
                                <label for="sort-by-price-desc" class="peer-checked:font-bold w-full block">
                                    Price: High to Low
                                </label>
                            </li>
                            <li>
                                <input type="radio" name="sort" id="sort-by-price-asc"
                                       value="unitPrice" ${attribute == 'unitPrice' && direction == "asc" ? 'checked' : ''}
                                       class="peer hidden">
                                <label for="sort-by-price-asc" class="peer-checked:font-bold w-full block">
                                    Price: Low to High
                                </label>
                            </li>
                        </ul>
                    </div>
                </div>

                    <%-- product list --%>
                <div id="product-list"
                     class="grid auto-rows-[60vh] overflow-hidden"
                     style="grid-template-columns: repeat(auto-fill, minmax(28rem, 1fr))">
                    <c:forEach var="product" items="${result.data()}">
                        <jsp:useBean id="product"
                                     type="com.lavacorp.beautefly.webstore.search.dto.ProductSearchResultDTO"/>
                        <div>
                                <%-- product image --%>
                            <div class="h-[85%]">
                                <a href="<c:url value='/product/${product.id()}/${product.slug()}' />">
                                    <img src="<c:url value='${product.images()[0].url()}' />" alt=""
                                         class="object-contain h-full w-full m-auto">
                                </a>
                            </div>
                                <%-- product details --%>
                            <div class="text-center h-[15%] space-y-2 py-2">
                                <h3>
                                    <a href="${pageContext.request.contextPath}/product/${product.id()}/${product.slug()}">
                                            ${product.name()}
                                    </a>
                                </h3>
                                <p><fmt:formatNumber
                                        value="${product.unitPrice()}"
                                        type="currency"
                                        currencySymbol="RM "/></p>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <style>
                    /* grid border thingy */
                    #product-list > div {
                        position: relative;

                        &::before,
                        &::after {
                            content: '';
                            position: absolute;
                            background-color: var(--color-gray-500);
                        }

                        &::before {
                            height: 120vh;
                            width: 1px;
                            left: -1px;
                            top: 0;
                        }

                        &::after {
                            height: 1px;
                            width: 100vw;
                            left: 0;
                            top: -1px;
                        }
                    }
                </style>

                <div class="text-center p-4">
                    Page: ${result.page()} of ${result.maxPage()}
                </div>

                <div class="p-1">
                    <c:if test="${result.hasPrevious()}">
                        <button type="submit" class="float-left" id="previous">Previous</button>
                    </c:if>
                    <c:if test="${result.hasNext()}">
                        <button type="submit" class="float-right" id="next">Next</button>
                    </c:if>
                </div>
            </div>
        </form>
    </main>

    <script>
        const searchForm = document.querySelector('form#search')
        searchForm.addEventListener("submit", function (e) {
            const pageInput = this.querySelector("input[name='page']");

            if (e.submitter.id === "previous")
                pageInput.value = +pageInput.value - 1;

            if (e.submitter.id === "next")
                pageInput.value = +pageInput.value + 1;
        });
    </script>
</webstore:base>

