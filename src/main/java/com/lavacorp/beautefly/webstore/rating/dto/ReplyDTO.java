package com.lavacorp.beautefly.webstore.rating.dto;

import com.lavacorp.beautefly.webstore.security.dto.AccountContextDTO;

import java.io.Serializable;
import java.time.Instant;

/**
 * DTO for {@link com.lavacorp.beautefly.webstore.rating.entity.Reply}
 */
public record ReplyDTO(
        int id,
        String message,
        AccountContextDTO account,
        Instant repliedOn
) implements Serializable {
}