package com.lavacorp.beautefly.webstore.product.dto;

import java.io.File;
import java.io.Serializable;

/**
 * DTO for {@link com.lavacorp.beautefly.webstore.account.entity.UserAccount}
 */
public record RatingUserDTO(
        int id,
        String username,
        File profileImage
) implements Serializable {
}