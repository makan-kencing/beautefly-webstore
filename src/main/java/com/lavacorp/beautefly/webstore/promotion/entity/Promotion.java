package com.lavacorp.beautefly.webstore.promotion.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.time.LocalDate;
import java.util.Set;

@Getter
@Setter
@Entity
public class Promotion {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @NotBlank
    private String name;

    @NotBlank
    private String description;

    @ElementCollection
    private Set<String> imageUrls;

    @NotNull
    private LocalDate startDate;

    @NotNull
    private LocalDate endDate;

    @OneToMany(mappedBy = PromotionProduct_.PROMOTION)
    private Set<PromotionProduct> products;
}
