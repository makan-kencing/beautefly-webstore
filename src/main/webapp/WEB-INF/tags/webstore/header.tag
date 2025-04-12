<%@tag description="Webstore header" pageEncoding="UTF-8" %>
<%@ taglib prefix="webstore" tagdir="/WEB-INF/tags/webstore" %>

<header>
    <nav class="flex items-center gap-8 bg-linear-65 from-blue-300 to-pink-300 px-5 py-3 text-white">

        <div class="logo"><a href= "${pageContext.request.contextPath}/home">Beautéfly</a></div>

        <form class="flex flex-1 items-center rounded-md bg-white">
            <label for="query"></label>
            <input type="text" name="query" id="query" placeholder="Search for products..." class="w-full p-2 text-gray-700">

            <button type="submit" class="-ml-8 cursor-pointer"><i class="text-blue-300 fa-solid fa-magnifying-glass"></i></button>
        </form>

        <div class="nav-links text-2xl">
            <a href="${pageContext.request.contextPath}/cart" class="cursor-pointer"><i class="fa-solid fa-cart-shopping"></i></a>
            <a href="" class="cursor-pointer"><i class="fa-solid fa-bell"></i></a>
            <a href="${pageContext.request.contextPath}/account" class="cursor-pointer"><i class="fa-solid fa-user"></i></a>
            <button id="menubar" class="cursor-pointer" onclick="toggleMenu()"><i class="fa-solid fa-bars"></i></button>
        </div>
    </nav>

    <webstore:menu />

</header>