package com.lavacorp.beautefly.webstore.cart;

import com.lavacorp.beautefly.webstore.account.entity.Account;
import com.lavacorp.beautefly.webstore.account.entity.Address;
import com.lavacorp.beautefly.webstore.cart.dto.CartDTO;
import com.lavacorp.beautefly.webstore.cart.dto.CartItemDTO;
import com.lavacorp.beautefly.webstore.cart.dto.UpdateCartProductDTO;
import com.lavacorp.beautefly.webstore.cart.entity.Cart;
import com.lavacorp.beautefly.webstore.cart.entity.CartProduct;
import com.lavacorp.beautefly.webstore.cart.entity.CartProductLikeId;
import com.lavacorp.beautefly.webstore.cart.mapper.CartMapper;
import com.lavacorp.beautefly.webstore.product.entity.Product;
import com.lavacorp.beautefly.webstore.security.dto.AccountContextDTO;
import jakarta.annotation.Nullable;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.servlet.http.HttpSession;
import jakarta.transaction.Transactional;
import jakarta.validation.constraints.NotNull;

@Transactional
@ApplicationScoped
public class CartService {
    public static String SESSION_CART_ATTRIBUTE_NAME = "cart";

    @PersistenceContext
    private EntityManager em;

    @Inject
    private CartMapper cartMapper;

    @SuppressWarnings("UnusedReturnValue")
    public CartItemDTO updateCartProductQuantity(HttpSession session, AccountContextDTO user, UpdateCartProductDTO item) {
        var cart = getCart(session, user);

        var cartItem = new CartProduct();
        cartItem.setProduct(em.getReference(Product.class, item.productId()));
        cartItem.setCart(cart);
        cartItem.setQuantity(item.quantity());

        cartItem = switch (item.action()) {
            case INCREMENT -> cart.addProduct(cartItem);
            case SET -> cart.setProduct(cartItem);
            case DECREMENT -> cart.removeProduct(cartItem);
        };

        em.merge(cartItem);
        return cartMapper.toCartItemDTO(cartItem);
    }

    public CartDTO getCartDetails(HttpSession session, @Nullable AccountContextDTO user) {
        var cart = getCart(session, user);
        return cartMapper.toCartDTO(cart);
    }

    public void updateSelectedAddress(HttpSession session, AccountContextDTO user, int selectedAddressId) {
        var cart = getCart(session, user);
        cart.setShippingAddress(em.getReference(Address.class, selectedAddressId));

        em.merge(cart);
    }

    public @NotNull Cart getGuestCart(HttpSession session) {
        var cartId = session.getAttribute(SESSION_CART_ATTRIBUTE_NAME);

        // guest cart already created
        if (cartId != null)
            return em.find(Cart.class, cartId);

        // create new guest cart
        var cart = new Cart();
        em.persist(cart);

        session.setAttribute(SESSION_CART_ATTRIBUTE_NAME, cart.getId());

        return cart;
    }

    public @Nullable Cart getUserCart(AccountContextDTO user) {
        var account = em.find(Account.class, user.id());
        if (account == null)
            return null;

        var cart = account.getCart();

        // user has a cart
        if (cart != null)
            return cart;

        // create new user cart
        cart = new Cart();
        cart.setAccount(account);
        em.persist(cart);

        return cart;
    }

    public @NotNull Cart getCart(HttpSession session, @Nullable AccountContextDTO user) {
        if (user == null)
            return getGuestCart(session);

        var cart = getUserCart(user);

        if (cart == null)
            return getGuestCart(session);

        if (session.getAttribute(SESSION_CART_ATTRIBUTE_NAME) != null) // has guest cart
            mergeSessionCart(session, cart);

        return cart;
    }

    private void mergeSessionCart(HttpSession session, @NotNull Cart userCart) {
        var guestCart = getGuestCart(session);
        mergeCart(guestCart, userCart);

        session.removeAttribute(SESSION_CART_ATTRIBUTE_NAME);
    }

    private void mergeCart(@NotNull Cart src, @NotNull Cart dest) {
        for (var item : src)
            dest.addProduct(item);

        em.remove(src);
    }
}
