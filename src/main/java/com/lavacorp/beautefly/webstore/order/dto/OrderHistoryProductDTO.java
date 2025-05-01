package com.lavacorp.beautefly.webstore.order.dto;

import com.lavacorp.beautefly.webstore.file.dto.FileUploadDTO;

import java.util.List;

/**
 * DTO for {@link com.lavacorp.beautefly.webstore.product.entity.Product}
 */
public record OrderHistoryProductDTO (
        int id,
        String name,
        List<FileUploadDTO> images
) {
}
