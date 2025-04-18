package com.lavacorp.beautefly.webstore.account.dto;

import com.lavacorp.beautefly.webstore.file.dto.FileDTO;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Past;
import org.hibernate.validator.constraints.URL;

import java.io.Serializable;
import java.time.LocalDate;
import java.util.List;

/**
 * DTO for {@link com.lavacorp.beautefly.webstore.account.entity.UserAccount}
 */
public record UserAccountDTO(
        int id,
        String username,
        String gender,
        String email,
        LocalDate dob,
        FileDTO profileImage,
        boolean active,
        List<AddressDTO> addresses
) implements Serializable {
}