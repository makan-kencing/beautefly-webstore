package com.lavacorp.beautefly.webstore.cart;

import com.stripe.exception.StripeException;
import com.stripe.model.checkout.Session;
import jakarta.inject.Inject;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.Context;
import jakarta.ws.rs.core.MediaType;
import lombok.extern.log4j.Log4j2;

@Log4j2
@Path("/checkout")
@Produces(MediaType.APPLICATION_JSON)
public class CheckoutResource {
    @Inject
    private CheckoutService checkoutService;

    @Context
    private HttpServletRequest req;

    public record ClientSessionDTO(
            String clientSecret
    ) {
    }

    @POST
    @Path("/create")
    public ClientSessionDTO createSession() {
        try {
            var session = checkoutService.createCheckoutSession(req);

            return new ClientSessionDTO(session.getClientSecret());
        } catch (StripeException e) {
            log.error(e);
            throw new InternalServerErrorException(e);
        }
    }

    public record SessionStatusDTO(String status, String customerEmail) {
    }

    @GET
    @Path("/status")
    public SessionStatusDTO getSessionStatus(@QueryParam("session_id") String sessionId) {
        try {
            var session = Session.retrieve(sessionId);

            if ("complete".equals(session.getStatus()))
                checkoutService.fulfillCheckout(sessionId);

            return new SessionStatusDTO(session.getStatus(), session.getCustomerDetails().getEmail());
        } catch (StripeException e) {
            log.error(e);
            throw new InternalServerErrorException(e);
        }
    }

//    @POST
//    @Path("/callback")
//    public void fulfillCheckout(@HeaderParam("Stripe-Signature") String stripeSignature, Session session) {
//        if (!CheckoutService.endpointSecret.equals(stripeSignature))
//            throw new ForbiddenException();
//
//        try {
//            checkoutService.fulfillCheckout(session.getId());
//        } catch (StripeException e) {
//            log.error(e);
//            throw new InternalServerErrorException(e);
//        }
//    }
}
