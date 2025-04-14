package com.lavacorp.beautefly.webstore.product.entity;

import com.github.slugify.Slugify;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.validator.constraints.URL;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

@Getter
@Setter
@Entity
public class Subcategory implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @NotNull
    @NotBlank
    private String name;

    private String description;

    @NotNull
    @URL
    private String imageUrl;

    @ManyToOne(fetch = FetchType.EAGER, cascade = CascadeType.ALL, optional = false)
    private Category category;

    @OneToMany(mappedBy = Product_.SUBCATEGORY, fetch = FetchType.LAZY)
    private Set<Product> products = new HashSet<>();

    public String getSlug() {
        var slug = Slugify.builder().build();
        return slug.slugify(name);
    }
}
