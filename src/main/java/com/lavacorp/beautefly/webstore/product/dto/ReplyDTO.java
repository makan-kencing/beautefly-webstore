package com.lavacorp.beautefly.webstore.product.dto;

import java.io.Serializable;
import java.time.Instant;

/**
 * DTO for {@link com.lavacorp.beautefly.webstore.rating.entity.Reply}
 */
public record ReplyDTO(
        int id,
        String message,
        Instant repliedOn
) implements Serializable {
}