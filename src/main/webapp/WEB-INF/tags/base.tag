<%@tag description="Base page template" pageEncoding="UTF-8" %>
<%@attribute name="header" fragment="true" %>
<%@attribute name="footer" fragment="true" %>
<%@attribute name="pageTitle" required="true" type="java.lang.String" %>

<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Le Beautéfly | ${pageTitle}</title>

    <link href="${pageContext.request.contextPath}/static/css/output.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>
    <jsp:invoke fragment="header"/>

    <jsp:doBody/>

    <jsp:invoke fragment="footer"/>
</body>
</html>