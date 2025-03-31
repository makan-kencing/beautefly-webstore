<%@tag description="Login page base template" pageEncoding="UTF-8" %>
<%@attribute name="includeHead" fragment="true" %>
<%@attribute name="pageTitle" required="true" type="java.lang.String" %>

<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@taglib prefix="login" tagdir="/WEB-INF/tags/login" %>

<t:base pageTitle="${pageTitle}">
    <jsp:attribute name="header">
        <login:header />
    </jsp:attribute>

    <jsp:attribute name="footer">
        <login:footer />
    </jsp:attribute>

    <jsp:attribute name="includeHead">
        <jsp:invoke fragment="includeHead" />
    </jsp:attribute>

    <jsp:body>
        <jsp:doBody />
    </jsp:body>
</t:base>
