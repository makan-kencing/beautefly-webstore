package com.lavacorp.beautefly.webstore.cart.entity;

import jakarta.persistence.Embeddable;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;

@Getter
@Setter
@Embeddable
public class CartProductLikeId implements Serializable {
    private int cartId;
    private int productId;
}
