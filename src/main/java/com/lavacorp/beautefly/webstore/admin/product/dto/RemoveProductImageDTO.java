package com.lavacorp.beautefly.webstore.admin.product.dto;

/**
 * DTO for {@link com.lavacorp.beautefly.webstore.product.entity.Product}
 */
public record RemoveProductImageDTO(
        int id,
        int imageId
) {
}
