<%@tag description="Webstore header" pageEncoding="UTF-8" %>

<header>
    <nav class="flex items-center gap-8 bg-blue-300 px-5 py-3 text-white">

        <div class="logo"><a href= "${pageContext.request.contextPath}/mainpage.jsp">Beautéfly</a></div>

        <form class="flex flex-1 items-center rounded-md bg-white">
            <label for="query"></label>
            <input type="text" name="query" id="query" placeholder="Search for products..." class="w-full p-2 text-gray-700">

            <button type="submit" class="-ml-8 cursor-pointer"><i class="text-blue-300 fa-solid fa-magnifying-glass"></i></button>
        </form>

        <div class="nav-links">
            <i class="text-2xl fa-solid fa-cart-shopping"></i>
            <i class="text-2xl fa-solid fa-bell"></i>
            <i class="text-2xl fa-solid fa-user"></i>
            <i class="text-2xl fa-solid fa-bars"></i>
        </div>
    </nav>
</header>