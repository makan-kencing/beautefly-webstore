package com.lavacorp.beautefly.webstore.product.dto;

import com.github.slugify.Slugify;
import com.lavacorp.beautefly.webstore.product.entity.Product;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

/**
 * DTO for {@link Product}
 */
public record ProductSearchResultDTO(
        int id,
        String name,
        String description,
        List<String> imageUrls,
        String brand,
        CategoryDTO category,
        ColorDTO color,
        LocalDate releaseDate,
        BigDecimal unitPrice
) implements Serializable {
    public String slug() {
        var slug = Slugify.builder().build();
        return slug.slugify(name);
    }
}