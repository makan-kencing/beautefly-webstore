package com.lavacorp.beautefly.webstore.common.dto;

import jakarta.validation.constraints.NotNull;

public record Range<T extends Comparable<T>>(
        @NotNull T low,
        @NotNull T high
) {
}
