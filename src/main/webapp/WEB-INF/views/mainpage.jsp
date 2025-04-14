<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="webstore" tagdir="/WEB-INF/tags/webstore" %>
<jsp:useBean id="submenu" type="java.util.List<com.lavacorp.beautefly.webstore.home.dto.MainPromoDTO>" scope="request"/>

<webstore:base pageTitle="Home">

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper/swiper-bundle.min.css" />

    <div class="swiper-container w-full h-[calc(100vh-4.35rem)] overflow-x-hidden">
        <div class="swiper-wrapper">
            <!--skincare-->
            <c:forEach var="item" items="${promos}">
                <div class="swiper-slide bg-cover" style="background-image: url(${item.imageUrl()})">
                    <div class="backdrop-blur-xs flex flex-col items-center justify-center w-full h-full gap-5">
                        <h1 class="text-9xl text-white text-shadow-lg text-center font-bold ">${item.title()}</h1>
                        <p class="text-xl text-white text-shadow-lg text-center">${item.description()}</p>
                    </div>
                </div>
            </c:forEach>
        </div>

        <div class="swiper-pagination"></div>
        <div class="swiper-button-next"></div>
        <div class="swiper-button-prev"></div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/swiper/swiper-bundle.min.js"></script>
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const swiper = new Swiper('.swiper-container', {
                loop: true,
                autoplay: {
                    delay: 10000,
                    disableOnInteraction: false,
                },
                pagination: {
                    el: '.swiper-pagination',
                    clickable: true,
                },
                navigation: {
                    nextEl: '.swiper-button-next',
                    prevEl: '.swiper-button-prev',
                },
            });
        });
    </script>

</webstore:base>
