package com.lavacorp.beautefly.webstore.cart.entity;

import com.lavacorp.beautefly.webstore.common.entity.ProductItemId;
import jakarta.persistence.Embeddable;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Embeddable
public class CartProductLikeId extends ProductItemId {
    private int cartId;
    private int productId;
}
