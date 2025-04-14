<%@ page contentType="text/html;charset=UTF-8" %>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="webstore" tagdir="/WEB-INF/tags/webstore" %>

<jsp:useBean id="result" type="com.lavacorp.beautefly.webstore.product.dto.ProductSearchContext" scope="request"/>

<webstore:base pageTitle="Cart">
    <main>
        <form action="${pageContext.request.contextPath}/search" method="get">
            <div class="not-target:hidden" id="filter">

            </div>

            <div class="flex flex-col items-center *:border-b">
                    <%-- search header --%>
                <div>
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
                    <button>
                        <i class="fa-solid fa-filter"></i>
                        Filter
                    </button>
                    <span class="mx-auto"></span>
                    <button popovertarget="sort">
                        <i class="fa-solid fa-sort"></i>
                        Sort
                    </button>

                    <div id="sort" popover role="menu">
                        <label>
                            <input type="radio" name="sort"
                                   value="id" ${result.search().sort() == 'id' ? 'checked' : ''}>
                            Default
                        </label>
                        <label>
                            <input type="radio" name="sort"
                                   value="name" ${result.search().sort() == 'name' ? 'checked' : ''}>
                            A-Z
                        </label>
                        <label>
                            <input type="radio" name="sort"
                                   value="nameDesc" ${result.search().sort() == 'nameDesc' ? 'checked' : ''}>
                            Z-A
                        </label>
                        <label>
                            <input type="radio" name="sort"
                                   id="priceDesc" ${result.search().sort() == 'priceDesc' ? 'checked' : ''}>
                            Price: High to Low
                        </label>
                        <label>
                            <input type="radio" name="sort"
                                   id="price" ${result.search().sort() == 'price' ? 'checked' : ''}>
                            Price: Low to High
                        </label>
                    </div>
                </div>

                    <%-- product list --%>
                <div id="product-list" class="grid">
                    <c:forEach var="product" items="${result.page()}">
                        <div class="product-item">
                                <%-- product image --%>
                            <div class="h-[60%]">
                                <a href="${pageContext.request.contextPath}/product/${product.id}/${product.slug}">
                                    <img src="${product.imageUrls[0]}" alt="${product.name}">
                                </a>
                            </div>
                                <%-- product details --%>
                            <div class="flex flex-col items-center h-[40%]">
                                <h3>${product.name}</h3>
                                <p>${product.description}</p>
                                <p><fmt:formatNumber value="${product.unitPrice}" pattern="#,###.##" type="currency"
                                                     currencyCode="MYR"/></p>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <div>
                    Page: ${result.page().page()} of ${result.page().maxPage()}
                </div>

                <div>
                    <c:if test="${result.page().hasPrevious()}">
                        <button type="submit" onsubmit="setPreviousPage()">Previous</button>
                    </c:if>
                    <span class="mx-auto"></span>
                    <c:if test="${result.page().hasNext()}">
                        <button type="submit" onsubmit="setNextPage()">Next</button>
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

