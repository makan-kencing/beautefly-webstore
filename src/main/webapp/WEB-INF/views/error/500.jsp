<%@ page contentType="text/html;charset=UTF-8" isErrorPage="true" %>

<%@taglib prefix="webstore" tagdir="/WEB-INF/tags/webstore" %>

<webstore:base pageTitle="Something Went Wrong">
    <main class="vertical items-center justify-center p-10 min-h-[80vh]">
        <div class="text-gray-700 space-y-3">
            <div>
                <h1 class="text-9xl/26 uppercase">Oops!</h1>
                <p class="text-5xl">Something went wrong</p>
            </div>
            <p class="text-2xl">Please try again some time later.</p>
            <p class="text-2xl">Contact <a href="mailto:admin@beautefly.com" class="text-link hover:underline">admin@beautefly.com</a>
                if the problem still persists.
            </p>
            <p class="text-3xl">We apologize for the inconvenience.</p>
        </div>
    </main>
</webstore:base>