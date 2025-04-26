<%--
  Created by IntelliJ IDEA.
  User: CheeHua
  Date: 4/25/2025
  Time: 1:15 PM
  To change this template use File | Settings | File Templates.
--%>

<jsp:useBean id="account" type="com.lavacorp.beautefly.webstore.account.dto.UserAccountDetailsDTO" scope="request"/>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="web" tagdir="/WEB-INF/tags/web" %>

<c:set var="pageTitle" value="Checkout"/>
<webstore:base pageTitle="${pageTitle}">
    <main class="max-w-7xl mx-auto px-4 py-6 grid grid-cols-1 md:grid-cols-3 gap-8">
        <account:sidebar pageTitle="${pageTitle}"/>


</webstore:base>
