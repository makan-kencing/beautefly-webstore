<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="webstore" tagdir="/WEB-INF/tags/webstore" %>
<%@ taglib prefix="account" tagdir="/WEB-INF/tags/account" %>


<c:set var="pageTitle" value="Addresses"/>

<webstore:base pageTitle="${pageTitle}">
    <main class="flex min-h-screen bg-white text-black">
        <account:sidebar pageTitle="${pageTitle}"/>

        <div class="p-5 flex-1">
            <h1 class="text-2xl font-semibold mb-4">Addresses</h1>
            <div class="flex flex-wrap gap-4 bg-white *:h-[15rem] *:w-[20rem]
            *:border-2 *:border-gray-300 *:rounded-lg *:shadow-sm">
                <div class="border-dashed text-xl shadow-none!">
                    <a href="<c:url value='/address/new' />"
                       class="flex flex-col items-center justify-center h-full gap-2">
                        <i class="fa-solid fa-plus font-bold text-gray-200 text-4xl"></i>
                        <h2 class="text-gray-600 font-bold">Add Address</h2>
                    </a>
                </div>

                    <%--                <jsp:useBean id="address" type="com.lavacorp.beautefly.webstore.account.dto.AddressDTO"/>--%>
                <div class="flex flex-col *:px-6 *:py-4 text-sm">
                    <c:if test="">
                        <div class="border-b">
                            <p class="text-gray-600 text-xs">Default</p>
                        </div>
                    </c:if>

                    <div class="*:empty:none">
                        <h2 class="font-semibold">${address.name()}</h2>
                        <p>${address.address1()}</p>
                        <p>${address.address2()}</p>
                        <p>${address.address3()}</p>
                        <p>${address.city()}, ${address.state()} ${address.postcode()}</p>
                        <p>Phone number: ${address.contactNo()}</p>
                    </div>

                    <div class="mt-auto flex gap-3 text-blue-700 border-gray-600">
                        <a href="<c:url value='/address/${address.id()}' />" class="hover:underline">Edit</a>

                        <div class="border border-inherit"></div>

                        <button type="button" onclick="this.parentElement.querySelector('dialog').showModal()"
                                class="hover:underline">
                            Remove
                        </button>

                        <c:if test="${true}">
                            <div class="border border-inherit"></div>

                            <form action="<c:url value='/address/${address.id()}/default' />" method="post">
                                <button type="submit"
                                        class="hover:underline">
                                    Set as Default
                                </button>
                            </form>
                        </c:if>

                        <dialog class="m-auto rounded-2xl w-md">
                            <form action="<c:url value='/address/${address.id()}/delete' />" method="post"
                                  class="*:py-4 *:px-6">
                                <div class="flex bg-gray-100">
                                    <h2 class="text-xl font-semibold">Confirm Removal</h2>

                                    <button type="button" onclick="this.closest('dialog').close()" class="ml-auto">
                                        <i class="fa-solid fa-xmark"></i>
                                    </button>
                                </div>

                                <div class="space-y-2">
                                    <div class="*:empty:none">
                                        <h2 class="font-semibold">${address.name()}</h2>
                                        <p>${address.address1()}</p>
                                        <p>${address.address2()}</p>
                                        <p>${address.address3()}</p>
                                        <p>${address.city()}, ${address.state()} ${address.postcode()}</p>
                                        <p>Phone number: ${address.contactNo()}</p>
                                    </div>

                                    <div class="text-gray-600">
                                        <span class="font-semibold">Please note:</span>
                                        Removing this address will not affect any pending orders being shipped to this
                                        address. To ensure uninterrupted fulfillment of future orders, please update any
                                        wishlists and save settings using this address.
                                    </div>
                                </div>

                                <hr class="text-gray-300 p-0!">

                                <div class="flex justify-evenly *:rounded-full *:py-1 *:px-10">
                                    <button type="button" onclick="this.closest('dialog').close()"
                                            class="border hover:bg-gray-100">
                                        No
                                    </button>
                                    <button type="submit" class="bg-blue-200 hover:bg-blue-300">
                                        Yes
                                    </button>
                                </div>
                            </form>
                        </dialog>
                    </div>

                </div>
            </div>
        </div>
    </main>
</webstore:base>