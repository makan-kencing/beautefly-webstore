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

    <h2 class="text-center text-[#2D3E50] text-shadow-lg mt-20 text-[48px] font-extrabold mb-8 tracking-tight leading-tight">New Products Arrivals</h2>

    <div class="carousel_product swiper-container relative w-11/12 mx-auto my-16 overflow-hidden">
        <div class="swiper-wrapper flex transition-transform duration-500">
            <c:forEach var="product" begin="1" end="10">
                <div class="swiper-slide min-w-[25%] p-4">
                    <div class="h-[340px] bg-gradient-to-b from-white via-rose-50 to-blue-50 shadow-xl rounded-3xl p-4 flex flex-col justify-between transition-transform hover:scale-[1.02] duration-300">

                        <div class="h-[200px] flex items-center justify-center overflow-hidden rounded-xl bg-white shadow-inner">
                            <a href="<c:url value='/search' />" class="block w-full h-full p-2">
                                <img class="object-contain h-full mx-auto"
                                     src="https://hadalabo.com.my/img/2ab67433-0e27-49c1-bae4-ae833fe37f17/hydrating-oil-lg.png?fm=png&q=80&fit=max&crop=1855%2C2334%2C0%2C0"
                                     alt="Product ${product}" />
                            </a>
                        </div>

                        <p class="mt-5 text-center font-semibold text-lg text-gray-800">Product ${product}</p>
                    </div>
                </div>
            </c:forEach>
        </div>

        <div class="swiper-pagination swiper-pagination-products mt-4"></div>
        <div class="swiper-button-prev swiper-button-prev-products !text-gray-600 !left-0 hover:scale-110 transition"></div>
        <div class="swiper-button-next swiper-button-next-products !text-gray-600 !right-0 hover:scale-110 transition"></div>
    </div>



    <div class="swiper-pagination swiper-pagination-products"></div>
        <div class="swiper-button-next swiper-button-next-products"></div>
        <div class="swiper-button-prev swiper-button-prev-products"></div>
    </div>


    <section class="relative bg-gradient-to-r from-white via-pink-50 to-white py-20 px-5">
        <div class="max-w-screen-xl mx-auto flex flex-col md:flex-row items-center gap-12">

            <!-- Image Section -->
            <div class="md:w-1/2">
                <div class="relative w-full">
                    <img src="https://mycopywriting.com.my/wp-content/uploads/2022/02/skincare1.jpg"
                         alt="Company Intro Image"
                         class="w-full rounded-3xl shadow-xl object-cover">
                    <div class="absolute inset-0 rounded-3xl ring-4 ring-white ring-opacity-40 pointer-events-none"></div>
                </div>
            </div>

            <!-- Text Section -->
            <div class="md:w-1/2 text-justify">
                <h3 class="text-[48px] font-extrabold text-gray-800 text-center mb-8 tracking-tight leading-tight">
                    <span class="text-pink-600">Company Introduction</span>
                </h3>
                <p class="text-[17px] text-gray-700 leading-relaxed mb-6">
                    At Beautéfly, we believe that beauty is not just about appearance it's about feeling confident, radiant, and empowered every day. As a professional beauty and skincare
                    company, we are committed to providing high-quality, effective, and thoughtful products that cater to the diverse needs of our customers.
                </p>
                <p class="text-[17px] text-gray-700 leading-relaxed mb-6">
                    From comprehensive skincare solutions including cleansers, serums, moisturizers, and sun protection, to professional-grade makeup essentials and body care must-haves, Beautéfly offers a complete beauty experience. Our product lines also extend to hair care,
                    beauty tools & devices, and special treatment formulas that address concerns like acne, aging, and sensitive skin.
                </p>
                <p class="text-[17px] text-gray-700 leading-relaxed mb-6">
                    Driven by innovation and inspired by the latest beauty trends,
                    we carefully curate and develop our products to ensure safety, efficacy, and satisfaction. Whether you’re looking to elevate your daily routine or
                    pamper yourself with a luxurious treatment, Beautéfly is here to help you shine inside and out.
                </p>
                <p class="text-[20px] font-bold text-pink-600 italic text-center">Beautéfly — Bring out the beauty in you.</p>
            </div>
        </div>
    </section>

    <h2 class="text-center text-[#2D3E50] mt-20 mb-10 text-[48px] font-extrabold tracking-tight leading-tight uppercase">
        May 2025 Top Sales
    </h2>

    <div class="carousel_topsales swiper-container relative w-[1000px] h-[555px] mx-auto mb-16 overflow-hidden bg-gradient-to-r from-[#6A82FB] via-[#FC5C7D] to-[#FFB6B9] box-border rounded-3xl shadow-lg">
        <div class="swiper-wrapper flex transition-transform duration-700 ease-in-out">
            <c:forEach var="category" begin="1" end="6">
                <div class="swiper-slide min-w-full flex justify-center items-center relative">

                    <!-- Category Title with refined font -->
                    <div class="absolute top-[60px] w-full text-center text-[75px] font-bold text-[#F7F7F7] z-10">
                        <p class="text-shadow-lg opacity-90">Skin Care</p>
                    </div>

                    <!-- Image Section with soft borders -->
                    <div class="absolute top-[200px] left-1/2 transform -translate-x-1/2 w-[280px] h-[280px] border-4 border-[#F8F8F8] rounded-2xl shadow-xl hover:scale-110 transition-all duration-500 ease-in-out">
                        <a href="<c:url value='/search' />" class="block w-full h-full">
                            <img class="w-full h-full object-cover rounded-2xl shadow-md transform transition-all duration-300 hover:opacity-90"
                                 src="https://m.media-amazon.com/images/I/71-55TGAWNL.jpg"
                                 alt="Category ${category}" />
                        </a>
                    </div>
                </div>
            </c:forEach>
        </div>

        <!-- Pagination with soft styling -->
        <div class="swiper-pagination swiper-pagination-topsales opacity-70 absolute bottom-4 w-full flex justify-center"></div>

        <!-- Custom navigation buttons with enhanced interaction -->
        <div class="swiper-button-next swiper-button-next-topsales !text-[#2C3E50] !opacity-80 hover:opacity-100 transition-all"></div>
        <div class="swiper-button-prev swiper-button-prev-topsales !text-[#2C3E50] !opacity-80 hover:opacity-100 transition-all"></div>
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

            new Swiper('.carousel_product', {
                loop: false,
                autoplay: false,
                slidesPerView: 4,
                spaceBetween: 20,
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
