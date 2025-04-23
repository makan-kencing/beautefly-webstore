package com.lavacorp.beautefly.webstore.admin.dto.parameters;

import com.lavacorp.beautefly.webstore.account.entity.Account;
import com.lavacorp.beautefly.webstore.account.entity.Credential;
import jakarta.annotation.Nullable;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.io.Serializable;
import java.time.LocalDate;
import java.util.List;

/**
 * DTO for {@link Account}
 */
@Data
public class AccountCreateParametersDTO implements Serializable {
    @NotNull String username;
    @NotNull @Email String email;
    @NotNull String password;
    List<Credential.Role> roles;
    @Nullable String gender;
    @Nullable LocalDate dob;
    @Nullable Integer profileImageFileId;
}