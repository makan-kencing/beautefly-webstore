package com.lavacorp.beautefly.webstore.cart.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

import static jakarta.persistence.FetchType.LAZY;

@Getter
@Setter
@Embeddable
public class Cart implements Serializable {
    @OneToMany(mappedBy = CartProduct_.ACCOUNT, fetch = LAZY)
    private Set<CartProduct> products = new HashSet<>();

    public void addProduct(CartProduct product) {
        var cartProduct = products.stream().filter(product::equals).findAny();
        if (cartProduct.isPresent())
            cartProduct.get().addQuantity(product.getQuantity());
        else
            products.add(product);
    }

    public void removeProduct(CartProduct product) {
        var cartProduct = products.stream().filter(product::equals).findAny();
        if (cartProduct.isPresent())
            if (cartProduct.get().getQuantity() <= product.getQuantity())  // subtraction would result in less than 0
                products.remove(product);
            else
                cartProduct.get().removeQuantity(product.getQuantity());
        else
            products.add(product);
    }
}
