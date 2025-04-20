package com.lavacorp.beautefly.webstore.account.dto;

import com.lavacorp.beautefly.webstore.account.entity.Account;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotNull;

import java.io.Serializable;

/**
 * DTO for {@link Account}
 */
public record UpdateCredentialDTO(int id, @NotNull @Email String email,
                                  String credentialPassword) implements Serializable {
}