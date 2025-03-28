package com.lavacorp.beautefly.webstore.product.entity;

import com.lavacorp.beautefly.webstore.promotion.entity.PromotionProduct;
import com.lavacorp.beautefly.webstore.promotion.entity.PromotionProduct_;
import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.Set;

import static jakarta.persistence.FetchType.LAZY;

@Getter
@Setter
@Entity
public class Product implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @NotBlank
    private String name;

    @NotBlank
    private String description;

    @ElementCollection
    private Set<String> imageUrls;

    private String brand;

    private String category;

    @PastOrPresent
    private LocalDate releaseDate;

    @NotNull
    @Positive
    private BigDecimal unitPrice;

    @NotNull
    @Positive
    private BigDecimal unitCost;

    @NotNull
    @PositiveOrZero
    private int stockCount;

    // TODO: filter only within period
    @OneToMany(mappedBy = PromotionProduct_.PRODUCT, fetch = LAZY)
    private Set<PromotionProduct> promotedProduct;
}
