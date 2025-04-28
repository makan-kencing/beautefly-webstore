<%@ page contentType="text/html;charset=UTF-8" %>

<jsp:useBean id="publishableKey" type="java.lang.String" scope="request"/>
<%@ taglib prefix="base" tagdir="/WEB-INF/tags" %>

<base:base pageTitle="Payment">
    <jsp:attribute name="includeHead">
        <script src="https://js.stripe.com/v3/"></script>
    </jsp:attribute>

    <jsp:body>
        <div id="checkout" class="w-screen h-screen flex items-center justify-center"></div>

        <script>
            const stripe = Stripe("${publishableKey}");

            initialize();

            // Create a Checkout Session
            async function initialize() {
                const fetchClientSecret = async () => {
                    const response = await fetch("/api/checkout/create", {
                        method: "POST",
                    });
                    const {clientSecret} = await response.json();
                    return clientSecret;
                };

                const checkout = await stripe.initEmbeddedCheckout({
                    fetchClientSecret,
                });

                // Mount Checkout
                checkout.mount('#checkout');
            }
        </script>
    </jsp:body>
</base:base>


