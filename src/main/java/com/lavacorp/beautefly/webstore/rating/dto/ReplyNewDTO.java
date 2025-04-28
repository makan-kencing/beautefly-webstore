package com.lavacorp.beautefly.webstore.rating.dto;

import java.io.Serializable;

/**
 * DTO for {@link com.lavacorp.beautefly.webstore.rating.entity.Reply}
 */
public record ReplyNewDTO(
        String message,
        int originalId
) implements Serializable {
}