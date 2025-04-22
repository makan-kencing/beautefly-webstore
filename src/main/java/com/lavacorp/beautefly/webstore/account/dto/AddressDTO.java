package com.lavacorp.beautefly.webstore.account.dto;

import jakarta.annotation.Nullable;
import jakarta.validation.constraints.NotNull;

import java.io.Serializable;

/**
 * DTO for {@link com.lavacorp.beautefly.webstore.account.entity.Address}
 */
public record AddressDTO(
        int id,
        @NotNull String name,
        @NotNull String contactNo,
        @NotNull String address1,
        @Nullable String address2,
        @Nullable String address3,
        @NotNull String city,
        @NotNull String postcode,
        @NotNull String state,
        @NotNull String country
) implements Serializable {
}