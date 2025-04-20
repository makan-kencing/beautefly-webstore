package com.lavacorp.beautefly.webstore.rating.dto;

import com.lavacorp.beautefly.webstore.account.entity.Account;
import com.lavacorp.beautefly.webstore.file.dto.FileUploadDTO;

import java.io.Serializable;

/**
 * DTO for {@link Account}
 */
public record RatingUserDTO(
        int id,
        String username,
        FileUploadDTO profileImage
) implements Serializable {
}