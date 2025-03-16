package com.lavacorp.beautefly.webstore.promotion.entity;

import com.lavacorp.beautefly.webstore.product.entity.Product;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.ManyToOne;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.math.BigDecimal;

@Data
@Entity
public class PromotionProduct {
    @Id
    @ManyToOne
    private Promotion promotion;

    @Id
    @ManyToOne
    private Product product;

    @NotNull
    private BigDecimal discountPrice;
}
