package com.lavacorp.beautefly.webstore.account.dto;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import lombok.Data;

@Data
public class AccountLoginDTO {
    @Email
    private String email;

    @NotBlank
    private String password;
}
