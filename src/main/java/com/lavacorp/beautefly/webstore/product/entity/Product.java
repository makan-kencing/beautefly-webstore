package com.lavacorp.beautefly.webstore.product.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.validator.constraints.URL;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.HashSet;
import java.util.Set;

@Getter
@Setter
@Entity
public class Product implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @NotBlank
    private String name;

    @NotNull
    private String description;

    @ElementCollection
    private Set<@URL String> imageUrls = new HashSet<>();

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
