package com.lavacorp.beautefly.webstore.product.dto;

import com.lavacorp.beautefly.webstore.file.dto.FileDTO;

import java.io.Serializable;

/**
 * DTO for {@link com.lavacorp.beautefly.webstore.account.entity.UserAccount}
 */
public record RatingUserDTO(
        int id,
        String username,
        FileDTO profileImage
) implements Serializable {
}