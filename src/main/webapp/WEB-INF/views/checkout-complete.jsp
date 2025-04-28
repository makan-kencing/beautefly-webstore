<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib prefix="webstore" tagdir="/WEB-INF/tags/webstore" %>
<%@ taglib prefix="account" tagdir="/WEB-INF/tags/account" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<webstore:base pageTitle="Thanks for your order!">
    <main class="p-4">
        <div id="success" class="hidden">
            <p>
                We appreciate your business! A confirmation email will be sent to <span id="customer-email"></span>.

                If you have any questions, please email <a href="mailto:orders@example.com">orders@example.com</a>.
            </p>
        </div>

        <script>
            initialize();

            async function initialize() {
                const response = await fetch("/api/checkout/status?session_id=${param.get('session_id')}");
                const session = await response.json();

                if (session.status === "open")
                    window.location.replace("/checkout/payment");
                else if (session.status === "complete") {
                    document.querySelector("#success").classList.remove("hidden");
                    document.querySelector("#customer-email").textContent = session.customerEmail;
                }
            }
        </script>
    </main>
</webstore:base>