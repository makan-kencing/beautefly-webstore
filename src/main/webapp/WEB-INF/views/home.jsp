<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="webstore" tagdir="/WEB-INF/tags/webstore" %>
<jsp:useBean id="promos" type="java.util.List<com.lavacorp.beautefly.webstore.home.dto.MainPromoDTO>" scope="request"/>

<webstore:base pageTitle="Home">

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper/swiper-bundle.min.css" />

    <div class="swiper-container main-swiper w-full h-[calc(100vh-4.35rem)] overflow-x-hidden">
        <div class="swiper-wrapper">
            <c:forEach var="item" items="${promos}">
                <div class="swiper-slide bg-cover" style="background-image: url(${item.imageUrl()})">
                    <div class="backdrop-blur-xs flex flex-col items-center justify-center w-full h-full gap-5">
                        <h1 class="text-9xl text-white text-shadow-lg text-center font-bold">${item.title()}</h1>
                        <p class="text-xl text-white text-shadow-lg text-center">${item.description()}</p>
                    </div>
                </div>
            </c:forEach>
        </div>

        <div class="swiper-pagination main-swiper-pagination"></div>
        <div class="swiper-button-next main-swiper-button-next"></div>
        <div class="swiper-button-prev main-swiper-button-prev"></div>
    </div>

    <h2 class="text-center text-blue-400 text-shadow-lg mt-20 text-[40px] font-black">New Products Arrivals</h2>

    <!-- 新品轮播 -->
    <div class="carousel_product swiper-container relative w-11/12 mx-auto my-8 overflow-hidden">
        <div class="swiper-wrapper flex transition-transform duration-500">
            <c:forEach var="product" begin="1" end="10">
                <div class="swiper-slide min-w-[22%] box-border p-2 flex flex-col justify-between">
                    <div class="bg-gradient-to-b from-white to-blue-100 rounded-xl shadow-md text-center p-4 flex flex-col justify-between h-[300px]">

                        <!-- Fix: wrap <img> in block-level <a> with full height/width -->
                        <div class="h-[180px] overflow-hidden flex justify-center items-center">
                            <a href="<c:url value='/search' />" class="block h-full">
                                <img class="max-h-full max-w-full mx-auto object-contain"
                                     src="https://hadalabo.com.my/img/2ab67433-0e27-49c1-bae4-ae833fe37f17/hydrating-oil-lg.png?fm=png&q=80&fit=max&crop=1855%2C2334%2C0%2C0"
                                     alt="Product ${product}" />
                            </a>
                        </div>

                        <p class="mt-5 font-bold text-xl">Product ${product}</p>
                    </div>
                </div>
            </c:forEach>
        </div>

        <div class="swiper-pagination swiper-pagination-products"></div>
        <div class="swiper-button-next swiper-button-next-products"></div>
        <div class="swiper-button-prev swiper-button-prev-products"></div>
    </div>


    <div class="swiper-pagination swiper-pagination-products"></div>
        <div class="swiper-button-next swiper-button-next-products"></div>
        <div class="swiper-button-prev swiper-button-prev-products"></div>
    </div>


    <div class="flex justify-center items-center max-w-screen-lg mx-auto my-16 gap-12 px-5 mt-20">
        <div class="flex-1 pr-10">
            <h3 class="text-blue-400 text-shadow-lg text-[40px] mb-4 font-black">Company Introduction</h3>
            <p class="text-lg leading-relaxed text-justify font-times">
                At Beautéfly, we believe that beauty is not just about appearance it's about feeling confident, radiant, and empowered every day. As a professional beauty and skincare
                company, we are committed to providing high-quality, effective, and thoughtful products that cater to the diverse needs of our customers. <br><br>
                From comprehensive skincare solutions including cleansers, serums, moisturizers, and sun protection, to professional-grade makeup essentials and body care must-haves, Beautéfly offers a complete beauty experience. Our product lines also extend to hair care,
                beauty tools & devices, and special treatment formulas that address concerns like acne, aging, and sensitive skin. <br><br>
                Driven by innovation and inspired by the latest beauty trends,
                we carefully curate and develop our products to ensure safety, efficacy, and satisfaction. Whether you’re looking to elevate your daily routine or
                pamper yourself with a luxurious treatment, Beautéfly is here to help you shine inside and out.<br><br>
            <p class="text-[20px] font-bold text-shadow-lg text-red-500">Beautéfly — Bring out the beauty in you.</p>
            </p>
        </div>
        <div class="flex-1">
            <img class="w-full max-w-md rounded-xl" src="https://mycopywriting.com.my/wp-content/uploads/2022/02/skincare1.jpg" alt="Company Intro Image">
        </div>
    </div>

    <h2 class="text-center text-blue-400 text-shadow-lg mt-20 mb-5 text-[40px] font-black">May 2025 Top Sales</h2>

    <div class="carousel_topsales swiper-container relative w-[1000px] h-[555px] mx-auto mb-10 overflow-hidden bg-gradient-to-r from-blue-300 via-white to-pink-300 box-border">
        <div class="swiper-wrapper flex transition-transform duration-500">
            <c:forEach var="category" begin="1" end="6">
                <div class="swiper-slide min-w-full flex justify-center items-center relative">

                    <!-- Title slightly higher -->
                    <div class="absolute top-[70px] w-full text-center text-5xl font-bold text-white z-10">
                        <p class="text-shadow-lg/40 drop-shadow-lg">Skin Care</p>
                    </div>

                    <!-- Image slightly lower -->
                    <div class="absolute top-[150px] left-1/2 transform -translate-x-1/2 w-[300px] h-[300px]">
                        <a href="<c:url value='/search' />" class="block w-full h-full">
                            <img class="w-full h-full object-contain rounded-xl shadow-md"
                                 src="https://m.media-amazon.com/images/I/71-55TGAWNL.jpg"
                                 alt="Category ${category}" />
                        </a>
                    </div>
                </div>
            </c:forEach>
        </div>

        <div class="swiper-pagination swiper-pagination-topsales"></div>
        <div class="swiper-button-next swiper-button-next-topsales"></div>
        <div class="swiper-button-prev swiper-button-prev-topsales"></div>
    </div>


    <script src="https://cdn.jsdelivr.net/npm/swiper/swiper-bundle.min.js"></script>
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            new Swiper('.main-swiper', {
                loop: false,
                autoplay: false,
                pagination: {
                    el: '.main-swiper-pagination',
                    clickable: true,
                },
                navigation: {
                    nextEl: '.main-swiper-button-next',
                    prevEl: '.main-swiper-button-prev',
                },
            });

            // 新品轮播初始化
            new Swiper('.carousel_product', {
                loop: false,
                autoplay: false,
                slidesPerView: 'auto',
                spaceBetween: 10,
                pagination: {
                    el: '.swiper-pagination-products',
                    clickable: true,
                },
                navigation: {
                    nextEl: '.swiper-button-next-products',
                    prevEl: '.swiper-button-prev-products',
                },
            });

            new Swiper('.carousel_topsales', {
                loop: false,
                autoplay: false,
                pagination: {
                    el: '.swiper-pagination-topsales',
                    clickable: true,
                },
                navigation: {
                    nextEl: '.swiper-button-next-topsales',
                    prevEl: '.swiper-button-prev-topsales',
                },
            });
        });
    </script>

</webstore:base>
