package com.lavacorp.beautefly.webstore.account.dto;

import com.lavacorp.beautefly.webstore.file.dto.UseFileDTO;
import jakarta.annotation.Nullable;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Past;

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
        @Nullable UseFileDTO profileImage,
        @Nullable Boolean active,
        @Nullable String password
) implements Serializable {
}