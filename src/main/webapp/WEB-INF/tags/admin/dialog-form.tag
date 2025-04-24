<%@ tag description="Input form component" pageEncoding="UTF-8" %>

<%@ attribute name="action" required="true" %>
<%@ attribute name="method" required="true" %>
<%@ attribute name="title" required="true" %>

<%@ attribute name="dialogid" required="false" %>
<%@ attribute name="dialogclass" required="false" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>

<dialog id="${dialogid}" class="overflow-hidden m-auto backdrop:bg-black/50 w-3xl  ${dialogclass}">
    <form action="${action}" method="${method}">
        <div class="horizontal items-center px-4 py-6 text-xl">
            <h2 class="font-bold">${title}</h2>

            <button type="button" onclick="this.closest('dialog').close()" class="ml-auto">
                <i class="fa-solid fa-xmark text-gray-500"></i>
            </button>
        </div>

        <hr class="text-border mx-2">

        <div class="overflow-auto px-4 py-2 space-y-4 *:space-y-2 max-h-[70vh]">
            <jsp:doBody/>
        </div>

        <hr class="text-border mx-2">

        <div class="horizontal justify-end p-4">
            <button type="reset" onclick="this.closest('dialog').close()" class="button-bad">Cancel</button>
            <button type="submit" class="button-good">Confirm</button>
        </div>
    </form>
</dialog>
