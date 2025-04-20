package com.lavacorp.beautefly.webstore.cart.entity;

import jakarta.persistence.Entity;

import java.math.BigDecimal;

@Entity
public class Cart extends CartLike<CartProduct> {
    public void addProduct(CartProduct product) {
        var cartProduct = products.stream().filter(product::equals).findAny();
        if (cartProduct.isPresent())
            cartProduct.get().addQuantity(product.getQuantity());
        else
            products.add(product);
    }

    public void removeProduct(CartProduct product) {
        var cartProduct = products.stream()
                .filter(product::equals)
                .findAny();
        if (cartProduct.isPresent())
            if (cartProduct.get().getQuantity() <= product.getQuantity())  // subtraction would result in less than 0
                products.remove(product);
            else
                cartProduct.get().removeQuantity(product.getQuantity());
        else
            products.add(product);
    }

    public void setProduct(CartProduct product) {
        var cartProduct = products.stream().filter(product::equals).findAny();
        if (cartProduct.isPresent())
            cartProduct.get().setQuantity(product.getQuantity());
        else
            products.add(product);
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

    public boolean isShippingDiscounted() {
        return getSubtotal().compareTo(BigDecimal.valueOf(1000)) >= 0;
    }

    public BigDecimal getTotal() {
        var total = getSubtotal();

        if (!isShippingDiscounted())
            total = total.add(getShippingCost());

        total = total.add(getEstimatedTax());

        return total;
    }
}
