package com.lavacorp.beautefly.webstore.product.dto;

import com.lavacorp.beautefly.webstore.file.dto.FileUploadDTO;

import java.io.Serializable;
import java.util.List;

/**
 * DTO for {@link com.lavacorp.beautefly.webstore.product.entity.Category}
 */
public record CategoryTreeDTO(
        int id,
        String name,
        String description,
        FileUploadDTO image,
        List<CategoryTreeDTO> subcategories
) implements Serializable {
}