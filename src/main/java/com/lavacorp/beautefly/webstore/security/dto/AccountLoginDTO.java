package com.lavacorp.beautefly.webstore.security.dto;

import com.lavacorp.beautefly.webstore.account.entity.Account;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

/**
 * DTO for {@link Account}
 */
public record AccountLoginDTO(
        @NotNull @Email String email,
        @NotBlank String password) {
}
