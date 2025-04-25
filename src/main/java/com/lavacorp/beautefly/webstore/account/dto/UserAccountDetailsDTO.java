package com.lavacorp.beautefly.webstore.account.dto;

import com.lavacorp.beautefly.webstore.account.entity.Account;
import com.lavacorp.beautefly.webstore.account.entity.Credential;
import com.lavacorp.beautefly.webstore.file.dto.FileUploadDTO;
import com.lavacorp.beautefly.webstore.order.dto.OrderDetailsDTO;

import java.io.Serializable;
import java.time.Instant;
import java.time.LocalDate;
import java.util.List;

/**
 * DTO for {@link Account}
 */
public record UserAccountDetailsDTO(
        int id,
        String username,
        String email,
        Instant createdAt,
        FileUploadDTO profileImage,
        Account.Gender gender,
        LocalDate dob,
        List<Credential.Role> roles,
        boolean active
) implements Serializable {
}