package com.lavacorp.beautefly.common;

import jakarta.validation.constraints.NotNull;

public record Range<T>(
        @NotNull T low,
        @NotNull T high
) {
}
