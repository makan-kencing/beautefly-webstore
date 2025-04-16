package com.lavacorp.beautefly.webstore.product.dto;

import java.io.Serializable;

/**
 * DTO for {@link com.lavacorp.beautefly.webstore.account.entity.UserAccount}
 */
public record RatingUserDTO(
        int id,
        String username,
        String profileImageUrl
) implements Serializable {
}