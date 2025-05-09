package com.lavacorp.beautefly.webstore.product.dto;

import com.github.slugify.Slugify;
import com.lavacorp.beautefly.webstore.file.dto.FileUploadDTO;
import com.lavacorp.beautefly.webstore.product.entity.Product;
import com.lavacorp.beautefly.webstore.rating.dto.RatingDTO;

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
        List<FileUploadDTO> images,
        String brand,
        CategoryDTO category,
        ColorDTO color,
        LocalDate releaseDate,
        BigDecimal unitPrice,
        int stockCount,
        List<RatingDTO> ratings
) implements Serializable {
    public String slug() {
        var slug = Slugify.builder().build();
        return slug.slugify(name);
    }
}