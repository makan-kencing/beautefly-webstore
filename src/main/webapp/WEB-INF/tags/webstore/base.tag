<%@tag description="Webstore page base template" pageEncoding="UTF-8" %>
<%@attribute name="includeHead" fragment="true" %>
<%@attribute name="pageTitle" required="true" type="java.lang.String" %>

<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@taglib prefix="webstore" tagdir="/WEB-INF/tags/webstore" %>

<t:base pageTitle="${pageTitle}">
    <jsp:attribute name="header">
        <webstore:header />
    </jsp:attribute>

    <jsp:attribute name="footer">
        <webstore:footer />
    </jsp:attribute>

    <jsp:attribute name="includeHead">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
        <jsp:invoke fragment="includeHead" />
    </jsp:attribute>

    <jsp:body>
        <jsp:doBody />
    </jsp:body>
</t:base>
