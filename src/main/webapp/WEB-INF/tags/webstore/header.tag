<%@tag description="Webstore header" pageEncoding="UTF-8" %>

<style>
    .fancy-li {
        display: block;
        padding: 0.5rem 1rem;
        font-size: 20px;
        color: black;
        font-family: 'Comic Sans MS', cursive, sans-serif;
        transition: all 0.3s;
    }

    .fancy-li:hover {
        background-color: #93c5fd;
    }
</style>

<header>
    <nav class="flex items-center gap-8 from-blue-300 to-pink-300 px-5 py-3 text-white bg-linear-65">
        <div class="logo"><a href="${pageContext.request.contextPath}/home">Beautéfly</a></div>

        <form class="flex flex-1 items-center rounded-md bg-white">
            <label for="query"></label>
            <input type="text" name="query" id="query" placeholder="Search for products..."
                   class="w-full p-2 text-gray-700">
            <button type="submit" class="-ml-8 cursor-pointer"><i
                    class="text-blue-300 fa-solid fa-magnifying-glass"></i></button>
        </form>

        <div class="nav-links text-2xl *:cursor-pointer">
            <a href="${pageContext.request.contextPath}/cart">
                <i class="fa-solid fa-cart-shopping"></i>
            </a>
            <a href="">
                <i class="fa-solid fa-bell"></i>
            </a>
            <a href="${pageContext.request.contextPath}/account">
                <i class="fa-solid fa-user"></i>
            </a>

            <button onclick="document.getElementById('nav-menu').showModal()">
                <i class="fa-solid fa-bars"></i>
            </button>

        </div>
    </nav>
</header>

<nav>
    <dialog id="nav-menu"
            class="ml-auto overflow-hidden bg-transparent p-4 text-xl backdrop:blur-xl backdrop:brightness-200">
        <div class="flex h-full flex-row-reverse gap-3 rounded-xl bg-white">
            <%-- main menus --%>
            <div>
                <div class="font-times font-bold">
                    <ul>
                        <li class="fancy-li"><a href="#sub-skin-care">Skin Care</a></li>
                        <li class="fancy-li"><a href="#sub-makeup">Makeup</a></li>
                        <li class="fancy-li"><a href="#sub-body-care">Body Care</a></li>
                        <li class="fancy-li"><a href="#sub-hair-care">Hair Care</a></li>
                        <li class="fancy-li"><a href="#sub-beauty-tools">Beauty Tools</a></li>
                        <li class="fancy-li"><a href="#sub-treatments">Special Treatments</a></li>
                    </ul>
                </div>
            </div>

            <%-- submenus --%>
            <div class="">
                <div id="sub-skin-care" class="not-target:hidden">
                    <ul>
                        <li class="fancy-li"><a href="${pageContext.request.contextPath}../../views/SkinCare/Cleansing.jsp">Cleansing</a></li>
                        <li class="fancy-li"><a href="">Toning</a></li>
                        <li class="fancy-li"><a href="">Moisturizing</a></li>
                        <li class="fancy-li"><a href="">Serums & Treatments</a></li>
                        <li class="fancy-li"><a href="">Eye Care</a></li>
                        <li class="fancy-li"><a href="">Sun Protection</a></li>
                        <li class="fancy-li"><a href="">Special Treatments</a></li>
                        <li class="fancy-li"><a href="">Repair & Recovery</a></li>
                    </ul>
                </div>

                <div id="sub-makeup" class="not-target:hidden">
                    <ul>
                        <li class="fancy-li"><a href="">Base Makeup</a></li>
                        <li class="fancy-li"><a href="">Eye Makeup</a></li>
                        <li class="fancy-li"><a href="">Lip Makeup</a></li>
                        <li class="fancy-li"><a href="">Blush & Contouring</a></li>
                        <li class="fancy-li"><a href="">Setting Makeup</a></li>
                    </ul>
                </div>

                <div id="sub-body-care" class="not-target:hidden">
                    <ul>
                        <li class="fancy-li"><a href="">Cleansing</a></li>
                        <li class="fancy-li"><a href="">Moisturizing</a></li>
                        <li class="fancy-li"><a href="">Fragrance</a></li>
                        <li class="fancy-li"><a href="">Hair Removal</a></li>
                        <li class="fancy-li"><a href="">Whitening & Acne Treatment</a></li>
                    </ul>
                </div>

                <div id="sub-hair-care" class="not-target:hidden">
                    <ul>
                        <li class="fancy-li"><a href="">Shampoo & Conditioner</a></li>
                        <li class="fancy-li"><a href="">Hair Treatment</a></li>
                        <li class="fancy-li"><a href="">Styling</a></li>
                        <li class="fancy-li"><a href="">Hair Coloring</a></li>
                    </ul>
                </div>

                <div id="sub-beauty-tools" class="not-target:hidden">
                    <ul>
                        <li class="fancy-li"><a href="">Makeup Tools</a></li>
                        <li class="fancy-li"><a href="">Skincare Devices</a></li>
                        <li class="fancy-li"><a href="">Hair Removal Devices</a></li>
                        <li class="fancy-li"><a href="">Message Tools</a></li>
                        <li class="fancy-li"><a href="">Nail Care Tools</a></li>
                    </ul>
                </div>

                <div id="sub-treatments" class="not-target:hidden">
                    <ul>
                        <li class="fancy-li"><a href="">Acne Treatment</a></li>
                        <li class="fancy-li"><a href="">Anti-Aging</a></li>
                        <li class="fancy-li"><a href="">Whitening</a></li>
                        <li class="fancy-li"><a href="">Sensitive Skin Repair</a></li>
                        <li class="fancy-li"><a href="">Dark Circle Treatment</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </dialog>
</nav>

<script>
    const dialog = document.getElementById('nav-menu');

    dialog.addEventListener('click', function (event) {
        const rect = dialog.getBoundingClientRect();
        const isInDialog =
            event.clientX >= rect.left &&
            event.clientX <= rect.right &&
            event.clientY >= rect.top &&
            event.clientY <= rect.bottom;

        if (!isInDialog) {
            dialog.close();
        }
    });
</script>