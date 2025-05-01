<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="webstore" tagdir="/WEB-INF/tags/webstore" %>
<%@ taglib prefix="account" tagdir="/WEB-INF/tags/account" %>

<jsp:useBean id="addresses" type="com.lavacorp.beautefly.webstore.account.dto.AddressesDTO" scope="request"/>

<c:set var="pageTitle" value="Addresses"/>

<webstore:base pageTitle="${pageTitle}">
    <main class="flex min-h-screen bg-white text-black">
        <account:sidebar pageTitle="${pageTitle}"/>

        <div class="p-5 flex-1">
            <h1 class="text-2xl font-semibold mb-4">Addresses</h1>

            <div class="flex flex-wrap gap-4 bg-white *:h-68 *:w-92
            *:border-border *:rounded-lg ">
                    <%-- Add address box --%>
                <div class="border-dashed border-2 text-xl -order-2">
                    <a href="<c:url value='/address/new' />"
                       class="flex flex-col items-center justify-center h-full gap-2">
                        <i class="fa-solid fa-plus font-bold text-gray-200 text-4xl"></i>
                        <h2 class="text-gray-600 font-bold">Add Address</h2>
                    </a>
                </div>

                <c:forEach var="address" items="${addresses.addresses()}">
                    <c:set var="isDefault" value="${address.id() == addresses.defaultAddressId()}" />

                    <div class="flex flex-col *:px-6 *:py-4 text-sm border shadow-sm ${isDefault ? "-order-1 ": ""}">
                        <c:if test="${isDefault}">
                            <div class="border-b border-border pt-3! pb-2!">
                                <p class="text-gray-600 text-xs">Default</p>
                            </div>
                        </c:if>

                        <div class="*:empty:hidden">
                            <h2 class="font-semibold">${address.name()}</h2>
                            <p>${address.address1()}</p>
                            <p>${address.address2()}</p>
                            <p>${address.address3()}</p>
                            <p>${address.city()}, ${address.state()}&ensp;${address.postcode()}</p>
                            <p>Phone number: ${address.contactNo()}</p>
                        </div>

                        <div class="mt-auto flex gap-3 text-blue-700 border-gray-600">
                            <a href="<c:url value='/address/${address.id()}/edit' />" class="hover:underline">Edit</a>

                            <c:if test="${isDefault}">
                                <div class="border border-inherit"></div>

                                <button type="button" onclick="this.parentElement.querySelector('dialog').showModal()"
                                        class="hover:underline">
                                    Remove
                                </button>
                            </c:if>

                            <c:if test="not ${isDefault}">
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
                                    <div class="flex items-center py-0! pr-0!">
                                        <h2 class="text-xl font-semibold">Confirm Removal</h2>

                                        <button type="button" onclick="this.closest('dialog').close()"
                                                class="ml-auto w-14 h-14">
                                            <i class="fa-solid fa-xmark"></i>
                                        </button>
                                    </div>

                                    <hr class="text-gray-300 p-0!">

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
                                            Removing this address will not affect any pending orders being shipped to
                                            this
                                            address. To ensure uninterrupted fulfillment of future orders, please update
                                            any
                                            wishlists and save settings using this address.
                                        </div>
                                    </div>

                                    <hr class="text-gray-300 p-0!">

                                    <div class="flex justify-evenly *:rounded-full *:py-2 *:px-10">
                                        <button type="button" onclick="this.closest('dialog').close()"
                                                class="border hover:bg-gray-100">
                                            No
                                        </button>
                                        <button type="submit" class="text-white bg-blue-500 hover:bg-blue-600">
                                            Yes
                                        </button>
                                    </div>
                                </form>
                            </dialog>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </main>
</webstore:base>