package com.lavacorp.beautefly.webstore.cart.entity;

import jakarta.annotation.Nullable;
import jakarta.persistence.Entity;
import jakarta.validation.constraints.NotNull;

import java.math.BigDecimal;

@Entity
public class Cart extends CartLike<CartProduct> {
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
