<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="login" tagdir="/WEB-INF/tags/login" %>

<login:base pageTitle="Register">
    <div class="flex items-center justify-center">
        <div class="my-4 flex flex-col items-stretch justify-center gap-5">
            <form action="${pageContext.request.contextPath}/api/account/register" method="post"
                  class="rounded-xl border border-gray-300 px-7 py-6 shadow min-w-90 space-y-4">
                <h2 class="text-3xl font-bold">Register</h2>

                <div class="space-y-1">
                    <label for="username" class="block font-bold">Username</label>
                    <input type="text" name="username" id="username" required
                           class="w-full rounded-md border border-gray-500 p-1.5 text-gray-700 shadow">
                </div>

                <div class="space-y-1">
                    <label for="email" class="block font-bold">Email</label>
                    <input type="email" name="email" id="email" required
                           class="w-full rounded-md border border-gray-500 p-1.5 text-gray-700 shadow">
                </div>

                <div class="space-y-1">
                    <label for="password" class="block font-bold">Password</label>
                    <input type="password" name="password" id="password" required
                           class="w-full rounded-md border border-gray-500 p-1.5 text-gray-700 shadow">
                </div>

                <div class="space-y-1">
                    <label for="confirm-password" class="block font-bold">Re-enter password</label>
                    <input type="password" id="confirm-password" required
                           class="w-full rounded-md border border-gray-500 p-1.5 text-gray-700 shadow">
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

    <script>
        $('form')
            .ajaxForm({
                beforeSubmit: (formData, $form, options) => {
                    return $form.valid();
                },
                success: (response, statusText, jqXHR, $form) => {
                    window.location.replace('${pageContext.request.contextPath}/login');
                },
                error: (jqXHR, statusText, errorText, $form) => {
                }
            })
        // .validate();
    </script>
</login:base>
