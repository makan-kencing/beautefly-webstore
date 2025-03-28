<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="login" tagdir="/WEB-INF/tags/login" %>

<login:base pageTitle="Sign In">
    <div class="my-4 flex items-center justify-center">
        <div class="flex flex-col items-stretch justify-center gap-5">
            <form action="j_security_check" method="post"
                  class="rounded-xl border border-gray-300 px-7 py-6 shadow min-w-90 space-y-4">
                <h2 class="text-3xl font-bold">Sign in</h2>

                <div class="space-y-1">
                    <label for="email" class="block font-bold">Email</label>
                    <input type="email" name="j_username" id="email" required
                           class="w-full rounded-md border border-gray-500 p-1.5 text-gray-700 shadow">
                </div>

                <div class="mb-8 space-y-1">
                    <label for="password" class="block font-bold">Password</label>
                    <input type="password" name="j_password" id="password" required
                           class="w-full rounded-md border border-gray-500 p-1.5 text-gray-700 shadow">
                </div>

                <div class="flex items-center justify-between">
                    <button type="submit"
                            class="rounded-full bg-blue-500 px-5 py-2 font-bold text-white hover:bg-blue-700">
                        Sign In
                    </button>
                    <a href="#"
                       class="rounded-full px-5 py-2 align-baseline text-sm font-bold text-blue-500 hover:bg-blue-50">
                        Forgot password?
                    </a>
                </div>
            </form>

            <c:if test="${param.get('error') != null}">
                <div class="rounded-xl border border-red-400 bg-red-100 p-3 text-red-700" role="alert">
                    <span>The username or password is invalid.</span>
                </div>
            </c:if>

            <hr class="border-gray-400">

            <a href="${pageContext.request.contextPath}/register.jsp"
               class="rounded-full border border-gray-400 text-center text-sm p-1.5 hover:bg-gray-100">
                Create new account
            </a>
        </div>
    </div>
</login:base>
