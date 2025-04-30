package com.lavacorp.beautefly.webstore.admin.product.dto;

import com.lavacorp.beautefly.webstore.file.dto.FileUploadDTO;
import com.lavacorp.beautefly.webstore.product.dto.CategoryDTO;
import com.lavacorp.beautefly.webstore.product.dto.ColorDTO;
import jakarta.annotation.Nullable;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

/**
 * DTO for {@link com.lavacorp.beautefly.webstore.product.entity.Product}
 */
public record ProductDetailsDTO(
        int id,
        String name,
        String description,
        List<FileUploadDTO> images,
        String brand,
        CategoryDTO category,
        @Nullable ColorDTO color,
        LocalDate releaseDate,
        BigDecimal unitPrice,
        BigDecimal unitCost,
        int stockCount
) implements Serializable {
}