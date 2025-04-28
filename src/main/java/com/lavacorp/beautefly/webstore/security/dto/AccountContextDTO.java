package com.lavacorp.beautefly.webstore.security.dto;

import com.lavacorp.beautefly.webstore.account.entity.Account;
import com.lavacorp.beautefly.webstore.account.entity.Credential;
import com.lavacorp.beautefly.webstore.file.dto.FileUploadDTO;

import java.io.Serializable;
import java.util.List;

/**
 * DTO for {@link Account}
 */
public record AccountContextDTO(
        int id,
        String username,
        String email,
        FileUploadDTO profileImage,
        List<Credential.Role> roles
) implements Serializable {
}