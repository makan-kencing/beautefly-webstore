package com.lavacorp.beautefly.webstore.admin.dto;

import java.io.Serializable;
import java.util.List;

/**
 * DTO for {@link com.lavacorp.beautefly.webstore.account.entity.Account}
 */
public record DeleteAccountDTO(List<Integer> id) implements Serializable {
}