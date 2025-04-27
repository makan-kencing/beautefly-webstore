<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="webstore" tagdir="/WEB-INF/tags/webstore" %>
<%@ taglib prefix="account" tagdir="/WEB-INF/tags/account" %>

<c:set var="pageTitle" value="New Address"/>

<webstore:base pageTitle="${pageTitle}">
    <main class="flex min-h-screen bg-white text-black">
        <account:sidebar pageTitle="${pageTitle}"/>

        <div class="p-5 flex-1">
            <h1 class="text-2xl font-bold mb-4">Add a new address</h1>

            <form action="<c:url value='/address/new' />" method="post"
                  class="space-y-5 border border-gray-300 p-6 rounded-lg shadow-sm">

                <div class="space-y-3">
                    <div class="space-y-2">
                        <label for="name" class="block font-semibold">Full name</label>
                        <input type="text" name="name" id="name" required
                               class="border border-gray-300 rounded-lg p-2 w-full">
                    </div>

                    <div class="space-y-2">
                        <label for="address1" class="block font-semibold">Street Address</label>
                        <input type="text" name="address1" id="address1" required
                               class="border border-gray-300 rounded-lg p-2 w-full">
                            <%--suppress HtmlFormInputWithoutLabel --%>
                        <input type="text" name="address2" id="address2"
                               class="border border-gray-300 rounded-lg p-2 w-full">
                    </div>

                    <div class="space-y-2">
                        <label for="city" class="block font-semibold">City</label>
                        <input type="text" name="city" id="city" required
                               class="border border-gray-300 rounded-lg p-2 w-full">
                    </div>

                    <div class="space-y-2">
                        <label for="state" class="block font-semibold">State</label>
                        <input type="text" name="state" id="state" required
                               class="border border-gray-300 rounded-lg p-2 w-full">
                    </div>

                    <div class="space-y-2">
                        <label for="postcode" class="block font-semibold">Postcode</label>
                        <input type="text" name="postcode" id="postcode" required
                               class="border border-gray-300 rounded-lg p-2 w-full">
                    </div>
                    
                    <div class="space-y-2">
                        <label for="country" class="block font-semibold">Country</label>
                        <input type="text" name="country" id="country" required
                               class="border border-gray-300 rounded-lg p-2 w-full">
                    </div>

                    <div class="space-y-2">
                        <label for="contactNo" class="block font-semibold">Phone number</label>
                        <input type="tel" name="contactNo" id="contactNo" required
                               class="border border-gray-300 rounded-lg p-2 w-full">
                    </div>

                    <div>
                        <input type="checkbox" name="isDefault" id="isDefault" class="mb-1">
                        <label for="isDefault">Use as my default address.</label>
                    </div>

                    <div class="text-right">
                        <button type="submit"
                                class="cursor-pointer px-6 py-2 bg-blue-500 text-white rounded-lg hover:bg-blue-600">
                            Add address
                        </button>
                    </div>
                </div>
            </form>
        </div>
    </main>
</webstore:base>
