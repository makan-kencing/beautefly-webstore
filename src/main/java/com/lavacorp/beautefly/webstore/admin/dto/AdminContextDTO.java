package com.lavacorp.beautefly.webstore.admin.dto;

import com.lavacorp.beautefly.webstore.account.entity.Account;
import com.lavacorp.beautefly.webstore.account.entity.Credential;
import com.lavacorp.beautefly.webstore.file.dto.FileUploadDTO;

import java.io.Serializable;
import java.util.List;

/**
 * DTO for {@link Account}
 */
public record AdminContextDTO(
        int id,
        String username,
        FileUploadDTO profileImage,
        List<Credential.Role> roles
) implements Serializable {
}