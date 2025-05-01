<%@ tag description="Webstore header" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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
        <a href="<c:url value='/' />" class="font-bold text-3xl horizontal items-center gap-2">
            <img src="<c:url value='/static/images/logo.png' />" alt="" class="h-8">
            ${initParam["company.name"]}
        </a>

        <form action="<c:url value='/search' />" method="get"
              class="flex flex-1 items-center rounded-md bg-white">
            <label for="query"></label>
            <input type="text" name="query" id="query" placeholder="Search for products..."
                   class="w-full p-2 text-gray-700">
            <button type="submit" class="-ml-8 cursor-pointer"><i
                    class="text-blue-300 fa-solid fa-magnifying-glass"></i></button>
        </form>

        <div class="nav-links text-2xl *:cursor-pointer">
            <a href="<c:url value='/cart' />">
                <i class="fa-solid fa-cart-shopping"></i>
            </a>
            <c:if test="${pageContext.request.userPrincipal != null}">
                <!-- Trigger Button -->
                <button popovertarget="userPopover"
                        class="border-2 overflow-hidden rounded-full bg-gray-400 w-10 h-10 border-gray-300">
                    <img src="${user.profileImage().url()}" alt="" class="w-full h-full object-cover">
                </button>

                <!-- Popover Content -->
                <div id="userPopover" popover
                     class="mt-2 w-64 rounded-lg shadow-lg bg-white border border-gray-300 z-50"
                     style="position-area: bottom span-left">
                    <div class="p-4 flex items-center gap-3">
                        <!-- Avatar -->
                        <div class="border-2 overflow-hidden rounded-full bg-gray-400 w-12 h-12 border-gray-300">
                            <img src="${user.profileImage().url()}" alt="" class="w-full h-full object-cover">
                        </div>
                        <!-- Name + Role -->
                        <div>
                            <div class="font-semibold text-lg text-gray-800">${user.username()}</div>
                            <div class="text-sm text-gray-400">
                            <c:forEach var="role" items="${user.roles()}">
                                <span class="mr-1">${role}</span>
                            </c:forEach>
                            </div>
                        </div>
                    </div>

                    <ul class="text-sm">
                        <li>
                            <a href="<c:url value='/account' />"
                               class="flex items-center gap-2 px-4 py-3 hover:bg-gray-100">
                                <i class="fa-solid fa-user"></i> My Profile
                            </a>
                        </li>

                        <c:if test="${pageContext.request.isUserInRole('ADMIN') || pageContext.request.isUserInRole('STAFF') }">
                            <li>
                                <a href="<c:url value='/admin' />"
                                   class="flex items-center gap-2 px-4 py-3 hover:bg-gray-100">
                                    <i class="fa-solid fa-shield-halved"></i> Admin Panel
                                </a>
                            </li>
                        </c:if>

                        <li>
                            <a href="<c:url value='/orders' />"
                               class="flex items-center gap-2 px-4 py-3 hover:bg-gray-100">
                                <i class="fa-solid fa-clipboard-list"></i> Order History
                            </a>
                        </li>
                    </ul>

                    <!-- Divider -->
                    <hr class="my-1 mx-4 border-gray-300"/>

                    <div class="px-4 py-3">
                        <a href="<c:url value='/logout' />"
                           class="w-full flex items-center justify-center gap-2 text-red-600 hover:text-red-700 text-sm font-medium">
                            <i class="fa-solid fa-arrow-right-from-bracket"></i> Sign out
                        </a>
                    </div>
                </div>
            </c:if>
            <c:if test="${pageContext.request.userPrincipal == null}">
                <a href="<c:url value='/login' />" class="text-white px-3 py-2 flex items-center">
                    <i class="fa-solid fa-right-to-bracket text-2xl"></i>
                </a>
            </c:if>


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
                        <li class="fancy-li"><a
                                href="<c:url value='/search?categories=Facial+Cleanser' />">Cleansing</a></li>
                        <li class="fancy-li"><a href="<c:url value='/search?categories=Toner' />">Toning</a></li>
                        <li class="fancy-li"><a
                                href="<c:url value='/search?categories=Lotion&categories=Face+Cream&categories=Gel' />">Moisturizing</a>
                        </li>
                        <li class="fancy-li"><a
                                href="<c:url value='/search?categories=Brightening+Serum&categories=Anti-aging+Serum&categories=Repairing+Serum' />">Serums
                            & Treatments</a></li>
                        <li class="fancy-li"><a
                                href="<c:url value='/search?categories=Eye+Cream&categories=Eye+Serum' />">Eye Care</a>
                        </li>
                        <li class="fancy-li"><a
                                href="<c:url value='/search?categories=Sunscreen&categories=Sunblock+Spray' />">Sun
                            Protection</a></li>
                        <li class="fancy-li"><a
                                href="<c:url value='/search?categories=Acne+Treatment&categories=Exfoliators&categories=Sheet+Masks&categories=Clay+Masks&categories=Peel-off+Masks' />">Special
                            Treatments</a></li>
                        <li class="fancy-li"><a
                                href="<c:url value='/search?categories=After-Sun+Repair&categories=Sensitive+Skin+Repair' />">Repair
                            & Recovery</a></li>
                    </ul>
                </div>

                <div id="sub-makeup" class="not-target:hidden">
                    <ul>
                        <li class="fancy-li"><a
                                href="<c:url value='/search?categories=Foundation&categories=BB+Cream&categories=Cushion+Compact&categories=Concealer&categories=Setting+Powder' />">Base
                            Makeup</a></li>
                        <li class="fancy-li"><a
                                href="<c:url value='/search?categories=Eyeshadow&categories=Eyeliner&categories=Mascara&categories=Eyebrow+Pencil' />">Eye
                            Makeup</a></li>
                        <li class="fancy-li"><a
                                href="<c:url value='/search?categories=Lipstick&categories=Lip+Gloss&categories=Lip+Balm&categories=Lip+Liner' />">Lip
                            Makeup</a></li>
                        <li class="fancy-li"><a
                                href="<c:url value='/search?categories=Blush&categories=Contour+Powder&categories=Highlighter&categories=Nose+Shadow' />">Blush
                            & Contouring</a></li>
                        <li class="fancy-li"><a
                                href="<c:url value='/search?categories=Setting+Spray&categories=Oil-Control+Powder' />">Setting
                            Makeup</a></li>
                    </ul>
                </div>

                <div id="sub-body-care" class="not-target:hidden">
                    <ul>
                        <li class="fancy-li"><a
                                href="<c:url value='/search?categories=Body+Wash&categories=Soap&categories=Body+Scrub' />">Cleansing</a>
                        </li>
                        <li class="fancy-li"><a
                                href="<c:url value='/search?categories=Body+Lotion&categories=Body+Oil&categories=Hand+Cream' />">Moisturizing</a>
                        </li>
                        <li class="fancy-li"><a
                                href="<c:url value='/search?categories=Perfume&categories=Body+Mist' />">Fragrance</a>
                        </li>
                        <li class="fancy-li"><a
                                href="<c:url value='/search?categories=Body+Cleansing&categories=Razor' />">Hair
                            Removal</a></li>
                        <li class="fancy-li"><a
                                href="<c:url value='/search?categories=Body+Whitening+Lotion&categories=Back+Acne+Spray' />">Whitening
                            & Acne Treatment</a></li>
                    </ul>
                </div>

                <div id="sub-hair-care" class="not-target:hidden">
                    <ul>
                        <li class="fancy-li"><a
                                href="<c:url value='/search?categories=Shampoo&categories=Conditioner' />">Shampoo &
                            Conditioner</a></li>
                        <li class="fancy-li"><a
                                href="<c:url value='/search?categories=Hair+Mask&categories=Hair+Oil&categories=Scalp+Care+Serum' />">Hair
                            Treatment</a></li>
                        <li class="fancy-li"><a
                                href="<c:url value='/search?categories=Hair+Spray&categories=Hair+Wax&categories=Curling+Mousse&categories=Hair+Straightening+Cream' />">Styling</a>
                        </li>
                        <li class="fancy-li"><a href="<c:url value='/search?categories=Hair+Dye&categories=Bleach' />">Hair
                            Coloring</a></li>
                    </ul>
                </div>

                <div id="sub-beauty-tools" class="not-target:hidden">
                    <ul>
                        <li class="fancy-li"><a
                                href="<c:url value='/search?categories=Makeup+Brushes&categories=Beauty+Sponge&categories=Powder+Puff&categories=Eyelash+Curler' />">Makeup
                            Tools</a></li>
                        <li class="fancy-li"><a
                                href="<c:url value='/search?categories=Facial+Cleansing+Brush&categories=Facial+Steamer&categories=LED+Beauty+Device' />">Skincare
                            Devices</a></li>
                        <li class="fancy-li"><a
                                href="<c:url value='/search?categories=Home-use+Hair+Removal+Device' />">Hair Removal
                            Devices</a></li>
                        <li class="fancy-li"><a
                                href="<c:url value='/search?categories=Face+Slimming+Device&categories=Roller+Massager&categories=Gua+Sha+Tool' />">Message
                            Tools</a></li>
                        <li class="fancy-li"><a
                                href="<c:url value='/search?categories=Nail+Polish&categories=Nail+Lamp&categories=Manicure+Set' />">Nail
                            Care Tools</a></li>
                    </ul>
                </div>

                <div id="sub-treatments" class="not-target:hidden">
                    <ul>
                        <li class="fancy-li"><a
                                href="<c:url value='/search?categories=Acne+Gel&categories=Pimple+Patch' />">Acne
                            Treatment</a></li>
                        <li class="fancy-li"><a
                                href="<c:url value='/search?categories=Anti-wrinkle+Serum&categories=Firming+Cream' />">Anti-Aging</a>
                        </li>
                        <li class="fancy-li"><a href="<c:url value='/search?categories=Dark+Spot+Corrector' />">Whitening</a>
                        </li>
                        <li class="fancy-li"><a
                                href="<c:url value='/search?categories=Sensitive+Skin+Protection+Cream' />">Sensitive
                            Skin Repair</a></li>
                        <li class="fancy-li"><a href="<c:url value='/search?categories=Eye+Mask' />">Dark Circle
                            Treatment</a></li>
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

    // Simple dropdown toggle
    function toggleDropdown() {
        document.getElementById("accountDropdown").classList.toggle("hidden");
    }


</script>