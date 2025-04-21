package com.lavacorp.beautefly.webstore.cart;

import com.lavacorp.beautefly.webstore.account.entity.Account;
import com.lavacorp.beautefly.webstore.cart.dto.CartDTO;
import com.lavacorp.beautefly.webstore.cart.dto.CartItemDTO;
import com.lavacorp.beautefly.webstore.cart.dto.SetCartProductDTO;
import com.lavacorp.beautefly.webstore.cart.entity.Cart;
import com.lavacorp.beautefly.webstore.cart.entity.CartProduct;
import com.lavacorp.beautefly.webstore.cart.mapper.CartMapper;
import com.lavacorp.beautefly.webstore.product.ProductStatelessRepository;
import com.lavacorp.beautefly.webstore.product.entity.Product;
import com.lavacorp.beautefly.webstore.security.SecurityService;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.servlet.http.HttpServletRequest;
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
    private ProductStatelessRepository productRepository;

    @Inject
    private SecurityService securityService;

    @Inject
    private CartMapper cartMapper;

    @SuppressWarnings("UnusedReturnValue")
    public CartItemDTO setCartProductQuantity(HttpServletRequest req, SetCartProductDTO dto) {
        var cart = getCart(req);

        var cartItem = new CartProduct();
        cartItem.setProduct(em.getReference(Product.class, dto.productId()));
        cartItem.setQuantity(dto.quantity());

        cartItem = cart.setProduct(cartItem);
        return cartMapper.toCartItemDTO(cartItem);
    }

    @SuppressWarnings("UnusedReturnValue")
    public CartItemDTO addCartProductQuantity(HttpServletRequest req, SetCartProductDTO dto) {
        var cart = getCart(req);

        var cartItem = new CartProduct();
        cartItem.setProduct(em.getReference(Product.class, dto.productId()));
        cartItem.setQuantity(dto.quantity());

        cartItem = cart.addProduct(cartItem);
        return cartMapper.toCartItemDTO(cartItem);
    }

    @SuppressWarnings("UnusedReturnValue")
    public CartItemDTO removeCartProductQuantity(HttpServletRequest req, SetCartProductDTO dto) {
        var cart = getCart(req);

        var cartItem = new CartProduct();
        cartItem.setProduct(em.getReference(Product.class, dto.productId()));
        cartItem.setQuantity(dto.quantity());

        cartItem = cart.removeProduct(cartItem);
        return cartMapper.toCartItemDTO(cartItem);
    }


    public CartDTO getCartDetails(HttpServletRequest req) {
        var cart = getCart(req);
        return cartMapper.toCartDTO(cart);
    }

    private @NotNull Cart getGuestCart(HttpSession session) {
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

    private @NotNull Cart getUserCart(Account account) {
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

    private @NotNull Cart getCart(HttpServletRequest req) {
        var account = securityService.getAccountContext(req);
        var session = req.getSession();

        if (account == null)
            return getGuestCart(session);

        var userCart = getUserCart(account);

        if (session.getAttribute(SESSION_CART_ATTRIBUTE_NAME) != null) { // has guest cart
            var guestCart = getGuestCart(session);
            mergeCart(guestCart, userCart);
        }

        return userCart;
    }

    private void mergeCart(@NotNull Cart src, @NotNull Cart dest) {
        for (var item : src)
            src.addProduct(item);

        em.remove(src);
    }
}
