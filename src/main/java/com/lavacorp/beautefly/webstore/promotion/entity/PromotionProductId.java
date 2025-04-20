package com.lavacorp.beautefly.webstore.promotion.entity;

import jakarta.persistence.Embeddable;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Embeddable
public class PromotionProductId {
    private int promotionId;
    private int productId;
}
