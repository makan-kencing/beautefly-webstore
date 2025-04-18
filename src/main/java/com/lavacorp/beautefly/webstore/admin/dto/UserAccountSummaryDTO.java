package com.lavacorp.beautefly.webstore.admin.dto;

import com.lavacorp.beautefly.webstore.account.entity.Credential;
import com.lavacorp.beautefly.webstore.account.entity.UserAccount;

import java.io.Serializable;
import java.time.Instant;
import java.util.List;

/**
 * DTO for {@link com.lavacorp.beautefly.webstore.account.entity.UserAccount}
 */
public record UserAccountSummaryDTO(
        int id,
        String username,
        String email,
        List<Credential.Role> roles,
        Instant createdAt,
        boolean active
) implements Serializable {
}