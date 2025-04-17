package com.lavacorp.beautefly.webstore.account.dto;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Past;
import org.hibernate.validator.constraints.URL;

import java.io.Serializable;
import java.time.LocalDate;

/**
 * DTO for {@link com.lavacorp.beautefly.webstore.account.entity.UserAccount}
 */
public record UserAccountDTO(int id,
                             @NotBlank String username,
                             String phone,
                             String gender,
                             @NotNull @Email String email,
                             @Past LocalDate dob,
                             @URL String profileImageUrl) implements Serializable {
}