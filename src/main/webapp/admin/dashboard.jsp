<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.lavacorp.beautefly.webstore.admin.model.DashboardStats" %>

<html>
<head>
    <title>Admin Dashboard</title>
</head>
<body>
    <h1>Admin Dashboard</h1>
    <%
        DashboardStats stats = (DashboardStats) request.getAttribute("stats");
    %>
    <my:adminNavbar />

</body>
</html>
