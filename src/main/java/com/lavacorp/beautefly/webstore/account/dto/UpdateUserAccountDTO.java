package com.lavacorp.beautefly.webstore.account.dto;

import com.lavacorp.beautefly.webstore.account.entity.Account;
import jakarta.annotation.Nullable;

import java.io.Serializable;
import java.time.LocalDate;

/**
 * DTO for {@link Account}
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