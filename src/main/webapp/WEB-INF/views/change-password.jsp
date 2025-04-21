<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="webstore" tagdir="/WEB-INF/tags/webstore" %>
<%@ taglib prefix="account" tagdir="/WEB-INF/tags/account" %>

<c:set var="pageTitle" value="Password"/>

<webstore:base pageTitle="${pageTitle}">
    <main class="flex min-h-screen bg-white text-black">
        <account:sidebar pageTitle="${pageTitle}"/>

        <div>
            <h1 class="text-2xl font-semibold mb-4">Password</h1>
            <div class="bg-white border border-gray-300 p-6 rounded-lg shadow-sm space-y-6">
                <form onsubmit="return handleSubmit()" class="text-left">
                    <label for="oldPassword" class="block font-medium mb-1 mt-4">Old Password</label>
                    <div class="relative">
                        <input type="password" id="oldPassword" oninput="checkOldPassword()"
                               class="w-full px-4 py-2 pr-10 border border-gray-300 rounded-md">
                        <span class="absolute right-3 top-1/2 transform -translate-y-1/2 text-gray-500 cursor-pointer"
                              onclick="togglePassword('oldPassword')">👁️</span>
                    </div>
                    <div id="errorMsg" class="text-sm mt-1 hidden"></div>

                    <label for="newPassword" class="block font-medium mb-1 mt-4">New Password</label>
                    <div class="relative">
                        <input type="password" id="newPassword" oninput="checkPasswordMatch()" disabled
                               class="w-full px-4 py-2 pr-10 border border-gray-300 rounded-md">
                        <span class="absolute right-3 top-1/2 transform -translate-y-1/2 text-gray-500 cursor-pointer"
                              onclick="togglePassword('newPassword')">👁️</span>
                    </div>

                    <label for="confirmPassword" class="block font-medium mb-1 mt-4">Confirm Password</label>
                    <div class="relative">
                        <input type="password" id="confirmPassword" oninput="checkPasswordMatch()" disabled
                               class="w-full px-4 py-2 pr-10 border border-gray-300 rounded-md">
                        <span class="absolute right-3 top-1/2 transform -translate-y-1/2 text-gray-500 cursor-pointer"
                              onclick="togglePassword('confirmPassword')">👁️</span>
                    </div>
                    <div id="matchMsg" class="text-sm mt-1 hidden"></div>

                    <input type="hidden" id="croppedImageData">

                    <button type="submit"
                            class="mt-6 px-4 py-2 text-white bg-blue-600 hover:bg-blue-700 rounded-md w-full">Submit
                    </button>
                    <div id="submitResult" class="mt-4 font-semibold"></div>
                </form>
            </div>
        </div>
    </main>
</webstore:base>