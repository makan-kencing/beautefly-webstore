package com.lavacorp.beautefly.webstore.cart;

import com.lavacorp.beautefly.webstore.cart.dto.CartDTO;
import com.lavacorp.beautefly.webstore.cart.dto.CartItemDTO;
import com.lavacorp.beautefly.webstore.cart.entity.Cart;
import com.lavacorp.beautefly.webstore.cart.entity.CartProduct;
import com.lavacorp.beautefly.webstore.product.ProductStatelessRepository;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.ValidationException;

import java.util.NoSuchElementException;

@ApplicationScoped
public class CartService {
    @Inject
    ProductStatelessRepository productRepository;

    public CartProduct getCartProductFromParameter(HttpServletRequest req) {
        var productIdParameter = req.getParameter("product");
        if (productIdParameter == null) {
            throw new ValidationException("product field is null");
        }
        var productId = Integer.parseInt(productIdParameter);

        var quantityParameter = req.getParameter("quantity");
        if (quantityParameter == null)
            quantityParameter = "1";
        var quantity = Integer.parseInt(quantityParameter);

        var product = productRepository.find(productId);
        if (product == null) {
            throw new NoSuchElementException("Product with id " + productId + " does not exists.");
        }

        var cartProduct = new CartProduct();
        cartProduct.setProduct(product);
        cartProduct.setQuantity(quantity);
        return cartProduct;
    }

    public CartDTO toCartDto(Cart cart) {
        return new CartDTO(
                cart.stream()
                        .map(p -> new CartItemDTO(
                                p.getProduct(),
                                p.getQuantity(),
                                p.getSubtotal()
                        )).toList(),
                cart.getSubtotal(),
                cart.getShippingCost(),
                cart.isShippingDiscounted(),
                cart.getEstimatedTax(),
                cart.getTotal()
        );
    }
}
