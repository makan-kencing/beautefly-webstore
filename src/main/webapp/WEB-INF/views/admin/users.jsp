<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="admin" tagdir="/WEB-INF/tags/admin" %>

<admin:base pageTitle="Users">
    <!-- Pop Up Successful Message-->
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

    <!-- Pop Up Successful Delete Message-->
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

    <h2 class="text-2xl font-bold mb-4">Manage Users</h2>

    <div class="flex justify-between items-center mb-4">
        <input id="searchInput" onkeyup="filterTable()" type="text" placeholder="Search username/email..."
               class="border p-2 rounded w-[60%]">
        <div class="flex gap-2">
            <a href="javascript:void(0)" onclick="openModal()"
               class="bg-green-600 text-white px-4 py-2 rounded hover:bg-green-700">+ Add</a>
            <button type="button" onclick="toggleDeleteMode()" id="deleteModeBtn"
                    class="bg-red-600 text-white px-4 py-2 rounded hover:bg-red-700">🗑️ Delete
            </button>
        </div>
    </div>

    <!-- User Table -->
    <form id="deleteForm" method="post" action="/admin/users/delete">
        <table class="min-w-full border text-sm" id="userTable">
            <thead class="bg-gray-200 text-left">
            <tr>
                <th class="p-2"><input type="checkbox" onclick="toggleAll(this)"></th>
                <th class="p-2" data-sort="username">Username ↕</th>
                <th class="p-2" data-sort="email">Email ↕</th>
                <th class="p-2">Roles</th>
                <th class="p-2" data-sort="active">Active ↕</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="user" items="${users}">
                <tr class="border-b">
                    <td class="p-2"><input type="checkbox" name="usernames" value="${user.username}"
                                           class="delete-checkbox hidden"></td>
                    <td class="p-2">
                        <a href="/admin/users/view?username=${user.username}" class="text-blue-600 hover:underline">
                                ${user.username}
                        </a>
                    </td>
                    <td class="p-2">${user.email}</td>
                    <td class="p-2">
                        <c:forEach var="role" items="${user.credential.roles}">
                        <span class="px-2 py-1 text-white text-xs rounded-full mr-1
                            ${role == 'ADMIN' ? 'bg-red-600' :
                              role == 'STAFF' ? 'bg-blue-600' :
                              role == 'USER' ? 'bg-green-600' : 'bg-gray-500'}">
                                ${role}
                        </span>
                        </c:forEach>
                    </td>
                    <td class="p-2">
                    <span class="${user.active ? 'text-green-600' : 'text-red-600'} font-semibold">
                            ${user.active ? 'YES' : 'NO'}
                    </span>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <div id="deleteBtnContainer" class="mt-4 hidden">
            <button type="submit" class="bg-red-600 text-white px-4 py-2 rounded hover:bg-red-700">
                🗑️ Delete Selected
            </button>
        </div>
    </form>

    <!-- Pagination -->
    <div class="mt-4">
        <c:set var="totalPages" value="${(totalUsers / pageSize) + (totalUsers % pageSize > 0 ? 1 : 0)}"/>
        <c:forEach var="i" begin="1" end="${totalPages}">
            <a href="?page=${i}&search=${param.search}&sort=${param.sort}"
               class="px-3 py-1 border rounded mr-1 ${i == currentPage ? 'bg-blue-500 text-white' : 'bg-white'}">
                    ${i}
            </a>
        </c:forEach>
    </div>

    <!-- Add New User -->
    <div id="addUserModal" class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center hidden z-50">
        <div class="bg-white p-6 rounded shadow w-[400px]">
            <h2 class="text-xl font-bold mb-4">Add New User</h2>
            <form method="post" action="/admin/users/add" class="space-y-3">
                <c:if test="${not empty errors}">
                    <div class="bg-red-100 text-red-700 p-4 rounded mb-4">
                        <ul>
                            <c:forEach var="err" items="${errors}">
                                <li>⚠️ ${err}</li>
                            </c:forEach>
                        </ul>
                    </div>
                </c:if>
                <input type="text" name="username" placeholder="Username" class="w-full border p-2 rounded"/>
                <input type="email" name="email" placeholder="Email" class="w-full border p-2 rounded"/>
                <input type="password" name="password" placeholder="Password" class="w-full border p-2 rounded"/>
                <label class="block font-semibold mb-1">Roles:</label>
                <select name="roles" multiple class="w-full border rounded p-2">
                    <option value="USER">User</option>
                    <option value="STAFF">Staff</option>
                    <option value="ADMIN">Admin</option>
                </select>
                <small class="text-gray-500">Hold Ctrl (or Cmd) to select multiple</small>
                <div>
                    <label><input type="checkbox" name="active" value="true"/> Active</label>
                </div>
                <div class="flex justify-between">
                    <button type="submit" class="bg-green-600 text-white px-4 py-2 rounded">Create</button>
                    <button type="button" onclick="closeModal()" class="text-gray-500 hover:underline">Cancel</button>
                </div>
            </form>
        </div>
    </div>

    <!-- JavaScript -->
    <script>
        function toggleDeleteMode() {
            document.querySelectorAll('.delete-checkbox').forEach(cb => cb.classList.toggle('hidden'));
            document.getElementById('deleteBtnContainer').classList.toggle('hidden');
        }

        function toggleAll(source) {
            document.querySelectorAll(".delete-checkbox:not(.hidden)").forEach(cb => cb.checked = source.checked);
        }

        function openModal() {
            document.getElementById("addUserModal").classList.remove("hidden");
        }

        function closeModal() {
            document.getElementById("addUserModal").classList.add("hidden");
        }

        function filterTable() {
            const input = document.getElementById("searchInput").value.toLowerCase();
            const rows = document.querySelectorAll("#userTable tbody tr");
            rows.forEach(row => {
                const text = row.textContent.toLowerCase();
                row.style.display = text.includes(input) ? "" : "none";
            });
        }

        let sortCol = null;
        let sortAsc = true;

        document.addEventListener("DOMContentLoaded", () => {
            document.querySelectorAll("#userTable thead th[data-sort]").forEach(th => {
                th.addEventListener("click", () => {
                    const col = th.dataset.sort;
                    if (col === sortCol) sortAsc = !sortAsc;
                    else {
                        sortCol = col;
                        sortAsc = true;
                    }
                    sortTable(col, sortAsc);
                });
            });
        });

        function sortTable(col, asc = true) {
            const rows = Array.from(document.querySelectorAll("#userTable tbody tr"));
            const getCellValue = (row, colName) => {
                if (colName === "username") return row.cells[1].innerText.toLowerCase();
                if (colName === "email") return row.cells[2].innerText.toLowerCase();
                if (colName === "active") return row.cells[4].innerText.trim().toLowerCase();
                return "";
            };

            rows.sort((a, b) => {
                const aVal = getCellValue(a, col);
                const bVal = getCellValue(b, col);
                if (aVal < bVal) return asc ? -1 : 1;
                if (aVal > bVal) return asc ? 1 : -1;
                return 0;
            });

            const tbody = document.querySelector("#userTable tbody");
            rows.forEach(row => tbody.appendChild(row));
        }
    </script>

    <c:if test="${not empty errors}">
        <script>
            window.onload = function () {
                openModal();
            };
        </script>
    </c:if>
</admin:base>