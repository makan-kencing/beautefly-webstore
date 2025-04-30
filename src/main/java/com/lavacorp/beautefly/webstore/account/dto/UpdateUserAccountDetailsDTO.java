package com.lavacorp.beautefly.webstore.account.dto;

import com.lavacorp.beautefly.webstore.account.entity.Account;
import jakarta.annotation.Nullable;

import java.io.Serializable;
import java.time.LocalDate;

/**
 * DTO for {@link Account}
 */
public record UpdateUserAccountDetailsDTO(
        @Nullable String username,
        @Nullable String email,
        @Nullable Account.Gender gender,
        @Nullable LocalDate dob
) implements Serializable {
}