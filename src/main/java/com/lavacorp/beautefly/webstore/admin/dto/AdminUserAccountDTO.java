package com.lavacorp.beautefly.webstore.admin.dto;

import com.lavacorp.beautefly.webstore.account.dto.AddressDTO;
import com.lavacorp.beautefly.webstore.account.entity.Credential;
import com.lavacorp.beautefly.webstore.account.entity.UserAccount;
import com.lavacorp.beautefly.webstore.file.dto.FileDTO;

import java.io.Serializable;
import java.time.Instant;
import java.time.LocalDate;
import java.util.List;

/**
 * DTO for {@link com.lavacorp.beautefly.webstore.account.entity.UserAccount}
 */
public record AdminUserAccountDTO(
        int id,
        Instant createdAt,
        String username,
        String email,
        UserAccount.Gender gender,
        LocalDate dob,
        FileDTO profileImage,
        List<Credential.Role> roles,
        List<AddressDTO> addresses,
        boolean active
) implements Serializable {
}