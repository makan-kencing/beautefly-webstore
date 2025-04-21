<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="webstore" tagdir="/WEB-INF/tags/webstore" %>
<%@ taglib prefix="account" tagdir="/WEB-INF/tags/account" %>

<c:set var="pageTitle" value="Order Details"/>

<webstore:base pageTitle="${pageTitle}">
    <main class="flex min-h-screen bg-white text-black">
        <account:sidebar pageTitle="${pageTitle}"/>

    </main>
</webstore:base>