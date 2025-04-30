package com.lavacorp.beautefly.webstore.admin.product.dto;

import jakarta.servlet.http.Part;

/**
 * DTO for {@link com.lavacorp.beautefly.webstore.product.entity.Product}
 */
public record UploadProductImageDTO (
        int id,
        Part image
) {
}
