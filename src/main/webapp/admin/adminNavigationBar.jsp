<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <style>
        .navbar {
            background-color: #f0f0f0;
            padding: 10px 20px;
            display: flex;
            gap: 30px;
            font-family: 'Arial', sans-serif;
            border-bottom: 2px solid #00bfff;
        }
        .navbar a {
            text-decoration: none;
            font-weight: bold;
            color: #00bfff;
            border-bottom: 2px solid transparent;
        }
        .navbar a:hover {
            border-bottom: 2px solid #00bfff;
        }
    </style>
</head>
<body>
<div class="navbar">
    <a href="/admin/dashboard">Dashboard</a>
    <a href="/admin/users">Manage Users</a>
    <a href="/admin/content">Content</a>
    <a href="/admin/logs">View Logs</a>
    <a href="/admin/reports">Reports</a>
    <a href="/admin/settings">Settings</a>
</div>
</body>
</html>

