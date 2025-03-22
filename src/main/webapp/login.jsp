<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="login" tagdir="/WEB-INF/tags/login" %>

<login:base pageTitle="Sign In">
    <div class="flex items-center justify-center my-4">
        <div class="flex flex-col gap-5 items-stretch justify-center">
            <form action="j_security_check" method="post"
                  class="min-w-90 border border-gray-300 shadow rounded-xl py-6 px-7 space-y-4">
                <h2 class="text-3xl font-bold">Sign in</h2>

                <div class="space-y-1">
                    <label for="email" class="block font-bold">Email</label>
                    <input type="email" name="j_username" id="email"
                           class="shadow border border-gray-500 rounded-md w-full text-gray-700 p-2">
                </div>

                <div class="mb-8 space-y-1">
                    <label for="password" class="block font-bold">Password</label>
                    <input type="password" name="j_password" id="password"
                           class="shadow border border-gray-500 rounded-md w-full text-gray-700 p-2">
                </div>

                <div class="flex items-center justify-between">
                    <button type="submit" class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-5 rounded-full">Sign In</button>
                    <a href="#"
                       class="inline-block align-baseline font-bold text-sm py-2 px-5 text-blue-500  hover:bg-blue-50 rounded-full">Forgot password?</a>
                </div>
            </form>

            <c:if test="${param.get('error') != null}">
                <div class="bg-red-100 border border-red-400 text-red-700 p-3 rounded-xl" role="alert">
                    <span>The username or password is invalid.</span>
                </div>
            </c:if>

            <hr class="border-gray-400">

            <a href="${pageContext.request.contextPath}/register.jsp"
               class="border border-gray-400 text-sm p-1.5 text-center rounded-full hover:bg-gray-100">Create new account</a>
        </div>
    </div>
</login:base>
