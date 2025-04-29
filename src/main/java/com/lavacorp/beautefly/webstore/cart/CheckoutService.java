package com.lavacorp.beautefly.webstore.cart;

import com.lavacorp.beautefly.util.env.ConfigurableEnvironment;
import com.lavacorp.beautefly.util.env.el.ELExpressionEvaluator;
import com.lavacorp.beautefly.webstore.cart.entity.Cart;
import com.lavacorp.beautefly.webstore.cart.entity.CartProduct;
import com.lavacorp.beautefly.webstore.common.URLUtils;
import com.lavacorp.beautefly.webstore.order.entity.SalesOrder;
import com.lavacorp.beautefly.webstore.order.entity.SalesOrderProduct;
import com.lavacorp.beautefly.webstore.product.entity.Product;
import com.lavacorp.beautefly.webstore.security.filter.UserContextFilter;
import com.stripe.Stripe;
import com.stripe.exception.StripeException;
import com.stripe.model.checkout.Session;
import com.stripe.param.checkout.SessionCreateParams;
import com.stripe.param.checkout.SessionRetrieveParams;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.PersistenceUnit;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.transaction.Transactional;
import org.hibernate.SessionFactory;

import java.math.BigDecimal;
import java.util.List;

@Transactional
@ApplicationScoped
public class CheckoutService {
    @Inject
    private CartService cartService;

    @PersistenceUnit
    private EntityManagerFactory emf;

    private final static String taxId = "txr_1RItpXJrMFBDPmV7Ox7IHug1";
    public static final String publishableKey;
    public static final String apiKey;
    public static final String endpointSecret;

    static {
        var evaluator = new ELExpressionEvaluator();
        var environment = new ConfigurableEnvironment(evaluator);

        publishableKey = environment.getProperty("Stripe Publishable Key", "stripe.publish-key");
        apiKey = environment.getProperty("Stripe API Key", "stripe.api-key");
        endpointSecret = environment.getProperty("Stripe Webhook Secrets", "stripe.endpoint-secret");

        Stripe.apiKey = apiKey;
    }

    public Session createCheckoutSession(HttpServletRequest req) throws StripeException {
        var user = UserContextFilter.getUserContext(req);
        assert user != null;

        var cart = cartService.getUserCart(user);
        assert cart != null;

        var domain = URLUtils.getBaseURL(req.getRequestURL().toString());
        var returnUrl = domain + "/checkout/success?session_id={CHECKOUT_SESSION_ID}";

        var params = SessionCreateParams.builder()
                .setUiMode(SessionCreateParams.UiMode.EMBEDDED)
                .setMode(SessionCreateParams.Mode.PAYMENT)
                .setReturnUrl(returnUrl)
                .setCustomerEmail(user.email())
                .addShippingOption(getShipping(cart))
                .addAllLineItem(getLineItems(cart))
                .build();

        return Session.create(params);
    }

    public void fulfillCheckout(Session checkoutSession) throws StripeException {
        if ("unpaid".equals(checkoutSession.getPaymentStatus()))
            return;

        var session = emf.unwrap(SessionFactory.class)
                .openStatelessSession();

        var cart = session.createSelectionQuery("""
                            from Cart c
                                join fetch c.account
                                join fetch c.shippingAddress
                                join fetch c.products
                            where c.account.email = :email
                        """, Cart.class)
                .setParameter("email", checkoutSession.getCustomerEmail())
                .getSingleResultOrNull();

        var order = new SalesOrder();
        order.setAccount(cart.getAccount());
        order.setShippingAddress(cart.getShippingAddress());
        order.setPaymentMethod(checkoutSession.getPaymentIntentObject().getPaymentMethodObject().getType());
        order.setTaxAmount(cart.getEstimatedTax());
        order.setDiscountAmount(BigDecimal.ZERO);
        if (!cart.getIsShippingDiscounted())
            order.setShippingAmount(cart.getShippingCost());

        cart.forEach(item -> {
            var orderItem = new SalesOrderProduct();
            orderItem.setOrder(order);
            orderItem.setProduct(item.getProduct());
            orderItem.setQuantity(item.getQuantity());
            orderItem.setUnitPrice(item.getProduct().getUnitPrice());
            orderItem.setUnitCost(item.getProduct().getUnitCost());

            session.insert(orderItem);
        });
        session.insert(order);

        cart.forEach(session::delete);
        session.delete(cart);
    }

    private SessionCreateParams.ShippingOption getShipping(Cart cart) {
        if (cart.getIsShippingDiscounted())
            return getFreeShipping();

        return SessionCreateParams.ShippingOption.builder()
                .setShippingRateData(
                        SessionCreateParams.ShippingOption.ShippingRateData.builder()
                                .setType(SessionCreateParams.ShippingOption.ShippingRateData.Type.FIXED_AMOUNT)
                                .setFixedAmount(
                                        SessionCreateParams.ShippingOption.ShippingRateData.FixedAmount.builder()
                                                .setCurrency("myr")
                                                .setAmount(cart.getShippingCost().movePointRight(2).longValue())
                                                .build()
                                ).setDisplayName("Standard Shipping")
                                .setDeliveryEstimate(getDeliveryEstimate()).build()
                ).build();
    }

    private SessionCreateParams.ShippingOption getFreeShipping() {
        return SessionCreateParams.ShippingOption.builder()
                .setShippingRateData(
                        SessionCreateParams.ShippingOption.ShippingRateData.builder()
                                .setType(SessionCreateParams.ShippingOption.ShippingRateData.Type.FIXED_AMOUNT)
                                .setFixedAmount(
                                        SessionCreateParams.ShippingOption.ShippingRateData.FixedAmount.builder()
                                                .setCurrency("myr")
                                                .setAmount(0L)
                                                .build()
                                ).setDisplayName("Free Shipping")
                                .setDeliveryEstimate(getDeliveryEstimate()).build()
                ).build();
    }

    private SessionCreateParams.ShippingOption.ShippingRateData.DeliveryEstimate getDeliveryEstimate() {
        return SessionCreateParams.ShippingOption.ShippingRateData.DeliveryEstimate.builder()
                .setMinimum(
                        SessionCreateParams.ShippingOption.ShippingRateData.DeliveryEstimate.Minimum.builder()
                                .setUnit(SessionCreateParams.ShippingOption.ShippingRateData.DeliveryEstimate.Minimum.Unit.BUSINESS_DAY)
                                .setValue(5L)
                                .build()
                ).setMaximum(
                        SessionCreateParams.ShippingOption.ShippingRateData.DeliveryEstimate.Maximum.builder()
                                .setUnit(SessionCreateParams.ShippingOption.ShippingRateData.DeliveryEstimate.Maximum.Unit.BUSINESS_DAY)
                                .setValue(7L)
                                .build()
                ).build();
    }

    private List<SessionCreateParams.LineItem> getLineItems(Cart cart) {
        return cart.stream()
                .map(this::getLineItem).toList();
    }

    private SessionCreateParams.LineItem getLineItem(CartProduct item) {
        return SessionCreateParams.LineItem.builder()
                .setQuantity((long) item.getQuantity())
                .setPriceData(getPriceData(item.getProduct()))
                .addTaxRate(taxId)
                .build();
    }

    private SessionCreateParams.LineItem.PriceData getPriceData(Product product) {
        return SessionCreateParams.LineItem.PriceData.builder()
                .setCurrency("myr")
                .setUnitAmountDecimal(product.getUnitPrice().movePointRight(2))
                .setProductData(
                        SessionCreateParams.LineItem.PriceData.ProductData.builder()
                                .setName(product.getName())
                                .build()
                ).build();
    }

}
