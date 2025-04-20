package com.lavacorp.beautefly.webstore.admin.dto;

import com.lavacorp.beautefly.webstore.account.dto.AddressDTO;
import com.lavacorp.beautefly.webstore.account.entity.Credential;
import com.lavacorp.beautefly.webstore.account.entity.Account;
import com.lavacorp.beautefly.webstore.file.dto.FileUploadDTO;

import java.io.Serializable;
import java.time.Instant;
import java.time.LocalDate;
import java.util.List;

/**
 * DTO for {@link Account}
 */
public record AdminUserAccountDTO(
        int id,
        Instant createdAt,
        String username,
        String email,
        Account.Gender gender,
        LocalDate dob,
        FileUploadDTO profileImage,
        List<Credential.Role> roles,
        List<AddressDTO> addresses,
        boolean active
) implements Serializable {
}