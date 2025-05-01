<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="webstore" tagdir="/WEB-INF/tags/webstore" %>
<%@ taglib prefix="account" tagdir="/WEB-INF/tags/account" %>

<c:set var="pageTitle" value="Password"/>

<webstore:base pageTitle="${pageTitle}">
    <jsp:attribute name="includeHead">
        <script src="https://cdn.jsdelivr.net/npm/@zxcvbn-ts/core@2.0.0/dist/zxcvbn-ts.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@zxcvbn-ts/language-common@2.0.0/dist/zxcvbn-ts.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@zxcvbn-ts/language-en@2.0.0/dist/zxcvbn-ts.js"></script>
        <script src="<c:url value='/static/js/password.js' />"></script>
    </jsp:attribute>

    <jsp:body>
        <main class="flex min-h-screen">
            <account:sidebar pageTitle="${pageTitle}"/>

            <div class="p-5 flex-1">
                <h1 class="text-2xl font-semibold mb-4">Password</h1>
                <div class="border border-border p-6 rounded-lg shadow-sm space-y-3">
                    <form action="<c:url value='/account/change-password' />" method="post" id="change-password"
                          class="space-y-5">
                        <div class="space-y-1">
                            <label for="old-password" class="block font-medium">Old password</label>
                            <div class="flex items-center">
                                <input type="password" name="oldPassword" id="old-password" required
                                       class="w-full rounded-md border border-gray-500 text-gray-700 shadow p-1.5">
                                <div class="-ml-7 show-password group">
                                    <i class="fa-solid fa-eye-slash group-data-visible:hidden!"></i>
                                    <i class="fa-solid fa-eye group-not-data-visible:hidden!"></i>
                                </div>
                            </div>
                        </div>

                        <c:if test="${param.error == 'incorrect-password'}">
                            <div class="rounded-xl border border-red-400 bg-red-100 p-3 text-red-700" role="alert">
                                <span>The old password is incorrect.</span>
                            </div>
                        </c:if>

                        <div class="space-y-1">
                            <div class="space-y-1">
                                <label for="password" class="block font-medium">Password</label>
                                <div class="space-y-1">
                                    <div class="flex items-center">
                                        <input type="password" name="newPassword" id="password" required
                                               class="w-full rounded-md border border-gray-500 text-gray-700 shadow p-1.5">
                                        <div class="-ml-7 show-password group">
                                            <i class="fa-solid fa-eye-slash group-data-visible:hidden!"></i>
                                            <i class="fa-solid fa-eye group-not-data-visible:hidden!"></i>
                                        </div>
                                    </div>

                                    <div class="flex rounded-full strength-bar gap-0.5">
                                        <div class="flex-auto bg-gray-300 data-passed:bg-blue-300 h-1.5"></div>
                                        <div class="flex-auto bg-gray-300 data-passed:bg-blue-300 h-1.5"></div>
                                        <div class="flex-auto bg-gray-300 data-passed:bg-blue-300 h-1.5"></div>
                                        <div class="flex-auto bg-gray-300 data-passed:bg-blue-300 h-1.5"></div>
                                    </div>
                                </div>

                                <div class="space-y-1">
                                    <h3 class="font-medium">Your password must contain: </h3>
                                    <ul>
                                        <li class="flex items-center gap-2 data-passed:text-blue-300 group"
                                            data-strength-rule="lowercase">
                                            <i class="fa-solid fa-circle-xmark group-data-passed:hidden!"></i>
                                            <i class="fa-solid fa-circle-check group-not-data-passed:hidden!"></i>
                                            at least 1 lowercase
                                        </li>
                                        <li class="flex items-center gap-2 data-passed:text-blue-300 group"
                                            data-strength-rule="uppercase">
                                            <i class="fa-solid fa-circle-xmark group-data-passed:hidden!"></i>
                                            <i class="fa-solid fa-circle-check group-not-data-passed:hidden!"></i>
                                            at least 1 uppercase
                                        </li>
                                        <li class="flex items-center gap-2 data-passed:text-blue-300 group"
                                            data-strength-rule="min-length">
                                            <i class="fa-solid fa-circle-xmark group-data-passed:hidden!"></i>
                                            <i class="fa-solid fa-circle-check group-not-data-passed:hidden!"></i>
                                            minimum 8 characters
                                        </li>
                                    </ul>
                                </div>
                            </div>

                            <div class="space-y-1">
                                <label for="confirm-password" class="block font-medium">Re-enter password</label>
                                <div class="flex items-center">
                                    <input type="password" id="confirm-password" required
                                           class="w-full rounded-md border border-gray-500 text-gray-700 shadow p-1.5">
                                    <div class="-ml-7 show-password group">
                                        <i class="fa-solid fa-eye-slash group-data-visible:hidden!"></i>
                                        <i class="fa-solid fa-eye group-not-data-visible:hidden!"></i>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="flex items-center justify-between">
                            <button type="submit"
                                    class="button-link w-full">
                                Submit
                            </button>
                        </div>
                    </form>
                </div>
            </div>

            <script>
                new PasswordForm(document.querySelector("form#change-password"));

                for (const input of document.querySelectorAll("input[type='password']")) {
                    const showPassword = input.parentElement.querySelector(".show-password");

                    new ShowPassword(input, showPassword);
                }
            </script>
        </main>
    </jsp:body>
</webstore:base>