package com.lavacorp.beautefly.webstore.product.entity;

import com.lavacorp.beautefly.webstore.file.entity.File;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.NaturalId;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

@Getter
@Setter
@Entity
public class Category implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @NotNull
    @NotBlank
    @NaturalId
    private String name;

    private String description;

    @OneToOne(fetch = FetchType.EAGER)
    private File image;

    @ManyToOne(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    private Category parent;

    @OneToMany(mappedBy = Category_.PARENT, fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    private Set<Category> subcategories = new HashSet<>();

    @OneToMany(mappedBy = Product_.CATEGORY, fetch = FetchType.LAZY)
    private Set<Product> products;
}
