package com.lavacorp.beautefly.webstore.account.dto;

import com.lavacorp.beautefly.webstore.account.entity.Account;
import com.lavacorp.beautefly.webstore.account.entity.Credential;
import jakarta.annotation.Nullable;
import jakarta.validation.constraints.NotNull;

import java.io.Serializable;
import java.time.LocalDate;
import java.util.List;

/**
 * DTO for {@link Account}
 */
public record CreateUserAccountDTO(
        @NotNull int id,
        @NotNull String username,
        @NotNull String email,
        @NotNull String password,
        List<Credential.Role> roles,
        @Nullable String gender,
        @Nullable LocalDate dob,
        @Nullable Integer profileImageFileId
) implements Serializable {
}