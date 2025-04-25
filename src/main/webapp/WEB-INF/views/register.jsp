<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="login" tagdir="/WEB-INF/tags/login" %>

<login:base pageTitle="Register">
    <jsp:attribute name="includeHead">
        <script src="https://cdn.jsdelivr.net/npm/@zxcvbn-ts/core@2.0.0/dist/zxcvbn-ts.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@zxcvbn-ts/language-common@2.0.0/dist/zxcvbn-ts.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@zxcvbn-ts/language-en@2.0.0/dist/zxcvbn-ts.js"></script>
    </jsp:attribute>

    <jsp:body>
        <div class="flex items-center justify-center">
            <div class="my-4 flex flex-col items-stretch justify-center gap-5">
                <form action="${pageContext.request.contextPath}/api/account/register" method="post"
                      class="rounded-xl border border-gray-300 px-7 py-6 shadow min-w-90 space-y-4">
                    <h2 class="text-3xl font-bold">Register</h2>

                    <div class="form-field space-y-1">
                        <label for="username" class="block font-bold">Username</label>
                        <input type="text" name="username" id="username" required
                               class="w-full rounded-md border border-gray-500 text-gray-700 shadow p-1.5">
                    </div>

                    <div class="form-field space-y-1">
                        <label for="email" class="block font-bold">Email</label>
                        <input type="email" name="email" id="email" required
                               class="w-full rounded-md border border-gray-500 text-gray-700 shadow p-1.5">
                    </div>

                    <div class="form-field space-y-1">
                        <label for="password" class="block font-bold">Password</label>
                        <div class="space-y-1">
                            <div class="flex items-center">
                                <input type="password" name="password" id="password" required
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

                        <div class="form-field space-y-1">
                            <h3 class="font-bold">Your password must contain: </h3>
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
                        <label for="confirm-password" class="block font-bold">Re-enter password</label>
                        <div class="flex items-center">
                            <input type="password" id="confirm-password" required
                                   class="w-full rounded-md border border-gray-500 text-gray-700 shadow p-1.5">
                            <div class="-ml-7 show-password group">
                                <i class="fa-solid fa-eye-slash group-data-visible:hidden!"></i>
                                <i class="fa-solid fa-eye group-not-data-visible:hidden!"></i>
                            </div>
                        </div>
                    </div>

                    <div class="flex items-center justify-between">
                        <button type="submit"
                                class="rounded-full bg-blue-500 px-5 py-2 font-bold text-white hover:bg-blue-700">
                            Register
                        </button>
                    </div>
                </form>

                <div>
                    Or already have an account?
                    <a href="${pageContext.request.contextPath}/login">
                        Login here
                    </a>
                </div>
            </div>
        </div>

        <script src="<c:url value='/static/js/password.js' />"></script>
        <script>
            $form = $('form');

            new PasswordForm($form[0]);
            for (const input of document.querySelectorAll("input[type='password']")) {
                const showPassword = input.parentElement.querySelector(".show-password");

                new ShowPassword(input, showPassword);
            }

            $form.ajaxForm({
                success: (_response, _statusText, _jqXHR, _$form) => {
                    window.location.replace('${pageContext.request.contextPath}/login');
                },
                error: (jqXHR, _statusText, _errorText, _$form) => {
                    if (jqXHR.status === 409) {
                        const email = document.querySelector("#email")
                        email.setCustomValidity('Email is already taken.');
                        email.reportValidity();
                    }
                }
            });
        </script>
    </jsp:body>
</login:base>
