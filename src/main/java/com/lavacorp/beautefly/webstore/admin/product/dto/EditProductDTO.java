package com.lavacorp.beautefly.webstore.admin.product.dto;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDate;

/**
 * DTO for {@link com.lavacorp.beautefly.webstore.product.entity.Product}
 */
public record EditProductDTO(
        int id,
        String name,
        String description,
        String brand,
        Integer categoryId,
        Integer colorId,
        LocalDate releaseDate,
        BigDecimal unitPrice,
        BigDecimal unitCost,
        int stockCount
) implements Serializable {
}