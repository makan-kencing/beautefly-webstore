package com.lavacorp.beautefly.webstore.cart;

import com.lavacorp.beautefly.webstore.account.entity.Account;
import com.lavacorp.beautefly.webstore.account.entity.Address;
import com.lavacorp.beautefly.webstore.cart.dto.CartDTO;
import com.lavacorp.beautefly.webstore.cart.dto.UpdateCartProductDTO;
import com.lavacorp.beautefly.webstore.cart.entity.Cart;
import com.lavacorp.beautefly.webstore.cart.entity.CartProduct;
import com.lavacorp.beautefly.webstore.cart.mapper.CartMapper;
import com.lavacorp.beautefly.webstore.product.entity.Product;
import com.lavacorp.beautefly.webstore.security.dto.AccountContextDTO;
import jakarta.annotation.Nullable;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.PersistenceUnit;
import jakarta.servlet.http.HttpSession;
import jakarta.transaction.Transactional;
import jakarta.validation.constraints.NotNull;
import org.hibernate.SessionFactory;

import static com.lavacorp.beautefly.webstore.cart.dto.UpdateCartProductDTO.Action.DECREMENT;

@Transactional
@ApplicationScoped
public class CartService {
    public static String SESSION_CART_ATTRIBUTE_NAME = "cart";

    @PersistenceUnit
    private EntityManagerFactory emf;

    @Inject
    private CartMapper cartMapper;

    public void updateCartProductQuantity(HttpSession session, AccountContextDTO user, UpdateCartProductDTO update) {
        var cart = getCart(session, user);

        var statelessSession = emf.unwrap(SessionFactory.class)
                .openStatelessSession();

        var product = new Product();
        product.setId(update.productId());

        var item = cart.getCartItem(update.productId()).orElse(null);

        if (item != null) {
            switch (update.action()) {
                case INCREMENT -> item.addQuantity(update.quantity());
                case SET -> item.setQuantity(update.quantity());
                case DECREMENT -> item.removeQuantity(update.quantity());
            }

            if (item.getQuantity() <= 0)
                statelessSession.delete(item);
            else
                statelessSession.update(item);
        } else {
            if (update.action() == DECREMENT)
                return;

            item = new CartProduct();

            item.setProduct(product);
            item.setCart(cart);
            item.setQuantity(update.quantity());

            statelessSession.insert(item);
        }
    }


    public CartDTO getCartDetails(HttpSession session, @Nullable AccountContextDTO user) {
        var cart = getCart(session, user);
        return cartMapper.toCartDTO(cart);
    }

    public void updateSelectedAddress(HttpSession session, AccountContextDTO user, int selectedAddressId) {
        var cart = getCart(session, user);

        var statelessSession = emf.unwrap(SessionFactory.class)
                .openStatelessSession();

        var address = new Address();
        address.setId(selectedAddressId);

        cart.setShippingAddress(address);

        statelessSession.update(cart);
    }

    public @Nullable Cart getCart(AccountContextDTO user) {
        var statelessSession = emf.unwrap(SessionFactory.class)
                .openStatelessSession();

        return statelessSession.createSelectionQuery("""
                            from Cart c
                                left join fetch c.products
                            where c.account.id = :accountId
                        """, Cart.class)
                .setParameter("accountId", user.id())
                .getSingleResultOrNull();
    }

    public @Nullable Cart getCart(HttpSession session) {
        var statelessSession = emf.unwrap(SessionFactory.class)
                .openStatelessSession();

        var cartId = session.getAttribute(SESSION_CART_ATTRIBUTE_NAME);
        if (cartId == null)
            return null;

        return statelessSession.createSelectionQuery("""
                            from Cart c
                                left join fetch c.products
                            where c.id = :cartId
                        """, Cart.class)
                .setParameter("cartId", cartId)
                .getSingleResultOrNull();
    }

    public Cart createCart(AccountContextDTO user) {
        var statelessSession = emf.unwrap(SessionFactory.class)
                .openStatelessSession();

        var account = new Account();
        account.setId(user.id());

        var cart = new Cart();
        cart.setAccount(account);

        statelessSession.insert(cart);

        return cart;
    }

    public Cart createCart(HttpSession session) {
        var statelessSession = emf.unwrap(SessionFactory.class)
                .openStatelessSession();

        var cart = new Cart();

        statelessSession.insert(cart);
        session.setAttribute(SESSION_CART_ATTRIBUTE_NAME, cart.getId());

        return cart;
    }

    public void invalidateGuestCart(HttpSession session) {
        session.removeAttribute(SESSION_CART_ATTRIBUTE_NAME);
    }

    public @NotNull Cart getCart(HttpSession session, @Nullable AccountContextDTO user) {
        var guestCart = getCart(session);

        // guest user
        if (user == null)
            return guestCart != null ? guestCart : createCart(session);

        // authenticated
        var userCart = getCart(user);
        if (userCart == null)
            userCart = createCart(user);

        if (guestCart != null) {  // has guest cart
            mergeCart(guestCart, userCart);
            invalidateGuestCart(session);
        }

        return userCart;
    }

    private void mergeCart(@NotNull Cart src, @NotNull Cart dest) {
        var statelessSession = emf.unwrap(SessionFactory.class)
                .openStatelessSession();

        for (var item : src) {
            statelessSession.delete(item);
            item.setCart(dest);

            var existingItem = dest.getCartItem(item.getProduct().getId()).orElse(null);

            if (existingItem != null) {
                existingItem.setQuantity(existingItem.getQuantity() + item.getQuantity());

                statelessSession.update(existingItem);
            } else {
                dest.getProducts().add(item);

                statelessSession.insert(item);
            }
        }

        statelessSession.delete(src);
        statelessSession.update(dest);
    }
}
