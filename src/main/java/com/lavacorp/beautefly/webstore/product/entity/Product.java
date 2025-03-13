package com.lavacorp.beautefly.webstore.product.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.Data;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.Set;

@Data
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
}
