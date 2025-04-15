package com.lavacorp.beautefly.webstore.product.dto;

import com.github.slugify.Slugify;
import com.lavacorp.beautefly.webstore.product.entity.Category;
import jakarta.annotation.Nullable;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import org.hibernate.validator.constraints.URL;

import java.io.Serializable;

/**
 * DTO for {@link Category}
 */
public record CategoryDTO(
        int id,
        String name,
        String description,
        String imageUrl,
        @Nullable CategoryDTO parent
) implements Serializable {
    public String slug() {
        var slug = Slugify.builder().build();
        return slug.slugify(name);
    }
}
