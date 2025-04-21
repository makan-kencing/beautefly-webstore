<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="webstore" tagdir="/WEB-INF/tags/webstore" %>
<%@ taglib prefix="account" tagdir="/WEB-INF/tags/account" %>

<c:set var="pageTitle" value="Addresses"/>

<webstore:base pageTitle="${pageTitle}">
    <main class="flex min-h-screen bg-white text-black">
        <account:sidebar pageTitle="${pageTitle}"/>

        <div class="p-5 flex-1">
            <h1 class="text-2xl font-semibold mb-4">Addresses</h1>
            <div class="bg-white border border-gray-300 p-6 rounded-lg shadow-sm space-y-6">
                <form id="addresses" action="${pageContext.request.contextPath}/account" method="post"
                      class="space-y-4">
                    <input type="hidden" name="profileImageFileId" value="${account.profileImage().id()}">

                    <fieldset class="peer space-y-4 *:space-y-1 inert:opacity-90" inert>
                        <div>
                            <label for="username" class="block font-medium">Address</label>
                            <input type="text" name="address" id="addressDetails" value="address"
                                   class="w-full border border-gray-300 p-2 rounded">
                        </div>

                    </fieldset>

                    <div class="not-peer-inert:hidden">
                        <button type="button" onclick="toggleFormInert.call(this)"
                                class="bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600">Edit
                        </button>
                    </div>
                    <div class="peer-inert:hidden space-x-2">
                        <button type="reset" onclick="toggleFormInert.call(this)"
                                class="bg-red-500 text-white px-4 py-2 rounded hover:bg-red-600">Cancel
                        </button>
                        <button type="submit" onclick="toggleFormInert.call(this)"
                                class="bg-green-600 text-white px-4 py-2 rounded hover:bg-green-700">Save
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </main>
</webstore:base>