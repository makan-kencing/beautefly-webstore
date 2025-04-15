package com.lavacorp.beautefly.webstore.product.dto;

import java.io.Serializable;

/**
 * DTO for {@link com.lavacorp.beautefly.webstore.product.entity.Color}
 */
public record ColorDTO(
        int id,
        String name,
        java.awt.Color color
) implements Serializable {
}