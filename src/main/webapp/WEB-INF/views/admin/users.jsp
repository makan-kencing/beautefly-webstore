<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="admin" tagdir="/WEB-INF/tags/admin" %>

<admin:base pageTitle="Accounts">
    <jsp:attribute name="includeHead">
        <link href="https://cdn.datatables.net/2.2.2/css/dataTables.dataTables.min.css" rel="stylesheet"/>
        <link href="https://cdn.datatables.net/colreorder/2.0.4/css/colReorder.dataTables.min.css" rel="stylesheet"/>

        <script src="https://cdn.datatables.net/2.2.2/js/dataTables.min.js"></script>
        <script src="https://cdn.datatables.net/colreorder/2.0.4/js/dataTables.colReorder.min.js"></script>
        <script src="https://cdn.datatables.net/buttons/3.2.2/js/dataTables.buttons.min.js"></script>
        <script src="https://cdn.datatables.net/select/3.0.0/js/dataTables.select.min.js"></script>

        <script src="https://cdn.jsdelivr.net/npm/@zxcvbn-ts/core@2.0.0/dist/zxcvbn-ts.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@zxcvbn-ts/language-common@2.0.0/dist/zxcvbn-ts.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@zxcvbn-ts/language-en@2.0.0/dist/zxcvbn-ts.js"></script>
    </jsp:attribute>

    <jsp:body>
        <main class="vertical p-4">
            <c:if test="${param.created == '1'}">
                <div id="toast"
                     class="fixed top-4 right-4 bg-green-500 text-white px-4 py-2 rounded shadow-lg z-50 opacity-100 transition-opacity duration-500 ease-in-out">
                    User created successfully!!
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

            <c:if test="${param.deleted == '1'}">
                <div id="toast"
                     class="fixed top-4 right-4 bg-red-500 text-white px-4 py-2 rounded shadow-lg z-50 opacity-100 transition-opacity duration-500 ease-in-out">
                    User(s) deleted successfully!
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
                <h2 class="text-2xl font-bold">Manage Users</h2>

                <table id="table" class="hover row-border">
                    <thead>
                    <tr>
                        <th class="p-2"></th>
                        <th class="dt-left">#</th>
                        <th>Username</th>
                        <th>Email</th>
                        <th>Roles</th>
                        <th>Active</th>
                    </tr>
                    </thead>
                </table>

                <script>
                    const table = new DataTable("#table", {
                        layout: {
                            topStart: {
                                search: {
                                    text: "",
                                    placeholder: "Search username / email ..."
                                }
                            },
                            topEnd: {
                                buttons: [
                                    {
                                        text: "<i class='fa-solid fa-plus mr-1'></i> Add",
                                        action: function (e, dt, node, config) {
                                            document.querySelector("dialog#create-account").showModal();
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

                                            fetch("<c:url value='/admin/account/delete'/>", {
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
                        ajax: {
                            url: "<c:url value='/api/admin/account/search' />",
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
                            {data: "username"},
                            {data: "email"},
                            {data: "roles", orderable: false},
                            {data: "active"}
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
                                className: "dt-left"
                            },
                            {
                                targets: 2,
                                name: "username",
                                render: function (data, type, row, meta) {
                                    if (type === "display")
                                        return `<a href='<c:url value='/admin/account/\${row.id}' />'>\${data}</a>`;
                                    return data;
                                }
                            },
                            {
                                targets: 3,
                                name: "email"
                            },
                            {
                                targets: 4,
                                name: "roles",
                                render: function (data, type, row, meta) {
                                    if (type === "display")
                                        return data.map((role) =>
                                            `<span data-cell data-role='\${role}'">\${role}</span>`
                                        ).join("");
                                    return data;
                                },
                                className: "cell"
                            },
                            {
                                targets: 5,
                                name: "active",
                                render: function (data, type, row, meta) {
                                    if (type === "display") {
                                        return `<span data-boolean='\${data}'>\${data ? 'YES' : 'NO'}</span>`;
                                    }
                                    return data;
                                },
                                className: "boolean"
                            }
                        ],
                        order: [[1, 'asc']]
                    });
                </script>
            </div>

            <admin:dialog-form dialogid="create-account"
                               action="${pageContext.request.contextPath}/admin/account/add"
                               method="post"
                               title="Add New Account">

            <div>
                    <label for="username" class="block">Username</label>
                    <input type="text" name="username" id="username" placeholder="Admin" required
                           class="w-full border border-border py-1 px-2 rounded"/>
                </div>

                <div>
                    <label for="email" class="block">Email</label>
                    <input type="email" name="email" id="email" placeholder="admin@example.com" required
                           class="w-full border border-border py-1 px-2 rounded"/>
                </div>

                <div>
                    <label for="password" class="block">Password</label>

                    <div class="flex items-center">
                        <input type="password" name="password" id="password" required
                               class="w-full border border-border py-1 px-2 rounded">
                        <div class="-ml-7 show-password group">
                            <i class="fa-solid fa-eye-slash group-data-visible:hidden!"></i>
                            <i class="fa-solid fa-eye group-not-data-visible:hidden!"></i>
                        </div>
                    </div>

                    <div class="flex rounded-full strength-bar gap-0.5">
                        <div class="flex-auto bg-gray-300 data-passed:bg-blue-300 h-1.5"></div>
                        <div class="flex-auto bg-gray-300 data-passed:bg-blue-300 h-1.5"></div>
                        <div class="flex-auto bg-gray-300 data-passed:bg-blue-300 h-1.5"></div>
                        <div class="flex-auto bg-gray-300 data-passed:bg-blue-300 h-1.5"></div>
                    </div>

                    <div class="space-y-1">
                        <h3 class="font-bold">Your password must contain: </h3>
                        <ul>
                            <li class="flex items-center gap-2 data-passed:text-blue-300 group"
                                data-strength-rule="lowercase">
                                <i class="fa-solid fa-circle-xmark group-data-passed:hidden!"></i>
                                <i class="fa-solid fa-circle-check group-not-data-passed:hidden!"></i>
                                at least 1 lowercase
                            </li>
                            <li class="flex items-center gap-2 data-passed:text-blue-300 group"
                                data-strength-rule="uppercase">
                                <i class="fa-solid fa-circle-xmark group-data-passed:hidden!"></i>
                                <i class="fa-solid fa-circle-check group-not-data-passed:hidden!"></i>
                                at least 1 uppercase
                            </li>
                            <li class="flex items-center gap-2 data-passed:text-blue-300 group"
                                data-strength-rule="min-length">
                                <i class="fa-solid fa-circle-xmark group-data-passed:hidden!"></i>
                                <i class="fa-solid fa-circle-check group-not-data-passed:hidden!"></i>
                                minimum 8 characters
                            </li>
                        </ul>
                    </div>
                </div>

                <div>
                    <label for="confirm-password" class="block">Confirm Password</label>

                    <div class="flex items-center">
                        <input type="password" name="confirm-password" id="confirm-password" required
                               class="w-full border border-border py-1 px-2 rounded">
                        <div class="-ml-7 show-password group">
                            <i class="fa-solid fa-eye-slash group-data-visible:hidden!"></i>
                            <i class="fa-solid fa-eye group-not-data-visible:hidden!"></i>
                        </div>
                    </div>
                </div>

                <div>
                    <label for="roles" class="block">Roles</label>

                    <select name="roles" id="roles" multiple required
                            class="w-full border border-border py-1 px-2 rounded">
                        <option value="USER">User</option>
                        <option value="STAFF">Staff</option>
                        <option value="ADMIN">Admin</option>
                    </select>

                    <small class="text-gray-500">Hold Ctrl (or Cmd) to select multiple</small>
                </div>

                <div>
                    <label for="gender" class="block">Gender</label>
                    <select name="gender" id="gender"
                            class="w-full border border-border py-1 px-2 rounded">
                        <option value="MALE">Male</option>
                        <option value="FEMALE">Female</option>
                        <option value="PREFER_NOT_TO_SAY">Prefer Not To Say</option>
                    </select>
                </div>

                <div>
                    <label for="dob" class="block">Gender</label>
                    <input type="date" name="dob" id="dob"
                           class="w-full border border-border py-1 px-2 rounded"/>
                </div>

                <div>
                    <label for="active" class="inline-flex items-center cursor-pointer">
                        <input type="checkbox" name="active" id="active" checked class="sr-only peer"/>
                        <div class="relative w-11 h-6 bg-gray-200 peer-focus:outline-none peer-focus:ring-1 peer-focus:ring-blue-300 rounded-full peer  peer-checked:after:translate-x-full rtl:peer-checked:after:-translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px] after:start-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all  peer-checked:bg-blue-600"></div>
                        <span class="ml-1">Active</span>
                    </label>
                </div>

                <script src="<c:url value='/static/js/password.js' />"></script>
                <script>
                    const dialog = document.querySelector("dialog#create-account");
                    new PasswordForm(dialog.querySelector("form"));
                    for (const input of dialog.querySelectorAll("input[type='password']")) {
                        const showPassword = input.parentElement.querySelector(".show-password");

                        new ShowPassword(input, showPassword);
                    }
                </script>
            </admin:dialog-form>
        </main>

        <script>

        </script>
    </jsp:body>
</admin:base>