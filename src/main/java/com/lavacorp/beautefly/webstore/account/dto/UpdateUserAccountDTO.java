package com.lavacorp.beautefly.webstore.account.dto;

import jakarta.annotation.Nullable;

import java.io.Serializable;
import java.time.LocalDate;

/**
 * DTO for {@link com.lavacorp.beautefly.webstore.account.entity.UserAccount}
 */
public record UpdateUserAccountDTO(
        int id,
        @Nullable String username,
        @Nullable String gender,
        @Nullable String email,
        @Nullable LocalDate dob,
        @Nullable Integer profileImageFileId,
        @Nullable Boolean active,
        @Nullable String password
) implements Serializable {
}