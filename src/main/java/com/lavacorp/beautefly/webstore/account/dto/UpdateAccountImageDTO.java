package com.lavacorp.beautefly.webstore.account.dto;

import jakarta.servlet.http.Part;

/**
 * DTO for {@link com.lavacorp.beautefly.webstore.account.entity.Account}
 */
public record UpdateAccountImageDTO(
        int accountId,
        Part image
) {
}
