package com.lavacorp.beautefly.webstore.search.dto;

import com.lavacorp.beautefly.webstore.account.entity.Credential;

import java.io.Serializable;
import java.util.List;

/**
 * DTO for {@link com.lavacorp.beautefly.webstore.account.entity.Account}
 */
public record AccountSearchResultDTO(
        int id,
        String username,
        String email,
        List<Credential.Role> roles,
        boolean active
) implements Serializable {
}