package com.lavacorp.beautefly.webstore.promotion.entity;

import com.lavacorp.beautefly.webstore.file.entity.FileUpload;
import com.lavacorp.beautefly.webstore.file.entity.FileUpload_;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;
import java.time.LocalDate;
import java.util.HashSet;
import java.util.Set;

@Getter
@Setter
@Entity
public class Promotion implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @NotBlank
    private String name;

    @NotBlank
    private String description;

    @OneToMany(mappedBy = FileUpload_.PROMOTION, fetch = FetchType.EAGER)
    private Set<FileUpload> images = new HashSet<>();

    @NotNull
    private LocalDate startDate;

    @NotNull
    private LocalDate endDate;

    @OneToMany(mappedBy = PromotionProduct_.PROMOTION, fetch = FetchType.EAGER)
    private Set<PromotionProduct> products = new HashSet<>();
}
