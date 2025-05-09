<%@ page contentType="text/html;charset=UTF-8" isErrorPage="true" %>

<%@taglib prefix="webstore" tagdir="/WEB-INF/tags/webstore" %>

<webstore:base pageTitle="Not Found">
    <main class="vertical items-center justify-center p-10 min-h-[80vh]">
        <div class="text-gray-700 space-y-3">
            <div>
                <h1 class="text-9xl/26">SORRY</h1>
                <p class="text-5xl">We couldn't find that page</p>
            </div>
            <p class="text-2xl">Try searching or go to the <a href="${pageContext.request.contextPath}/" class="text-blue-600">home page</a>.</p>
        </div>
    </main>
</webstore:base>