<%@ page contentType="text/html;charset=UTF-8" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:base pageTitle="Admin">
    <jsp:attribute name="header">
        <header style="display: flex; justify-content: center; align-items: center;">
            <h1>The BeautiFries</h1>

            <h1 style="margin-left: auto; margin-right: auto;">Admin Panel</h1>
        </header>
        <hr>
    </jsp:attribute>

    <jsp:attribute name="footer">
        <footer style="display: flex; flex-flow: column; align-items: center;">
            <hr>
            <br>
            Lavacorp (C) 2024
        </footer>
    </jsp:attribute>

    <jsp:body>
        <div style="display: flex; flex-flow: column; align-items: center;">
            Admin stuff
        </div>
    </jsp:body>
</t:base>