package com.lavacorp.beautefly.webstore.promotion.entity;

import com.lavacorp.beautefly.webstore.common.entity.ProductItemId;
import jakarta.persistence.Embeddable;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Embeddable
public class PromotionProductId extends ProductItemId {
    private int promotionId;
    private int productId;
}
