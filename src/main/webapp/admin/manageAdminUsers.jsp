<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.lavacorp.beautefly.webstore.admin.model.UsersStats" %>
<%@ page import="com.lavacorp.beautefly.webstore.admin.model.DashboardStats" %>
<%@ include file="adminNavigationBar.jsp" %>


<!DOCTYPE html>
<html>
<head>
    <title>Users</title>
    <style>
        body { font-family: Arial, sans-serif; padding: 20px; }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: left;
        }
        th {
            background-color: #f3f3f3;
        }
        .status-yes {
            background-color: #b2f2bb;
            color: green;
            font-weight: bold;
            padding: 5px 10px;
            border-radius: 5px;
        }
        .status-no {
            background-color: #ffa8a8;
            color: red;
            font-weight: bold;
            padding: 5px 10px;
            border-radius: 5px;
        }
    </style>
</head>
<body>
<h1>Admin Dashboard</h1>

<%
    DashboardStats stats = (DashboardStats) request.getAttribute("stats");
%>

<h2>Manage Users</h2>

<%--Search Funtion--%>
<form method="get" action="/admin/users">
    <input type="text" name="search" placeholder="Search username..." />
    <button type="submit">Search</button>
</form>

<%--Sort Funtion--%>
<form method="get" action="/admin/users">
    <input type="text" name="search" value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>" placeholder="Search username/email..." />
    <select name="sort">
        <option value="username">Username</option>
        <option value="email">Email</option>
        <option value="group">Group</option>
    </select>
    <button type="submit">Apply</button>
</form>

<table border="1">
    <tr>
        <th>Username</th>
        <th>First</th>
        <th>Last</th>
        <th>Email</th>
        <th>Group</th>
        <th>Staff</th>
        <th>Superuser</th>
        <th>Active</th>
    </tr>
    <%
        List<UsersStats> users = (List<UsersStats>) request.getAttribute("users");
        for (UsersStats u : users) {
    %>
    <tr>
        <td><%= u.getUsername() %></td>
        <td><%= u.getFirstName() %></td>
        <td><%= u.getLastName() %></td>
        <td><%= u.getEmail() %></td>
        <td><%= u.getGroupId() %></td>
        <td><%= u.isStaff() ? "YES" : "NO" %></td>
        <td><%= u.isSuperuser() ? "YES" : "NO" %></td>
        <td><%= u.isActive() ? "YES" : "NO" %></td>
    </tr>
    <% } %>
</table>

<%
    int totalUsers = (int) request.getAttribute("totalUsers");
    int pageSize = (int) request.getAttribute("pageSize");
    int currentPage = (int) request.getAttribute("currentPage");
    int totalPages = (int) Math.ceil((double) totalUsers / pageSize);
%>

<%--Paging Funtion--%>
<div style="margin-top: 20px;">
    <% for (int i = 1; i <= totalPages; i++) { %>
    <a href="?page=<%= i %>&search=<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>&sort=<%= request.getParameter("sort") != null ? request.getParameter("sort") : "" %>">
        <%= (i == currentPage ? "<strong>" + i + "</strong>" : i) %>
    </a>
    <% } %>
</div>


</body>
</html>

