<%@tag description="Admin page base template" pageEncoding="UTF-8" %>
<%@attribute name="includeHead" fragment="true" %>
<%@attribute name="pageTitle" required="true" type="java.lang.String" %>

<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@taglib prefix="admin" tagdir="/WEB-INF/tags/admin" %>

<t:base pageTitle="${pageTitle}">
    <jsp:attribute name="header">
        <admin:header />
    </jsp:attribute>

    <jsp:attribute name="footer">
        <admin:footer />
    </jsp:attribute>

    <jsp:attribute name="includeHead">
        <jsp:invoke fragment="includeHead" />
    </jsp:attribute>

    <jsp:body>
        <jsp:doBody />
    </jsp:body>
</t:base>
