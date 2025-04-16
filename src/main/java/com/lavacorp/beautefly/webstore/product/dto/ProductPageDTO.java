package com.lavacorp.beautefly.webstore.product.dto;

import com.lavacorp.beautefly.webstore.product.entity.Product;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

/**
 * DTO for {@link Product}
 */
public record ProductPageDTO(
        int id,
        String name,
        String description,
        List<String> imageUrls,
        String brand,
        CategoryDTO category,
        ColorDTO color,
        LocalDate releaseDate,
        BigDecimal unitPrice,
        int stockCount,
        List<RatingDTO> ratings
) implements Serializable {
}