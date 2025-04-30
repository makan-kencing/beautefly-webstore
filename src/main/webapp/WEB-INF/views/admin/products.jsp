<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="admin" tagdir="/WEB-INF/tags/admin" %>

<jsp:useBean id="context" type="com.lavacorp.beautefly.webstore.admin.product.dto.CreateProductContext"
             scope="request"/>

<admin:base pageTitle="Products">
    <jsp:attribute name="includeHead">
        <link href="https://cdn.datatables.net/2.2.2/css/dataTables.dataTables.min.css" rel="stylesheet"/>
        <link href="https://cdn.datatables.net/colreorder/2.0.4/css/colReorder.dataTables.min.css" rel="stylesheet"/>

        <script src="https://cdn.datatables.net/2.2.2/js/dataTables.min.js"></script>
        <script src="https://cdn.datatables.net/colreorder/2.0.4/js/dataTables.colReorder.min.js"></script>
        <script src="https://cdn.datatables.net/buttons/3.2.2/js/dataTables.buttons.min.js"></script>
        <script src="https://cdn.datatables.net/select/3.0.0/js/dataTables.select.min.js"></script>

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
            <c:if test="${param.created == '1'}">
                <div id="toast"
                     class="fixed top-4 right-4 bg-green-500 text-white px-4 py-2 rounded shadow-lg z-50 opacity-100 transition-opacity duration-500 ease-in-out">
                    Product created successfully!!
                </div>
                <script>
                    setTimeout(() => {
                        const toast = document.getElementById("toast");
                        toast.classList.remove("opacity-100");
                        toast.classList.add("opacity-0");
                        setTimeout(() => toast.remove(), 500);
                    }, 2000);
                </script>
            </c:if>

            <!-- Pop Up Successful Delete Message-->
            <c:if test="${param.deleted == '1'}">
                <div id="toast"
                     class="fixed top-4 right-4 bg-red-500 text-white px-4 py-2 rounded shadow-lg z-50 opacity-100 transition-opacity duration-500 ease-in-out">
                    Product deleted successfully!
                </div>
                <script>
                    setTimeout(() => {
                        const toast = document.getElementById("toast");
                        toast.classList.remove("opacity-100");
                        toast.classList.add("opacity-0");
                        setTimeout(() => toast.remove(), 500);
                    }, 2000);
                </script>
            </c:if>

            <div class="border rounded-xl border-border shadow-md p-4">

                <h2 class="text-2xl font-bold">Manage Products</h2>

                <table id="table" class="hover row-border nowrap">
                    <thead>
                    <tr>
                        <th></th>
                        <th>#</th>
                        <th>Product</th>
                        <th>In Stock</th>
                        <th>Description</th>
                        <th>Unit Cost (RM)</th>
                        <th>Unit Price (RM)</th>
                        <th>Brand</th>
                        <th>Category</th>
                        <th>Color</th>
                        <th>Release Date</th>
                    </tr>
                    </thead>
                </table>

                <script>
                    const table = new DataTable("#table", {
                        layout: {
                            topStart: {
                                search: {
                                    text: "",
                                    placeholder: "Search products ..."
                                }
                            },
                            topEnd: {
                                buttons: [
                                    {
                                        text: "<i class='fa-solid fa-plus mr-1'></i> Add",
                                        action: function (e, dt, node, config) {
                                            document.querySelector("dialog#create-product").showModal();
                                        },
                                        className: "button-good transition"
                                    },
                                    {
                                        extend: "selected",
                                        text: "<i class='fa-solid fa-trash mr-1'></i> Delete",
                                        action: function (e, dt, node, config) {
                                            const formData = new FormData();
                                            dt.select.cumulative().rows.forEach(
                                                (id) => formData.append("id", id)
                                            );

                                            fetch("<c:url value='/admin/product/delete'/>", {
                                                method: "post",
                                                body: formData
                                            }).then((res) => {
                                                if (!res.ok)
                                                    console.error(res);
                                                dt.ajax.reload();
                                            });
                                        },
                                        className: "button-bad transition"
                                    }
                                ],
                                pageLength: true
                            }
                        },
                        searching: true,
                        ordering: true,
                        colReorder: true,
                        pageLength: 50,
                        paging: true,
                        select: true,
                        serverSide: true,
                        processing: true,
                        scrollX: true,
                        ajax: {
                            url: "<c:url value='/api/admin/product/search' />",
                            dataSrc: function (json) {
                                for (const data of json.data)
                                    data.DT_RowId = data.id
                                json.recordsFiltered = json.filteredTotal;
                                json.recordsTotal = json.total;
                                return json.data;
                            }
                        },
                        columns: [
                            {data: null, orderable: false, searchable: false, render: DataTable.render.select()},
                            {data: "id"},
                            {data: "name"},
                            {data: "stockCount"},
                            {data: "description", orderable: false, defaultContent: ""},
                            {data: "unitCost"},
                            {data: "unitPrice"},
                            {data: "brand"},
                            {data: "category", orderable: false},
                            {data: "color", orderable: false, defaultContent: ""},
                            {data: "releaseDate"}
                        ],
                        columnDefs: [
                            {
                                targets: 1,
                                name: "id",
                                render: function (data, type, row, meta) {
                                    if (type === "display")
                                        return "#" + data;
                                    return data;
                                },
                                className: "dt-body-left"
                            },
                            {
                                targets: 2,
                                name: "name",
                                render: function (data, type, row, meta) {
                                    if (type === "display")
                                        return `<a href='<c:url value='/admin/product/\${row.id}' />'>\${data}</a>`;
                                    return data;
                                }
                            },
                            {
                                targets: 3,
                                name: "stockCount",
                                render: function (data, type, row, meta) {
                                    if (type === "display")
                                        if (data <= 0)
                                            return "<span class='text-bad'>No Stock</span>";
                                        else if (data < 10)
                                            return `<span class='text-bad'>\${data}</span>`;
                                            // else if (data < 20)
                                        //    return `<span class='text-warn'>\${data}</span>`;
                                        else
                                            return `<span class='text-good'>\${data}</span>`;
                                    return data;
                                }
                            },
                            {
                                targets: 4,
                                name: "description",
                                className: "overflow-ellipsis"
                            },
                            {
                                targets: 5,
                                name: "unitCost"
                            },
                            {
                                targets: 6,
                                name: "unitPrice"
                            },
                            {
                                targets: 7,
                                name: "brand"
                            },
                            {
                                targets: 8,
                                name: "category",
                                render: function (data, type, row, meta) {
                                    if (type === "display") {
                                        let categories = [];

                                        while (data != null) {
                                            categories.push(data.name);

                                            data = data.parent;
                                        }

                                        return categories.toReversed().join("  ▸  ");
                                    }
                                    return data;
                                }
                            },
                            {
                                targets: 9,
                                name: "color",
                                render: function (data, type, row, meta) {
                                    if (type === "display") {
                                        if (!data)
                                            return "";
                                        <%--suppress CssInvalidPropertyValue --%>
                                        return `<span data-cell style='color: \${data.color}'>\${data.name}</span>`;
                                    }
                                    return data;
                                },
                                className: "cell"
                            },
                            {
                                targets: 10,
                                name: "releaseDate"
                            }
                        ],
                        order: [[1, 'asc']]
                    })
                </script>
            </div>

            <c:url var="endpoint" value='/admin/product/create'/>
            <admin:dialog-form dialogid="create-product" action="${endpoint}" method="post"
                               title="Add Product">

                <div class="horizontal *:flex-1 space-y-0! *:space-y-2">
                    <div>
                        <label for="name" class="block">Product Name *</label>
                        <input type="text" name="name" id="name" placeholder="" required
                               class="w-full border border-border py-1 px-2 rounded">
                    </div>

                    <div>
                        <label for="brand" class="block">Brand *</label>
                        <input type="text" name="brand" id="brand" list="brands" required
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
                                      onInput="this.parentNode.dataset.replicatedValue = this.value"></textarea>
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

                                        <option value="${category.id()}">
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
                                <jsp:useBean id="color" type="com.lavacorp.beautefly.webstore.product.dto.ColorDTO"/>
                                <c:set var="r" value="${color.color().red}"/>
                                <c:set var="g" value="${color.color().green}"/>
                                <c:set var="b" value="${color.color().blue}"/>

                                <option value="${color.id()}" style="color: rgb(${r}, ${g}, ${b})" class="font-bold">
                                        ${color.name()}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                </div>

                <div class="horizontal *:flex-1 space-y-0! *:space-y-2">
                    <div>
                        <label for="unitPrice" class="block">Unit Price (RM) *</label>
                        <input type="number" name="unitPrice" id="unitPrice" step="0.01" required
                               class="w-full border border-border py-1 px-2 rounded">
                    </div>

                    <div>
                        <label for="unitCost" class="block">Unit Cost (RM) *</label>
                        <input type="number" name="unitCost" id="unitCost" step="0.01" required
                               class="w-full border border-border py-1 px-2 rounded">
                    </div>
                </div>

                <div>
                    <label for="releaseDate" class="block">Release Date *</label>
                    <input type="date" name="releaseDate" id="releaseDate" required
                           class="w-full border border-border py-1 px-2 rounded">
                </div>

                <div>
                    <label for="stockCount" class="block">Stock *</label>
                    <input type="number" name="stockCount" id="stockCount" min="0" step="1" required
                           class="w-full border border-border py-1 px-2 rounded">
                </div>
            </admin:dialog-form>
        </main>
    </jsp:body>
</admin:base>