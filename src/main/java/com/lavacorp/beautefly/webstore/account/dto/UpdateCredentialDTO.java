package com.lavacorp.beautefly.webstore.account.dto;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotNull;

import java.io.Serializable;

/**
 * DTO for {@link com.lavacorp.beautefly.webstore.account.entity.UserAccount}
 */
public record UpdateCredentialDTO(int id, @NotNull @Email String email,
                                  String credentialPassword) implements Serializable {
}