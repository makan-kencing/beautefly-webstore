package com.lavacorp.beautefly.webstore.rating.dto;

import jakarta.servlet.http.Part;

import java.io.Serializable;
import java.util.Collection;
import java.util.List;

/**
 * DTO for {@link com.lavacorp.beautefly.webstore.rating.entity.Rating}
 */
public record RatingNewDTO(
        int productId,
        int rating,
        String title,
        String message,
        Collection<Part> images
) implements Serializable {
}