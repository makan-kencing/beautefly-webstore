package com.lavacorp.beautefly.webstore.promotion.entity;

import com.lavacorp.beautefly.webstore.product.entity.Product;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;
import java.math.BigDecimal;

@Getter
@Setter
@Entity
public class PromotionProduct implements Serializable {
    @EmbeddedId
    private PromotionProductId id;

    @MapsId(PromotionProductId_.PROMOTION_ID)
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    private Promotion promotion;

    @MapsId(PromotionProductId_.PRODUCT_ID)
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    private Product product;

    @NotNull
    private BigDecimal discountPrice;
}
