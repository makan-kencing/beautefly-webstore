package com.lavacorp.beautefly.webstore.account.dto;

import com.lavacorp.beautefly.webstore.account.entity.UserAccount;
import com.lavacorp.beautefly.webstore.file.dto.FileDTO;

import java.io.Serializable;
import java.time.LocalDate;

/**
 * DTO for {@link com.lavacorp.beautefly.webstore.account.entity.UserAccount}
 */
public record UserAccountDetailsDTO(
        int id,
        String username,
        UserAccount.Gender gender,
        String email,
        LocalDate dob,
        FileDTO profileImage
) implements Serializable {
}