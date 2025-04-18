package com.lavacorp.beautefly.webstore.account.dto;

import com.lavacorp.beautefly.webstore.account.entity.Credential;
import com.lavacorp.beautefly.webstore.file.dto.UseFileDTO;
import jakarta.annotation.Nullable;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Past;

import java.io.Serializable;
import java.time.LocalDate;
import java.util.List;

/**
 * DTO for {@link com.lavacorp.beautefly.webstore.account.entity.UserAccount}
 */
public record CreateUserAccountDTO(
        @NotNull int id,
        @NotNull String username,
        @NotNull String email,
        @NotNull String password,
        List<Credential.Role> roles,
        @Nullable String gender,
        @Nullable LocalDate dob,
        @Nullable UseFileDTO profileImage
) implements Serializable {
}