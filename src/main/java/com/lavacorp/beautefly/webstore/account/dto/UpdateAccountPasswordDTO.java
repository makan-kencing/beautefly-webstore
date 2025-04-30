package com.lavacorp.beautefly.webstore.account.dto;

import java.io.Serializable;

/**
 * DTO for {@link com.lavacorp.beautefly.webstore.account.entity.Account}
 */
public record UpdateAccountPasswordDTO(
        String oldPassword,
        String newPassword
) implements Serializable {
}