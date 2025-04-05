package com.lavacorp.beautefly.webstore.security.dto;

import com.lavacorp.beautefly.webstore.security.constraint.Password;
import com.lavacorp.beautefly.webstore.account.entity.Account;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

/**
 * DTO for {@link Account}
 */
public record AccountRegisterDTO(
        @NotBlank String username,
        @NotNull @Email String email,
        @NotNull @Password String password) {
}
