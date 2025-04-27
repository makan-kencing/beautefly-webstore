package com.lavacorp.beautefly.webstore.account.dto;

import java.util.List;

/**
 * DTO for {@link com.lavacorp.beautefly.webstore.account.entity.AddressBook}
 */
public record AddressesDTO(
        List<AddressDTO> addresses,
        int defaultAddressId
) {
}
