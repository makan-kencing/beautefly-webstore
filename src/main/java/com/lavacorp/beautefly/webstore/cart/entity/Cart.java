package com.lavacorp.beautefly.webstore.cart.entity;

import jakarta.persistence.Entity;
import jakarta.validation.constraints.NotNull;

import java.math.BigDecimal;

@Entity
public class Cart extends CartLike<CartProduct> {
    public @NotNull CartProduct addProduct(CartProduct product) {
        var cartProduct = getCartItem(product.getId().getProductId());
        if (cartProduct.isPresent()) {
            cartProduct.get().addQuantity(product.getQuantity());
            return cartProduct.get();
        }
        else {
            products.add(product);
            return product;
        }
    }

    public @NotNull CartProduct removeProduct(CartProduct product) {
        var cartProduct = getCartItem(product.getId().getProductId());
        if (cartProduct.isPresent()) {
            if (cartProduct.get().getQuantity() <= product.getQuantity()) // subtraction would result in less than 0
                products.remove(product);
            else
                cartProduct.get().removeQuantity(product.getQuantity());
            return cartProduct.get();
        }
        else {
            products.add(product);
            return product;
        }
    }

    public @NotNull CartProduct setProduct(CartProduct product) {
        var cartProduct = getCartItem(product.getId().getProductId());
        if (cartProduct.isPresent()) {
            cartProduct.get().setQuantity(product.getQuantity());
            return cartProduct.get();
        }
        else {
            products.add(product);
            return product;
        }
    }

    public BigDecimal getSubtotal() {
        return products.stream()
                .map(CartProduct::getSubtotal)
                .reduce(BigDecimal::add)
                .orElse(BigDecimal.ZERO);
    }

    public BigDecimal getShippingCost() {
        return BigDecimal.valueOf(25);
    }

    public BigDecimal getEstimatedTax() {
        return getSubtotal().multiply(BigDecimal.valueOf(0.10));
    }

    public boolean getIsShippingDiscounted() {
        return getSubtotal().compareTo(BigDecimal.valueOf(1000)) >= 0;
    }

    public BigDecimal getTotal() {
        var total = getSubtotal();

        if (!getIsShippingDiscounted())
            total = total.add(getShippingCost());

        total = total.add(getEstimatedTax());

        return total;
    }
}
