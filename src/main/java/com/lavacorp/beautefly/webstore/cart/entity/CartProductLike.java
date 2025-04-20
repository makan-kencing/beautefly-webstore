package com.lavacorp.beautefly.webstore.cart.entity;

import com.lavacorp.beautefly.webstore.product.entity.Product;
import jakarta.persistence.*;
import jakarta.validation.constraints.PastOrPresent;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.CurrentTimestamp;

import java.io.Serializable;
import java.time.Instant;

@Getter
@Setter
@MappedSuperclass
public class CartProductLike<T extends CartLike<?>> implements Serializable {
    @EmbeddedId
    protected CartProductLikeId id;

    @MapsId(CartProductLikeId_.CART_ID)
    @ManyToOne(fetch = FetchType.LAZY)
    protected T cart;

    @MapsId(CartProductLikeId_.PRODUCT_ID)
    @ManyToOne(fetch = FetchType.LAZY)
    protected Product product;

    @PastOrPresent
    @CurrentTimestamp
    protected Instant addedAt;
}
