package com.lavacorp.beautefly.webstore.admin.dto;

import com.lavacorp.beautefly.webstore.account.entity.Credential;
import com.lavacorp.beautefly.webstore.account.entity.Account.Gender;
import java.io.Serializable;
import java.time.Instant;
import java.time.LocalDate;
import java.util.List;

public record AdminUserAccountDTO(
        int id,
        String username,
        String email,
        List<Credential.Role> roles,
        Gender gender,
        LocalDate dob,
        Instant createdAt,
        boolean active,
        String profileImageHash
) implements Serializable {}
