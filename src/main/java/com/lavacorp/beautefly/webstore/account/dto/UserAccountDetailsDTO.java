package com.lavacorp.beautefly.webstore.account.dto;

import com.lavacorp.beautefly.webstore.account.entity.Account;
import com.lavacorp.beautefly.webstore.file.dto.FileUploadDTO;

import java.io.Serializable;
import java.time.LocalDate;

/**
 * DTO for {@link Account}
 */
public record UserAccountDetailsDTO(
        int id,
        String username,
        Account.Gender gender,
        String email,
        LocalDate dob,
        FileUploadDTO profileImage
) implements Serializable {
}