package com.lavacorp.beautefly.webstore.cart.entity;

import jakarta.persistence.Embeddable;
import jakarta.persistence.OneToMany;
import lombok.Getter;
import lombok.Setter;

import java.util.Set;

import static jakarta.persistence.FetchType.LAZY;

@Getter
@Setter
@Embeddable
public class Cart {
    @OneToMany(mappedBy = CartProduct_.ACCOUNT, fetch = LAZY)
    private Set<CartProduct> products;
}
