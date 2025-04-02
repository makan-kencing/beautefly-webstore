<%@tag description="Webstore header" pageEncoding="UTF-8" %>

<header>
    <nav class="flex items-center px-5 py-3 text-white gap-8 bg-blue-300">

        <div class="logo"><a href= "${pageContext.request.contextPath}/mainpage.jsp">Beautéfly</a></div>

        <form class="rounded-md bg-white flex items-center flex-1">
            <label for="query"></label>
            <input type="text" name="query" id="query" placeholder="Search for products..." class="w-full p-2 text-gray-700">

            <button type="submit" class="-ml-8 cursor-pointer"><i class="fa-solid fa-magnifying-glass text-blue-300"></i></button>
        </form>

        <div class="nav-links">
            <i class="text-2xl fa-solid fa-cart-shopping"></i>
            <i class="text-2xl fa-solid fa-bell"></i>
            <i class="text-2xl fa-solid fa-user"></i>
            <i class="text-2xl fa-solid fa-bars"></i>
        </div>
    </nav>
</header>