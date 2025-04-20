package com.lavacorp.beautefly.webstore.product.dto;

import com.github.slugify.Slugify;
import com.lavacorp.beautefly.webstore.file.dto.FileUploadDTO;
import com.lavacorp.beautefly.webstore.product.entity.Category;
import jakarta.annotation.Nullable;

import java.io.Serializable;

/**
 * DTO for {@link Category}
 */
public record CategoryDTO(
        int id,
        String name,
        String description,
        FileUploadDTO image,
        @Nullable CategoryDTO parent
) implements Serializable {
    public String slug() {
        var slug = Slugify.builder().build();
        return slug.slugify(name);
    }
}
