<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="webstore" tagdir="/WEB-INF/tags/webstore" %>

<jsp:useBean id="product" type="com.lavacorp.beautefly.webstore.product.dto.ProductPageDTO" scope="request"/>

<webstore:base pageTitle="${product.name()}">


</webstore:base>
